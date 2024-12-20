package com.kh.youcamp.reserve.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.youcamp.common.model.vo.PageInfo;
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

	// 결제 완료 후 예약 내역 상세조회용 서비스 메소드
	Reserve selectAfterReserve(int rNum);

	// 예약 insert 용 서비스 메소드
	int insertReserve(Reserve r);
	
	// 예약 내역 목록조회용 서비스 메소드
	ArrayList<Reserve> selectReserveList(int memberNo);

	// 결제후 방금 예약한 예약번호 조회용 쿼리문
	int selectReserveNo();

	// 예약내역 총 갯수 조회용 서비스 메소드
	int selectListCount(int memberNo);

	// 예약내역 목록조회용 서비스 메소드
	ArrayList<Reserve> selectList(PageInfo pi, int memberNo);

	// 예약내역 상세조회용 서비스 메소드
	Reserve selectReserve(int rno);
	
}
