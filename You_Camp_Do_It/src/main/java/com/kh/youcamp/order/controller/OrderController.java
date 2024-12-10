package com.kh.youcamp.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.youcamp.order.model.service.OrderService;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	/**
	 * 24.12.10 17시 윤홍문작성
	 * 주문 폼 요청 컨트롤러 메소드
	 * @return
	 */
	@GetMapping("orderForm.or")
	public String orderForm() {
		
		return "order/orderForm";
		
	}
	
	@GetMapping("orderTest.or")
	public String orderTest() {
		
		return "order/payRequest_utf";
		
	}

}
