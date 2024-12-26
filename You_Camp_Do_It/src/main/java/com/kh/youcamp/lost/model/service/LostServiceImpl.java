package com.kh.youcamp.lost.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.lost.model.dao.LostDao;
import com.kh.youcamp.lost.model.vo.Lost;
import com.kh.youcamp.lost.model.vo.LostAttachment;

@Service
public class LostServiceImpl implements LostService {

	@Autowired
    private LostDao lostDao;

    @Autowired
	private SqlSessionTemplate sqlSession;
	
    // 상세조회 서비스 메소드
	@Override
	public Lost selectLost(int lostNo) {
		return lostDao.selectLost(sqlSession, lostNo);
	}

	@Override
	public ArrayList<LostAttachment> selectLostAttachment(int lostNo) {
		return lostDao.selectLostAttachment(sqlSession, lostNo);
	}

	@Override
	public int selectCount() {
		return lostDao.selectCount(sqlSession);
	}

	@Override
	public List<Lost> selectLostList(PageInfo pi) {
		return lostDao.selectLostList(sqlSession, pi);
	}

}
