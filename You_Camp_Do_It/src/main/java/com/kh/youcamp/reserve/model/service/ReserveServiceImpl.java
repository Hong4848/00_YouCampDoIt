package com.kh.youcamp.reserve.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.youcamp.reserve.model.dao.ReserveDao;

@Service
public class ReserveServiceImpl implements ReserveService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ReserveDao reserveDao;

}
