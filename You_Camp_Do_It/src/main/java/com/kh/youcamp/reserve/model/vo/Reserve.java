package com.kh.youcamp.reserve.model.vo;

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
public class Reserve {
	
	private int reserveNo;
	private Date startDate;
	private Date endDate;
	private int nights;
	private String paymentId;
	private int price;
	private Date paymentDate;
	private String paymentMethod;
	private String paymentStatus;
	private Date updateDate;
	private int memberNo;
	private int campsiteId;

}
