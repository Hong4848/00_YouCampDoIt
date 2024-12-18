package com.kh.youcamp.review.model.service;

import java.util.List;

import com.kh.youcamp.review.model.vo.Review;

public interface ReviewService {
    int insertReview(Review r);
    List<Review> selectReviewList();
}
