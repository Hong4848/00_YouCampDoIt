package com.kh.youcamp.member.model.service;

import java.util.ArrayList;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.member.model.vo.Identification;
import com.kh.youcamp.member.model.vo.Member;

public interface MemberService {
	
	// 24.12.06 정성민 작성
	// 회원 관리 서비스 메소드 
	
	// 로그인 서비스 (select)
	Member loginMember(Member m);
	
	// 회원가입 서비스 (insert)
	int insertMember(Member m);
	
	// 회원정보수정 서비스 (update)
	int updateMember(Member m);
	
	// 아이디 중복체크 서비스 (select)
	int idCheck(String checkId);
	
	// 이메일 중복체크 서비스 (select)
	int emailCheck(String checkEmail);
	
	// 회원 전체조회 서비스 (select)
	ArrayList<Member> selectMemberList();
	
	// 인증번호 저장용 서비스 (insert)
	int insertCertNo(Identification idf);
	
	// 인증번호 대조용 서비스 (select)
	Identification validateCertNo(Identification idf);
	
	// 인증번호 삭제용 서비스 (delete)
	int deleteCertNo(String email);

	// 아이디 찾기용 서비스 (select)
	String selectId(Member m);

	// 비밀번호 찾기 입력 정보 대조용 서비스 (select)
	Member selectPwdMember(Member m);

	// 비밀번호 변경용 서비스 (update)
	int updatePwd(Member m);

	// 회원 탈퇴용 서비스 (update)
	int deleteMember(String memberId);

	// 관리자 회원 수 조회용 서비스 (select)
	int ajaxSelectListCount(String state);

	// 관리자 회원 목록 조회용 서비스 (select)
	ArrayList<Member> ajaxMemberSelect(PageInfo pi, String state);

	// 관리자 회원 상세 조회용 서비스 (select)
	Member ajaxMemberDetail(int memberNo);

	// 관리자 회원 상태 수정용 서비스 (update)
	int ajaxMemberDetailUpdate(Member m);

	// 모든 회원 수 조회용
	int totalCount();

	// 탈퇴한 회원 수 조회용
	int exitCount();

	// 활동중인 회원 수 조회용
	int activeCount();

	// 카트 추가한 지 30일 경과 시 삭제하는 기능
	int checkCart(int memberNo);

	
	
	

}
