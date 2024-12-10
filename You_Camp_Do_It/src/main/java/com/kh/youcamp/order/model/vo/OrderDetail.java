package com.kh.youcamp.order.model.vo;

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
public class OrderDetail {
	
	private int orderDetailNo;   // ORDER_DETAIL_NO NUMBER - 주문 상세 번호. 시퀀스로 채번
	private int quantity;        // QUANTITY NUMBER - 수량. 장바구니 상품일 경우 필수
	private double price;        // PRICE NUMBER - 개별 금액
	private double totalPrice;   // TOTAL_PRICE NUMBER - 항목 별 총 금액
	private int goodsNo;         // GOODS_NO NUMBER - 주문하고자 하는 제품 번호
	private int orderNo;         // ORDER_NO NUMBER - 주문 번호

}
