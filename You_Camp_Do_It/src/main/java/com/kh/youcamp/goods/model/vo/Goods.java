package com.kh.youcamp.goods.model.vo;

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
public class Goods {
	
	private int goodsNo;             // GOODS_NO NUMBER - 시퀀스로 채번하여 등록
	private String category;         // CATEGORY VARCHAR2(60 BYTE) - 카테고리 별로 분류하기 위한 제품의 종류
	private String goodsName;        // GOODS_NAME VARCHAR2(60 BYTE) - 제품의 이름
	private String goodsContent;     // GOODS_CONTENT CLOB - 제품 설명 내용 (CLOB 타입, 이미지 포함 가능)
	private String mark;             // MARK VARCHAR2(60 BYTE) - 제품의 제조사
	private int price;               // PRICE NUMBER - 제품의 가격
	private int views;               // VIEWS NUMBER - 제품 페이지 조회 수
	private Date enrollDate;         // ENROLL_DATE DATE - 제품 등록일
	private int totalStock;          // TOTAL_STOCK NUMBER - 보유한 제품의 총 재고 개수
	private int remainStock;         // REMAIN_STOCK NUMBER - 제품의 남은 재고 개수
	private String status;           // STATUS VARCHAR2(1 BYTE) - 제품 존속 여부 (Y: 존속, N: 폐기)


}
