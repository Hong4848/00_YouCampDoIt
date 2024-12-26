package com.kh.youcamp.review.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;
import com.kh.youcamp.review.model.vo.ReviewReply;


@Repository
public class ReviewDao {


	public List<Review> selectReviewList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (List)sqlSession.selectList("reviewMapper.selectReviewList", null, rowBounds);
	}

	 public int insertReview(SqlSessionTemplate sqlSession, Review review) {
        return sqlSession.insert("reviewMapper.insertReview", review);
    }
    
    public int insertReviewAttachment(SqlSessionTemplate sqlSession, ReviewAttachment attachment) {
        return sqlSession.insert("reviewMapper.insertReviewAttachment", attachment);
    }
    
    public int selectCount(SqlSessionTemplate sqlSession) {
    	return sqlSession.selectOne("reviewMapper.selectCount");
    }

	public Review selectReview(SqlSessionTemplate sqlSession, int reviewNo) {
		// select문 (단일행) : selectOne 메소드
		return sqlSession.selectOne("reviewMapper.selectReview", reviewNo);
	}

	public ArrayList<ReviewAttachment> selectReviewAttachment(SqlSessionTemplate sqlSession, int reviewNo) {
		// select문(여러행) selectList 메소드
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewAttachment", reviewNo);
	}

	// 수정하기
	 public int updateReview(SqlSessionTemplate sqlSession, Review r) {
        // update문 : update 메소드
        return sqlSession.update("reviewMapper.updateReview", r);
    }
	 
	// 첨부파일 상태 변경
	 public int updateReviewAttachment(SqlSessionTemplate sqlSession, ReviewAttachment attachment) {
		    return sqlSession.update("reviewMapper.updateReviewAttachment", attachment);
	}
    
	
	// 삭제하기
	public int deleteReview(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.update("reviewMapper.deleteReview", reviewNo);
	}
	
	// 첨부파일 삭제
	public int deleteReviewAttachment(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.delete("reviewMapper.deleteReviewAttachment", reviewNo);
		
	}
	

	// 댓글 리스트 조회
	public ArrayList<ReviewReply> selectReplyList(SqlSessionTemplate sqlSession, int reviewNo) {
		// select 문(여러행) : selectList 메소드
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReplyList", reviewNo);
	}

	// 댓글 작성
	public int insertReply(SqlSessionTemplate sqlSession, ReviewReply r) {
		// insert 문 : insert 메소드
		return sqlSession.insert("reviewMapper.insertReply", r);
	}

	// 내가 쓴 리뷰 목록조회
	public int selectMyCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("reviewMapper.selectMyCount");
	}
	public List<Review> selectMyReviewList(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (List)sqlSession.selectList("reviewMapper.selectMyReviewList", memberNo, rowBounds);
	}

	
	// 좋아요 관련
	public int checkLike(SqlSessionTemplate sqlSession, Map<String, Integer> paramMap) {
        return sqlSession.selectOne("reviewMapper.checkLike", paramMap);
    }
    public int insertLike(SqlSessionTemplate sqlSession, Map<String, Integer> paramMap) {
        return sqlSession.insert("reviewMapper.insertLike", paramMap);
    }
    public int deleteLike(SqlSessionTemplate sqlSession, Map<String, Integer> paramMap) {
        return sqlSession.delete("reviewMapper.deleteLike", paramMap);
    }
    public int updateLikeCount(SqlSessionTemplate sqlSession, int reviewNo) {
        return sqlSession.update("reviewMapper.updateLikeCount", reviewNo);
    }
    public int getLikeCount(SqlSessionTemplate sqlSession, int reviewNo) {
        return sqlSession.selectOne("reviewMapper.getLikeCount", reviewNo);
    }

	public boolean checkReviewLike(SqlSessionTemplate sqlSession, int reviewNo, int memberNo) {
		Map<String, Integer> paramMap = new HashMap<>();
	    paramMap.put("reviewNo", reviewNo);
	    paramMap.put("memberNo", memberNo);

	    return sqlSession.selectOne("reviewMapper.checkReviewLike", paramMap);
	}



	




}
