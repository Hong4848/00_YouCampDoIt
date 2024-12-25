package com.kh.youcamp.order.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.order.model.vo.Order;
import com.kh.youcamp.order.model.vo.OrderDetail;

@Repository
public class OrderDao {

	public int insertOrder(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.insert("orderMapper.insertOrder", order);
	}

	public int selectGeneratedOrderNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("orderMapper.selectGeneratedOrderNo");
	}

	public int insertOrderDetail(SqlSessionTemplate sqlSession, OrderDetail orderDetail) {
		return sqlSession.insert("orderMapper.insertOrderDetail", orderDetail);
	}

	public Order selectOrder(SqlSessionTemplate sqlSession, int orderNo) {
		return sqlSession.selectOne("orderMapper.selectOrder", orderNo);
	}

	public ArrayList<OrderDetail> selectOrederDetailList(SqlSessionTemplate sqlSession, int orderNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectOrederDetailList", orderNo);
	}

	public int updateOrder(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.update("orderMapper.updateOrder", order);
	}

	public ArrayList<Order> selectOrederWithDetailListByMemberNo(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectOrederWithDetailListByMemberNo", memberNo);
	}

	public ArrayList<Order> selectOrederListByMemberNo(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectOrederListByMemberNo", memberNo);
	}

	public int deleteOrder(SqlSessionTemplate sqlSession, int orderNo) {
		return sqlSession.update("orderMapper.deleteOrder", orderNo);
	}

	

	

}
