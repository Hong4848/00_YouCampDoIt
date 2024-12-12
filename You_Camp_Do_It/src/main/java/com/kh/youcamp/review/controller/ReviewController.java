package com.kh.youcamp.review.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.review.model.service.ReviewService;

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
	

	
	// 게시글 상세보기 요청 - Path Variable 방식을 이용
	@GetMapping("detail.re")
	public ModelAndView selectBoard(ModelAndView mv) {
		mv.setViewName("review/reviewDetailView");
		return mv;
	}
}
