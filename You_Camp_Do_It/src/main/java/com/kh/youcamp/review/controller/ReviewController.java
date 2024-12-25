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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.common.template.Pagination;
import com.kh.youcamp.member.model.vo.Member;
import com.kh.youcamp.review.model.service.ReviewService;
import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;
import com.kh.youcamp.review.model.vo.ReviewReply;

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
    public String updateForm(@RequestParam("rno") int reviewNo, Model model) {
        // 리뷰 정보 가져오기
        Review r = reviewService.selectReview(reviewNo);
        
        // 첨부파일 리스트 가져오기
        List<ReviewAttachment> attachments = reviewService.selectReviewAttachment(reviewNo);
        
         // FILE_LEVEL에 따라 분류
        ReviewAttachment mainImage = null;
        ReviewAttachment detailImage1 = null;
        ReviewAttachment detailImage2 = null;

        for (ReviewAttachment attachment : attachments) {
            if (attachment.getFileLevel() == 1) {
                mainImage = attachment; // 대표 이미지
            } else if (attachment.getFileLevel() == 2 && detailImage1 == null) {
                detailImage1 = attachment; // 상세 이미지 1
            } else if (attachment.getFileLevel() == 2) {
                detailImage2 = attachment; // 상세 이미지 2
            }
        }

        // model 에 데이터 추가
        model.addAttribute("r", r);
        model.addAttribute("mainImage", mainImage);
        model.addAttribute("detailImage1", detailImage1);
        model.addAttribute("detailImage2", detailImage2);
        
        return "review/reviewUpdateForm";
    }
   
    // 게시글 수정 요청
    @PostMapping("update.re")
    public String updateReview(Review r, 
                               @RequestParam(value="upfile", required=false) MultipartFile[] upfiles,
                               HttpSession session, 
                               Model model, 
                               ArrayList<ReviewAttachment> attachments) {
    	 log.debug("Review object before updating: {}", r);

    	    if (r == null) {
    	        model.addAttribute("errorMsg", "리뷰 정보가 유효하지 않습니다.");
    	        return "common/errorPage";
    	    }

    	    if (attachments == null) {
    	        model.addAttribute("errorMsg", "첨부파일 정보가 유효하지 않습니다.");
    	        return "common/errorPage";
    	    }
    	
    	
    	log.debug("Review object before updating: {}", r);

        // reviewNo 유효성 검증
        if (r.getReviewNo() <= 0) {
            log.error("Invalid reviewNo: {}", r.getReviewNo());
            model.addAttribute("errorMsg", "게시글 번호가 유효하지 않습니다.");
            return "common/errorPage";
        }

        // 로그인 사용자 정보 가져오기
        Member loginUser = (Member) session.getAttribute("loginMember");
        log.debug("Session ID: {}", session.getId());
        log.debug("loginMember from session: {}", loginUser);

        if (loginUser == null) {
            model.addAttribute("errorMsg", "로그인이 필요합니다.");
            return "common/errorPage";
        }

        // 사용자 정보 설정
        r.setMemberNo(loginUser.getMemberNo());
        r.setReviewWriter(loginUser.getMemberName());

        // 파일 저장 경로 (서버 내부 경로)
        String savePath = session.getServletContext().getRealPath("/resources/images/review_upfiles/");
        
        // 파일 처리 부분
        if (upfiles != null) {
            for (MultipartFile upfile : upfiles) {
                if (!upfile.getOriginalFilename().isEmpty()) {
                    // 기존 파일이 있는지 확인하고 삭제
                    if (r.getReviewAttachments() != null && !r.getReviewAttachments().isEmpty()) {
                        for (ReviewAttachment existingAttachment : r.getReviewAttachments()) {
                            File oldFile = new File(savePath + existingAttachment.getChangeName());
                            if (oldFile.exists()) {
                                oldFile.delete(); // 모든 첨부파일 삭제
                            }
                        }
                    }

                    // 새로운 파일 저장
                    String changeName = saveFile(upfile, savePath);  // changeName은 실제로 저장된 파일명
                    ReviewAttachment at = new ReviewAttachment();
                    at.setOriginName(upfile.getOriginalFilename());
                    at.setChangeName("/resources/images/review_upfiles/" + changeName);  // 클라이언트에서 접근할 수 있는 경로
                    at.setFilePath(savePath);  // 서버 경로
                    at.setReviewNo(r.getReviewNo());
                    
                    // 파일 레벨 설정 (첫 번째 파일은 대표 이미지로 설정)
                    at.setFileLevel(attachments.isEmpty() ? 1 : 2); // 첫 번째 첨부파일을 대표 이미지로 처리
                    attachments.add(at);  // 새로운 첨부파일 리스트에 추가
                }
            }
        }

        // 업데이트된 리뷰 및 첨부파일 리스트를 서비스에 전달
        int result = reviewService.updateReview(r);  // 리뷰 업데이트
        log.debug("Update result: {}", result);

        if (result > 0) {
            session.setAttribute("alertMsg", "게시글이 성공적으로 수정되었습니다.");
            return "redirect:/list.re";
        } else {
            model.addAttribute("errorMsg", "게시글 수정에 실패했습니다.");
            return "common/errorPage";
        }
    }

    // 게시글 삭제하기 요청 메소드
    @PostMapping("delete.re")
    public String deleteReview(int rno,
    						   String filePath,
                               HttpSession session, 
                               Model model) {
        
        // 첨부파일 정보 가져오기
        ArrayList<ReviewAttachment> attachments = reviewService.selectReviewAttachment(rno);
        
        int result = reviewService.deleteReview(rno);
        
        if (result > 0) {
            // 첨부파일이 있었을 경우 실제 서버에 저장된 파일을 삭제
            for (ReviewAttachment attachment : attachments) {
                String realPath = session.getServletContext().getRealPath(attachment.getChangeName());
                new File(realPath).delete();
            }
            
            session.setAttribute("alertMsg", "게시글이 성공적으로 삭제되었습니다.");
            return "redirect:list.re";
        } else {
            model.addAttribute("errorMsg", "게시글 삭제에 실패하였습니다.");
            return "common/errorPage";
        }
    }

    // 댓글 목록 조회 요청 (ajax)
    @ResponseBody
    @GetMapping(value="rlist.re", produces="application/json; charset=UTF-8")
    public String ajaxSelectReplyList(@RequestParam("rno") int reviewNo) {
        ArrayList<ReviewReply> list = reviewService.selectReplyList(reviewNo);
        return new Gson().toJson(list);
    }
 	
    // 댓글 작성용 요청
    @ResponseBody
    @PostMapping(value="rinsert.re", produces="text/html; charset=UTF-8")
    public String ajaxInsertReply(@ModelAttribute ReviewReply r) {
        int result = reviewService.insertReviewReply(r);
        return (result > 0) ? "success" : "fail";
    }
    
    


}

