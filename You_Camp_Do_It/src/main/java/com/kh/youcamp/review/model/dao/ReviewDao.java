package com.kh.youcamp.review.model.dao;

import java.util.ArrayList;
import java.util.List;

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
    
    // 첨부파일 삭제
	 public void deleteReviewAttachment(SqlSessionTemplate sqlSession, int reviewNo) {
		    sqlSession.delete("reviewMapper.deleteReviewAttachment", reviewNo);
		}
	
	// 삭제하기
	public int deleteReview(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.update("reviewMapper.deleteReview", reviewNo);
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




}
