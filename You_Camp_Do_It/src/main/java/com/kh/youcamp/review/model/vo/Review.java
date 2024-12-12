package com.kh.youcamp.review.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Review {

	private int reviewNo;
	private String reviewTitle;
	private String reviewContent;
	private int count;
	private String createDate;
	private String status;
	private int MemberNo;
	
}
