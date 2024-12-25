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

	// 예약취소 요청용 서비스 메소드
	int deleteReserveRequest(int reserveNo);

	// 중복된 자리 체크용 서비스 메소드
	Reserve selectTempReserve(Reserve r);

	// 임시 예약 insert 용 서비스 메소드
	int insertTempReserve(Reserve r);

	// 임시 예약 delete 용 서비스 메소드
	int deleteTempReserve(int reserveNo);

	// 관리자페이지 예약 갯수 조회용 select 메소드
	int ajaxSelectListCount(String state);

	int totalCount();

	int forestCount();

	int bellyCount();

	int skyCount();

	int stoneCount();

	// 관리자페이지 예약 목록조회용 
	ArrayList<Reserve> ajaxReserveSelect(PageInfo pi, String state);
	
}
