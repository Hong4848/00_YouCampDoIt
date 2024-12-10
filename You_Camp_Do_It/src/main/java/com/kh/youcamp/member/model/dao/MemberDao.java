package com.kh.youcamp.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.member.model.vo.Member;

@Repository
public class MemberDao {

	
	/**
	 * 24.12.06 정성민
	 * 로그인 요청용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param m
	 * @return
	 */
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}

	/**
	 * 24.12.06 정성민
	 * 회원가입 요청용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param m
	 * @return
	 */
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}


	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}

	/**
	 * 24.12.10 13시 윤홍문
	 * 회원정보 수정용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param m 수정할 회원정보
	 * @return 성공한 행의 갯수
	 */
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);

	}

}
