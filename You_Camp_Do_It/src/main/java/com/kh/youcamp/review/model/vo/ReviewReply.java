package com.kh.youcamp.review.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class ReviewReply {

	private int replyNo;
	private String replyContent;
	private int reviewNo;
	private int memberNo;
	private String replyWriter;
	private String createDate;
	private String status;
}
