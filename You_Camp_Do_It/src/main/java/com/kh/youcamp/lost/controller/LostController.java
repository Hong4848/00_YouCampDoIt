package com.kh.youcamp.lost.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
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
    
    /*게시글등록 요청 메소드*/
    @GetMapping("enrollForm.lo")
    public String enrollForm() {
        return "lost/lostEnrollForm";
    }

    // 게시글 작성 요청 메소드
    @PostMapping("insert.lo")
    public String insertReview(Lost l, 
                             @RequestParam("upfile") MultipartFile[] upfiles,
                             HttpSession session, Model model) {

    	if (l.getCategoryName() == null || l.getCategoryName().isEmpty()) {
            model.addAttribute("msg", "카테고리를 선택해주세요.");
            return "errorPage";
        }
        
        String savePath = session.getServletContext().getRealPath("/resources/images/lost_upfiles/");

        ArrayList<LostAttachment> attachments = new ArrayList<>();

        for (int i = 0; i < upfiles.length; i++) {
            MultipartFile upfile = upfiles[i];
            
            if (!upfile.getOriginalFilename().isEmpty()) {
                String changeName = saveFile(upfile, savePath);

                LostAttachment at = new LostAttachment();
                at.setOriginName(upfile.getOriginalFilename());
                at.setChangeName("/resources/images/lost_upfiles/" + changeName);
                at.setFilePath(changeName);
                
                // 첫 번째 파일은 대표이미지(fileLevel=1)
                // 나머지는 상세이미지(fileLevel=2)로 설정
                at.setFileLevel(i == 0 ? 1 : 2);
                

                attachments.add(at);
                log.debug("attachment:{}", at);
            }
        }

        l.setLostAttachments(attachments); // 첨부파일 리스트 설정
        lostService.insertLost(l); // 서비스 호출

        return "redirect:/list.lo"; // 분실물게시판 목록으로 이동
    }

    // --- 일반메소드 ---
    // 현재 넘어온 첨부파일 그 자체를 서버의 폴더에 저장시키는 역할~
    private String saveFile(MultipartFile upfile, String savePath) {
        String originName = upfile.getOriginalFilename();
        String currentTime = new java.text.SimpleDateFormat("yyyyMMddHHmmss")
                               .format(new java.util.Date());
        int ranNum = (int)(Math.random() * 90000 + 10000);
        String ext = originName.substring(originName.lastIndexOf("."));
        String changeName = currentTime + ranNum + ext;
        
        try {
            upfile.transferTo(new File(savePath + changeName));
        } catch (IllegalStateException | IOException e) {
        	e.printStackTrace();
        }
        
        return changeName;
    }
	

}
