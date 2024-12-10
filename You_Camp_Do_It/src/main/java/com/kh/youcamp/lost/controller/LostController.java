package com.kh.youcamp.lost.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LostController {
	
	// 게시글 목록조회 요청
	@GetMapping("list.lo")
	public String selectList() {
		return "lost/lostListView";
	}
	
	// 게시글 상세보기 요청 - Path Variable 방식을 이용
	@GetMapping("detail.lo")
	public ModelAndView selectBoard(ModelAndView mv) {
		mv.setViewName("lost/lostDetailView");
		return mv;
	}

}
