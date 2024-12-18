package com.kh.youcamp.reserve.controller;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.youcamp.reserve.model.service.ReserveService;
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
	
	

	/**
	 * 24.12.18 정성민
	 * 캠핑장 섹션별 남은 자리 갯수 조회요청용 컨트롤러
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="getRestSite.res", produces="application/json; charset=UTF-8")
	public String selectRestSite(Reserve r) {
		
		System.out.println();
		log.debug(r.getStartDate());
		log.debug(r.getEndDate());
		System.out.println(r);
		
		ArrayList<RestSite> restSite = reserveService.selectRestSite(r);
	    
		
		return new Gson().toJson(restSite);
		
		
	}

	
	
	
	
	
	
	
	
	
}







