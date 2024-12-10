package com.kh.youcamp.notice.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Notice {

	private int noticeNo;
	private String noticeTitle;
	private String noticeWriter;
	private String noticeContent;
	private String createDate;
	private int count;
	private String originName;
	private String changeName; // "resources/uploadFiles/xxxxxxxxxxx.jsp"
	private String status;
	
}
