package com.kh.youcamp.reserve.controller;


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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.common.template.Pagination;
import com.kh.youcamp.member.model.vo.Member;
import com.kh.youcamp.order.util.DataEncrypt;
import com.kh.youcamp.reserve.model.service.ReserveService;
import com.kh.youcamp.reserve.model.vo.Campsite;
import com.kh.youcamp.reserve.model.vo.Reserve;
import com.kh.youcamp.reserve.model.vo.RestSite;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReserveController {

	@Autowired
	private ReserveService reserveService;
	
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
	
	// --------------------------------------------------------------------
		
			
	
	/**
	 * 24.12.09 정성민
	 * 날짜 및 섹션선택 페이지 접속요청용 컨트롤러
	 * @return
	 */
	@GetMapping("reserveDate.res")
	public String toReserveDate() {
		
		return "reserve/reserveDateView";
	}
	
	
	/**
	 * 24.12.09 정성민 => 24.12.19
	 * 캠핑장 자리선택 페이지 접속요청용 컨트롤러
	 * 해당 섹션의 남은자리 조회도 동시에 처리
	 * (추후에 쿼리스트링으로 받아온 변수 처리 해줘야됨!!)@@@@@@@@ -> 완료
	 * 해당 섹션의 이용가능한 자리 조회해와야함!
	 * @return
	 */
	@GetMapping(value="reserveDetail.res", produces="application/json; charset=UTF-8")
	public ModelAndView toReserveDetail(String section, String checkIn, String checkOut, String stay, String price, ModelAndView mv) {
		
		Reserve r = new Reserve();
		r.setSection(section);
		r.setStartDate(checkIn);
		r.setEndDate(checkOut);
		int nights = Integer.parseInt(stay);
		r.setNights(nights);
		
		ArrayList<Campsite> restSites = reserveService.selectRestSites(r);
		
		mv.addObject("section", section)
		  .addObject("checkIn", checkIn)
		  .addObject("checkOut", checkOut)
		  .addObject("stay", stay)
		  .addObject("price", price)
		  .addObject("restSites", restSites)
		  .setViewName("reserve/reserveDetailView");
		
		return mv;
	}
	
	
	/**
	 * 24.12.09 정성민
	 * 캠핑장 결제 페이지 접속요청용 컨트롤러
	 * (추후에 쿼리스트링으로 받아온 변수 처리해줘야됨!!)@@@@@@@ -> 완료
	 * 결제관련 기능구현 24.12.24 윤홍문
	 * 로그인한 회원 정보 담아 보내기
	 * @return
	 */
	@PostMapping("reservePayment.res")
	public ModelAndView toReservePayment(Reserve r, ModelAndView mv, HttpSession session) {
		
		int memberNo = ((Member)session.getAttribute("loginMember")).getMemberNo();
		
		// --------------------------------------------------
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
		String price =  r.getPrice()+"";
		log.debug("price : " + price);
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
		
		
		mv.addObject("merchantKey", merchantKey);
		mv.addObject("merchantID", merchantID);
		mv.addObject("goodsName", goodsName);
		// model.addAttribute("price", price);
		// model.addAttribute("buyerName", buyerName);
		// model.addAttribute("buyerTel", buyerTel);
		// model.addAttribute("buyerEmail", buyerEmail);
		mv.addObject("moid", moid);
		// model.addAttribute("returnURL", returnURL);
		mv.addObject("ediDate", ediDate);
		mv.addObject("hashString", hashString);
		// ---------------------------------------------------
		
		mv.addObject("r", r)
		  .addObject("memberNo", memberNo)
		  .setViewName("reserve/reservePaymentView");
		
		return mv;
	}
	
	// 이거 필요없음
	/**
	 * 24.12.10 정성민
	 * 캠핑장 결제 요청 나이스페이 페이지 접속요청 컨트롤러
	 * 여기서 결제 완료 구문 처리
	 * @return
	 */
	/*
	@PostMapping("reserveRequirePay.res")
	public ModelAndView reserveRequirePayment(Reserve r, ModelAndView mv, HttpSession session) {
		
		
		
		// 결제 요청 처리 @@@@@@@@@@@@@@@@@@@@@@@
		
		
		
		
		
	}*/
	
	
	
	
	/**
	 * 24.12.20 정성민
	 * 캠핑장 결제 완료 후 예약 확인 페이지 접속요청 컨트롤러
	 * 결제완료 정보 추가 24.12.24 윤홍문
	 * @return
	 * @throws Exception 
	 */
	@PostMapping("reserveComplete.res")
	public ModelAndView toReserveComplete(Reserve r, 
										  Model model, 
										  HttpServletRequest request,
										  ModelAndView mv, 
										  HttpSession session) throws Exception {
		
//		System.out.println(r);
		
		
		
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
					// 예약 정보 insert 하기
					r.setPaymentId(TID);
					r.setPaymentMethod(PayMethod);
//					log.debug("결제 완료 후 insrt 예정 정보 insert 직전 : " + r);
					int result = reserveService.insertReserve(r);
					if(result > 0) {
						
						// 방금 insert 한 예약 데이터의 예약번호 가져오기
						int rNum = reserveService.selectReserveNo();
						
						// 예약 번호에 맞는 예약 정보 조회해오기
						Reserve reserveInfo = reserveService.selectAfterReserve(rNum);
						
//						System.out.println(reserveInfo);
						
						if(reserveInfo != null) {
							session.setAttribute("alertMsg", "캠핑장 예약에 성공했습니다!");
							
							String afterPayment = "o";
							
							mv.addObject("r", reserveInfo)
							  .addObject("afterPayment", afterPayment)
							  .setViewName("reserve/reserveCompleteView");
							
							Member loginMember = (Member)session.getAttribute("loginMember");
							
							MimeMessage message = mailSender.createMimeMessage();
							
							MimeMessageHelper mimeMessageHelper
							= new MimeMessageHelper(message, true, "UTF-8");
							
							String formattedStartDate = reserveInfo.getStartDate().substring(0, 10);
							String formattedPaymentDate = reserveInfo.getPaymentDate().substring(0, 19); // "2024-12-22 01:34:25"
							
							int price = reserveInfo.getPrice(); // 결제금액은 int로 가정
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
								                + "<h2 style='color: #333333; text-align: center;'>예약 정보 안내</h2>"
								                + "<table style='width: 100%; border-collapse: collapse; margin: 20px 0;'>"
								                    + "<tr>"
								                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>예약번호</td>"
								                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + reserveInfo.getReserveNo() + "</td>"
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
								                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>예약일자</td>"
								                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + formattedStartDate + " (" + reserveInfo.getNights() + "박)" + "</td>"
								                    + "</tr>"
								                    + "<tr>"
								                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>사이트명</td>"
								                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + reserveInfo.getSection() + "-" + reserveInfo.getSpotNo() + "</td>"
								                    + "</tr>"
								                    + "<tr>"
								                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>결제일자</td>"
								                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + formattedPaymentDate + "</td>"
								                    + "</tr>"
								                    + "<tr>"
								                        + "<td style='padding: 10px; border: 1px solid #ddd; font-weight: bold; background-color: #f9f9f9; width: 150px;'>결제금액</td>"
								                        + "<td style='padding: 10px; border: 1px solid #ddd;'>" + formattedPrice + "</td>"
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
							mimeMessageHelper.setSubject("[YouCampDoIt] 예약 안내");
							mimeMessageHelper.setText(emailContent, true); // 내용
							
							mimeMessageHelper.setTo(loginMember.getEmail());
							
							FileSystemResource logo = new FileSystemResource(new File("C:\\YouCampDoIt\\You_Camp_Do_It\\src\\main\\webapp\\resources\\images\\mainPage\\메인로고.png")); // 로고 이미지 파일 경로
							mimeMessageHelper.addInline("companyLogo", logo);
							
							mailSender.send(message);
							
							
						} else {
							
							mv.addObject("errorMsg", "결제 실패!")
							  .setViewName("common/errorPage");
						}
						
						
					} else {
						
						mv.addObject("errorMsg", "결제 실패!")
						  .setViewName("common/errorPage");
						
					}
					
					// 결제완료하고 이메일 전송까지 성공하면

					model.addAttribute("resultJsonStr", resultJsonStr);
					model.addAttribute("ResultCode", ResultCode);
				    model.addAttribute("ResultMsg", ResultMsg);
				    model.addAttribute("PayMethod", PayMethod);
				    model.addAttribute("GoodsName", GoodsName);
				    model.addAttribute("Amt", Amt);
				    model.addAttribute("TID", TID);
					
				    return mv;
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
	    mv.setViewName("common/errorPage");
		return mv;
	}
	

	/**
	 * 24.12.18 정성민
	 * 캠핑장 섹션별 남은 자리 갯수 조회요청용 컨트롤러
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="getRestSite.res", produces="application/json; charset=UTF-8")
	public String selectRestSite(Reserve r) {
		
		
		ArrayList<RestSite> restSite = reserveService.selectRestSiteCounts(r);
	    
		
		return new Gson().toJson(restSite);
	}


	/**
	 * 24.12.10 정성민
	 * 캠핑장 예약 내역 목록 페이지 접속요청용 컨트롤러
	 * @return
	 */
	@GetMapping("reserveList.res")
	public String toReserveList(@RequestParam(value="cpage", defaultValue="1")int currentPage, Model model, HttpSession session) {
		
		// 회원번호 가져오기
		int memberNo = ((Member)session.getAttribute("loginMember")).getMemberNo();
		
		// 페이징 처리용 변수 7개
		int listCount = reserveService.selectListCount(memberNo);
		
		int pageLimit = 5;
		int boardLimit = 5;
		
		
		PageInfo pi 
		= Pagination.getPageInfo(listCount, currentPage, 
								 pageLimit, boardLimit);
	
		ArrayList<Reserve> list = reserveService.selectList(pi, memberNo);
		
		// 응답데이터로 목록 및 페이징바 관련 객체를 넘기고
		// 게시글 목록 조회 페이지를 포워딩
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "reserve/reserveListView";
	}
	
	
	/**
	 * 24.12.20 정성민
	 * 캠핑장 예약내역 상세조회 요청용 컨트롤러
	 * @param rno
	 * @param mv
	 * @return
	 */
	@GetMapping("reserveComplete.res")
	public ModelAndView selectReserve(int rno, ModelAndView mv) {
		
		Reserve r = reserveService.selectReserve(rno);
		
		mv.addObject("r", r)
		  .setViewName("reserve/reserveCompleteView");
		
		
		return mv;
	}
	
	@GetMapping("cancleTest.rev")
	public ModelAndView cancleReqTest(ModelAndView mv) {
		
		mv.setViewName("order/cancelRequest_utf");
		
		return mv;
	}
	
	@PostMapping("cancleResultTest.rev")
	public ModelAndView cancleResultTest(ModelAndView mv) {
		
		mv.setViewName("order/cancelResult_utf");
		
		return mv;
	}
	
	
	/**
	 * 24.12.21 정성민 
	 * 캠핑장 예약취소 페이지 요청용 컨트롤러
	 * @param reserveNo
	 * @param mv
	 * @return
	 */
	@GetMapping("reserveCancel.res")
	public ModelAndView toReserveCancel(int reserveNo, ModelAndView mv) {
		
		Reserve r = reserveService.selectReserve(reserveNo);
		
		mv.addObject("r", r)
		  .setViewName("reserve/reserveCancelView");
		
		return mv;
	}
	/*
	 * 
	 * 취소 흐름 현재 관리자 페이지가 구성되있지 않아 2번으로 구현
	 * 사용자의 취소요청 > 관리자페이지에서 승인 및 나이스페이 취소 실행 > db 업데이트
	 * 사용자의 취소요청 > 나이스페이 결제 취소 > 관리자가 상태 update (취소자체는 나이스페이 및 카드사가 바로 진행)
	 */
	/**
	 * 24.12.22 정성민
	 * 캠핑장 예약취소 요청 처리용 컨트롤러
	 * @param reserveNo
	 * @param mv
	 * @param request 
	 * @return
	 * 예약 취소는 db데이터 변동이니까 post로 변경
	 * @throws Exception 
	 */
	@PostMapping("reserveCancelRequest.res")
	public ModelAndView deleteReserveRequest(int reserveNo, 
											 ModelAndView mv, 
											 HttpSession session, 
											 ServletRequest request) throws Exception {
		
		/*
		****************************************************************************************
		* <취소요청 파라미터>
		* 취소시 전달하는 파라미터입니다.
		* 샘플페이지에서는 기본(필수) 파라미터만 예시되어 있으며, 
		* 추가 가능한 옵션 파라미터는 연동메뉴얼을 참고하세요.
		****************************************************************************************
		*/
		String tid 					= (String)request.getParameter("TID");	// 거래 ID
		String cancelAmt 			= (String)request.getParameter("CancelAmt");	// 취소금액
		String partialCancelCode 	= (String)request.getParameter("PartialCancelCode"); 	// 부분취소여부
		String mid 					= "nicepay00m";	// 상점 ID
		String moid					= "nicepay_api_3.0_test";	// 주문번호
		String cancelMsg 			= "고객요청";	// 취소사유

		/*
		****************************************************************************************
		* <해쉬암호화> (수정하지 마세요)
		* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
		****************************************************************************************
		*/
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg=="; // 상점키
		String ediDate			= getyyyyMMddHHmmss();
		String signData 		= sha256Enc.encrypt(mid + cancelAmt + ediDate + merchantKey);

		/*
		****************************************************************************************
		* <취소 요청>
		* 취소에 필요한 데이터 생성 후 server to server 통신을 통해 취소 처리 합니다.
		* 취소 사유(CancelMsg) 와 같이 한글 텍스트가 필요한 파라미터는 euc-kr encoding 처리가 필요합니다.
		****************************************************************************************
		*/
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

		/*
		****************************************************************************************
		* <취소 결과 파라미터 정의>
		* 샘플페이지에서는 취소 결과 파라미터 중 일부만 예시되어 있으며, 
		* 추가적으로 사용하실 파라미터는 연동메뉴얼을 참고하세요.
		****************************************************************************************
		*/
		String ResultCode 	= ""; String ResultMsg 	= ""; String CancelAmt 	= "";
		String CancelDate 	= ""; String CancelTime = ""; String TID 		= ""; String Signature = "";

		/*  
		****************************************************************************************
		* Signature : 요청 데이터에 대한 무결성 검증을 위해 전달하는 파라미터로 허위 결제 요청 등 결제 및 보안 관련 이슈가 발생할 만한 요소를 방지하기 위해 연동 시 사용하시기 바라며 
		* 위변조 검증 미사용으로 인해 발생하는 이슈는 당사의 책임이 없음 참고하시기 바랍니다.
		****************************************************************************************
		 */
		//String Signature = ""; String cancelSignature = "";

		if("9999".equals(resultJsonStr)){
			ResultCode 	= "9999";
			ResultMsg	= "통신실패";
			
			mv.addObject("errorMsg", "예약 취소 실패!")
			  .setViewName("common/errorPage");
		}else{ // 통신성공
			
			HashMap resultData = jsonStringToHashMap(resultJsonStr);
			ResultCode 	= (String)resultData.get("ResultCode");	// 결과코드 (취소성공: 2001, 취소성공(LGU 계좌이체):2211)
			ResultMsg 	= (String)resultData.get("ResultMsg");	// 결과메시지
			CancelAmt 	= (String)resultData.get("CancelAmt");	// 취소금액
			CancelDate 	= (String)resultData.get("CancelDate");	// 취소일
			CancelTime 	= (String)resultData.get("CancelTime");	// 취소시간
			TID 		= (String)resultData.get("TID");		// 거래아이디 TID
			//Signature       	= (String)resultData.get("Signature");
			//cancelSignature = sha256Enc.encrypt(TID + mid + CancelAmt + merchantKey);
			log.debug("결제 취소 요청 ResultCode : " + ResultCode);
			log.debug("결제 취소 요청 resultData : " + ResultMsg);
			
			if(ResultCode.equals("2001")) { // 취소 성공
				
				int result = reserveService.deleteReserveRequest(reserveNo);
				log.debug("쿼리문실행 잘 됐나?  result : " + result);
				
				if(result > 0) { // 쿼리문 성공
					session.setAttribute("alertMsg", "캠핑장 예약 취소에 성공했습니다!");
					mv.setViewName("redirect:/reservelist.res");
					
				} else { // 쿼리문 실패
					mv.addObject("errorMsg", "예약 취소 실패!")
					  .setViewName("common/errorPage");
				}
				
			} else { // 취소실패
				mv.addObject("errorMsg", "예약 취소 실패!")
				  .setViewName("common/errorPage");
			}
				
		}
		
		
		
		return mv;
	}
	
	
	/**
	 * 24.12.23 정성민
	 * 중복된 자리 체크용 컨트롤러
	 * @param r
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="checkDuplicate.res", produces="text/html; charset=UTF-8")
	public String selectTempReserve(Reserve r) {
		
		Reserve r1 = reserveService.selectTempReserve(r);
		
		if(r1 == null) {
			
			return "해당 자리 이용 가능";
		} else {
			
			return "해당 자리 존재";
		}
	}
	
	
	/**
	 * 24.12.23 정성민
	 * 임시 예약 insert 용 컨트롤러
	 * @param r
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="tempInsert.me", produces="application/json; charset=UTF-8")
	public String insertTempReserve(Reserve r) {
		
		int randomNumber = (int)(Math.random() * 900000) + 100000; // 100000 ~ 999999
        r.setPaymentId(String.valueOf(randomNumber));
		
		int result = reserveService.insertTempReserve(r);
		
		JSONObject jObj = new JSONObject();
		
		if(result > 0) {
			
			// 방금 insert 한 예약 데이터의 예약번호 가져오기
			int rNum = reserveService.selectReserveNo();
			
			jObj.put("status", "success");
			jObj.put("reserveNo", rNum);
		} else {
			jObj.put("status", "fail");
			jObj.put("reserveNo", null);
			
		}	
		
		return jObj.toJSONString();
		
	}
	
	/**
	 * 24.12.23 정성민
	 * 임시 예약 delete 용 컨트롤러
	 * @param tempReserveNo
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="tempDelete.me", produces="text/html; charset=UTF-8")
	public String deleteTempReserve(int reserveNo) {
		
		
		int result = reserveService.deleteTempReserve(reserveNo);
		
		
		
		if(result > 0) {
			
			return "성공";
		} else {
			
			return "실패";
		}
		
	}
	
	
}







