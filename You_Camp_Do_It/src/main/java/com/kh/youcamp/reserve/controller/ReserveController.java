package com.kh.youcamp.reserve.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.youcamp.reserve.model.service.ReserveService;

@Controller
public class ReserveController {

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
	 * 24.12.09 정성민
	 * 캠핑장 자리선택 페이지 접속요청용 컨트롤러
	 * (추후에 쿼리스트링으로 받아온 변수 처리 해줘야됨!!)@@@@@@@@
	 * @return
	 */
	@GetMapping("reserveDetail.res")
	public String toReserveDetail() {
		
		return "reserve/reserveDetailView";
	}
	
	
	/**
	 * 24.12.09 정성민
	 * 캠핑장 결제 페이지 접속요청용 컨트롤러
	 * (추후에 쿼리스트링으로 받아온 변수 처리해줘야됨!!)@@@@@@@
	 * @return
	 */
	@GetMapping("reservePayment.res")
	public String toReservePayment() {
		
		return "reserve/reservePaymentView";
	}
	
	
	/**
	 * 24.12.10 정성민
	 * 캠핑장 결제 완료 페이지 접속요청용 컨트롤러
	 * (추후에 결제 완료시 이동하도록 조건 걸고 쿼리스트링으로 받아온 변수 처리해줘야됨!!)@@@@
	 * @return
	 */
	@GetMapping("reserveComplete.res")
	public String toReserveComplete() {
		
		return "reserve/reserveCompleteView";
	}
	
	
	/**
	 * 24.12.10 정성민
	 * 캠핑장 예약 내역 페이지 접속요청용 컨트롤러
	 * @return
	 */
	@GetMapping("reserveList.res")
	public String toReserveList() {
		
		return "reserve/reserveListView";
	}
	
	
	@GetMapping("getRestSite.res")
	public 
	
	
	
	
	
	
	
	
	
}







