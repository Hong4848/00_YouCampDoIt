package com.kh.youcamp.order.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
import com.kh.youcamp.reserve.model.service.ReserveService;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ReserveService reserveService;
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private JavaMailSender mailSender;
	
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
	

	
	/**
	 * 24.12.10 17시 윤홍문작성
	 * 장바구니의 주문하기버튼 클릭 시 요청
	 * order 및 orderDetail INSERT, 데이터 가공
	 * 주문폼에 데이터 전송
	 * @return

	 */
	@PostMapping("insert.or")
	public String insertOrder(@RequestParam("orderDetails") String orderDetailsJson,
							  Model model, 
							  HttpSession session,
							  Order order) {
//	    log.debug("jsp 에서 값 넘어오나? order : " + order);
		
		Member loginMember = (Member) session.getAttribute("loginMember");
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
	    order.setMemberNo(memberNo);
	    
	    // 예약 내역 확인
	    int reserveCount = reserveService.selectReserveCount(memberNo);
	    log.debug("주문결제 진행 전, 예약내역 있는지 ? reserveCount : " + reserveCount);
	    if(reserveCount == 0) { // 예약내역 없음 > 주문 불가능
	    	model.addAttribute("errorMsg", "예약내역이 없습니다. 예약 후 주문을 진행해 주세요.");
			return "common/errorPage";
	    }
	    

	    // -----------------------------------------------------------------
	    // order insert 쿼리문실행
	    // TOTAL_PRICE, MEMBER_NO insert
	    int result1 = orderService.insertOrder(order);
	    log.debug("insertOrder 잘 실행 됐나? 처리된 행 : " + result1);
	    
	    if(!(result1 > 0)) {
	    	// 에러 문구를 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "주문하기 실패. 다시 시도해주세요");
			return "common/errorPage";
	    } 
	    
	    // db에서 채번된 orderNo 가져오기
	    int orderNo = orderService.selectGeneratedOrderNo();
	    log.debug("채번한 번호 갖고 왔나? orderNo : " + orderNo);
	    
	    // -------------------------------------------------------------
		// orderDetail insert 쿼리문 실행
	    // Json 형태 데이터 아니면 cart에서 셀렉해와서 orderDetail 에 insert 하기 
//	    log.debug("jsp 에서 값 넘어오나? orderDetailsJson  : "  + orderDetailsJson);
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
	        
//	        log.debug("orderDetail INSERT 잘 됐나? n번 반복됏나?");
	        
	        if(!(result2 > 0)) {
		    	// 에러 문구를 담아서 에러페이지로 포워딩
				model.addAttribute("errorMsg", "주문하기 실패. 다시 시도해주세요");
				return "common/errorPage";
		    } 
	    }
	    
	    // 조회에 필요한 데이터 세션에 저장 (개인정보이므로 세션에 저장하여 데이터 전송)
	    // 사용자의 f5반복으로 db 처리 반복 방지위해 데이터 처리와 jsp데이터 전송을 나눔
	    session.setAttribute("orderNo", orderNo);
	    return "redirect:/orderForm.or";
	}
	
	/**
	 * orderForm에 출력할 데이터 전송 및 jsp 화면 요청
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/orderForm.or")
	public String orderForm(HttpSession session, 
							Model model) {    
	    
		// 세션에서 데이터 가져오기
	    Integer orderNo = (Integer) session.getAttribute("orderNo");

	    if (orderNo == null) {
	        model.addAttribute("errorMsg", "유효하지 않은 접근입니다. 다시 시도해주세요.");
	        return "common/errorPage";
	    }

	    // 세션 데이터 삭제
	    session.removeAttribute("orderNo");
		
	    //-------------------------------------------------
	    // 조회
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
	    model.addAttribute("thumbnailMap", thumbnailMap);
		
	    // <결제요청 파라미터>
		String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg=="; // 상점키
		String merchantID 		= "nicepay00m"; 				// 상점아이디			
		String price =  selectedOrder.getTotalPrice()+"";				// 결제상품금액	
		String moid 			= "mnoid1234567890"; 			// 상품주문번호	

		// <해쉬암호화> (수정하지 마세요) SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String ediDate 			= getyyyyMMddHHmmss();	
		String hashString 		= sha256Enc.encrypt(ediDate + merchantID + price + merchantKey);
		
		model.addAttribute("merchantKey", merchantKey);
		model.addAttribute("merchantID", merchantID);
		model.addAttribute("moid", moid);
		model.addAttribute("ediDate", ediDate);
		model.addAttribute("hashString", hashString);
		
		return "order/orderForm";
	}
	
	
	
	/**
	 * 결제 후 결제 완료되면 order테이블의 status 컬럼 update
	 * 그리고 주문완료(결제완료) 내역 뷰 요청
	 * 결제 완료 데이터를 payResult.jsp로 전송
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="update.or")
	public String updateOrder(HttpServletRequest request, 
							  Model model,
							  int orderNo,
							  HttpSession session) throws Exception {
		
		// <인증 결과 파라미터>
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
		
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg=="; // 상점키

		// * <승인 결과 파라미터 정의>
		String ResultCode 	= ""; String ResultMsg 	= ""; String PayMethod 	= "";
		String GoodsName 	= ""; String Amt 		= ""; String TID 		= ""; 
		
		// <인증 결과 성공시 승인 진행>
		String resultJsonStr = "";
		if(authResultCode.equals("0000") /*&& authSignature.equals(authComparisonSignature)*/){
			// <해쉬암호화> (수정하지 마세요)
			String ediDate			= getyyyyMMddHHmmss();
			String signData 		= sha256Enc.encrypt(authToken + mid + amt + ediDate + merchantKey);

			// <승인 요청> 승인에 필요한 데이터 생성 후 server to server 통신을 통해 승인 처리 합니다.
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
				// <망취소 요청> (승인 통신중에 Exception 발생시 망취소 처리를 권고합니다.)
				StringBuffer netCancelData = new StringBuffer();
				requestData.append("&").append("NetCancel=").append("1");
				String cancelResultJsonStr = connectToServer(requestData.toString(), netCancelURL);
				
				HashMap cancelResultData = jsonStringToHashMap(cancelResultJsonStr);
				ResultCode = (String)cancelResultData.get("ResultCode");
				ResultMsg = (String)cancelResultData.get("ResultMsg");
				
			}else{
				resultData = jsonStringToHashMap(resultJsonStr);
				ResultCode 	= (String)resultData.get("ResultCode");	// 결과코드 (정상 결과코드:3001)
				ResultMsg 	= (String)resultData.get("ResultMsg");	// 결과메시지
				PayMethod 	= (String)resultData.get("PayMethod");	// 결제수단
				GoodsName   = (String)resultData.get("GoodsName");	// 상품명
				Amt       	= (String)resultData.get("Amt");		// 결제 금액
				TID       	= (String)resultData.get("TID");		// 거래번호
				
				// <결제 성공 여부 확인>
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
					log.debug("결제 완료 후 오더 업데이트 됐나? resultUpdateOrder : " + resultUpdateOrder);
					
					// 결제 완료된 장바구니 삭제
					// 오더넘버 > 주문상세의 상품번호 > 상품번호 기준 장바구니 삭제
					int resultDeleteCart = cartService.deleteCartByOrderNo(orderNo);
					log.debug("결제 완료 후 카트 딜리트 됐나? resultDeleteCart : " + resultDeleteCart);
					
					// 결제완료한 상품 orderDetail select > orderNo 기준
					ArrayList<OrderDetail> list = orderService.selectOrederDetailList(orderNo);
					
					// ----------------------------------------------------------------------
					// 결제완료한 상품 재고 소진(박진홍 작성)
					for(OrderDetail ord : list) {
						int remainStockCounting = orderService.remainStockCounting(ord.getGoodsNo(), ord.getQuantity());
					}
					// ----------------------------------------------------------------------
					
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
				    
				    //----------------------------------------------------------------------
					// 결제 완료 내역 이메일발송
				    
					Order orderInfo = orderService.selectOrder(orderNo);
					
					Member loginMember = (Member)session.getAttribute("loginMember");
					
					MimeMessage message = mailSender.createMimeMessage();
					
					MimeMessageHelper mimeMessageHelper
					= new MimeMessageHelper(message, true, "UTF-8");
					
					String formattedPaymentDate = (orderInfo.getUpdatedDate()+""); // "2024-12-22"
					
					String name = "";
					if(list.size() > 1) {
						name = list.get(0).getGoods().getGoodsName() + " 외 " + (list.size() - 1) + "건" ;
					} else {
						name = list.get(0).getGoods().getGoodsName();
					}
					log.debug("이메일발송 name : " + name);
					
					int price = orderInfo.getTotalPrice(); // 결제금액은 int로 가정
					String formattedPrice = NumberFormat.getInstance().format(price) + "원";
					
					String emailContent = 
						    "<div style='font-family: Arial, sans-serif; background-color: #f8f8f8; padding: 20px;'>"
						        + "<div style='max-width: 600px; margin: auto; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);'>"
						            + "<div style='padding: 20px; text-align: center; background-color: #4CAF50; border-radius: 8px 8px 0 0;'>"
						                + "<img src='cid:companyLogo' alt='YouCampDoIt 로고' style='width: 150px;'>"
						                + "<h1 style='color: #ffffff; margin: 0;'>YouCampDoIt</h1>"
						                + "<p style='color: #ffffff; font-size: 16px;'>자연과 캠핑을 사랑하는 당신을 환영합니다!</p>"
						            + "</div>"
						            + "<div style='padding: 20px;'>"
						                + "<h2 style='color: #333333; text-align: center;'>용품대여 결제 정보 안내</h2>"
						                + "<table style='width: 100%; border-collapse: collapse; margin: 20px 0;'>"
						                    + "<tr>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>주문번호</td>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + orderInfo.getOrderNo() + "</td>"
						                    + "</tr>"
						                    + "<tr>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>예약자명</td>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + loginMember.getMemberName() + "</td>"
						                    + "</tr>"
						                    + "<tr>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>생년월일</td>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + loginMember.getBirthDate() + "</td>"
						                    + "</tr>"
						                    + "<tr>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>결제일자</td>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + formattedPaymentDate + "</td>"
						                    + "</tr>"
						                    + "<tr>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>결제금액</td>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + formattedPrice + "</td>"
						                    + "</tr>"
						                    + "<tr>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>대여용품</td>"
						                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + name + "</td>"
					                        + "</tr>"
						                + "</table>"
						                + "<p style='color: #666666; font-size: 14px; text-align: center;'>"
						                    + "이용해 주셔서 감사합니다.<br>캠핑장에서 뵙겠습니다!"
						                + "</p>"
						            + "</div>"
						            + "<div style='padding: 10px; background-color: #f1f1f1; text-align: center; font-size: 12px; color: #666;'>"
						                + "<p style='margin: 0;'>본 메일은 YouCampDoIt 캠핑장에서 발송되었습니다.</p>"
						                + "<p style='margin: 5px 0;'>문의사항은 youcampdoit123@gmail.com 으로 연락 바랍니다.</p>"
						            + "</div>"
						        + "</div>"
						    + "</div>";
					
					// 메세지 정보 담기
					mimeMessageHelper.setSubject("[YouCampDoIt] 용품대여 결제 정보 안내");
					mimeMessageHelper.setText(emailContent, true); // 내용
					
					mimeMessageHelper.setTo(loginMember.getEmail());
					
					FileSystemResource logo = new FileSystemResource(new File("C:\\YouCampDoIt\\You_Camp_Do_It\\src\\main\\webapp\\resources\\images\\mainPage\\메인로고.png")); // 로고 이미지 파일 경로
					mimeMessageHelper.addInline("companyLogo", logo);
					
					mailSender.send(message);
				    
					return "order/payResult";
				}
				// --------------------------------------------------------------------------
				
			}
		}else{
			ResultCode 	= authResultCode; 	
			ResultMsg 	= authResultMsg;
		}
		
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
	public String selectList(ModelAndView mv, 
								   Model model,
								   HttpSession session) {
		
		// 세션에서 유저 번호 가져오기
		Member loginMember = (Member) session.getAttribute("loginMember");
		int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
		log.debug("결제내역 리스트뷰 컨트롤러, memberNo : " + memberNo);
		
		// 주문(결제)한 내용 memberNo > order테이블 > 
		ArrayList<Order> list = 
				orderService.selectOrederListByMemberNo(memberNo);
//		log.debug("결제내역 잘 갖고왔나, list : " + list);
		
		model.addAttribute("list", list);
		
		 return "order/orderListView";
	}
	
	@GetMapping("/orderDetail.or")
    public String getOrderDetail(@RequestParam("orderNo") int orderNo, Model model) {
        
		log.debug("orderNo 잘 넘어옴? orderNo : " + orderNo);
		// 주문 정보 조회
		Order order = orderService.selectOrder(orderNo);
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

        

        // Model에 주문 정보 추가
	    model.addAttribute("order", order);
	    model.addAttribute("list", list);
		model.addAttribute("thumbnailMap", thumbnailMap);

        // 뷰 이름 반환
        return "order/orderDetailView"; 
    }
	
	/**
	 * 24.12.25 윤홍문
	 * 용품대여 결제취소 컨트롤러
	 * @param reserveNo
	 * @param mv
	 * @param request 
	 * @return
	 * @throws Exception 
	 */
	@PostMapping("orderCancelRequest.or")
	public ModelAndView deleteReserveRequest(int orderNo, 
											 ModelAndView mv, 
											 HttpSession session, 
											 ServletRequest request) throws Exception {
		// <취소요청 파라미터>
		String tid 					= (String)request.getParameter("TID");	// 거래 ID
		String cancelAmt 			= (String)request.getParameter("CancelAmt");	// 취소금액
		String partialCancelCode 	= (String)request.getParameter("PartialCancelCode"); 	// 부분취소여부
		String mid 					= "nicepay00m";	// 상점 ID
		String moid					= "nicepay_api_3.0_test";	// 주문번호
		String cancelMsg 			= "고객요청";	// 취소사유

		// <해쉬암호화> (수정하지 마세요)
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg=="; // 상점키
		String ediDate			= getyyyyMMddHHmmss();
		String signData 		= sha256Enc.encrypt(mid + cancelAmt + ediDate + merchantKey);

		// <취소 요청>
		StringBuffer requestData = new StringBuffer();
		requestData.append("TID=").append(tid).append("&");
		requestData.append("MID=").append(mid).append("&");
		requestData.append("Moid=").append(moid).append("&");
		requestData.append("CancelAmt=").append(cancelAmt).append("&");
		requestData.append("CancelMsg=").append(URLEncoder.encode(cancelMsg, "euc-kr")).append("&");
		requestData.append("PartialCancelCode=").append(partialCancelCode).append("&");
		requestData.append("EdiDate=").append(ediDate).append("&");
		requestData.append("CharSet=").append("utf-8").append("&");
		requestData.append("SignData=").append(signData);
		String resultJsonStr = connectToServer(requestData.toString(), "https://pg-api.nicepay.co.kr/webapi/cancel_process.jsp");

		// <취소 결과 파라미터 정의>
		String ResultCode 	= ""; String ResultMsg 	= ""; String CancelAmt 	= "";
		String CancelDate 	= ""; String CancelTime = ""; String TID 		= ""; String Signature = "";

		if("9999".equals(resultJsonStr)){
			ResultCode 	= "9999";
			ResultMsg	= "통신실패";
			
			mv.addObject("errorMsg", "대여결제 취소 실패!")
			  .setViewName("common/errorPage");
		}else{ // 통신성공
			
			HashMap resultData = jsonStringToHashMap(resultJsonStr);
			ResultCode 	= (String)resultData.get("ResultCode");	// 결과코드 (취소성공: 2001, 취소성공(LGU 계좌이체):2211)
			ResultMsg 	= (String)resultData.get("ResultMsg");	// 결과메시지
			CancelAmt 	= (String)resultData.get("CancelAmt");	// 취소금액
			CancelDate 	= (String)resultData.get("CancelDate");	// 취소일
			CancelTime 	= (String)resultData.get("CancelTime");	// 취소시간
			TID 		= (String)resultData.get("TID");		// 거래아이디 TID
			
			log.debug("결제 취소 요청 ResultCode : " + ResultCode);
			log.debug("결제 취소 요청 resultData : " + ResultMsg);
			
			if(ResultCode.equals("2001")) { // 취소 성공
				
				int result = orderService.deleteOrder(orderNo);
				log.debug("쿼리문실행 잘 됐나?  result : " + result);
				
				if(result > 0) { // 쿼리문 성공
					session.setAttribute("alertMsg", "용품대여 결제 취소에 성공했습니다!");
					mv.setViewName("redirect:/list.or");
					
				} else { // 쿼리문 실패
					mv.addObject("errorMsg", "결제 취소 실패!")
					  .setViewName("common/errorPage");
				}
				
			} else { // 취소실패
				mv.addObject("errorMsg", "결제 취소 실패!")
				  .setViewName("common/errorPage");
			}
				
		}
		
		return mv;
	}
	
	
	
	

}
