package com.kh.youcamp.review.model.vo;

import java.util.ArrayList;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@ToString
public class Review {

	private int reviewNo;
	private String reviewTitle;
	private String reviewContent;
	private int count;
	private String createDate;
	private String status;
	private int memberNo;	// MEMBER_NO 외래키
	private ArrayList<ReviewAttachment> reviewAttachments; // Lombok으로 getter/setter 자동 생성
	public ArrayList<ReviewAttachment> getReviewAttachments() {
		// TODO Auto-generated method stub
		return null;
	}
	public int getReviewNo() {
		// TODO Auto-generated method stub
		return 0;
	}

	


	
	
}
