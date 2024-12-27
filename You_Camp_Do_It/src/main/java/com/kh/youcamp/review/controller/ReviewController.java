package com.kh.youcamp.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.common.template.Pagination;
import com.kh.youcamp.member.model.vo.Member;
import com.kh.youcamp.notice.model.vo.Notice;
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
    @GetMapping(value="list.re")
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

	    int listCount = reviewService.selectListCount(searchMap); // 검색 조건에 따른 전체 리스트 수
        
        int pageLimit = 5;
        int boardLimit = 8;
        
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
        ArrayList<Review> list = reviewService.selectList(pi, searchMap); // 검색 조건에 따른 리스트 조회


        // 검색 조건과 키워드도 뷰로 전달
	    model.addAttribute("list", list);
	    model.addAttribute("pi", pi);
	    model.addAttribute("condition", condition);
	    model.addAttribute("keyword", keyword);

	    return "review/reviewListView";
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
    public ModelAndView selectReview(int reviewNo, ModelAndView mv, HttpSession session) {
    	
    	// 게시글 정보, 첨부파일 정보 조회
    	Review r = reviewService.selectReview(reviewNo);
    	log.debug("Review data: {}", r);  // 로그 추가
        
        // 게시글 정보 첨부파일 정보 조회 후 상세페이지 포워딩
        ArrayList<ReviewAttachment> list = reviewService.selectReviewAttachment(reviewNo);
        log.debug("Attachment list size: {}", list.size());  // 로그 추가
        
        // 각 첨부파일 정보 로깅
        for(ReviewAttachment file : list) {
            log.debug("File info - fileNo: {}, fileLevel: {}, changeName: {}", 
                     file.getFileNo(), file.getFileLevel());
        }
        
        // 로그인한 사용자 정보 가져오기
        Member loginMember = (Member) session.getAttribute("loginMember");
	    int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

	    // 좋아요 여부와 카운트 가져오기
	    boolean isLiked = reviewService.isReviewLikedByMember(reviewNo, memberNo);
	    int likeCount = reviewService.getLikeCount(reviewNo);
	    
	    // 좋아요 정보 설정
	    r.setLiked(isLiked);
	    r.setLikeCount(likeCount);
	    
	    log.debug("좋아요 정보 넣고 r : " + r);
	    
	    mv.addObject("r", r)
	      .addObject("list", list)
	      .addObject("likeCount", likeCount);

    	
    	// 조회된 데이터들 담아서 응답페이지로 포워딩
    	mv.setViewName("review/reviewDetailView");
    	
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
					            Model model) {
			if (r == null || r.getReviewNo() <= 0) {
			model.addAttribute("errorMsg", "리뷰 정보가 유효하지 않습니다.");
			return "common/errorPage";
			}
			
			Member loginUser = (Member) session.getAttribute("loginMember");
			log.debug("Login user: {}", loginUser);
			if (loginUser == null) {
				model.addAttribute("errorMsg", "로그인이 필요합니다.");
				return "common/errorPage";
			}
			
			r.setMemberNo(loginUser.getMemberNo());
			r.setReviewWriter(loginUser.getMemberName());
			
			String savePath = session.getServletContext().getRealPath("/resources/images/review_upfiles/");
			
			ArrayList<ReviewAttachment> attachments = new ArrayList<>();
			List<ReviewAttachment> existingAttachments = reviewService.selectReviewAttachment(r.getReviewNo());
			log.debug("Existing attachments: {}", existingAttachments);
			
			for (ReviewAttachment attachment : existingAttachments) {
				boolean fileUpdated = false;
					for (MultipartFile upfile : upfiles) {
					if (!upfile.isEmpty() && attachment.getOriginName().equals(upfile.getOriginalFilename())) {
					 String changeName = saveFile(upfile, savePath);
					 attachment.setChangeName("/resources/images/review_upfiles/" + changeName);
					 attachment.setFilePath(savePath);
					 attachment.setStatus("Y");
					 fileUpdated = true;
					 break;
					}
				}
				if (!fileUpdated) {
					attachment.setStatus("N");
				}
					attachments.add(attachment);
			}
			
			if (upfiles != null) {
				for (MultipartFile upfile : upfiles) {
					if (!upfile.isEmpty()) {
					 boolean fileAlreadyExists = false;
					 for (ReviewAttachment existingAttachment : existingAttachments) {
					     if (existingAttachment.getOriginName().equals(upfile.getOriginalFilename())) {
					         fileAlreadyExists = true;
					         break;
					     }
					 }
					 if (!fileAlreadyExists) {
					     String changeName = saveFile(upfile, savePath);
					     log.debug("Saved file path: {}", changeName);
					     ReviewAttachment at = new ReviewAttachment();
					     at.setOriginName(upfile.getOriginalFilename());
					     at.setChangeName("/resources/images/review_upfiles/" + changeName);
					     at.setFilePath(savePath);
					     at.setReviewNo(r.getReviewNo()); // reviewNo 설정
					     at.setFileLevel(attachments.isEmpty() ? 1 : 2);
					     at.setStatus("Y");
					     attachments.add(at);
					 }
					}
				}
			}


        // 리뷰 업데이트와 첨부파일 업데이트
        int result = reviewService.updateReviewWithAttachments(r, attachments);

        if (result > 0) {
            // 수정된 reviewNo를 반환받을 수 있도록 하세요.
            int updatedReviewNo = r.getReviewNo(); // 수정된 리뷰 번호
            log.debug("Updated review number: {}", updatedReviewNo);  // 로그 출력

            session.setAttribute("alertMsg", "게시글이 성공적으로 수정되었습니다.");
            return "redirect:/list.re?reviewNo=" + updatedReviewNo; // 수정된 번호를 쿼리 파라미터로 넘김
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

    /* 
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
    */
    
    /**
     * 좋아요 기능 구현 ajax
     * 24.12.26 윤홍문
     * @param data
     * @return
     */
    @PostMapping("/like.re")
    public ResponseEntity<Map<String, Object>> toggleLike(@RequestBody Map<String, Integer> data) {
        int reviewNo = data.get("reviewNo");
        int memberNo = data.get("memberNo");

        // 좋아요 상태 변경 (추가 또는 삭제)
        boolean isLiked = reviewService.toggleLike(memberNo, reviewNo);

        // 변경 후 좋아요 개수 조회
        int likeCount = reviewService.getLikeCount(reviewNo);

        // 응답 데이터 구성
        Map<String, Object> response = new HashMap<>();
        response.put("isLiked", isLiked);
        response.put("likeCount", likeCount);

        return ResponseEntity.ok(response);
    }


}

