package com.kh.youcamp.reserve.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.youcamp.reserve.model.vo.Campsite;
import com.kh.youcamp.reserve.model.vo.Reserve;
import com.kh.youcamp.reserve.model.vo.RestSite;

public interface ReserveService {
	
	// 24.12.18 정성민 
	// 예약 관련 서비스 메소드

	// 섹션별 남은 자리 갯수 조회용 서비스 메소드
	ArrayList<RestSite> selectRestSiteCounts(Reserve r);

	// 남은 자리 조회용 서비스 메소드
	ArrayList<Campsite> selectRestSites(Reserve r);

	// 예약 내역 상세조회용 서비스 메소드
	Reserve selectReserve(int memberNo);
	
	// 예약 내역 목록조회용 서비스 메소드
	// int selectReserveList();
	
}
