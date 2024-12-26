package com.kh.youcamp.lost.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.common.template.Pagination;
import com.kh.youcamp.lost.model.service.LostService;
import com.kh.youcamp.lost.model.vo.Lost;
import com.kh.youcamp.lost.model.vo.LostAttachment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LostController {
	
	@Autowired
    private LostService lostService;
	
	// 목록조회 요청 메소드
    @GetMapping("list.lo")
    public ModelAndView selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
                                 ModelAndView mv) {
        
        int listCount = lostService.selectCount();
        
        int pageLimit = 5;
        int boardLimit = 16;
        
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
        List<Lost> list = lostService.selectLostList(pi);
        
        mv.addObject("pi", pi)
          .addObject("list", list)
          .setViewName("lost/lostListView");
        
        System.out.println(list);
        System.out.println(list.size());
        
        return mv;
    }
	
    // 게시글 상세보기 요청 메소드
    @GetMapping("detail.lo")
    public ModelAndView selectLost(int lostNo, ModelAndView mv) {
    	
    	// 게시글 정보, 첨부파일 정보 조회
    	Lost l = lostService.selectLost(lostNo);
    	log.debug("Review data: {}", l);  // 로그 추가
        
        // 게시글 정보 첨부파일 정보 조회 후 상세페이지 포워딩
        ArrayList<LostAttachment> list = lostService.selectLostAttachment(lostNo);
        log.debug("Attachment list size: {}", list.size());  // 로그 추가
        
        // 각 첨부파일 정보 로깅
        for(LostAttachment file : list) {
            log.debug("File info - fileNo: {}, fileLevel: {}, changeName: {}", 
                     file.getFileNo(), file.getFileLevel());
        }
    	
    	// 조회된 데이터들 담아서 응답페이지로 포워딩
    	mv.addObject("l", l).addObject("list",list).setViewName("lost/lostDetailView");
    	
    	return mv;
    }

}
