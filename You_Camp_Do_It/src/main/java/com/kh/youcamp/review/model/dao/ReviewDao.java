package com.kh.youcamp.review.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.review.model.vo.Review;

@Repository
public class ReviewDao {

	public int insertReview(SqlSessionTemplate sqlSession, Review r) {
		// insert문 : insert 메소드
		return sqlSession.insert("reviewMapper.insertReview", r);
	}

}
