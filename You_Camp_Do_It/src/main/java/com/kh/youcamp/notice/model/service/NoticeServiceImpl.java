package com.kh.youcamp.notice.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.notice.model.dao.NoticeDao;
import com.kh.youcamp.notice.model.vo.Notice;


@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private NoticeDao noticeDao;
	
	
	@Override
    public int selectListCount(HashMap<String, String> searchMap) {
        return noticeDao.selectListCount(sqlSession, searchMap);
    }

    @Override
    public ArrayList<Notice> selectList(PageInfo pi, HashMap<String, String> searchMap) {
        return noticeDao.selectList(sqlSession, pi, searchMap);
    }


	@Override
	@Transactional
	public int increaseCount(int noticeNo) {
		return noticeDao.increaseCount(sqlSession, noticeNo);
	}

	@Override
	public Notice selectNotice(int noticeNo) {
		return noticeDao.selectNotice(sqlSession, noticeNo);
	}

	 // 이전글 가져오기
    @Override
    public Notice getPreviousNotice(int noticeNo) {
        return noticeDao.getPreviousNotice(sqlSession, noticeNo);
    }

    // 다음글 가져오기
    @Override
    public Notice getNextNotice(int noticeNo) {
        return noticeDao.getNextNotice(sqlSession, noticeNo);
    }

    // 전체 공지사항 번호 가져오기
    @Override
    public List<Integer> getAllNoticeNumbers() {
        return noticeDao.getAllNoticeNumbers(sqlSession);
    }

    // 공지사항 작성
	@Override
	public int insertNotice(Notice n) {
		return noticeDao.insertNotice(sqlSession, n);
	}

	// 공지사항 삭제
	@Override
	@Transactional
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(sqlSession, noticeNo);
	}

	// 공지사항 수정
	@Override
	@Transactional
	public int updateNotice(Notice n) {
		return noticeDao.updateNotice(sqlSession, n);
	}

	@Override
	public int totalCount() {
		return noticeDao.totalCount(sqlSession);
	}

	@Override
	public int exitCount() {
		return noticeDao.exitCount(sqlSession);
	}

	@Override
	public int activeCount() {
		return noticeDao.activeCount(sqlSession);
	}

	@Override
	public int ajaxSelectListCount(String state) {
		return noticeDao.ajaxSelectListCount(sqlSession, state);
	}

	@Override
	public ArrayList<Notice> ajaxNoticeSelect(PageInfo pi, String state) {
		return noticeDao.ajaxNoticeSelect(sqlSession, pi, state);
	}



	
    


}
