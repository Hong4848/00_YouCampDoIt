package com.kh.youcamp.review.model.service;

import java.util.List;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.review.model.vo.Review;

public interface ReviewService {
	
	// 목록조회 서비스 메소드
	List<Review> selectReviewList(PageInfo pi);
	
    // 게시글 작성 서비스 메소드
	int insertReview(Review review);
    
    int selectCount();

    // 상세조회 서비스 메소드
	Review selectReview(int rno);

	
}
