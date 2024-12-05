package com.kh.youcamp.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor // 기본생성자
@AllArgsConstructor // 모든 매개변수 생성자
@Setter // setter 메소드들
@Getter // getter 메소드들
@ToString // toString 메소드
public class Member {

	private int memberNo;         // MEMBER_NO NUMBER - 회원 번호
	private String memberId;      // MEMBER_ID VARCHAR2(30 BYTE) - 회원 ID
	private String memberPwd;     // MEMBER_PWD VARCHAR2(50 BYTE) - 회원 비밀번호
	private String memberName;    // MEMBER_NAME VARCHAR2(15 BYTE) - 회원 이름
	private Date birthDate;       // BIRTH_DATE DATE - 생년월일
	private String phone;         // PHONE CHAR(13 BYTE) - 전화번호
	private String email;         // EMAIL VARCHAR2(300 BYTE) - 이메일
	private Date signupDate;      // SIGNUP_DATE DATE - 가입일
	private String address;       // ADDRESS VARCHAR2(200 BYTE) - 주소
	private String status;        // STATUS VARCHAR2(1 BYTE) - 상태 (활성화 여부)

	
}
