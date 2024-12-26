package com.kh.youcamp.reserve.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.reserve.model.dao.ReserveDao;
import com.kh.youcamp.reserve.model.vo.Campsite;
import com.kh.youcamp.reserve.model.vo.Reserve;
import com.kh.youcamp.reserve.model.vo.RestSite;

@Service
public class ReserveServiceImpl implements ReserveService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ReserveDao reserveDao;

	/**
	 * 24.12.18 정성민
	 * 캠핑장 섹션별 남은자리 갯수 조회용 서비스 메소드
	 */
	@Override
	public ArrayList<RestSite> selectRestSiteCounts(Reserve r) {
		
		return reserveDao.selectRestSiteCounts(sqlSession, r);
	}

	/**
	 * 24.12.19 정성민
	 * 캠핑장 예약 가능 자리 조회용 서비스 메소드
	 */
	@Override
	public ArrayList<Campsite> selectRestSites(Reserve r) {
		
		return reserveDao.selectRestSites(sqlSession, r);
	}

	/**
	 * 24.12.20 정성민
	 * 캠핑장 예약 insert 용 서비스 메소드
	 */
	@Override
	public int insertReserve(Reserve r) {
		return reserveDao.insertReserve(sqlSession, r);
	}
	
	/**
	 * 24.12.20 정성민
	 * 결제후 예약번호 조회용 쿼리문
	 */
	@Override
	public int selectReserveNo() {
		return reserveDao.selectReserveNo(sqlSession);
	}
	
	/**
	 * 24.12.20 정성민
	 * 결제후 예약 상세조회용 서비스 메소드
	 */
	@Override
	public Reserve selectAfterReserve(int rNum) {
		return reserveDao.selectAfterReserve(sqlSession, rNum);
	}

	/**
	 * 24.12.20 정성민
	 * 캠핑장 예약 목록조회용 서비스 메소드
	 */
	@Override
	public ArrayList<Reserve> selectReserveList(int memberNo) {
		return null;
	}

	/**
	 * 24.12.20 정성민
	 * 캠핑장 예약내역 총 갯수 조회용 서비스 메소드
	 */
	@Override
	public int selectListCount(int memberNo) {
		return reserveDao.selectListCount(sqlSession, memberNo);
	}

	/**
	 * 24.12.20 정성민
	 * 캠핑장 예약내역 목록 조회용 서비스 메소드
	 */
	@Override
	public ArrayList<Reserve> selectList(PageInfo pi, int memberNo) {
		return reserveDao.selectList(sqlSession, pi, memberNo);
	}

	/**
	 * 24.12.20 정성민
	 * 캠핑장 예약내역 상세 조회용 서비스 메소드
	 */
	@Override
	public Reserve selectReserve(int rno) {
		return reserveDao.selectReserve(sqlSession, rno);
	}

	/**
	 * 24.12.22 정성민
	 * 캠핑장 예약취소 요청용 서비스 메소드
	 */
	@Override
	public int deleteReserveRequest(int reserveNo) {
		return reserveDao.deleteReserveRequest(sqlSession, reserveNo);
	}

	/**
	 * 24.12.23 정성민
	 * 중복된 자리 체크용 서비스 메소드
	 */
	@Override
	public Reserve selectTempReserve(Reserve r) {
		return reserveDao.selectTempReserve(sqlSession, r);
	}

	/**
	 * 24.12.23 정성민
	 * 임시 예약 insert 용 서비스 메소드
	 */
	@Override
	public int insertTempReserve(Reserve r) {
		return reserveDao.insertTempReserve(sqlSession, r);
	}

	/**
	 * 24.12.24 정성민
	 * 임시 예약 delete 용 서비스 메소드
	 */
	@Override
	public int deleteTempReserve(int reserveNo) {
		return reserveDao.deleteTempReserve(sqlSession, reserveNo);
	}

	/**
	 * 관리자페이지 예약 갯수 조회용
	 */
	@Override
	public int ajaxSelectListCount(String state) {
		return reserveDao.ajaxSelectListCount(sqlSession, state);
	}

	@Override
	public int totalCount() {
		return reserveDao.totalCount(sqlSession);
	}

	@Override
	public int forestCount() {
		return reserveDao.forestCount(sqlSession);
	}

	@Override
	public int bellyCount() {
		return reserveDao.bellyCount(sqlSession);
	}

	@Override
	public int skyCount() {
		return reserveDao.skyCount(sqlSession);
	}

	@Override
	public int stoneCount() {
		return reserveDao.stoneCount(sqlSession);
	}

	/**
	 * 관리자페이지 에약 목록조회용
	 */
	@Override
	public ArrayList<Reserve> ajaxReserveSelect(PageInfo pi, String state) {
		return reserveDao.ajaxReserveSelect(sqlSession, pi, state);
	}

	/**
	 * 관리자페이지 예약 상세조회용
	 */
	@Override
	public Reserve ajaxReserveDetail(int reserveNo) {
		return reserveDao.ajaxReserveDetail(sqlSession, reserveNo);
	}

	/**
	 * 주문 결제 시 예약내역 체크용
	 * 24.12.26 윤홍문
	 */
	@Override
	public int selectReserveCount(int memberNo) {
		return reserveDao.selectReserveCount(sqlSession, memberNo);
	}

	
	

}
