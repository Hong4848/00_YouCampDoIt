package com.kh.youcamp.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.member.model.vo.Identification;
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


	/**
	 * 24.12.06 정성민
	 * 아이디 중복체크용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param checkId
	 * @return
	 */
	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}
	
	/**
	 * 24.12.23 정성민 
	 * 이메일 중복체크용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param checkEmail
	 * @return
	 */
	public int emailCheck(SqlSessionTemplate sqlSession, String checkEmail) {
		return sqlSession.selectOne("memberMapper.emailCheck", checkEmail);
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

	/**
	 * 24.12.11 정성민
	 * 인증번호 발급용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param idf
	 * @return
	 */
	public int insertCertNo(SqlSessionTemplate sqlSession, Identification idf) {
		return sqlSession.insert("memberMapper.insertCertNo", idf);
	}

	/**
	 * 24.12.11 정섬민
	 * 인증번호 대조용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param idf
	 * @return
	 */
	public Identification validateCertNo(SqlSessionTemplate sqlSession, Identification idf) {
		return sqlSession.selectOne("memberMapper.validateCertNo", idf);
	}

	/**
	 * 24.12.11 정성민
	 * 인증번호 삭제용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param email
	 * @return
	 */
	public int deleteCertNo(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.delete("memberMapper.deleteCertNo", email);
	}

	/**
	 * 24.12.12 정성민
	 * 아이디 찾기용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param m
	 * @return
	 */
	public String selectId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.selectId", m);
	}

	/**
	 * 23.12.12 정성민
	 * 비밀번호 찾기 입력 정보 대조용 메소드
	 * @param sqlSession
	 * @param m
	 * @return
	 */
	public Member selectPwdMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.selectPwdMember", m);
	}

	/**
	 * 24.12.12 정성민
	 * 비밀번호 변경용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param m
	 * @return
	 */
	public int updatePwd(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updatePwd", m);
	}

	/**
	 * 24.12.13 정성민
	 * 회원탈퇴용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param memberId
	 * @return
	 */
	public int deleteMember(SqlSessionTemplate sqlSession, String memberId) {
		int result = sqlSession.update("memberMapper.deleteMember", memberId);
		return result;
	}

	/**
	 * 24.12.24 정성민
	 * 관리자 회원 총 수 조회용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param state
	 * @return
	 */
	public int ajaxSelectListCount(SqlSessionTemplate sqlSession, String state) {
		return sqlSession.selectOne("memberMapper.ajaxSelectListCount", state);
	}

	/**
	 * 24.12.24 정성민
	 * 관리자 회원 목록 조회용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param pi
	 * @param state
	 * @return
	 */
	public ArrayList<Member> ajaxMemberSelect(SqlSessionTemplate sqlSession, PageInfo pi, String state) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds 
				= new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.ajaxMemberSelect", state, rowBounds);
	}

	/**
	 * 24.12.24 정성민
	 * 관리자 회원 상세 조회용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param memberNo
	 * @return
	 */
	public Member ajaxMemberDetail(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("memberMapper.ajaxMemberDetail", memberNo);
	}

	/**
	 * 24.12.25 정성민
	 * 관리자 회원 상태 수정용 쿼리문 실행 메소드
	 * @param sqlSession
	 * @param m
	 * @return
	 */
	public int ajaxMemberDetailUpdate(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.ajaxMemberDetailUpdate", m);
	}

	public int totalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.totalCount");
	}

	public int exitCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.exitCount");
	}

	public int activeCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.activeCount");
	}

	public int checkCart(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.delete("memberMapper.checkCart", memberNo);
	}

	

	

	

}
