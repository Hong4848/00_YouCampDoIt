package com.kh.youcamp.cart.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.youcamp.cart.model.vo.Cart;

public interface CartService {
	
	// 장바구니 목록조회용 서비스
	ArrayList<Cart> selectList(int memberNo);
	
	// 장바구니 담기용 서비스
	int insertCart(Cart cart);

	// 장바구니 삭제용 서비스 Ajax
	int deleteCart(int cartNo);
	
	// 장바구니 수량변경용 서비스 Ajax
	int updateCartQuantity(Cart cart);
	
	// 결제 완로 후 결제된 장바구니 삭제
	int deleteCartByOrderNo(int orderNo);

	// 장바구니 중복체크
	int selectCartCount(int goodsNo);
	
}
