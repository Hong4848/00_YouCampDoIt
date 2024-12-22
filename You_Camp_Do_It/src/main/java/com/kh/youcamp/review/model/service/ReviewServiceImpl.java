package com.kh.youcamp.review.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.review.model.dao.ReviewDao;
import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;
@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewDao reviewDao;

    @Autowired
	private SqlSessionTemplate sqlSession;
    
    
    @Override
    public List<Review> selectReviewList(PageInfo pi) {
        return reviewDao.selectReviewList(sqlSession, pi);
    }
    
    @Override
    @Transactional
    public int insertReview(Review review) {
        int result = reviewDao.insertReview(sqlSession, review);
        
        if(result > 0 && review.getReviewAttachments() != null) {
            for(ReviewAttachment attachment : review.getReviewAttachments()) {
                attachment.setReviewNo(review.getReviewNo());
                result *= reviewDao.insertReviewAttachment(sqlSession, attachment);
            }
        }
        
        return result;
    }
    
    @Override
    public int selectCount() {
        return reviewDao.selectCount(sqlSession);
    }

    // 상세조회 서비스 메소드
	@Override
	public Review selectReview(int reviewNo) {
		return reviewDao.selectReview(sqlSession, reviewNo);
	}

	@Override
	public ArrayList<ReviewAttachment> selectReviewAttachment(int reviewNo) {
		return reviewDao.selectReviewAttachment(sqlSession, reviewNo);
	}

	// 게시글 수정 서비스 메소드
	@Override
	@Transactional
	public int updateReview(Review r) {
		return reviewDao.updateReview(sqlSession, r);
	}

    



}


