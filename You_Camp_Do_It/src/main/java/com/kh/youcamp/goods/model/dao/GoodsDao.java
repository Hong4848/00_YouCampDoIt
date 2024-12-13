package com.kh.youcamp.goods.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.goods.model.vo.Goods;

@Repository
public class GoodsDao {

	public int insertGoods(SqlSessionTemplate sqlSession, Goods g)
	{
		return sqlSession.insert("goodsMapper.insertGoods", g);
	}

}
