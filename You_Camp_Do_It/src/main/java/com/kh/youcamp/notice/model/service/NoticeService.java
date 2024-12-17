package com.kh.youcamp.notice.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.notice.model.vo.Notice;

public interface NoticeService {
	
	// 게시글 리스트 조회용 서비스 메소드 + 페이징 처리
	// 게시글의 총 갯수 조회를 먼저~!
	int selectListCount();
	
	// 게시글 목록조회
	ArrayList<Notice> selectList(PageInfo pi);
	
	// 게시글 상세조회 서비스 메소드
	// 1.게시글 조회수 증가 메소드
	int increaseCount(int noticeNo);
	// 2.게시글 상세조회 메소드
	Notice selectNotice(int noticeNo);

	// 이전글 가져오기
    Notice getPreviousNotice(int noticeNo);

    // 다음글 가져오기
    Notice getNextNotice(int noticeNo);

    // 전체 공지사항 번호 가져오기
    List<Integer> getAllNoticeNumbers();
    
}
