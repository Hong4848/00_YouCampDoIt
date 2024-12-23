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

	/* 상품정보 등록 */
	public int insertGoods(SqlSessionTemplate sqlSession, Goods g)
	{
		return sqlSession.insert("goodsMapper.insertGoods", g);
	}

	/* 등록된 상품 중 '판매', '품절' 개수 조회 */
	public int selectListCount(SqlSessionTemplate sqlSession)
	{
		return sqlSession.selectOne("goodsMapper.selectListCount");
	}

	/* 등록된 상품 중 '판매', '품절' 상품 리스트 조회 */
	public ArrayList<Goods> selectGoodsList(SqlSessionTemplate sqlSession, PageInfo pi)
	{
		Map<String, Object> pageSE = new HashMap<>();
				
		int start = (pi.getCurrentPage() - 1) * pi.getBoardLimit()+1;
		int end = start+pi.getBoardLimit()-1;
		
		pageSE.put("start", start);
		pageSE.put("end", end);

		return (ArrayList)sqlSession.selectList("goodsMapper.selectGoodsList", pageSE);
	}

	/* 상품 검색 리스트 조회 */
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

	/* 상품 조회수 증가 */
	public int selectViewCount(SqlSessionTemplate sqlSession, int goods)
	{
		return sqlSession.update("goodsMapper.selectViewCount", goods);
	}
	
	/* 상품 상세 내용 조회 */
	public Goods selectOneGoods(SqlSessionTemplate sqlSession, int goods)
	{
		return sqlSession.selectOne("goodsMapper.selectOneGoods", goods);
	}

	/* 관리자 페이지 상품 전체 리스트 조회 */
	public ArrayList<Goods> ajaxGoodsSelect(SqlSessionTemplate sqlSession, Search search, PageInfo pi, String state) {
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
		pageSE.put("state", state);
		
		return (ArrayList)sqlSession.selectList("goodsMapper.ajaxGoodsSelect", pageSE);
	}

	/* 관리자 페이지 선택적 리스트 개수 */
	public int ajaxSelectListCount(SqlSessionTemplate sqlSession, String state){
		return sqlSession.selectOne("goodsMapper.ajaxSelectListCount", state);
	}

	/* 전체 상품 개수 */
	public int totalCount(SqlSessionTemplate sqlSession, Search search){
		return sqlSession.selectOne("goodsMapper.totalCount");
	}

	/* 판매 상품 개수 */
	public int onSaleCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("goodsMapper.onSaleCount");
	}

	/* 품절 상품 개수 */
	public int offSaleCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("goodsMapper.offSaleCount");
	}

	/* 숨김 상품 개수 */
	public int hideCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("goodsMapper.hideCount");
	}
	
	/* 관리자 페이지 상세 정보 조회 */
	public Goods ajaxGoodsDetail(SqlSessionTemplate sqlSession, int goodsNo) {
		return sqlSession.selectOne("goodsMapper.ajaxGoodsDetail", goodsNo);
	}

	/* 관리자 페이지 상세 정보 수정 */
	public int ajaxGoodsDetailUpdate(SqlSessionTemplate sqlSession, Goods g) {
		return sqlSession.update("goodsMapper.ajaxGoodsDetailUpdate", g);
	}
	
/************************************************************************************************************************/	
/************************************************************************************************************************/	
/************************************************************************************************************************/	
	
	public ArrayList<Goods> selectGoodsThumbnailList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("goodsMapper.selectGoodsThumbnailList", memberNo);
	}

	public ArrayList<Goods> selectGoodsThumbnailListByOrderNo(SqlSessionTemplate sqlSession, int orderNo) {
		return (ArrayList)sqlSession.selectList("goodsMapper.selectGoodsThumbnailListByOrderNo", orderNo);
	}
}
