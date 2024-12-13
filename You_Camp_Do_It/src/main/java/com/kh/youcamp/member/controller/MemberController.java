package com.kh.youcamp.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.member.model.service.MemberService;
import com.kh.youcamp.member.model.vo.Identification;
import com.kh.youcamp.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	@Autowired
	private JavaMailSender mailSender;
	
	
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
	 * 로그인 요청용 컨트롤러
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
	 * 로그아웃 요청용 컨트롤러
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
	 * 회원가입 페이지 요청용 컨트롤러
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
	 * 회원가입 요청 처리용 컨트롤러
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@PostMapping(value="insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {
		
		
		String encPwd = bcryptPasswordEncoder.encode(m.getMemberPwd());
		
		m.setMemberPwd(encPwd);
		
		// System.out.println(m);
		
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
	 * 24.12.10 정성민
	 * 아이디 중복 체크 요청 처리용 컨트롤러
	 * @param checkId
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="idCheck.me", produces="text/html; charset=UTF-8")
	public String idCheck(String checkId) {
		
		int count = memberService.idCheck(checkId);
		
		return (count > 0) ? "NNNNN" : "NNNNY";
		
	}
	
	/**
	 * 
	 * 24.12.11 정성민
	 * 이메일 인증번호 요청 처리용 컨트롤러
	 * @param email
	 */
	@ResponseBody
	@PostMapping(value="cert.me", produces="text/html; charset=UTF-8")
	public String sendCertNo(String email) {
		
		// 인증번호 만들기
		int random = (int)(Math.random() * 900000 + 100000);
		
		// 객체로 가공 후 Identification 테이블에 INSERT
		Identification idf = new Identification();
		idf.setEmail(email);
		idf.setAuthCode(String.valueOf(random));
		int count = memberService.insertCertNo(idf);
		
		System.out.println();
		
		if(count > 0) {
			SimpleMailMessage message = new SimpleMailMessage();
			
			// 메세지 정보 담기
			message.setSubject("[YOU CAMP DO IT] 이메일 인증 번호입니다.");
			message.setText("인증 번호 : " + random);
			message.setTo(email);
			
			// 메세지 전송하기
			mailSender.send(message);
			
			return "인증번호 발급 완료"; 
		} else {
			return "인증번호 발급 실패!";
		}
	}
	
	
	/**
	 * 24.12.11 정성민
	 * 인증번호 대조 요청 처리용 컨트롤러
	 * @param email
	 * @param ckeckNo
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="validate.me", produces="text/html; charset=UTF-8")
	public String validateCertNo(String email, String checkNo) {
		
		
		String result = "";
		
		Identification beforeIdf = new Identification();
		beforeIdf.setEmail(email);
		beforeIdf.setAuthCode(checkNo);
		
		Identification afterIdf = memberService.validateCertNo(beforeIdf);
		
		
		if(afterIdf == null) {
			
			result = "인증 실패";
		} else if (afterIdf != null && afterIdf.getAuthCode().equals(checkNo)) {
			
			result = "인증 성공";
		}
		
		// DELETE 해줘야됨
		int deleteResult = memberService.deleteCertNo(email);
		
		return result;
		
	}
	
	/**
	 * 24.12.11 정성민
	 * 이메일 인증번호 삭제 요청 처리용 컨트롤러
	 * @param email
	 */
	@ResponseBody
	@PostMapping(value="timeOut.me", produces="text/html; charset=UTF-8")
	public void timeOutCertNo(String email) {
		
		int result = memberService.deleteCertNo(email);
		
	}
	
	/**
	 * 24.12.12 정성민
	 * 아이디찾기 페이지 접속 요청용 컨트롤러
	 * @param mv
	 * @return
	 */
	@GetMapping(value="findIdForm.me")
	public ModelAndView findIdForm(ModelAndView mv) {
		
		mv.setViewName("member/findMemberId");
		return mv;
	}
	
	/**
	 * 24.12.12 정성민
	 * 아이디찾기 요청용 컨트롤러
	 * @param m
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="findId.me", produces="text/html; charset=UTF-8")
	public String selectId(Member m) {
		
		String email = memberService.selectId(m);
		
		if(email == null) {
			return "해당 계정 없음";
			
		} else {
			
			return email;
		}
		

	}
	
	/**
	 * 24.12.12 정성민
	 * 비밀번호 찾기 페이지 접속 요청용 컨트롤러
	 * @param mv
	 * @return
	 */
	@GetMapping(value="findPwdForm.me")
	public ModelAndView findPwdForm(ModelAndView mv) {
		
		mv.setViewName("member/findMemberPwd");
		return mv;
	}
	
	/**
	 * 24.12.12 정성민
	 * 비밀번호 찾기 입력 정보 대조용 컨트롤러
	 * @param m
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="findPwd.me", produces="text/html; charset=UTF-8")
	public String selectPwdMember(Member m, HttpSession session) {
		
		Member checkedMember = memberService.selectPwdMember(m);

		if(checkedMember != null) {
			
	        session.setAttribute("loginMember", checkedMember);
			return "입력한 정보와 일치하는 계정 존재";
				
		} else {
			return "해당 계정 없음";
			
		}
	}
	
	/**
	 * 24.12.12 정성민
	 * 비밀번호 변경 페이지 접속 요청용 컨트롤러
	 * @param mv
	 * @return
	 */
	@GetMapping(value="changePwdForm.me")
	public ModelAndView changePwdForm(ModelAndView mv) {
		
		mv.setViewName("member/changeMemberPwd");
		return mv;
	}
	
	
	/**
	 * 24.12.13 정성민 
	 * 비밀번호 변경 요청용 컨트롤러
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@PostMapping(value="changePwd.me")
	public String updatePwd(Member m, Model model, HttpSession session) {
		
		Member changeMember = (Member)session.getAttribute("loginMember");
		
		String encPwd = bcryptPasswordEncoder.encode(m.getMemberPwd());
		changeMember.setMemberPwd(encPwd);
		
		int result = memberService.updatePwd(changeMember);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "비밀번호 변경에 성공했습니다! 변경한 비밀번호로 로그인해주세요!");
			
			session.removeAttribute("loginMember");
			
			return "redirect:/";
		} else {
			session.removeAttribute("loginMember");
			
			model.addAttribute("errorMsg", "비밀번호 변경에 실패했습니다!");
			
			return "common/errorPage";
		}
	}
	
	/**
	 * 24.12.13 정성민
	 * 회원탈퇴 페이지 접속 요청용 컨트롤러
	 * @param mv
	 * @return
	 */
	@GetMapping(value="memberDeleteForm.me")
	public ModelAndView memberDeleteForm(ModelAndView mv) {
		
		mv.setViewName("member/memberDeleteForm");
		return mv;
	}
	
	/**
	 * 24.12.13 정성민
	 * 회원탈퇴 요청용 컨트롤러
	 * @param memberPwd
	 * @param mv
	 * @param session
	 * @return
	 */
	@PostMapping(value="memberDelete.me")
	public String deleteMember(String memberPwd, Model model, HttpSession session) {
		
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		System.out.println(loginMember);
		System.out.println(bcryptPasswordEncoder.matches(memberPwd, loginMember.getMemberPwd()));
		
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		
		
		
		if(bcryptPasswordEncoder.matches(memberPwd, loginMember.getMemberPwd())) {
			
			
			System.out.println("서비스 전");
			int result = memberService.deleteMember(memberId);
			
			System.out.println(result);
			if(result > 0) {
				
				session.removeAttribute("loginMember");
				
				System.out.println("비밀번호 똑같음");
				
				session.setAttribute("alertMsg", "회원 탈퇴에 성공했습니다. 그동안 이용해 주셔서 감사합니다.");
				return "redirect:/";
			} else {
				
				model.addAttribute("errorMsg", "회원 탈퇴 실패");
				
				return "common/errorPage";
			}
			
		} else {
			
			session.setAttribute("alertMsg", "비밀번호가 틀렸습니다!");
			
			System.out.println("else문 실행된");
			
			return "redirect:/myPage.me";
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
