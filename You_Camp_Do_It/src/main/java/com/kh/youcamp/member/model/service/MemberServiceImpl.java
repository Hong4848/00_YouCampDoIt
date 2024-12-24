package com.kh.youcamp.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.member.model.dao.MemberDao;
import com.kh.youcamp.member.model.vo.Identification;
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

	/**
	 * 24.12.10 13시 윤홍문
	 * 회원정보 수정용 서비스 메소드
	 */
	@Override
	@Transactional
	public int updateMember(Member m) {
		return memberDao.updateMember(sqlSession, m);
	}


	/**
	 * 24.12.10 정성민
	 * 아이디 중복체크용 서비스 메소드
	 */
	@Override
	public int idCheck(String checkId) {
		return memberDao.idCheck(sqlSession, checkId);
	}
	
	/**
	 * 24.12.23 정성민
	 * 이메일 중복체크용 서비스 메소드
	 */
	@Override
	public int emailCheck(String checkEmail) {
		return memberDao.emailCheck(sqlSession, checkEmail);
	}

	@Override
	public ArrayList<Member> selectMemberList() {
		return null;
	}


	/**
	 * 24.12.11 정성민
	 * 인증번호 발급용 서비스 메소드
	 */
	@Override
	public int insertCertNo(Identification idf) {
		return memberDao.insertCertNo(sqlSession, idf);
	}


	/**
	 * 24.12.11 정성민
	 * 인증번호 대조용 서비스 메소드
	 */
	@Override
	public Identification validateCertNo(Identification idf) {
		return memberDao.validateCertNo(sqlSession, idf);
	}


	/**
	 * 24.12.11 정성민
	 * 인증번호 삭제용 서비스 메소드
	 */
	@Override
	public int deleteCertNo(String email) {
		return memberDao.deleteCertNo(sqlSession, email);
	}


	/**
	 * 24.12.12 정성민
	 * 아이디 찾기용 서비스 메소드
	 *
	 */
	@Override
	public String selectId(Member m) {
		return memberDao.selectId(sqlSession, m);
	}


	/**
	 * 24.12.12 정성민
	 * 비밀번호 찾기 입력정보 대조용 서비스 메소드
	 */
	@Override
	public Member selectPwdMember(Member m) {
		return memberDao.selectPwdMember(sqlSession, m);
	}


	/**
	 * 24.12.12 정성민
	 * 비밀번호 변경용 서비스 메소드
	 */
	@Override
	public int updatePwd(Member m) {
		return memberDao.updatePwd(sqlSession, m);
	}


	/**
	 * 24.12.13 정성민
	 * 회원탈퇴용 서비스 메소드
	 */
	@Override
	public int deleteMember(String memberId) {
		return memberDao.deleteMember(sqlSession, memberId);
	}


	@Override
	public int ajaxSelectListCount(String state) {
		return memberDao.ajaxSelectListCount(sqlSession, state);
	}


	@Override
	public ArrayList<Member> ajaxMemberSelect(PageInfo pi, String state) {
		return memberDao.ajaxMemberSelect(sqlSession, pi, state);
	}


	


	


	

}
