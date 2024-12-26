package com.kh.youcamp.member.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.common.template.Pagination;
import com.kh.youcamp.member.model.service.MemberService;
import com.kh.youcamp.member.model.vo.Identification;
import com.kh.youcamp.member.model.vo.Member;
import com.kh.youcamp.review.model.service.ReviewService;
import com.kh.youcamp.review.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ReviewService reviewService;
	
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
	 * 카트 추가한 지 30일 경과 시 삭제하는 기능 추가 - 24.12.25 윤홍문
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
			
			// 장바구니 추가 30일 경과 시 삭제
			int result = memberService.checkCart(m.getMemberNo());
			log.debug(" 장바구니 추가 30일 경과 된거 삭제 됐나? result : " + result);
			
			session.setAttribute("loginMember", loginMember);
			session.setAttribute("alertMsg", "로그인 성공");
			
			mv.setViewName("redirect:/");
			
		} else { // 로그인 실패
			
			session.setAttribute("alertMsg", "아이디 또는 비밀번호가 잘봇되었습니다. 아이디와 비밀번호를 정확히 입력해주세요!");
			
			mv.setViewName("redirect:/");
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
		
		int result = memberService.idCheck(checkId);
		
		return (result > 0) ? "NNNNN" : "NNNNY";
		
	}
	
	/**
	 * 24.12.23 정성민
	 * 이메일 중복 체크 요청 처리용 컨트롤러
	 * @param checkId
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="emailCheck.me", produces="text/html; charset=UTF-8")
	public String emailCheck(String checkEmail) {
		
		
		int result = memberService.emailCheck(checkEmail);
		
		return (result > 0) ? "NNNNN" : "NNNNY";
		
	}
	
	/**
	 * 
	 * 24.12.11 정성민
	 * 이메일 인증번호 요청 처리용 컨트롤러
	 * @param email
	 * @throws MessagingException 
	 */
	@ResponseBody
	@PostMapping(value="cert.me", produces="text/html; charset=UTF-8")
	public String sendCertNo(String email, String key) throws MessagingException {
		
		// 인증번호 만들기
		int random = (int)(Math.random() * 900000 + 100000);
		
		// 객체로 가공 후 Identification 테이블에 INSERT
		Identification idf = new Identification();
		idf.setEmail(email);
		idf.setAuthCode(String.valueOf(random));
		int result = memberService.insertCertNo(idf);
		
		
		
		
		if(result > 0) {
			MimeMessage message = mailSender.createMimeMessage();
			
			MimeMessageHelper mimeMessageHelper
			= new MimeMessageHelper(message, true, "UTF-8");
			
			// key 값에 따른 이메일 내용 변경
			if(key.equals("enroll")) {
				// 이메일 내용 HTML
				String emailContent = 
				    "<div style='font-family: Arial, sans-serif; background-color: #ffffff; padding: 20px;'>"
				        + "<div style='max-width: 600px; margin: auto; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);'>"
				            + "<div style='padding: 20px; text-align: center; background-color: #d4f4c4; border-radius: 8px 8px 0 0;'>"
				            	+ "<img src='cid:companyLogo' alt='YouCampDoIt 로고' style='width: 150px;'>"
				                + "<h1 style='color: #2f4f4f; margin: 0;'>YouCampDoIt</h1>"
				                + "<p style='color: #2f4f4f; font-size: 16px;'>캠핑과 자연을 사랑하는 당신을 환영합니다!</p>"
				            + "</div>"
				            + "<div style='padding: 20px; text-align: center;'>"
				                + "<h2 style='color: #333333;'>회원가입 인증번호</h2>"
				                + "<p style='font-size: 18px; color: #5a4bcf; font-weight: bold; margin: 20px 0;'>"
				                    + random
				                + "</p>"
				                + "<p style='color: #666666; font-size: 14px;'>"
				                    + "위 인증번호를 인증번호 입력 창에 입력해주세요.<br>이 번호는 3분간만 유효합니다."
				                + "</p>"
				                
				            + "</div>"
				            + "<div style='padding: 10px; background-color: #f8f8f8; text-align: center; font-size: 12px; color: #666;'>"
				                + "<p style='margin: 0;'>본 메일은 YouCampDoIt 캠핑장 회원가입을 위해 발송되었습니다.</p>"
				                + "<p style='margin: 5px 0;'>문의사항이 있으시면 youcampdoit123@gmail.com 으로 메일주세요.</p>"
				            + "</div>"
				        + "</div>"
				    + "</div>";
				
				// 메세지 정보 담기
				mimeMessageHelper.setSubject("[YouCampDoIt] 회원가입 인증번호 안내");
				mimeMessageHelper.setText(emailContent, true); // 내용
				
				mimeMessageHelper.setTo(email);
				
				// DataSource dataSource = new FileDataSource("C:/mainLogo.png");
				// mimeMessageHelper.addAttachment(dataSource.getName(), dataSource);
				
				// 로고를 인라인 이미지로 첨부
				FileSystemResource logo = new FileSystemResource(new File("C:\\YouCampDoIt\\You_Camp_Do_It\\src\\main\\webapp\\resources\\images\\mainPage\\메인로고.png")); // 로고 이미지 파일 경로
				mimeMessageHelper.addInline("companyLogo", logo);
				
				mailSender.send(message);
				
				return "인증번호 발급 완료"; 
				
			} else if (key.equals("findId")) {
				
				// 이메일 내용 HTML
				String emailContent = 
				    "<div style='font-family: Arial, sans-serif; background-color: #ffffff; padding: 20px;'>"
				        + "<div style='max-width: 600px; margin: auto; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);'>"
				            + "<div style='padding: 20px; text-align: center; background-color: #d4f4c4; border-radius: 8px 8px 0 0;'>"
				            	+ "<img src='cid:companyLogo' alt='YouCampDoIt 로고' style='width: 150px;'>"
				                + "<h1 style='color: #2f4f4f; margin: 0;'>YouCampDoIt</h1>"
				                + "<p style='color: #2f4f4f; font-size: 16px;'>캠핑과 자연을 사랑하는 당신을 환영합니다!</p>"
				            + "</div>"
				            + "<div style='padding: 20px; text-align: center;'>"
				                + "<h2 style='color: #333333;'>아이디 찾기 인증번호</h2>"
				                + "<p style='font-size: 18px; color: #5a4bcf; font-weight: bold; margin: 20px 0;'>"
				                    + random
				                + "</p>"
				                + "<p style='color: #666666; font-size: 14px;'>"
				                    + "위 인증번호를 인증번호 입력 창에 입력해주세요.<br>이 번호는 3분간만 유효합니다."
				                + "</p>"
				                
				            + "</div>"
				            + "<div style='padding: 10px; background-color: #f8f8f8; text-align: center; font-size: 12px; color: #666;'>"
				                + "<p style='margin: 0;'>본 메일은 YouCampDoIt 회원 계정 아이디 찾기를 위해 발송되었습니다.</p>"
				                + "<p style='margin: 5px 0;'>문의사항이 있으시면 youcampdoit123@gmail.com 으로 메일주세요.</p>"
				            + "</div>"
				        + "</div>"
				    + "</div>";
				
				// 메세지 정보 담기
				mimeMessageHelper.setSubject("[YouCampDoIt] 아이디 찾기 인증번호 안내");
				mimeMessageHelper.setText(emailContent, true); // 내용
				
				mimeMessageHelper.setTo(email);
				
				// DataSource dataSource = new FileDataSource("C:/mainLogo.png");
				// mimeMessageHelper.addAttachment(dataSource.getName(), dataSource);
				
				// 로고를 인라인 이미지로 첨부
				FileSystemResource logo = new FileSystemResource(new File("C:\\YouCampDoIt\\You_Camp_Do_It\\src\\main\\webapp\\resources\\images\\mainPage\\메인로고.png")); // 로고 이미지 파일 경로
				mimeMessageHelper.addInline("companyLogo", logo);
				
				mailSender.send(message);
				
				return "인증번호 발급 완료"; 
				
			} else {
				
				// 이메일 내용 HTML
				String emailContent = 
				    "<div style='font-family: Arial, sans-serif; background-color: #ffffff; padding: 20px;'>"
				        + "<div style='max-width: 600px; margin: auto; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);'>"
				            + "<div style='padding: 20px; text-align: center; background-color: #d4f4c4; border-radius: 8px 8px 0 0;'>"
				            	+ "<img src='cid:companyLogo' alt='YouCampDoIt 로고' style='width: 150px;'>"
				                + "<h1 style='color: #2f4f4f; margin: 0;'>YouCampDoIt</h1>"
				                + "<p style='color: #2f4f4f; font-size: 16px;'>캠핑과 자연을 사랑하는 당신을 환영합니다!</p>"
				            + "</div>"
				            + "<div style='padding: 20px; text-align: center;'>"
				                + "<h2 style='color: #333333;'>비밀번호 변경 인증번호</h2>"
				                + "<p style='font-size: 18px; color: #5a4bcf; font-weight: bold; margin: 20px 0;'>"
				                    + random
				                + "</p>"
				                + "<p style='color: #666666; font-size: 14px;'>"
				                    + "위 인증번호를 인증번호 입력 창에 입력해주세요.<br>이 번호는 3분간만 유효합니다."
				                + "</p>"
				                
				            + "</div>"
				            + "<div style='padding: 10px; background-color: #f8f8f8; text-align: center; font-size: 12px; color: #666;'>"
				                + "<p style='margin: 0;'>본 메일은 YouCampDoIt 회원 계정 비밀번호 변경을 위해 발송되었습니다.</p>"
				                + "<p style='margin: 5px 0;'>문의사항이 있으시면 youcampdoit123@gmail.com 으로 메일주세요.</p>"
				            + "</div>"
				        + "</div>"
				    + "</div>";
				
				// 메세지 정보 담기
				mimeMessageHelper.setSubject("[YouCampDoIt] 비밀번호 변경 인증번호 안내");
				mimeMessageHelper.setText(emailContent, true); // 내용
				
				mimeMessageHelper.setTo(email);
				
				// DataSource dataSource = new FileDataSource("C:/mainLogo.png");
				// mimeMessageHelper.addAttachment(dataSource.getName(), dataSource);
				
				// 로고를 인라인 이미지로 첨부
				FileSystemResource logo = new FileSystemResource(new File("C:\\YouCampDoIt\\You_Camp_Do_It\\src\\main\\webapp\\resources\\images\\mainPage\\메인로고.png")); // 로고 이미지 파일 경로
				mimeMessageHelper.addInline("companyLogo", logo);
				
				mailSender.send(message);
				
				return "인증번호 발급 완료"; 
			}
			
			
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
	 * 아이디 찾기 페이지 접속 요청용 컨트롤러
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
	 * 아이디 찾기 요청용 컨트롤러
	 * @param m
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="findId.me", produces="text/html; charset=UTF-8")
	public String selectId(Member m, HttpSession session) {
		
		String id = memberService.selectId(m);
		
		if(id == null) {
			
			
			return "해당 계정 없음";
			
		} else {
			session.setAttribute("alertMsg", "회원님의 아이디는 " + id + " 입니다. 해당 아이디로 로그인 해주세요!");
			
			return "redirect:/";
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
		
		
		
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		
		
		
		if(bcryptPasswordEncoder.matches(memberPwd, loginMember.getMemberPwd())) {
			
			
			
			int result = memberService.deleteMember(memberId);
			
			
			if(result > 0) {
				
				session.removeAttribute("loginMember");
				
				
				
				session.setAttribute("alertMsg", "회원 탈퇴에 성공했습니다. 그동안 이용해 주셔서 감사합니다.");
				return "redirect:/";
			} else {
				
				model.addAttribute("errorMsg", "회원 탈퇴 실패");
				
				return "common/errorPage";
			}
			
		} else {
			
			session.setAttribute("alertMsg", "비밀번호가 틀렸습니다!");
			
			
			
			return "redirect:/myPage.me";
		}
			
	}
	
	/**
	 * 24.12.23 정성민 
	 * 로그인한 회원의 비밀번호 변경 페이지 접속 요청용 컨트롤러
	 * @param mv
	 * @return
	 */
	@GetMapping(value="changeLoginPwdForm.me")
	public ModelAndView changeLoginPwdForm(ModelAndView mv) {
		
		mv.setViewName("member/changeLoginMemberPwd");
		return mv;
	}
	
	
	/**
	 * 24.12.23 정성민
	 * 로그인한 회원의 비밀번호 변경 요청용 컨트롤러
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@PostMapping(value="changeLoginPwd.me")
	public String updateLoginPwd(String memberPwd, String newPwd, Model model, HttpSession session) {
		
		
		
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if((loginMember != null) && (bcryptPasswordEncoder.matches(memberPwd, loginMember.getMemberPwd()))) {
			String encPwd = bcryptPasswordEncoder.encode(newPwd);
			loginMember.setMemberPwd(encPwd);
			
			int result = memberService.updatePwd(loginMember);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "비밀번호 변경에 성공했습니다! 변경한 비밀번호로 로그인해주세요!");
				
				session.removeAttribute("loginMember");
				
				return "redirect:/";
			} else {
				session.removeAttribute("loginMember");
				
				model.addAttribute("errorMsg", "비밀번호 변경에 실패했습니다!");
				
				return "common/errorPage";
			}
			
		} else {
			session.setAttribute("alertMsg", "현재 비밀번호가 일치하지 않아 비밀번호 변경에 실패했습니다!");
			
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
	
	/**
	 * 24.12.24 정성민
	 * 관리자페이지 회원 목록조회 요청용 컨트롤러
	 * @param currentPage
	 * @param state
	 * @param session
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="ajaxMemberManagement.me", produces="application/json; charset=UTF-8")
	public String ajaxMemberSelect(@RequestParam(value="pageNumber", defaultValue="1")int currentPage, 
			@RequestParam(value="state", defaultValue="전체")String state, 
			HttpSession session)
	{
		
		int totalCount = memberService.totalCount();
		int exitCount = memberService.exitCount();
		int activeCount = memberService.activeCount();
		
		
		int listCount = memberService.ajaxSelectListCount(state);
		
		int pageLimit = 5;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Member> list = memberService.ajaxMemberSelect(pi, state);
		
		
		Map<String, Object> ajaxList = new HashMap<>();
		ajaxList.put("totalCount", totalCount);
		ajaxList.put("exitCount", exitCount);
		ajaxList.put("activeCount", activeCount);
		ajaxList.put("list", list);
		ajaxList.put("pi", pi);
		
		
		return new Gson().toJson(ajaxList);
	}
	
	/**
	 * 24.12.25 정성민 
	 * 관리자 페이지 회원 상세조회 요청용 컨트롤러
	 * @param memberNo
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="ajaxMemberDetail.me", produces="application/json; charset=UTF-8")
	public String ajaxMemberDetail(@RequestParam(value="memberNo")int memberNo){
		
		Member m = memberService.ajaxMemberDetail(memberNo);
		
		return new Gson().toJson(m);
	}
	
	
	@ResponseBody
	@GetMapping(value = "ajaxMemberDetailUpdate.me", produces="application/json; charset=UTF-8")
	public boolean ajaxMemberDetailUpdate(Member m) {
		int result = memberService.ajaxMemberDetailUpdate(m);
		if(result > 0){
			return true;
		}
		else {
			return false;
		}
		
	}
	
	
    /**
     * 내가 쓴 리뷰 목록조회 요청
     * 24.12.25 윤홍문
     * @param currentPage
     * @param mv
     * @return
     */
    @GetMapping("myList.re")
    public ModelAndView selectMyList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
                                     ModelAndView mv,
                                     HttpSession session) {
        
    	Member loginMember = (Member) session.getAttribute("loginMember");
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
    	
        int listCount = reviewService.selectMyCount(memberNo);
        log.debug("내가 쓴글 listCount : " + listCount);
        
        int pageLimit = 5;
        int boardLimit = 16;
        
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
        List<Review> list = reviewService.selectMyReviewList(pi, memberNo);
        
        mv.addObject("pi", pi)
          .addObject("list", list)
          .setViewName("member/myReviewListView");
        
//        log.debug("내가 쓴글 list : " + list);
        log.debug("내가 쓴글 list.size() : " + list.size());
        
        return mv;
    }
	
	
    @GetMapping("myLikedList.re")
    public ModelAndView selectMyLikedList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
                                     ModelAndView mv,
                                     HttpSession session) {
        
    	Member loginMember = (Member) session.getAttribute("loginMember");
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;
    	
        int listCount = reviewService.selectMyLikedCount(memberNo);
        log.debug("내가 쓴글 listCount : " + listCount);
        
        int pageLimit = 5;
        int boardLimit = 16;
        
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
        List<Review> list = reviewService.selectMyLikedReviewList(pi, memberNo);
        
        mv.addObject("pi", pi)
          .addObject("list", list)
          .setViewName("member/myReviewListView");
        
//        log.debug("내가 쓴글 list : " + list);
        log.debug("내가 쓴글 list.size() : " + list.size());
        
        return mv;
    }
	
	
	
	
	
	
	
	
	
}
