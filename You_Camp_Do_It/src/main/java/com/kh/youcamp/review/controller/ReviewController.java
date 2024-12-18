package com.kh.youcamp.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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

    /*게시글등록*/
    @GetMapping("enrollForm.re")
    public String enrollForm() {
        return "review/reviewEnrollForm";
    }

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
                at.setChangeName(changeName);
                at.setFilePath("/resources/images/review_upfiles/");
                at.setFileLevel(i);

                attachments.add(at);
                log.debug("attachment:{}", at);
            }
        }

        r.setReviewAttachments(attachments);
        reviewService.insertReview(r);

        return "redirect:/list.re";
    }
    
    @GetMapping("list.re")
    public ModelAndView selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
                                 ModelAndView mv) {
        
        int listCount = reviewService.selectCount();
        
        int pageLimit = 5;
        int boardLimit = 5;
        
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
        List<Review> list = reviewService.selectReviewList(pi);
        
        mv.addObject("pi", pi)
          .addObject("list", list)
          .setViewName("review/reviewListView");
        
        return mv;
    }
    
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
            log.error("File upload error: ", e);
        }
        
        return changeName;
    }
    
    
    

}

