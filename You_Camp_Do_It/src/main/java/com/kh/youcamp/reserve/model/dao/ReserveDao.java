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

	

	
	
	
	
	

}
