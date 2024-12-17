package com.kh.youcamp.cart.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.youcamp.cart.model.service.CartService;
import com.kh.youcamp.cart.model.vo.Cart;
import com.kh.youcamp.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	
	/**
	 * 24.12.06 10시 윤홍문작성
	 * 장바구니 목록조회 뷰 요청용 컨트롤러
	 * @return
	 */
	@GetMapping("listForm.ca")
	public String cartListViewForm() {
		 return "cart/cartListView";
	}
	
	/**
	 * 24.12.17 15시 윤홍문
	 * 장바구니 리스트 조회용 컨트롤러
	 * @param session
	 * @return 회원번호기준 조회한 장바구니 목록
	 */
	@ResponseBody
	@GetMapping(value="list.ca",
				produces="application/json; charset=UTF-8")
	public String ajaxSelectList(HttpSession session) {
	    Member loginMember = (Member) session.getAttribute("loginMember");
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
	    
	    log.debug("장바구니 리스트뷰 컨트롤러 회원번호 : " + memberNo);

	    ArrayList<Cart> list = cartService.selectList(memberNo);
//	    log.debug("장바구니 AJAX 목록 조회 결과: " + list);

	    return new Gson().toJson(list); // JSON 데이터 반환
	}
	
	
	/**
	 * 장바구니 담기 요청 컨트롤러
	 * @param cart
	 */
	@GetMapping("insert.ca")
	public void insertCart(Cart cart) {
		
		// post 방식으로 처리 필요함@@@@@@@@@@@@@@@@@@@@@@@@
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
		
		log.debug("장바구니 삭제메소드 카트번호" + cartNos);
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
	
	/**
	 * 24.12.17 윤홍문작성
	 * 장바구니 수량 업데이트 요청 메소드
	 * @param cartNo 바꿀 장바구니 번호
	 * @param quantity 바꿀 수량
	 */
	@ResponseBody
	@PostMapping(value="updateQuantity.ca",
				 produces="text/html; charset=UTF-8")
	public String AjaxUpdateCartQuantity(Cart cart,
										 HttpSession session) {
		
		Member loginMember = (Member) session.getAttribute("loginMember");
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
		
	    cart.setMemberNo(memberNo);
		
		log.debug("장바구니 수량업데이트 메소드, cart : " + cart);
		
		int result = cartService.updateCartQuantity(cart);
		
		return (result > 0) ? "success" : "fail";
	}
	
	
	
	
}











