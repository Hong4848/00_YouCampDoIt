package com.kh.youcamp.review.model.service;

import java.util.ArrayList;
import java.util.List;

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
    public int insertReview(Review r) {
        // 리뷰 저장
        reviewDao.insertReview(r);

     // 첨부파일 저장 로직
        ArrayList<ReviewAttachment> attachments = r.getReviewAttachments(); // Lombok으로 생성된 getter 사용

        if (attachments != null && !attachments.isEmpty()) {
            for (ReviewAttachment at : attachments) {
                // 첨부파일에 리뷰 번호 매핑
                at.setReviewNo(r.getReviewNo()); // Lombok의 setter 사용

                // 추가적인 데이터 초기화
                at.setStatus("Y"); // 기본값으로 활성화 상태 설정
                if (at.getFileLevel() == 0) {
                    at.setFileLevel(1); // FileLevel 기본값이 없으면 일반 첨부파일로 설정
                }

                // DAO를 통해 첨부파일 정보 저장
                reviewDao.insertReviewAttachment(at);
            }
        }
        return 1; // 성공 시 반환값 (필요에 따라 조정)
    }


	@Override
	public List<Review> selectReviewList() {
		// TODO Auto-generated method stub
		return null;
	}


}


