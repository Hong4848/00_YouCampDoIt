package com.kh.youcamp.reserve.model.vo;

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
public class Reserve {
	
	private int reserveNo;
	private String startDate;
	private String endDate;
	private int nights;
	private String paymentId;
	private int price;
	private String paymentDate;
	private String paymentMethod;
	private String paymentStatus;
	private String updateDate;
	private int memberNo;
	private int campsiteId;

}
