package com.kh.youcamp.order.model.vo;

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
public class Order {
	
	private int orderNo;             // ORDER_NO NUMBER - 주문 번호
	private String paymentId;        // PAYMENT_ID VARCHAR2(60 BYTE) - 결제 ID
	private int totalPrice;          // TOTAL_PRICE NUMBER - 총 금액
	private Date createdDate;        // CREATED_DATE DATE - 주문 생성 날짜
	private String paymentMethod;    // PAYMENT_METHOD VARCHAR2(60 BYTE) - 결제 방법
	private String paymentStatus;    // PAYMENT_STATUS VARCHAR2(60 BYTE) - 결제 상태 
	// CREATED: 사용자 결제 요청, PAID: 사용자 결제 완료, CANCELED: 사용자의 주문 취소 요청 시REFUNDED: 관리자 취소 승인
	private Date updatedDate;        // UPDATED_DATE DATE - 결제 상태 수정 날짜
	private int memberNo;            // MEMBER_NO NUMBER - 주문한 회원 번호
	
}
