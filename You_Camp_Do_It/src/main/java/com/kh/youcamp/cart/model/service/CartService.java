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
	//int deleteCart(String[] cartNoList);
	int deleteCart(String cartNos);
	
}
