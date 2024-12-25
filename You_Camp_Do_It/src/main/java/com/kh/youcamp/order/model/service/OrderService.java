package com.kh.youcamp.order.model.service;

import java.util.ArrayList;

import com.kh.youcamp.order.model.vo.Order;
import com.kh.youcamp.order.model.vo.OrderDetail;

public interface OrderService {

	// order DB INSERT
	int insertOrder(Order order);
	
	// INSERT 때 채번한 orderNo 가져오기
	int selectGeneratedOrderNo();

	// orderDetail INSERT
	int insertOrderDetail(OrderDetail orderDetail);

	// order 조회용
	Order selectOrder(int orderNo);

	// orderDetail 조회용
	ArrayList<OrderDetail> selectOrederDetailList(int orderNo);

	// 결제 완료 후 order 테이블에 결제정보 update 용
	int updateOrder(Order order);
	
	// 결제 내역 조회 용
	ArrayList<Order> selectOrederWithDetailListByMemberNo(int memberNo);

	// 결제내용 조회용 썸네일까지
	ArrayList<Order> selectOrederListByMemberNo(int memberNo);

	// 결제 취소용
	int deleteOrder(int orderNo);

	
	
	
	
}
