package com.kh.youcamp.goods.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.youcamp.goods.model.dao.GoodsDao;
import com.kh.youcamp.goods.model.vo.Goods;

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
	public int insertGoods(Goods g) {
		System.out.println(g);
		return goodsDao.insertGoods(sqlSession, g);
	}

}
