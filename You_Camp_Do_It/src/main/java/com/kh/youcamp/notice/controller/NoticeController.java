package com.kh.youcamp.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.common.template.Pagination;
import com.kh.youcamp.notice.model.service.NoticeService;
import com.kh.youcamp.notice.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	public String selectList(
	        @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
	        @RequestParam(value = "condition", required = false) String condition,
	        @RequestParam(value = "keyword", required = false) String keyword,
	        Model model) {

	    // 검색 조건과 키워드를 HashMap에 담아 전달
	    HashMap<String, String> searchMap = new HashMap<>();
	    if (condition != null && keyword != null && !keyword.trim().isEmpty()) {
	        searchMap.put("condition", condition);
	        searchMap.put("keyword", keyword);
	    }

	    int listCount = noticeService.selectListCount(searchMap); // 검색 조건에 따른 전체 리스트 수

	    int pageLimit = 5;
	    int boardLimit = 5;

	    PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

	    ArrayList<Notice> list = noticeService.selectList(pi, searchMap); // 검색 조건에 따른 리스트 조회

	    // 검색 조건과 키워드도 뷰로 전달
	    model.addAttribute("list", list);
	    model.addAttribute("pi", pi);
	    model.addAttribute("condition", condition);
	    model.addAttribute("keyword", keyword);

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
	        
	        // 3. 이전글과 다음글 조회
	        Notice previousNotice = noticeService.getPreviousNotice(nno);
	        Notice nextNotice = noticeService.getNextNotice(nno);
	        
	        // 4. ModelAndView에 데이터 추가
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
	
	// 공지사항 작성하기 페이지 요청
	@GetMapping("enrollForm.no")
	public ModelAndView enrollForm(ModelAndView mv) {
		mv.setViewName("notice/noticeEnrollForm");
		return mv;
	}
	
	// 공지사항 작성 요청
	@PostMapping("insert.no")
	public ModelAndView insertNotice(Notice n, MultipartFile upfile,
			HttpSession session,
			ModelAndView mv) {
		if(!upfile.getOriginalFilename().equals("")) {
			String changeName = saveFile(upfile, session);
		n.setOriginName(upfile.getOriginalFilename());
		n.setChangeName("resources/uploadFiles/" + changeName);
		}
		
		int result = noticeService.insertNotice(n);
		
		if(result > 0) { // 성공
			session.setAttribute("alertMsg", "게시글 작성 성공");
			mv.setViewName("redirect:/list.no");
		} else { // 실패
			mv.addObject("errorMsg", "게시글 작성 실패").setViewName("common/errorPage");
		}
		return mv;
	}
	
	// 게시글 삭제 요청
	@PostMapping("delete.no")
	public String deleteNotice(int nno,
							  String filePath,
							  Model model,
							  HttpSession session) {
		
		
		int result = noticeService.deleteNotice(nno);
		
		if(result > 0) { // 성공
			
			// 첨부파일이 있었을 경우는
			// > 실제 서버에 저장된 파일을 삭제시키기
			if(!filePath.equals("")) {
				// 기존의 첨부파일이 있을 경우
				
				String realPath 
					= session.getServletContext()
							 .getRealPath(filePath);
				
				new File(realPath).delete();
			}
			
			// 일회성 알람 문구를 담아서
			// 게시판 리스트 페이지로 url 재요청
			session.setAttribute("alertMsg", "게시글 삭제 성공");
			
			return "redirect:/list.no";
			
		} else { // 실패
			
			// 에러 문구를 담아서 에러 페이지로 포워딩
			
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			
			return "common/errorPage";
		}
	}
	
	// 게시글 수정하기 페이지 요청
	@GetMapping("updateForm.no")
	public String updateForm(int nno, Model model) {
		
		
		// 게시글 수정하기 페이지에서는
		// 기존 게시글의 제목, 내용등이 일단 먼저 보여져야함
		// > 기존 게시글 상세보기 서비스 로직 재활용
		Notice n = noticeService.selectNotice(nno);
		
		model.addAttribute("n", n);
		
		return "notice/noticeUpdateForm";
	}
	
	// 게시글 수정 요청
	@PostMapping("update.no")
	public String updateNotice(@ModelAttribute Notice n,
	                           @RequestParam(value="reupfile", required=false) MultipartFile reupfile,
	                           HttpSession session,
	                           Model model) {

		log.debug("Received Notice object: " + n);
		log.debug("Received file: " + (reupfile != null ? reupfile.getOriginalFilename() : "no file"));
		
		// 새로 넘어온 첨부파일이 있을 경우
	    if(reupfile != null && !reupfile.getOriginalFilename().isEmpty()) {
	        // 기존 파일이 있다면 삭제
	        Notice originalNotice = noticeService.selectNotice(n.getNoticeNo());
	        if(originalNotice != null && originalNotice.getChangeName() != null) {
	            String realPath = session.getServletContext().getRealPath(originalNotice.getChangeName());
	            new File(realPath).delete();
	        }
	        
	        // 새 파일 저장
	        String changeName = saveFile(reupfile, session);
	        n.setOriginName(reupfile.getOriginalFilename());
	        n.setChangeName("resources/uploadFiles/" + changeName);
	    }

	    int result = noticeService.updateNotice(n);
	    
	    log.debug("Update result: " + result);

	    if(result > 0) {
	        session.setAttribute("alertMsg", "게시글 수정 성공");
	        return "redirect:/list.no";
	    } else {
	        model.addAttribute("errorMsg", "게시글 수정 실패");
	        return "common/errorPage";
	    }
	}




	
	
	// --------일반메소드---------
	public String saveFile(MultipartFile upfile,
			   HttpSession session) {

	// 1. 원본파일명 얻어오기
	String originName = upfile.getOriginalFilename();
	// 예) bono.jpg
	
	
	// 2. 현재 시간을 년월일시분초로 뽑아내기
	// "yyyyMMddHHmmss" > SimpleDateFormat 객체 활용
	String currentTime 
		= new SimpleDateFormat("yyyyMMddHHmmss")
								.format(new Date());
	
	// 3. 뒤에 붙을 5자리 랜덤수 뽑아내기
	// 10000 ~ 99999 까지 총 90000 개의 숫자 중 한개
	int ranNum = (int)(Math.random() * 90000 + 10000);
	
	// 4. 원본파일명으로부터 확장자명 뽑아오기
	String ext 
	= originName.substring(originName.lastIndexOf("."));
	
	// 5. 모두 이어 붙이기
	String changeName = currentTime + ranNum + ext;
	// 예) "2024111817010112345.jpg"
	
	// 기존 cos.jar 는 파일명 수정 후 서버로 자동 업로드까지
	// 한번에 해줬었음!!
	// commons-fileupload, commons-io 는
	// 서버로 자동 업로드를 안해줌!! (보안 상 더 권장)
	
	// 6. 업로드 하고자 하는 서버의 물리적인 경로 알아내기
	// > applicationScope 객체를 이용해서 얻어낸다.
	String savePath 
		= session.getServletContext()
			.getRealPath("/resources/uploadFiles/");
	
	// 7. 경로와 수정파일명을 합체 후 파일을 업로드해주기
	// (업로드 하는 구문을 내가 직접 작성해야함)
	// MultipartFile 객체에서 제공하는 transferTo 메소드를 활용
	try {
		File targetFile = new File(savePath + changeName);
        upfile.transferTo(targetFile);
	} catch (IOException e) {
	e.printStackTrace();
	}
	
	return changeName;
	}

}
