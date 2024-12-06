package com.kh.youcamp.cart.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor // 기본생성자
@AllArgsConstructor // 모든 매개변수 생성자
@Setter // setter 메소드들
@Getter // getter 메소드들
@ToString // toString 메소드
public class Cart {

	private int cartNo;        // CART_NO NUMBER - 장바구니 번호. 시퀀스로 채번
	private int quantity;      // QUANTITY NUMBER - 상품의 수량
	private int price;         // PRICE NUMBER - 항목 총 금액 (제품가격 * 수량)
	private Date addedAt;      // ADDED_AT DATE - 장바구니에 담은 날짜 (30일이 넘으면 삭제)
	private int memberNo;      // MEMBER_NO NUMBER - 장바구니에 담은 회원 번호
	private int goodsNo;       // GOODS_NO NUMBER - 이 회원이 담은 제품의 번호

}
