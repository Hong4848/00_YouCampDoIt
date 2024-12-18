package com.kh.youcamp.order.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.order.model.vo.Order;

@Repository
public class OrderDao {

	public int insertOrderAndReturnOrderNo(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.insert("orderMapper.insertOrderAndReturnOrderNo", order);
	}

	

}
