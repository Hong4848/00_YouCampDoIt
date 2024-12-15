package com.kh.youcamp.notice.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	

	// 게시글 상세조회 요청 - 기존의 방식 (쿼리스트링 이용)
	@GetMapping("detail.no")
	public ModelAndView selectNotice(@RequestParam("nno") int nno, ModelAndView mv) {
	    
	    // 1. 조회수 증가
	    int result = noticeService.increaseCount(nno);
	    
	    if(result > 0) { 
	        // 2. 현재 게시글 정보 조회
	        Notice currentNotice = noticeService.selectNotice(nno);
	        
	        // 3. 모든 게시글의 번호 목록을 가져옵니다.
	        List<Integer> allNoticeNumbers = noticeService.getAllNoticeNumbers();
	        
	        // 4. 현재 게시글의 인덱스를 찾습니다.
	        int currentIndex = allNoticeNumbers.indexOf(nno);
	        
	        Notice previousNotice = null;
	        Notice nextNotice = null;
	        
	        // 5. 이전글 설정
	        if (currentIndex > 0) {
	            int previousNno = allNoticeNumbers.get(currentIndex - 1);
	            previousNotice = noticeService.selectNotice(previousNno);
	        }
	        
	        // 6. 다음글 설정
	        if (currentIndex < allNoticeNumbers.size() - 1) {
	            int nextNno = allNoticeNumbers.get(currentIndex + 1);
	            nextNotice = noticeService.selectNotice(nextNno);
	        }
	        
	        // 7. ModelAndView에 데이터 추가
	        mv.addObject("n", currentNotice);
	        mv.addObject("previousNotice", previousNotice);
	        mv.addObject("nextNotice", nextNotice);
	        mv.setViewName("notice/noticeDetailView");
	        
	    } else {
	        // 조회수 증가에 실패했을 경우
	        mv.addObject("errorMsg", "게시글 상세조회 실패");
	        mv.setViewName("common/errorPage");
	    }
	    
	    return mv;
	}
	


}
