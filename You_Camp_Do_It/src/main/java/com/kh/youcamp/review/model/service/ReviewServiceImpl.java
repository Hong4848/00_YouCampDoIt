package com.kh.youcamp.review.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.youcamp.review.model.dao.ReviewDao;
import com.kh.youcamp.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ReviewDao reviewDao;
	
	/**
	 * 후기게시판 작성하기 (24.12.12 이수경)
	 */
	@Override
	@Transactional
	public int insertReview(Review r) {
		return reviewDao.insertReview(sqlSession, r);
	}

}
