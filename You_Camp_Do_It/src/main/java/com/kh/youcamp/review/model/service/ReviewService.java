package com.kh.youcamp.review.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;
import com.kh.youcamp.review.model.vo.ReviewReply;

public interface ReviewService {
	
	// 목록조회 서비스 메소드
	List<Review> selectReviewList(PageInfo pi);
	
    // 게시글 작성 서비스 메소드
	int insertReview(Review review);
    
    int selectCount();

    // 상세조회 서비스 메소드
	Review selectReview(int reviewNo);
	ArrayList<ReviewAttachment> selectReviewAttachment(int reviewNo);

	// 게시글 수정 서비스
	int updateReview(Review r);
	
	// 게시글 삭제 서비스
	int deleteReview(int reviewNo);

	// 댓글 리스트 조회 서비스(Ajax)
	ArrayList<ReviewReply> selectReplyList(int reviewNo);

	// 댓글 작성 서비스(Ajax)
	int insertReviewReply(ReviewReply r);


	
	
}
