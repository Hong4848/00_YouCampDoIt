package com.kh.youcamp.order.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.youcamp.cart.model.service.CartService;
import com.kh.youcamp.goods.model.service.GoodsService;
import com.kh.youcamp.goods.model.vo.Goods;
import com.kh.youcamp.member.model.vo.Member;
import com.kh.youcamp.order.model.service.OrderService;
import com.kh.youcamp.order.model.vo.Order;
import com.kh.youcamp.order.model.vo.OrderDetail;
import com.kh.youcamp.order.util.DataEncrypt;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private GoodsService goodsService;
	
	// nicePay util 메소드들 ------------------------------------------------------
	public final synchronized String getyyyyMMddHHmmss(){
		SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
		return yyyyMMddHHmmss.format(new Date());
	}
	
	//server to server 통신
	public String connectToServer(String data, String reqUrl) throws Exception{
		HttpURLConnection conn 		= null;
		BufferedReader resultReader = null;
		PrintWriter pw 				= null;
		URL url 					= null;
		
		int statusCode = 0;
		StringBuffer recvBuffer = new StringBuffer();
		try{
			url = new URL(reqUrl);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setConnectTimeout(15000);
			conn.setReadTimeout(25000);
			conn.setDoOutput(true);
			
			pw = new PrintWriter(conn.getOutputStream());
			pw.write(data);
			pw.flush();
			
			statusCode = conn.getResponseCode();
			resultReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
			for(String temp; (temp = resultReader.readLine()) != null;){
				recvBuffer.append(temp).append("\n");
			}
			
			if(!(statusCode == HttpURLConnection.HTTP_OK)){
				throw new Exception();
			}
			
			return recvBuffer.toString().trim();
		}catch (Exception e){
			return "9999";
		}finally{
			recvBuffer.setLength(0);
			
			try{
				if(resultReader != null){
					resultReader.close();
				}
			}catch(Exception ex){
				resultReader = null;
			}
			
			try{
				if(pw != null) {
					pw.close();
				}
			}catch(Exception ex){
				pw = null;
			}
			
			try{
				if(conn != null) {
					conn.disconnect();
				}
			}catch(Exception ex){
				conn = null;
			}
		}
	}

	//JSON String -> HashMap 변환
	private static HashMap jsonStringToHashMap(String str) throws Exception{
		HashMap dataMap = new HashMap();
		JSONParser parser = new JSONParser();
		try{
			Object obj = parser.parse(str);
			JSONObject jsonObject = (JSONObject)obj;

			Iterator<String> keyStr = jsonObject.keySet().iterator();
			while(keyStr.hasNext()){
				String key = keyStr.next();
				Object value = jsonObject.get(key);
				
				dataMap.put(key, value);
			}
		}catch(Exception e){
			
		}
		return dataMap;
	}
	
	// 여기까지 나이스페이 결제 유틸메소드들 --------------------------------------------------
	
	/*
	 * cartListView 장바구니 에서 주문하기버튼
	 * 장바구니 항목들로 order db insert 하고 insert 컨트롤러
	 * (결제에필요한)응답데이터 넘기면서 orderForm 화면 포워딩
	 * orderForm 화면에서 결제하기 버튼 > nicepayStart() 함수 호출 결제 진행
	 * 나이스페이 결제창으로 결제완료되면, nicepaySubmit() 함수호출 > 
	 * 결제결과 order db update 하고, 데이터 와 함께 payResult 화면 포워딩
	 * 
	 */
	
	/**
	 * 24.12.10 17시 윤홍문작성
	 * 주문 폼 및 order insert 컨트롤러 메소드
	 * 나이스페이 결제 실행은 orderForm.jsp에서 js로 실행
	 * 장바구니의 주문하기버튼 클릭 시 요청
	 * @return
	 * 
	 * 메소드명 바꾸기
	 * insert 와 select를 동시에 진행함
	 * orderDetail insert 할 때 데이터 가공해서 넘기기보다
	 * 쿼리문에서 cart 쿼리문 인라인해봐서 넣는 방법 고민해 볼것
	 * 
	 * 여기도 insert 여러번 반복 시에 트랜잭션 처리 고민 필요
	 */
	@PostMapping("insert.or")
	public String insertOrder(@RequestParam("orderDetails") String orderDetailsJson,
							  Model model, 
							  HttpSession session,
							  Order order) {
		
		Member loginMember = (Member) session.getAttribute("loginMember");
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
		
	    order.setMemberNo(memberNo);
	    
//	    log.debug("jsp 에서 값 넘어오냐? order : " + order);
	    
	    // order insert 쿼리문실행
	    // TOTAL_PRICE, MEMBER_NO insert
	    int result1 = orderService.insertOrder(order);
	    log.debug("insertOrder 잘 실행 됐냐? 처리된 행 : " + result1);
	    
	    if(!(result1 > 0)) {
	    	// 에러 문구를 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "주문하기 실패. 다시 시도해주세요");
			return "common/errorPage";
	    } 
	    
	    // db에서 채번된 orderNo 가져오기
	    int orderNo = orderService.selectGeneratedOrderNo();
	    log.debug("채번한 번호 갖고 왔냐?? orderNo : " + orderNo);
	    
	    // -------------------------------------------------------------
		// orderDetail insert
	    // Json 형태 데이터 아니면 cart에서 셀렉해와서 orderDetail 에 insert 하기 
//	    log.debug("jsp 에서 값 넘어오냐? orderDetailsJson  : "  + orderDetailsJson);
	    
	    
	    ObjectMapper objectMapper = new ObjectMapper();
	    List<OrderDetail> orderDetails = new ArrayList<>();
		try {
			orderDetails = 
				objectMapper.readValue(orderDetailsJson, 
									   new TypeReference<List<OrderDetail>>() {});
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
	    for (OrderDetail orderDetail : orderDetails) {
	    	orderDetail.setOrderNo(orderNo);
//	    	log.debug("insert 할 orderDetail  : "  + orderDetail);
	        int result2 = orderService.insertOrderDetail(orderDetail);
	        
//	        log.debug("orderDetail INSERT 잘 됏냐? n번 반복됏나?");
	        
	        if(!(result2 > 0)) {
		    	// 에러 문구를 담아서 에러페이지로 포워딩
				model.addAttribute("errorMsg", "주문하기 실패. 다시 시도해주세요");
				return "common/errorPage";
		    } 
	    }
	    
	    //-------------------------------------------------
	    // orderNo 기준으로
	    // order, orderDetail 에서 결제에 필요한 정보 및 orderForm 뷰단에 필요한 정보 가져가기
	    Order selectedOrder = orderService.selectOrder(orderNo);
	    ArrayList<OrderDetail> list = orderService.selectOrederDetailList(orderNo);
	    // 굿즈섬네일가져오기, 오더번호 > 오더디테일테이블 > 굿즈넘버 > 섬네일 셀렉
	    ArrayList<Goods> gList = goodsService.selectGoodsThumbnailListByOrderNo(orderNo);
	    
	    for(Goods g : gList){
			String s = "<img src="; // 이미지 태그 찾기
			String body = g.getGoodsThumbnail();
			int start = 0;
			int end = 0;
			
			start = body.indexOf(s);
			body = body.substring(start);
			end = body.indexOf(">");
			body = body.substring(0, end+1);
			
			g.setGoodsThumbnail(body);
		}
	    
	    Map<Integer, String> thumbnailMap = new HashMap<>();
	    for (Goods goods : gList) {
	        thumbnailMap.put(goods.getGoodsNo(), goods.getGoodsThumbnail());
	    }
	    
//	    log.debug("조회 잘 됏냐? selectedOrder : " + selectedOrder);
//	    log.debug("조회 잘 됐냐? list : " + list);
	    
	    model.addAttribute("order", selectedOrder);
	    model.addAttribute("list", list);
	    // model.addAttribute("gList", gList);
	    model.addAttribute("thumbnailMap", thumbnailMap);
		
		/*
		*******************************************************
		* <결제요청 파라미터>
		* 결제시 Form 에 보내는 결제요청 파라미터입니다.
		* 샘플페이지에서는 기본(필수) 파라미터만 예시되어 있으며, 
		* 추가 가능한 옵션 파라미터는 연동메뉴얼을 참고하세요.
		*******************************************************
		*/
		String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg=="; // 상점키
		String merchantID 		= "nicepay00m"; 				// 상점아이디
		String goodsName 		= "나이스페이"; 					// 결제상품명
		// order에서 가져올꺼
		// String price 			= "1004"; 						// 결제상품금액	
		String price =  order.getTotalPrice()+"";
		// 아래 세개는 view 단에서 session 에서 직접 출력
		// String buyerName 		= "나이스"; 						// 구매자명
		// String buyerTel 		= "01000000000"; 				// 구매자연락처
		// String buyerEmail 		= "happy@day.co.kr"; 			// 구매자메일주소
		String moid 			= "mnoid1234567890"; 			// 상품주문번호	
		// String returnURL 		= "http://localhost:8080/nicepay3.0_utf-8/payResult_utf.jsp"; // 결과페이지(절대경로) - 모바일 결제창 전용

		/*
		*******************************************************
		* <해쉬암호화> (수정하지 마세요)
		* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
		*******************************************************
		*/
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String ediDate 			= getyyyyMMddHHmmss();	
		String hashString 		= sha256Enc.encrypt(ediDate + merchantID + price + merchantKey);
		
		
		model.addAttribute("merchantKey", merchantKey);
		model.addAttribute("merchantID", merchantID);
		model.addAttribute("goodsName", goodsName);
		// model.addAttribute("price", price);
		// model.addAttribute("buyerName", buyerName);
		// model.addAttribute("buyerTel", buyerTel);
		// model.addAttribute("buyerEmail", buyerEmail);
		model.addAttribute("moid", moid);
		// model.addAttribute("returnURL", returnURL);
		model.addAttribute("ediDate", ediDate);
		model.addAttribute("hashString", hashString);
		
		return "order/orderForm";
	}
	
	
	
	/**
	 * 
	 * 결제 후 결제 완료되면 order status 컬럼 update
	 * 그리고 주문완료(결제완료) 내역 뷰 요청
	 * 결제 완료 데이터를 payResult.jsp로 넘김
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="update.or")
	public String updateOrder(HttpServletRequest request, 
							  Model model,
							  int orderNo) throws Exception {
		
		// request.setCharacterEncoding("utf-8"); 
		
		
		/*
		****************************************************************************************
		* <인증 결과 파라미터>
		****************************************************************************************
		*/
		String authResultCode 	= (String)request.getParameter("AuthResultCode"); 	// 인증결과 : 0000(성공)
		String authResultMsg 	= (String)request.getParameter("AuthResultMsg"); 	// 인증결과 메시지
		String nextAppURL 		= (String)request.getParameter("NextAppURL"); 		// 승인 요청 URL
		String txTid 			= (String)request.getParameter("TxTid"); 			// 거래 ID
		String authToken 		= (String)request.getParameter("AuthToken"); 		// 인증 TOKEN
		String payMethod 		= (String)request.getParameter("PayMethod"); 		// 결제수단
		String mid 				= (String)request.getParameter("MID"); 				// 상점 아이디
		String moid 			= (String)request.getParameter("Moid"); 			// 상점 주문번호
		String amt 				= (String)request.getParameter("Amt"); 				// 결제 금액
		String reqReserved 		= (String)request.getParameter("ReqReserved"); 		// 상점 예약필드
		String netCancelURL 	= (String)request.getParameter("NetCancelURL"); 	// 망취소 요청 URL
		//String authSignature = (String)request.getParameter("Signature");			// Nicepay에서 내려준 응답값의 무결성 검증 Data

		/*  
		****************************************************************************************
		* Signature : 요청 데이터에 대한 무결성 검증을 위해 전달하는 파라미터로 허위 결제 요청 등 결제 및 보안 관련 이슈가 발생할 만한 요소를 방지하기 위해 연동 시 사용하시기 바라며 
		* 위변조 검증 미사용으로 인해 발생하는 이슈는 당사의 책임이 없음 참고하시기 바랍니다.
		****************************************************************************************
		 */
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg=="; // 상점키

		//인증 응답 Signature = hex(sha256(AuthToken + MID + Amt + MerchantKey)
		//String authComparisonSignature = sha256Enc.encrypt(authToken + mid + amt + merchantKey);

		/*
		****************************************************************************************
		* <승인 결과 파라미터 정의>
		* 샘플페이지에서는 승인 결과 파라미터 중 일부만 예시되어 있으며, 
		* 추가적으로 사용하실 파라미터는 연동메뉴얼을 참고하세요.
		****************************************************************************************
		*/
		String ResultCode 	= ""; String ResultMsg 	= ""; String PayMethod 	= "";
		String GoodsName 	= ""; String Amt 		= ""; String TID 		= ""; 
		//String Signature = ""; String paySignature = "";


		/*
		****************************************************************************************
		* <인증 결과 성공시 승인 진행>
		****************************************************************************************
		*/
		String resultJsonStr = "";
		if(authResultCode.equals("0000") /*&& authSignature.equals(authComparisonSignature)*/){
			/*
			****************************************************************************************
			* <해쉬암호화> (수정하지 마세요)
			* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
			****************************************************************************************
			*/
			String ediDate			= getyyyyMMddHHmmss();
			String signData 		= sha256Enc.encrypt(authToken + mid + amt + ediDate + merchantKey);

			/*
			****************************************************************************************
			* <승인 요청>
			* 승인에 필요한 데이터 생성 후 server to server 통신을 통해 승인 처리 합니다.
			****************************************************************************************
			*/
			StringBuffer requestData = new StringBuffer();
			requestData.append("TID=").append(txTid).append("&");
			requestData.append("AuthToken=").append(authToken).append("&");
			requestData.append("MID=").append(mid).append("&");
			requestData.append("Amt=").append(amt).append("&");
			requestData.append("EdiDate=").append(ediDate).append("&");
			requestData.append("CharSet=").append("utf-8").append("&");
			requestData.append("SignData=").append(signData);

			resultJsonStr = connectToServer(requestData.toString(), nextAppURL);

			HashMap resultData = new HashMap();
			boolean paySuccess = false;
			if("9999".equals(resultJsonStr)){
				/*
				*************************************************************************************
				* <망취소 요청>
				* 승인 통신중에 Exception 발생시 망취소 처리를 권고합니다.
				*************************************************************************************
				*/
				StringBuffer netCancelData = new StringBuffer();
				requestData.append("&").append("NetCancel=").append("1");
				String cancelResultJsonStr = connectToServer(requestData.toString(), netCancelURL);
				
				HashMap cancelResultData = jsonStringToHashMap(cancelResultJsonStr);
				ResultCode = (String)cancelResultData.get("ResultCode");
				ResultMsg = (String)cancelResultData.get("ResultMsg");
				/*Signature = (String)cancelResultData.get("Signature");
				String CancelAmt = (String)cancelResultData.get("CancelAmt");
				paySignature = sha256Enc.encrypt(TID + mid + CancelAmt + merchantKey);*/
			}else{
				resultData = jsonStringToHashMap(resultJsonStr);
				ResultCode 	= (String)resultData.get("ResultCode");	// 결과코드 (정상 결과코드:3001)
				ResultMsg 	= (String)resultData.get("ResultMsg");	// 결과메시지
				PayMethod 	= (String)resultData.get("PayMethod");	// 결제수단
				GoodsName   = (String)resultData.get("GoodsName");	// 상품명
				Amt       	= (String)resultData.get("Amt");		// 결제 금액
				TID       	= (String)resultData.get("TID");		// 거래번호
				// Signature : Nicepay에서 내려준 응답값의 무결성 검증 Data
				// 가맹점에서 무결성을 검증하는 로직을 구현하여야 합니다.
				/* Signature = (String)resultData.get("Signature");
				paySignature = sha256Enc.encrypt(TID + mid + Amt + merchantKey); */
				
				/*
				*************************************************************************************
				* <결제 성공 여부 확인>
				*************************************************************************************
				*/
				if(PayMethod != null){
					if(PayMethod.equals("CARD")){
						if(ResultCode.equals("3001")) paySuccess = true; // 신용카드(정상 결과코드:3001)       	
					}else if(PayMethod.equals("BANK")){
						if(ResultCode.equals("4000")) paySuccess = true; // 계좌이체(정상 결과코드:4000)	
					}else if(PayMethod.equals("CELLPHONE")){
						if(ResultCode.equals("A000")) paySuccess = true; // 휴대폰(정상 결과코드:A000)	
					}else if(PayMethod.equals("VBANK")){
						if(ResultCode.equals("4100")) paySuccess = true; // 가상계좌(정상 결과코드:4100)
					}else if(PayMethod.equals("SSG_BANK")){
						if(ResultCode.equals("0000")) paySuccess = true; // SSG은행계좌(정상 결과코드:0000)
					}else if(PayMethod.equals("CMS_BANK")){
						if(ResultCode.equals("0000")) paySuccess = true; // 계좌간편결제(정상 결과코드:0000)
					}
				}
				
				// ----------------------------------------------------------------------
				if(paySuccess = true) { // 결제완료
					
					log.debug("결제 완료 후 orderNo 잘 넘어오나? : " + orderNo);
					// 결제 완료 후 order UPDATE > orderNo 기준
					Order order = new Order();
					order.setOrderNo(orderNo);
					order.setPaymentId(TID);
					order.setPaymentMethod(PayMethod);
					
					int resultUpdateOrder = orderService.updateOrder(order);
					log.debug("결제 완료 후 오더 업데이트 됏냐? resultUpdateOrder : " + resultUpdateOrder);
					
					// 결제 완료된 장바구니 삭제
					// 오더넘버 > 주문상세의 상품번호 > 상품번호 기준 장바구니 삭제
					int resultDeleteCart = cartService.deleteCartByOrderNo(orderNo);
					log.debug("결제 완료 후 카트 딜리트 됏냐? resultUpdateOrder : " + resultDeleteCart);
					
					// 결제완료한 상품 orderDetail select > orderNo 기준
					ArrayList<OrderDetail> list = orderService.selectOrederDetailList(orderNo);
					// 결제완료된 상품 썸네일
					ArrayList<Goods> gList = goodsService.selectGoodsThumbnailListByOrderNo(orderNo);
				    
				    for(Goods g : gList){
						String s = "<img src="; // 이미지 태그 찾기
						String body = g.getGoodsThumbnail();
						int start = 0;
						int end = 0;
						
						start = body.indexOf(s);
						body = body.substring(start);
						end = body.indexOf(">");
						body = body.substring(0, end+1);
						
						g.setGoodsThumbnail(body);
					}
				    
				    Map<Integer, String> thumbnailMap = new HashMap<>();
				    for (Goods goods : gList) {
				        thumbnailMap.put(goods.getGoodsNo(), goods.getGoodsThumbnail());
				    }
					
					model.addAttribute("list", list);
					model.addAttribute("thumbnailMap", thumbnailMap);
					
					model.addAttribute("resultJsonStr", resultJsonStr);
					model.addAttribute("ResultCode", ResultCode);
				    model.addAttribute("ResultMsg", ResultMsg);
				    model.addAttribute("PayMethod", PayMethod);
				    model.addAttribute("GoodsName", GoodsName);
				    model.addAttribute("Amt", Amt);
				    model.addAttribute("TID", TID);
					
					return "order/payResult";
				}
				// --------------------------------------------------------------------------
				
			}
		}else/*if(authSignature.equals(authComparisonSignature))*/{
			ResultCode 	= authResultCode; 	
			ResultMsg 	= authResultMsg;
		}/*else{
			System.out.println("인증 응답 Signature : " + authSignature);
			System.out.println("인증 생성 Signature : " + authComparisonSignature);
		}*/
		
		
	    // 결제 실패 경우
	    model.addAttribute("errorMsg", "결제 실패. 다시 시도해주세요");
		return "common/errorPage";
		
	}
	
	
	/**
	 * 결제내역 목록조회 요청 메소드
	 * @param mv
	 * @param model
	 * @param session
	 * @return
	 */
	@GetMapping("list.or")
	public ModelAndView selectList(ModelAndView mv, 
								   Model model,
								   HttpSession session) {
		
		// 세션에서 유저 번호 가져오기
		Member loginMember = (Member) session.getAttribute("loginMember");
		int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
		log.debug("결제내역 리스트뷰 컨트롤러, memberNo : " + memberNo);
		
		// 로그인 인터셉터 처리 필요함@@@@@@@@@@@@@@@@@@@@@@@@@@
		// 주문(결제)한 내용 memberNo > order테이블 > 
//		ArrayList<Order> list = 
//				orderService.selectOrederWithDetailListByMemberNo(memberNo);
//		log.debug("결제내역 잘 갖고왔나, list : " + list);
		ArrayList<Order> list = 
				orderService.selectOrederListByMemberNo(memberNo);
		log.debug("결제내역 잘 갖고왔나, list : " + list);
//		// 결제완료된 상품 썸네일
//		ArrayList<Goods> gList = goodsService.selectGoodsThumbnailListByMemberNo(memberNo);
//	    
//	    for(Goods g : gList){
//			String s = "<img src="; // 이미지 태그 찾기
//			String body = g.getGoodsThumbnail();
//			int start = 0;
//			int end = 0;
//			
//			start = body.indexOf(s);
//			body = body.substring(start);
//			end = body.indexOf(">");
//			body = body.substring(0, end+1);
//			
//			g.setGoodsThumbnail(body);
//		}
//	    
//	    Map<Integer, String> thumbnailMap = new HashMap<>();
//	    for (Goods goods : gList) {
//	        thumbnailMap.put(goods.getGoodsNo(), goods.getGoodsThumbnail());
//	    }
//		
		model.addAttribute("list", list);
//		model.addAttribute("thumbnailMap", thumbnailMap);
		
		
		mv.setViewName("order/orderListView");
		
		
		 return mv;
	}
	
	
	
	
	

}
