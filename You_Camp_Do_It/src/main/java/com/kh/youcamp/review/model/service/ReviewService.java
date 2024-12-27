package com.kh.youcamp.review.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.kh.youcamp.common.model.vo.PageInfo;


import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;


public interface ReviewService {
	
	int selectListCount(HashMap<String, String> searchMap);
	// 목록조회 서비스 메소드
	ArrayList<Review> selectList(PageInfo pi, HashMap<String, String> searchMap);
	
    // 게시글 작성 서비스 메소드
	int insertReview(Review review);
    
    int selectCount();

    // 상세조회 서비스 메소드
	Review selectReview(int reviewNo);
	ArrayList<ReviewAttachment> selectReviewAttachment(int reviewNo);

	// 게시글 수정 서비스
	int updateReview(Review r);
	
	int updateReviewWithAttachments(Review r, ArrayList<ReviewAttachment> attachments);
	
	// 게시글 삭제 서비스
	int deleteReview(int reviewNo);


	// 내가 쓴 리뷰글 조회
	int selectMyCount(int memberNo);
	List<Review> selectMyReviewList(PageInfo pi, int memberNo);

	// 좋아요 관련 서비스
	boolean toggleLike(int memberNo, int reviewNo);
	int getLikeCount(int reviewNo);
	boolean isReviewLikedByMember(int reviewNo, int memberNo);
	
	// 내가 좋아요 한 글 조회
	List<Review> selectMyLikedReviewList(PageInfo pi, int memberNo);
	int selectMyLikedCount(int memberNo);

	
	

	


	


	
	
}
