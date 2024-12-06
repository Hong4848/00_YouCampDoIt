package com.kh.youcamp.review.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReviewController {

	// 후기게시판 목록조회 요청
	@GetMapping(value="list.re")
	public String selectList() {
		return "review/reviewListView";
	}
	
	// 후기게시판 작성 페이지 요청
	@GetMapping("enrollForm.re")
	public ModelAndView enrollForm(ModelAndView mv) {
		mv.setViewName("review/reviewEnrollForm");
		return mv;
	}
}
