package com.kh.youcamp.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.member.model.service.MemberService;
import com.kh.youcamp.member.model.vo.Member;

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
	 */
	@GetMapping("myPage.me")
	public String myPage() {
		
		return "member/myPage";
		
	}
	
	/**
	 * 24.12.06 정성민
	 * 로그인 요청용 메소드
	 * @param m
	 * @param mv
	 * @param session
	 * @param response
	 * @return 
	 */
	@PostMapping(value="login.me")
	public ModelAndView loginMember(Member m,
									ModelAndView mv,
									HttpSession session) {
		
		// log.debug(m.toString());
		
		Member loginMember = memberService.loginMember(m);
		
		if((loginMember != null) && (bcryptPasswordEncoder.matches(m.getMemberPwd(), loginMember.getMemberPwd()))) {
			// 로그인 성공
			
			session.setAttribute("loginMember", loginMember);
			session.setAttribute("alertMsg", "로그인 성공");
			
			mv.setViewName("redirect:/");
			
		} else { // 로그인 실패
			
			mv.addObject("errorMsg", "로그인 실패");
			
			mv.setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	/**
	 * 24.12.05 정성민
	 * 로그아웃 요청용 메소드
	 * @param session
	 * @return
	 */
	@GetMapping("logout.me")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginMember");
		
		session.setAttribute("alertMsg", "로그아웃 성공");
		
		return "redirect:/";
	}
	
	/**
	 * 24.12.05 정성민
	 * 회원가입 페이지 요청용 메소드
	 * @param mv
	 * @return
	 */
	@GetMapping(value="enrollForm.me")
	public ModelAndView enrollForm(ModelAndView mv) {
		
		// 회원가입 페이지로 포워딩
		mv.setViewName("member/memberEnrollForm");
		
		return mv;
	}
	
	
	/**
	 * 24.12.06 정성민
	 * 회원가입 요청 처리용 메소드
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@PostMapping(value="insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {
		
		
		String encPwd = bcryptPasswordEncoder.encode(m.getMemberPwd());
		
		m.setMemberPwd(encPwd);
		
		int result = memberService.insertMember(m);
		
		if(result > 0) { // 성공
			
			session.setAttribute("alertMsg", "회원가입에 성공했습니다!");
			
			return "redirect:/";
		} else { // 실패
			
			model.addAttribute("errorMsg", "회원가입 실패");
			
			return "common/errorPage";
		}
	}
	
	
	/**
	 * 24.12.10 09 윤홍문
	 * 회원정보 수정 페이지 접속용 메소드
	 * @param mv
	 * @return
	 */
	@GetMapping(value="updateForm.me")
	public ModelAndView updateForm(ModelAndView mv) {
		
		// 회원정보 수정 페이지로 포워딩
		mv.setViewName("member/memberUpdateForm");
		
		return mv;
	}
	
	
	/**
	 * 24.12.10 11 윤홍문
	 * 회원정보 수정 요청용 메소드
	 * 일단 (전화번호, 생년월일, 주소) 만 수정가능
	 * 
	 */
	@PostMapping(value="update.me")
	public String updateMember(Member m, 
							   HttpSession session,
							   Model model) {
		
		// System.out.println(m);
		
		int result = memberService.updateMember(m);
		
		if(result > 0) { // 성공
			
			// 갱신된 회원의 정보를 다시 조회 후 세션에 덮어씌우기
			Member updateMem 
					= memberService.loginMember(m);
			
			session.setAttribute("loginMember", updateMem);
			
			// 일회성 문구를 담아서 마이페이지로 url 재요청
			session.setAttribute("alertMsg", "회원정보 변경 성공");
			
			return "redirect:/myPage.me";
			
		} else { // 실패
			
			// 에러 문구를 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "회원정보 변경 실패");
			
			return "common/errorPage";
		}
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
