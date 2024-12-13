package com.kh.youcamp.cart.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
		Member loginMember = 
				(Member) session.getAttribute("loginMember");
		int memberNo = 
				(loginMember != null) ? loginMember.getMemberNo() : 0;
//		System.out.println("장바구니 리스트뷰 컨트롤러 : " + memberNo);

		// 로그인 인터셉터 처리 필요함@@@@@@@@@@@@@@@@@@@@@@@@@@
		ArrayList<Cart> list = cartService.selectList(memberNo);
				
		mv.addObject("list", list);
		mv.setViewName("cart/cartListView");
//		System.out.println("카트 list 뷰 db 조회 후 컨트롤러 단" + list);
		
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
	
	/**
	 * 24.12.13 윤홍문
	 * 장바구니 삭제 메소드
	 * @param cartNos 삭제할 카트 번호 - 쉼표가 포함된 문자열(숫자아님)
	 * @return 쿼리문실행결과
	 * 
	 * 목록조회 ajax 로 바꿔야함
	 */
	@ResponseBody
	@PostMapping(value="delete.ca",
				 produces="text/html; charset=UTF-8")
	public String AjaxDeleteCart(String cartNos) {
		
		System.out.println(cartNos);
		// null 또는 공백만있거나 또는 빈문자열"" 이면
		// 빈배열 [] 할당
		String[] cartNoList = 
			    (cartNos == null || cartNos.trim().isEmpty()) 
			    			? new String[0] : cartNos.split(",");
		int result = 0;
		for (int i = 0; i < cartNoList.length; i++) {
			result += 
				cartService.deleteCart( Integer.parseInt(cartNoList[i]));
        }
		
		return (result > 0) ? "success" : "fail";
	}
	
	
}











