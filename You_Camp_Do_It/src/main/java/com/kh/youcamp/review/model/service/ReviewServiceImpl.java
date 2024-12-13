package com.kh.youcamp.review.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.youcamp.review.model.dao.ReviewDao;
import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewDao reviewDao;

    @Override
    @Transactional
    public int insertReview(Review review) {
        int result = reviewDao.insertReview(review);
        
        if(result > 0 && !review.getReviewAtachments().isEmpty()) {
            for(ReviewAttachment at : review.getReviewAtachments()) {
                at.setReviewNo(review.getReviewNo());
                result *= reviewDao.insertReviewAttachment(at);
            }
        }
        
        return result;
    }
}


