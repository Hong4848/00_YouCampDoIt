package com.kh.youcamp.reserve.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
	 */
	@PostMapping("reserveComplete.res")
	public ModelAndView toReserveComplete(Reserve r, ModelAndView mv, HttpSession session) {
		
		// 예약 정보 insert 하기
		int result = reserveService.insertReserve(r);
		if(result > 0) {
			
			// 방금 insert 한 예약 데이터의 예약번호 가져오기
			int rNum = reserveService.selectReserveNo();
			
			// 예약 번호에 맞는 예약 정보 조회해오기
			Reserve reserveInfo = reserveService.selectAfterReserve(rNum);
			
			session.setAttribute("alertMsg", "캠핑장 예약에 성공했습니다!");
			
			mv.addObject(reserveInfo)
			   .setViewName("reserve/reserveCompleteView");
			
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
		
		System.out.println(r);
		ArrayList<RestSite> restSite = reserveService.selectRestSiteCounts(r);
	    
		System.out.println(restSite);
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
		
		System.out.println(rno);
		
		Reserve r = reserveService.selectReserve(rno);
		
		mv.addObject("r", r)
		  .setViewName("reserve/reserveCompleteView");
		
		
		return mv;
	}
	
	
	
	
	
	
}







