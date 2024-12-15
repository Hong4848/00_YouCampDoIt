package com.kh.youcamp.notice.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.notice.controller.NoticeController;
import com.kh.youcamp.notice.model.dao.NoticeDao;
import com.kh.youcamp.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private NoticeDao noticeDao;
	
	
	@Override
	public int selectListCount() {
		return noticeDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Notice> selectList(PageInfo pi) {
		return noticeDao.selectList(sqlSession, pi);
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
	
    


}
