package com.kh.youcamp.reserve.controller;


import java.io.File;
import java.text.NumberFormat;
import java.util.ArrayList;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
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
	 * 로그인한 회원 정보 담아 보내기
	 * @return
	 */
	@PostMapping("reservePayment.res")
	public ModelAndView toReservePayment(Reserve r, ModelAndView mv, HttpSession session) {
		
		int memberNo = ((Member)session.getAttribute("loginMember")).getMemberNo();
		
		
		
		mv.addObject("r", r)
		  .addObject("memberNo", memberNo)
		  .setViewName("reserve/reservePaymentView");
		
		return mv;
	}
	
	
	/**
	 * 24.12.10 정성민
	 * 캠핑장 결제 요청 나이스페이 페이지 접속요청 컨트롤러
	 * 
	 * @return
	 */
	
	/*
	@PostMapping("reserveRequirePay.res")
	public ModelAndView reserveRequirePayment(Reserve r, ModelAndView mv, HttpSession session) {
		
		
		
		// 결제 요청 처리 @@@@@@@@@@@@@@@@@@@@@@@
		
		
		
		
		
	}
	*/
	
	
	
	/**
	 * 24.12.20 정성민
	 * 캠핑장 결제 완료 후 예약 확인 페이지 접속요청 컨트롤러
	 * @return
	 * @throws MessagingException 
	 */
	@PostMapping("reserveComplete.res")
	public ModelAndView toReserveComplete(Reserve r, ModelAndView mv, HttpSession session) throws MessagingException {
		
		System.out.println(r);
		
		// 예약 정보 insert 하기
		int result = reserveService.insertReserve(r);
		if(result > 0) {
			
			// 방금 insert 한 예약 데이터의 예약번호 가져오기
			int rNum = reserveService.selectReserveNo();
			
			// 예약 번호에 맞는 예약 정보 조회해오기
			Reserve reserveInfo = reserveService.selectAfterReserve(rNum);
			
			System.out.println(reserveInfo);
			
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
	
	/**
	 * 24.12.22 정성민
	 * 캠핑장 예약취소 요청 처리용 컨트롤러
	 * @param reserveNo
	 * @param mv
	 * @return
	 */
	@GetMapping("reserveCancelRequest.res")
	public ModelAndView deleteReserveRequest(int reserveNo, ModelAndView mv, HttpSession session) {
		
		
		int result = reserveService.deleteReserveRequest(reserveNo);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "캠핑장 예약에 성공했습니다!");
			
			mv.setViewName("redirect:/reservelist.res");
			
		} else {
			mv.addObject("errorMsg", "예약 취소 실패!")
			  .setViewName("common/errorPage");
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







