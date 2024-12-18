package com.kh.youcamp.review.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.member.model.vo.Member;
import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;

@Repository
public class ReviewDao {

	@Autowired
    private SqlSessionTemplate sqlSession;

	public void insertReview(Review r) {
        sqlSession.insert("reviewMapper.insertReview", r);
    }

    public void insertReviewAttachment(ReviewAttachment at) {
        sqlSession.insert("reviewMapper.insertReviewAttachment", at);
    }

	public List<Review> selectReviewList() {
		return sqlSession.selectList("reviewMapper.selectReviewList");
	}






}
