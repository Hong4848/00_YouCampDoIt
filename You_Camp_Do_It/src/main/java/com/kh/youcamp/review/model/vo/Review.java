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
	
	
		// 실제 Review 테이블에 없는 컬럼이지만 필드로 추가 하여 썸네일 이미지 경로와 수정파일명 담을 필드 
		private String mainImage; 
		

		
		public String getMainImage() {
			return mainImage;
		}
		
		public void setMainImage(String mainImage) {
			this.mainImage = mainImage;
		}
	
	
		private String changeName; // 왜 이게 있어야 상세조회가 될까~?
		
		public String getChangeName() {
			return changeName;
		}
		
		public void setChangeName(String changeName) {
			this.changeName = changeName;
		}
}
