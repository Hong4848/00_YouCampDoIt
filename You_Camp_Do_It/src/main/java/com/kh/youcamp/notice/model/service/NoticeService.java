package com.kh.youcamp.notice.model.service;

import java.util.ArrayList;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.notice.model.vo.Notice;

public interface NoticeService {
	
	// 게시글 리스트 조회용 서비스 메소드 + 페이징 처리
	// 게시글의 총 갯수 조회를 먼저~!
	int selectListCount();
	
	// 게시글 목록조회
	ArrayList<Notice> selectList(PageInfo pi);
	
	// 게시글 작성하기 서비스 메소드 (관리자만)
	int insertNotice(Notice n);
	
	// 게시글 상세조회 서비스 메소드
	// 1.게시글 조회수 증가 메소드
	int increaseCount(int noticeNo);
	// 2.게시글 상세조회 메소드
	Notice selectNotice(int noticeNo);
	
	// 게시글 삭제 서비스 메소드 (update 사용 - 관리자만)
	int deleteNotice(int noticeNo);
	
	// 게시글 수정 서비스 메소드 (관리자)
	int updateNotice(Notice n);
	
	

}
