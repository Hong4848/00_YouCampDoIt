package com.kh.youcamp.cart.model.service;

import java.util.ArrayList;

import com.kh.youcamp.cart.model.vo.Cart;
import com.kh.youcamp.member.model.vo.Member;

public interface CartService {
	
	// 장바구니 목록조회용 서비스
	ArrayList<Cart> selectList(int memberNo);
	
	// 장바구니 담기용 서비스
	int insertCart(Cart cart);
	
}
