package com.kh.youcamp.reserve.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.reserve.model.vo.Campsite;
import com.kh.youcamp.reserve.model.vo.Reserve;
import com.kh.youcamp.reserve.model.vo.RestSite;

@Repository
public class ReserveDao {

	/**
	 * 24.12.18 정성민 
	 * 캠핑장 섹션별 남은 자리 갯수 조회용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param r
	 * @return
	 */
	public ArrayList<RestSite> selectRestSiteCounts(SqlSessionTemplate sqlSession, Reserve r) {
		return (ArrayList)sqlSession.selectList("reserveMapper.selectRestSiteCounts", r);
	}

	/**
	 * 24.12.19 정성민
	 * 캠핑장 자리 조회용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param r
	 * @return
	 */
	public ArrayList<Campsite> selectRestSites(SqlSessionTemplate sqlSession, Reserve r) {
		return (ArrayList)sqlSession.selectList("reserveMapper.selectRestSites", r);
	}

	/** 
	 * 24.12.20 정성민
	 * 캠핑장 예약 insert 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param r
	 * @return
	 */
	public int insertReserve(SqlSessionTemplate sqlSession, Reserve r) {
		return sqlSession.insert("reserveMapper.insertReserve", r);
	}
	
	/**
	 * 24.12.20 정성민
	 * 결제후 예약번호 조회용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @return
	 */
	public int selectReserveNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reserveMapper.selectReserveNo");
	}

	/**
	 * 24.12.20 정성민
	 * 캠핑장 예약 상세조회 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param rNum
	 * @return
	 */
	public Reserve selectAfterReserve(SqlSessionTemplate sqlSession, int rNum) {
		return sqlSession.selectOne("reserveMapper.selectReserve", rNum);
	}

	/**
	 * 24.12.20 정성민
	 * 예약내역 총 갯수 조회용 쿼리문
	 * @param sqlSession
	 * @return
	 */
	public int selectListCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("reserveMapper.selectListCount", memberNo);
	}

	/**
	 * 24.12.20 정성민
	 * 예약내역 목록조회용 쿼리문
	 * @param sqlSession
	 * @param pi
	 * @return
	 */
	public ArrayList<Reserve> selectList(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds 
				= new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reserveMapper.selectList", memberNo, rowBounds);
	}

	/**
	 * 24.12.20 정성민
	 * 예약내역 상세조회용 쿼리문
	 * @param sqlSession
	 * @param rno
	 * @return
	 */
	public Reserve selectReserve(SqlSessionTemplate sqlSession, int rno) {
		return sqlSession.selectOne("reserveMapper.selectReserve", rno);
	}

	/**
	 * 24.12.20 정성민
	 * 캠핑장 예약취소 요청용 쿼리문
	 * @param sqlSession
	 * @param reserveNo
	 * @return
	 */
	public int deleteReserveRequest(SqlSessionTemplate sqlSession, int reserveNo) {
		return sqlSession.update("reserveMapper.deleteReserveRequest", reserveNo);
	}

	/**
	 * 24.12.23 정성민
	 * 임시 자리 체크용 쿼리문
	 * @param sqlSession
	 * @param r
	 * @return
	 */
	public Reserve selectTempReserve(SqlSessionTemplate sqlSession, Reserve r) {
		return sqlSession.selectOne("reserveMapper.selectTempReserve", r);
	}

	/**
	 * 24.12.23 정성민
	 * 임시 예약 insert 용 쿼리문
	 * @param sqlSession
	 * @param r
	 * @return
	 */
	public int insertTempReserve(SqlSessionTemplate sqlSession, Reserve r) {
		return sqlSession.insert("reserveMapper.insertTempReserve", r);
	}

	/**
	 * 24.12.24 정성민
	 * @param sqlSession
	 * @param reserveNo
	 * @return
	 */
	public int deleteTempReserve(SqlSessionTemplate sqlSession, int reserveNo) {
		return sqlSession.delete("reserveMapper.deleteTempReserve", reserveNo);
	}

	/**
	 * 관리자 페이지 갯수 조회용
	 * @param sqlSession
	 * @param state
	 * @return
	 */
	public int ajaxSelectListCount(SqlSessionTemplate sqlSession, String state) {
		return sqlSession.selectOne("reserveMapper.ajaxSelectListCount", state);
	}

	public int totalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reserveMapper.totalCount");
	}

	public int forestCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reserveMapper.forestCount");
	}

	public int bellyCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reserveMapper.bellyCount");
	}

	public int skyCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reserveMapper.skyCount");
	}

	public int stoneCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reserveMapper.stoneCount");
	}

	/**
	 * 관리자페이지 예약 목록 조회용
	 * @param sqlSession
	 * @param pi
	 * @param state
	 * @return
	 */
	public ArrayList<Reserve> ajaxReserveSelect(SqlSessionTemplate sqlSession, PageInfo pi, String state) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds 
				= new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reserveMapper.ajaxReserveSelect", state, rowBounds);
	}

	/**
	 * 관리자페이지 예약 상세 조회용
	 * @param sqlSession
	 * @param reserveNo
	 * @return
	 */
	public Reserve ajaxReserveDetail(SqlSessionTemplate sqlSession, int reserveNo) {
		return sqlSession.selectOne("reserveMapper.ajaxReserveDetail", reserveNo);
	}

	public int selectReserveCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("reserveMapper.selectReserveCount", memberNo);
	}

	/**
	 * 관리자페이지 예약상태 수정용 쿼리문
	 * @param sqlSession
	 * @param r
	 * @return
	 */
	public int ajaxReserveDetailUpdate(SqlSessionTemplate sqlSession, Reserve r) {
		return sqlSession.update("reserveMapper.ajaxReserveDetailUpdate", r);
	}

	

	
	
	
	
	

}
