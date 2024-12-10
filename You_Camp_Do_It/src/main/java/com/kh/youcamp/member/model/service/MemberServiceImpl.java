package com.kh.youcamp.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.youcamp.member.model.dao.MemberDao;
import com.kh.youcamp.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao memberDao;
	
	
	// 24.12.06 정성민 작성
	// 회원 관리 서비스 메소드 
	
	/**
	 * 24.12.06 정성민
	 * 로그인 요청용 서비스 메소드
	 */
	@Override
	public Member loginMember(Member m) {
		return memberDao.loginMember(sqlSession, m);
	}

	
	/**
	 * 24.12.06 정성민
	 * 회원가입 요청용 서비스 메소드
	 */
	@Override
	@Transactional
	public int insertMember(Member m) {
		return memberDao.insertMember(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {
		return 0;
	}

	@Override
	public int deleteMember(String userId) {
		return 0;
	}

	/**
	 * 24.12.10 정성민
	 * 아이디 중복체크용 서비스 메소드
	 */
	@Override
	public int idCheck(String checkId) {
		return memberDao.idCheck(sqlSession, checkId);
	}

	@Override
	public ArrayList<Member> selectMemberList() {
		return null;
	}

}
