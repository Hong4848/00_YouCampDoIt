package com.kh.youcamp.review.model.service;

import java.util.List;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.review.model.vo.Review;

public interface ReviewService {
	List<Review> selectReviewList(PageInfo pi);
	
    int insertReview(Review review);
    
    int selectCount();
}
