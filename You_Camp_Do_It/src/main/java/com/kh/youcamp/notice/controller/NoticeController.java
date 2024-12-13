package com.kh.youcamp.notice.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.common.template.Pagination;
import com.kh.youcamp.notice.model.service.NoticeService;
import com.kh.youcamp.notice.model.vo.Notice;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 공지사항 목록조회 요청
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@GetMapping(value="list.no")
	public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, Model model) {
		
		int listCount = noticeService.selectListCount();
		
		int pageLimit = 5;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Notice> list = noticeService.selectList(pi);
		
		// 응답데이터로 목록조회 및 페이징바 관련 객체를 넘기고 공지사항 목록조회 페이지로 포워딩
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);

		return "notice/noticeListView";
	}
	
	// 게시글 상세보기 요청 - Path Variable 방식을 이용
	@GetMapping("notice/{noticeNo}")
	public ModelAndView selectNotice(@PathVariable(value="noticeNo")int nno, ModelAndView mv) {
		System.out.println(nno);
		// 1. 게시글 조회수 증가
		int result = noticeService.increaseCount(nno);
		
		if(result > 0) {
			// 2. 조회수 증가에 성공했다면 상세조회
			Notice n = noticeService.selectNotice(nno);
			mv.addObject("n", n).setViewName("notice/noticeDetailView");
		} else {
			// 조회수 증가에 실패했다면
			mv.addObject("errorMsg", "게시글 상세조회 실패").setViewName("common/errorPage");
		}
		return mv;
	}
	
	
	

}
