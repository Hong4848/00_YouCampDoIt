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

    private int fileNo;          // 파일 번호
    private String originName;   // 원본 파일명
    private String changeName;   // 변경된 파일명
    private String filePath;     // 파일 경로
    private String uploadDate;   // 업로드 날짜
    private int fileLevel;       // 파일 레벨
    private String status;       // 상태 (예: 활성화/비활성화)
    private int reviewNo;        // 리뷰 번호 (참조)
}
