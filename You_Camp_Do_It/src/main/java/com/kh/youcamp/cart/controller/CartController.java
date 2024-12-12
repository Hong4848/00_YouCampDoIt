package com.kh.youcamp.cart.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

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
	public ModelAndView selectList(ModelAndView mv,
								   HttpSession session) {
		
		// 세션에서 유저 번호 가져오기
		Member loginMember = (Member) session.getAttribute("loginMember");
		int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
		System.out.println("장바구니 리스트뷰 컨트롤러 : " + memberNo);

		
		// 로그인 인터셉터 처리 필요함@@@@@@@@@@@@@@@@@@@@@@@@@@
		ArrayList<Cart> list = cartService.selectList(memberNo);
		// list 쿼리문 수정필요@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		
		
		mv.addObject("list", list);
		mv.setViewName("cart/cartListView");
		System.out.println("카트 list 뷰 db 조회 후 컨트롤러 단" + list);
		
		 return mv;
	}
	
	/**
	 * 장바구니 담기 요청 실행 메소드
	 * @param cart
	 */
	@GetMapping("insert.ca")
	public void insertCart(Cart cart) {
		
		// 인터셉터 처리 필요함@@@@@@@@@@@@@@@@@@@@@@@@@@
		// 로그인한 유저번호 세션에서 
		// 장바구니 담기를 누른 페이지의 상품번호, 페이지에서 선택한 수량 쿼리스트링으로
		
		int result = cartService.insertCart(cart);
		
		if(result > 0) { // 성공
			// alert?, modal? 장바구니 담았고, 용품 더볼래? 아님 장바구니 갈래?
			
		} else {
			// 장바구니 담기 실패 다시해줘
		}
		
		
	}
	
	
}











