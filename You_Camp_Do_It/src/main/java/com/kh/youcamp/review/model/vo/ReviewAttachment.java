package com.kh.youcamp.review.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class ReviewAttachment {

	private int fileNo;
	private String originName;
	private String changeName;
	private String filePath;
	private String uploadDate;
	private int fileLevel;
	private String status;
	private int reviewNo;
	
}
