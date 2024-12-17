package com.kh.youcamp.goods.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.goods.model.vo.Goods;
import com.kh.youcamp.goods.model.vo.Search;

@Repository
public class GoodsDao {

	public int insertGoods(SqlSessionTemplate sqlSession, Goods g)
	{
		return sqlSession.insert("goodsMapper.insertGoods", g);
	}

	public int selectListCount(SqlSessionTemplate sqlSession)
	{
		return sqlSession.selectOne("goodsMapper.selectListCount");
	}

	public ArrayList<Goods> selectGoodsList(SqlSessionTemplate sqlSession, PageInfo pi)
	{
		Map<String, Object> pageSE = new HashMap<>();
				
		int start = (pi.getCurrentPage() - 1) * pi.getBoardLimit()+1;
		int end = start+pi.getBoardLimit()-1;
		
		pageSE.put("start", start);
		pageSE.put("end", end);

		return (ArrayList)sqlSession.selectList("goodsMapper.selectGoodsList", pageSE);
	}

	public ArrayList<Goods> searchingGoods(SqlSessionTemplate sqlSession, Search search, PageInfo pi)
	{
		Map<String, Object> pageSE = new HashMap<>();
		
		int start = (pi.getCurrentPage() - 1) * pi.getBoardLimit()+1;
		int end = start+pi.getBoardLimit()-1;
		
		pageSE.put("start", start);
		pageSE.put("end", end);
		pageSE.put("searchKeyword", search.getSearchKeyword());
		pageSE.put("searchCategory", search.getSearchCategory());
		pageSE.put("sort", search.getSort());
		pageSE.put("condition", search.getCondition());
		pageSE.put("startPrice", search.getStartPrice());
		pageSE.put("endPrice", search.getEndPrice());
		
		return (ArrayList)sqlSession.selectList("goodsMapper.searchingGoods", pageSE);
	}
}
