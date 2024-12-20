package com.kh.youcamp.goods.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.goods.model.dao.GoodsDao;
import com.kh.youcamp.goods.model.vo.Goods;
import com.kh.youcamp.goods.model.vo.Search;

@Service
public class GoodsServiceImpl implements GoodsService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Autowired
	private GoodsDao goodsDao;
	
	/**
	 * 작성일 : 2024.12.12
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 상품등록 메소드
	 * g : 상품 객체
	 */
	@Override
	public int insertGoods(Goods g)
	{
		return goodsDao.insertGoods(sqlSession, g);
	}

	/**
	 * 작성일 : 2024.12.17
	 * 작성자 : 박진홍
	 * 버전 : 1.0.1
	 * 내용 : 등록된 상품 개수를 반환하는 메소드
	 */
	@Override
	public int selectListCount()
	{
		return goodsDao.selectListCount(sqlSession);
	}

	/**
	 * 작성일 : 2024.12.17
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 등록된 모든 상품 정보를 페이징처리하여 반환하는 메소드
	 */
	@Override
	public ArrayList<Goods> selectGoodsList(PageInfo pi)
	{
		return goodsDao.selectGoodsList(sqlSession, pi);
	}

	/**
	 * 작성일 : 2024.12.17
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 검색 조건에 따른 상품리스트 검색
	 */
	@Override
	public ArrayList<Goods> searchingGoods(Search search, PageInfo pi)
	{
		return goodsDao.searchingGoods(sqlSession, search, pi);
	}

	/**
	 * 작성일 : 2024.12.18
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 상세 보기 조회 수 증가용 쿼리문
	 */
	@Override
	public int selectViewCount(int goods)
	{
		return goodsDao.selectViewCount(sqlSession, goods);
	}

	/**
	 * 작성일 : 2024.12.19
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 상세 보기 데이터 조회용 쿼리문
	 */
	@Override
	public Goods selectOneGoods(int goods)
	{
		return goodsDao.selectOneGoods(sqlSession, goods);
	}

	/**
	 * 작성일 : 2024.12.20
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 관리자 페이지 내용 데이터 조회용 쿼리문
	 */
	@Override
	public ArrayList<Goods> ajaxGoodsSelect(Search search, PageInfo pi) {
		return goodsDao.ajaxGoodsSelect(sqlSession, search, pi);
	}

	/**
	 * 작성일 : 2024.12.20
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 관리자 페이지 내용 데이터 조회용 쿼리문
	 */
	@Override
	public int ajaxSelectListCount() {
		return goodsDao.ajaxSelectListCount(sqlSession);
	}

	/**
	 * 작성일 : 2024.12.20
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 관리자 페이지 전체 개수 조회용 쿼리문
	 */
	@Override
	public int totalCount(Search search) {
		return goodsDao.totalCount(sqlSession, search);
	}

	/**
	 * 작성일 : 2024.12.20
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 관리자 페이지 판매중 개수 조회용 쿼리문
	 */
	@Override
	public int onSaleCount(Search search) {
		return goodsDao.onSaleCount(sqlSession, search);
	}

	/**
	 * 작성일 : 2024.12.20
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 관리자 페이지 품절 개수 조회용 쿼리문
	 */
	@Override
	public int offSaleCount(Search search) {
		return goodsDao.offSaleCount(sqlSession, search);
	}

	/**
	 * 작성일 : 2024.12.20
	 * 작성자 : 박진홍
	 * 버전 : 1.0.0
	 * 내용 : 관리자 페이지 숨김 개수 조회용 쿼리문
	 */
	@Override
	public int hideCount(Search search) {
		return goodsDao.hideCount(sqlSession, search);
	}
}
