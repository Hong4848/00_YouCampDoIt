package com.kh.youcamp.reserve.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.reserve.model.vo.Reserve;
import com.kh.youcamp.reserve.model.vo.RestSite;

@Repository
public class ReserveDao {

	/**
	 * 24.12.18 정성민 
	 * 캠핑장 섹션별 남은 자리 갯수 조회용 쿼리문
	 * @param sqlSession
	 * @param r
	 * @return
	 */
	public ArrayList<RestSite> selectRestSite(SqlSessionTemplate sqlSession, Reserve r) {
		ArrayList<RestSite> rs = (ArrayList)sqlSession.selectList("reserveMapper.selectRestSite", r);
		System.out.println(rs);
		return rs;
	}
	
	

}
