package com.kh.youcamp.cart.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.youcamp.cart.model.service.CartService;
import com.kh.youcamp.cart.model.vo.Cart;
import com.kh.youcamp.goods.model.service.GoodsService;
import com.kh.youcamp.goods.model.vo.Goods;
import com.kh.youcamp.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private GoodsService goodsService;
	
	
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

	    ArrayList<Cart> cList = cartService.selectList(memberNo);
//	    log.debug("장바구니 AJAX 목록 조회 결과: " + cList);
		
	    // 썸네일가져오기
	    ArrayList<Goods> gList = goodsService.selectGoodsThumbnailList(memberNo);
		// 섬네일 이미지 추출 (썸네일컬럼 img 부터 짤라서 div에 넣기)
	    for(Goods g : gList){
			String s = "<img src="; // 이미지 태그 찾기
			String body = g.getGoodsThumbnail();
			int start = 0;
			int end = 0;
			
			start = body.indexOf(s);
			body = body.substring(start);
			end = body.indexOf(">");
			body = body.substring(0, end+1);
			
			g.setGoodsThumbnail(body);
		}
	    
	    Map<String, Object> result = new HashMap<>();
	    result.put("cartList", cList);
	    result.put("goodsList", gList);
	    
	    return new Gson().toJson(result); // JSON 데이터 반환
	}
	

	/**
	 * 24.12.20 16시 윤홍문
	 * 장바구니 담기 요청 컨트롤러
	 * @param cart
	 */
	@PostMapping("insert.ca")
	public String insertCart(Cart cart,
						     HttpSession session,
						     Model model) {
		
		Member loginMember = (Member) session.getAttribute("loginMember");
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
	    cart.setMemberNo(memberNo);
//	    log.debug("cart : " + cart);
	    
	    // 장바구니에 중복으로 담는지 확인
	    int count = cartService.selectCartCount(cart.getGoodsNo());
	    if(count > 0) { // 장바구니 중복
	    	session.setAttribute("alertMsg", "장바구니에서 수량을 변경해주세요");
			return "redirect:/product.gs";
	    }
		
		int result = cartService.insertCart(cart);
		log.debug("certINSERT 됐냐? result : " + result);
		
		if(result > 0) { // 성공
			session.setAttribute("alertMsg", "장바구니 담기 성공");
			return "redirect:/product.gs";
		} else {
			// 에러 문구를 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "장바구니 담기 실패");
			return "common/errorPage";
		}
		
	}
	
	/**
	 * 24.12.13 윤홍문
	 * 장바구니 삭제 메소드
	 * @param cartNos 삭제할 카트 번호 - 쉼표가 포함된 문자열(숫자아님)
	 * @return 쿼리문실행결과
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
		/*
		 * *= 활용 하나의 삭제 메소드라도 실패하면 result 전체값이 0 으로 실패
		 * 근데 서비스 단에 트랜잭션이 있으니 이미 삭제되서 되돌릴수 없지 않나?
		 * 컨트롤러에서 결과는 이미 커밋 된 후 시점인데..? 어떻게 처리?
		 * 서비스에서 반복문을 돌려야 할듯..?
		 * 
		 * 서비스메소드1 삭제서비스메소드를 배열의길이만큼 반복시키는 메소드
		 * 서비스메소드2 삭제서비스메소드
		 * 
		 */
		
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
		
//		log.debug("장바구니 수량업데이트 메소드, cart : " + cart);
		
		int result = cartService.updateCartQuantity(cart);
		
		return (result > 0) ? "success" : "fail";
	}
	
	
	
	
}











