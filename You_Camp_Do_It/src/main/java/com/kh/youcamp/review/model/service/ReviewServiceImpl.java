package com.kh.youcamp.review.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    
    @Override
    @Transactional
    public int updateReviewWithAttachments(Review r, ArrayList<ReviewAttachment> attachments) {
        int result = reviewDao.updateReview(sqlSession, r);
        
        if (result > 0 && attachments != null && !attachments.isEmpty()) {
            reviewDao.deleteReviewAttachment(sqlSession, r.getReviewNo());
            for (ReviewAttachment attachment : attachments) {
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


	// 내가 쓴 리뷰 목록조회
	@Override
	public int selectMyCount(int memberNo) {
		return reviewDao.selectMyCount(sqlSession, memberNo);
	}
	@Override
	public List<Review> selectMyReviewList(PageInfo pi, int memberNo) {
		return reviewDao.selectMyReviewList(sqlSession, pi, memberNo);
	}

	// 좋아요 관련
	@Override
	public boolean toggleLike(int memberNo, int reviewNo) {
		 // 좋아요 상태 확인
	    Map<String, Integer> paramMap = new HashMap<>();
	    paramMap.put("memberNo", memberNo);
	    paramMap.put("reviewNo", reviewNo);

	    boolean isLiked = reviewDao.checkLike(sqlSession, paramMap) > 0;

	    if (isLiked) {
	        // 이미 좋아요 상태면 좋아요 취소
	        reviewDao.deleteLike(sqlSession, paramMap);
	    } else {
	        // 좋아요 추가
	        reviewDao.insertLike(sqlSession, paramMap);
	    }

	    // 좋아요 수 업데이트
	    reviewDao.updateLikeCount(sqlSession, reviewNo);

	    return !isLiked; // 반대 상태 반환
	}
	@Override
	public int getLikeCount(int reviewNo) {
		return reviewDao.getLikeCount(sqlSession, reviewNo);
	}

	@Override
	public boolean isReviewLikedByMember(int reviewNo, int memberNo) {
		Map<String, Integer> paramMap = new HashMap<>();
	    paramMap.put("memberNo", memberNo);
	    paramMap.put("reviewNo", reviewNo);
		return reviewDao.checkLike(sqlSession, paramMap) > 0;
	}

	// 내가 좋아요 한 글 보기
	@Override
	public List<Review> selectMyLikedReviewList(PageInfo pi, int memberNo) {
		return reviewDao.selectMyLikedReviewList(sqlSession, pi, memberNo);
	}
	@Override
	public int selectMyLikedCount(int memberNo) {
		return reviewDao.selectMyLikedCount(sqlSession, memberNo);
	}






}


