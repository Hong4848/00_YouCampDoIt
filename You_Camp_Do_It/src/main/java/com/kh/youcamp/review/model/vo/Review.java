package com.kh.youcamp.review.model.vo;

import java.util.ArrayList;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Review {

	private int reviewNo;
	private String reviewTitle;
	private String reviewContent;
	private int reviewCount;
	private String createDate;
	private String status;
	private int memberNo;	// MEMBER_NO 외래키
	private String reviewWriter;
	private ArrayList<ReviewAttachment> reviewAttachments; 
	
	
}
