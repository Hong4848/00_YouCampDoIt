package com.kh.youcamp.cart.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.cart.model.service.CartService;
import com.kh.youcamp.cart.model.vo.Cart;
import com.kh.youcamp.member.model.vo.Member;

@Controller
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	
	/**
	 * 24.12.06 10시 윤홍문작성
	 * 장바구니 목록조회 뷰 접속 용 컨트롤러
	 * @return
	 */
	@GetMapping("list.ca")
	public ModelAndView selectList(Member m, 
								 ModelAndView mv, 
								 Model model) {
		
		// 헤더에서 memberNo 넘겨야함@@@@@@@@@@@@@@@@@@@@@@@@@
		// 또는 세션에서 로그인 정보, memberNo 가져오기
		
		
		// 인터셉터 처리 필요함@@@@@@@@@@@@@@@@@@@@@@@@@@
		ArrayList<Cart> list = cartService.selectList(m);
		
		mv.addObject("list", list);
		mv.setViewName("cart/cartListView");
		
		return mv;
	}
	
	@GetMapping("insert.ca")
	public void insertCart(Cart cart) {
		
		// 인터셉터 처리 필요함@@@@@@@@@@@@@@@@@@@@@@@@@@
		
		int result = cartService.insertCart(cart);
		
		if(result > 0) { // 성공
			// alert?, modal? 장바구니 담았고, 용품 더볼래? 아님 장바구니 갈래?
			
		} else {
			// 장바구니 담기 실패 다시해줘
		}
		
		
	}
	
	
}











