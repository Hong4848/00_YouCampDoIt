package com.kh.youcamp.review.controller;

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
import com.kh.youcamp.member.model.vo.Member;
import com.kh.youcamp.review.model.service.ReviewService;
import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    /*게시글등록 요청 메소드*/
    @GetMapping("enrollForm.re")
    public String enrollForm() {
        return "review/reviewEnrollForm";
    }

    // 게시글 작성 요청 메소드
    @PostMapping("insert.re")
    public String insertReview(Review r, 
                             @RequestParam("upfile") MultipartFile[] upfiles,
                             HttpSession session) {
    	// 로그인한 사용자의 정보를 세션에서 가져옵니다.
        Member loginUser = (Member) session.getAttribute("loginMember");
        
        // Interceptor가 로그인 여부를 보장하므로 null 체크는 생략 가능
        r.setMemberNo(loginUser.getMemberNo()); // 작성자의 MEMBER_NO 설정
        r.setReviewWriter(loginUser.getMemberName()); // MEMBER_NAME을 REVIEW_WRITER로 설정
        
        log.debug("review: {}", r);
        
        String savePath = session.getServletContext().getRealPath("/resources/images/review_upfiles/");

        ArrayList<ReviewAttachment> attachments = new ArrayList<>();

        for (int i = 0; i < upfiles.length; i++) {
            MultipartFile upfile = upfiles[i];
            
            if (!upfile.getOriginalFilename().isEmpty()) {
                String changeName = saveFile(upfile, savePath);

                ReviewAttachment at = new ReviewAttachment();
                at.setOriginName(upfile.getOriginalFilename());
                at.setChangeName("/resources/images/review_upfiles/" + changeName);
                at.setFilePath(changeName);
                
                // fileLevel 설정
                /*
                if (i == 0) {
                    at.setFileLevel(1); // mainImage는 fileLevel 1
                } else {
                    at.setFileLevel(2); // detailImage1, detailImage2는 fileLevel 2
                }
                */
                
                // 첫 번째 파일은 대표이미지(fileLevel=1)
                // 나머지는 상세이미지(fileLevel=2)로 설정
                at.setFileLevel(i == 0 ? 1 : 2);
                

                attachments.add(at);
                log.debug("attachment:{}", at);
            }
        }

        r.setReviewAttachments(attachments); // 첨부파일 리스트 설정
        reviewService.insertReview(r); // 서비스 호출

        return "redirect:/list.re"; // 후기게시판 목록으로 이동
    }
    
    // 목록조회 요청 메소드
    @GetMapping("list.re")
    public ModelAndView selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
                                 ModelAndView mv) {
        
        int listCount = reviewService.selectCount();
        
        int pageLimit = 5;
        int boardLimit = 16;
        
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
        List<Review> list = reviewService.selectReviewList(pi);
        
        mv.addObject("pi", pi)
          .addObject("list", list)
          .setViewName("review/reviewListView");
        
        System.out.println(list);
        System.out.println(list.size());
        
        return mv;
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
    
    // 게시글 상세보기 요청 메소드
    @GetMapping("detail.re")
    public ModelAndView selectReview(int reviewNo, ModelAndView mv) {
    	System.out.println(reviewNo);
    	// 게시글 정보, 첨부파일 정보 조회
    	Review r = reviewService.selectReview(reviewNo);
    	
    	// 게시글 정보 첨부파일 정보 조회 후 상세페이지 포워딩
    	ArrayList<ReviewAttachment> list = reviewService.selectReviewAttachment(reviewNo);
    	
    	// 조회된 데이터들 담아서 응답페이지로 포워딩
    	mv.addObject("r", r).addObject("list",list).setViewName("review/reviewDetailView");
    	
    	return mv;
    }
    
    // 게시글 수정하기 페이지 요청
    @PostMapping("updateForm.re")
    public String updateForm(int reviewNo, Model model) {
    	Review r = reviewService.selectReview(reviewNo);
    	
    	model.addAttribute("r", r);
    	
    	return "review/reviewUpdateForm";
    }
    
    
    // 게시글 수정 요청
    @PostMapping("update.re")
    public String updateReview(Review r, ReviewAttachment re, MultipartFile reupFile, HttpSession session, Model model) {
    	
    	if(!reupFile.getOriginalFilename().equals("")) {
    		// 기존에 첨부파일이 있었을 경우
    		if(re.getOriginName() != null) {
    			String realPath = session.getServletContext().getRealPath(re.getChangeName());
    			new File(realPath).delete();
    		}
    		
    		// 새로 넘어온 첨부파일의 이름을 수정하고 서버에 업로드 시켜주기
    		//String changeName = saveFile(reupFile, session);
    		
    		// re 에 새로 넘어온 첨부파일에 대한 원본파일명, 경로를 포함한 수정파일명 필드 담아주기
    		re.setOriginName(reupFile.getOriginalFilename());
    		//re.setChangeName("resources/uploadFiles/" + changeName);
 
    	}
    	int result = reviewService.updateReview(r);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "게시글 수정 성공");
    		
    		return "redirect:/list.re";
    	} else {
    		model.addAttribute("errorMsg", "게시글 수정에 실패하였습니다.");
    		
    		return "common/errorPage";
    	}
    }
    
    
    
    /*
    
    // 게시글 삭제하기 요청 메소드
    public String deleteReview(int reviewNo, String filePath, Model model, HttpSession session) {
    	
    	int result = reviewService.deleteReview(reviewNo);
    	
    	if(result > 0) { // 성공
    		// 첨부파일이 있었을 경우는 실제 서버에 저장된 파일을 삭제시키기
    		if(!filePath.equals("")) {
    			// 기존의 첨부파일이 있을 경우
    			String realPath = session.getServletContext().getRealPath(filePath);
    			// c 드라이브에서 부터 시작되는 (루트디렉토리) 절대경로 뽑아오는 것
    			new File(realPath).delete(); // 실제로 타겟삼아 삭제하는 메소드
    		}
    		// 일회성 알람문구를 담아서 
    	}
    	
    }
    
    */
    
    // 게시글 수정하기 요청 메소드
    
    
    


}

