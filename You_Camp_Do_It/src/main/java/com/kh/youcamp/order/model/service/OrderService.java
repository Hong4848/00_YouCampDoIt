package com.kh.youcamp.order.model.service;

import com.kh.youcamp.order.model.vo.Order;
import com.kh.youcamp.order.model.vo.OrderDetail;

public interface OrderService {

	// order DB INSERT 및 orderNo 반환
	int insertOrderAndReturnOrderNo(Order order);
	
	
	
}
