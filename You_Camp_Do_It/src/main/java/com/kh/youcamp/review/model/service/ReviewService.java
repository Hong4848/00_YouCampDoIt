package com.kh.youcamp.review.model.service;

import com.kh.youcamp.review.model.vo.Review;

public interface ReviewService {

	// 게시글 작성하기 서비스 메소드
	int insertReview(Review r);
}
