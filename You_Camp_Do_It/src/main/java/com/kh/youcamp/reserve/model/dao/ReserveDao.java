package com.kh.youcamp.reserve.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	
	
	
	

}
