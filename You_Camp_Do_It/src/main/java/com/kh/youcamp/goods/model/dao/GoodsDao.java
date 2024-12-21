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

	public int selectViewCount(SqlSessionTemplate sqlSession, int goods)
	{
		return sqlSession.update("goodsMapper.selectViewCount", goods);
	}

	public Goods selectOneGoods(SqlSessionTemplate sqlSession, int goods)
	{
		return sqlSession.selectOne("goodsMapper.selectOneGoods", goods);
	}

	public ArrayList<Goods> ajaxGoodsSelect(SqlSessionTemplate sqlSession, Search search, PageInfo pi) {
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
		
		return (ArrayList)sqlSession.selectList("goodsMapper.ajaxGoodsSelect", pageSE);
	}

	public int ajaxSelectListCount(SqlSessionTemplate sqlSession){
		return sqlSession.selectOne("goodsMapper.ajaxSelectListCount");
	}

	public int totalCount(SqlSessionTemplate sqlSession, Search search){
		return sqlSession.selectOne("goodsMapper.totalCount");
	}

	public int onSaleCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("goodsMapper.onSaleCount");
	}

	public int offSaleCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("goodsMapper.offSaleCount");
	}

	public int hideCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("goodsMapper.hideCount");
	}

	public ArrayList<Goods> selectGoodsThumbnailList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("goodsMapper.selectGoodsThumbnailList", memberNo);
	}

	public ArrayList<Goods> selectGoodsThumbnailListByOrderNo(SqlSessionTemplate sqlSession, int orderNo) {
		return (ArrayList)sqlSession.selectList("goodsMapper.selectGoodsThumbnailListByOrderNo", orderNo);
	}
}
