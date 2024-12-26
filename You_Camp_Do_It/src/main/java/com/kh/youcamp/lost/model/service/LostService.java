package com.kh.youcamp.lost.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.lost.model.vo.Lost;
import com.kh.youcamp.lost.model.vo.LostAttachment;

public interface LostService {

	// 상세조회 서비스 메소드
	Lost selectLost(int lostNo);
	ArrayList<LostAttachment> selectLostAttachment(int lostNo);

	// 게시글 작성 서비스 메소드
	int selectCount();

	// 목록조회 서비스 메소드
	List<Lost> selectLostList(PageInfo pi);

}
