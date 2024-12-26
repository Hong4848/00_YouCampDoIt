package com.kh.youcamp.admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PageManagerController
{
	@GetMapping("adminMain.ma")
	public ModelAndView adminMain(ModelAndView mv)
	{
		mv.setViewName("admin/adminMain");
		return mv;
	}
	
	@GetMapping("addProduct.ma")
	public ModelAndView addProduct(ModelAndView mv)
	{
		mv.setViewName("goods/addProduct");
		return mv;
	}
	
	@GetMapping("Management.ma")
	public ModelAndView productManagement(ModelAndView mv)
	{
		mv.setViewName("goods/productManagement");
		return mv;
	}
	
	@ResponseBody
	@GetMapping("wrongApproach.ma")
	public ModelAndView wrongApproach(ModelAndView mv, HttpSession session) {
		session.setAttribute("wrongMsg", "잘못된 접근입니다.");
		mv.setViewName("redirect:/");
		return mv;
	}
	
	
	/**
	 * 24.12.24 정성민
	 * 관리자 페이지 회원관리 페이지 요청용 컨트롤러
	 * @param mv
	 * @return
	 */
	@GetMapping("memberManageList.me")
	public ModelAndView memberManagement(ModelAndView mv) {
		
		mv.setViewName("member/memberManagementList");
		return mv;
	}
	
	/**
	 * 24.12.24 정성민
	 * 관리자 페이지 예약관리 페이지 요청용 컨트롤러
	 * @param mv
	 * @return
	 */
	@GetMapping("reserveManageList.res")
	public ModelAndView reserveManagement(ModelAndView mv) {
		
		mv.setViewName("reserve/reserveManagementList");
		return mv;
	}
	
}
