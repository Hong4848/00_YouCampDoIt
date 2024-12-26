package com.kh.youcamp.goods.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Rental {
	private int memberNo;
	private String memberId;
	private String memberName;
	private Date startDate;
	private Date endDate;
}
