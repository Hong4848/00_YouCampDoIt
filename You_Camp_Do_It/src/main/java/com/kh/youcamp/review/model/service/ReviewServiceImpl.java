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
import com.kh.youcamp.review.model.vo.ReviewReply;
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
        // 게시글 내용 수정
        int result = reviewDao.updateReview(sqlSession, r);

        if (result > 0) {
            // 기존 첨부파일 삭제
            reviewDao.deleteReviewAttachment(sqlSession, r.getReviewNo());

            // 새 첨부파일 추가
            for (ReviewAttachment attachment : r.getReviewAttachments()) {
                reviewDao.insertReviewAttachment(sqlSession, attachment);
            }
        }

        return result;
    }

	// 게시글 삭제 서비스 메소드
	@Override
	public int deleteReview(int reviewNo) {
		return reviewDao.deleteReview(sqlSession, reviewNo);
	}

	// 댓글 작성 서비스 메소드
	// 댓글 리스트 조회
	@Override
	public ArrayList<ReviewReply> selectReplyList(int reviewNo) {
		return reviewDao.selectReplyList(sqlSession, reviewNo);
	}

	// 댓글 작성 서비스
	@Override
	@Transactional
	public int insertReviewReply(ReviewReply r) {
		return reviewDao.insertReply(sqlSession, r);
	}





    



}


