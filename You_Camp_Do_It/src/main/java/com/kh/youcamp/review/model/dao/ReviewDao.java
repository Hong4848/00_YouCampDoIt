package com.kh.youcamp.review.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;

@Repository
public class ReviewDao {

	@Autowired
    private SqlSessionTemplate sqlSession;

	public int insertReview(Review review) {
        return sqlSession.insert("reviewMapper.insertReview", review);
    }

	public int insertReviewAttachment(ReviewAttachment at) {
		return sqlSession.insert("reviewMapper.insertReviewAttachment", at);
	}


}
