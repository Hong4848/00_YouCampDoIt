package com.kh.youcamp.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.youcamp.member.model.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	/**
	 * 24.12.05 16시 윤홍문작성
	 * 마이페이지 접속 요청 용 컨트롤러
	 * @return
	 * 인터셉터 작성해야함 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	 * 로그인 기능 작성 후 생성 예정
	 */
	@GetMapping("myPage.me")
	public String myPage() {
		
		// 인터셉터 적용 전
		/*
		// 권한체크 (로그인 후 이용 가능하도록 막기)
		if(session.getAttribute("loginUser") == null) {
			// 로그인 전
			// 알람문구를 담아서 메인페이지로 url 재요청
			
			session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
			
			return "redirect:/";
			
		} else {
			// 로그인 후
			// 마이페이지 화면 포워딩
			
			// > /WEB-INF/views/member/myPage.jsp
			return "member/myPage";
		}
		*/
		
		// 인터셉터 적용 후
		// System.out.println("마이페이지로 요청됨!!");
		
		return "member/myPage";
	}
}
