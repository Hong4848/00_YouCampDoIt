package com.kh.youcamp.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.youcamp.review.model.service.ReviewService;
import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;

@Controller
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    /*목록조회*/
    @GetMapping("list.re")
    public String selectList() {
        return "review/reviewListView";
    }

    /*게시글등록*/
    @GetMapping("enrollForm.re")
    public String showEnrollForm() {
        return "review/reviewEnrollForm";
    }

    @RequestMapping(value = "/insert.re", method = RequestMethod.POST)
    public String insertReview(@ModelAttribute Review r, 
                               @RequestParam("upfile") MultipartFile[] upfiles,
                               HttpSession session) {

        // 첨부파일 처리 로직
        ArrayList<ReviewAttachment> attachments = new ArrayList<>();
        String savePath = session.getServletContext().getRealPath("/resources/images/review_upfiles/");

        for (int i = 0; i < upfiles.length; i++) {
            MultipartFile upfile = upfiles[i];
            
            if (!upfile.getOriginalFilename().isEmpty()) { // 파일이 비어 있지 않으면
                // 파일 저장 처리
                String changeName = saveFile(upfile, savePath);

                // 파일 첨부 객체 생성 후 리스트에 추가
                ReviewAttachment at = new ReviewAttachment();
                at.setOriginName(upfile.getOriginalFilename());
                at.setChangeName(changeName);
                at.setFilePath("/resources/images/review_upfiles/");
                at.setFileLevel(i); // 파일 순서

                attachments.add(at);
            }
        }

        // 리뷰 객체에 첨부파일 목록 설정
        r.setReviewAtachments(attachments);

        // 데이터베이스 저장 또는 서비스 호출
        // 예시: reviewService.insertReview(r); 

        System.out.println("Review: " + r);
        System.out.println("Attachments: " + attachments);

        // 성공적으로 처리된 후, list.re로 리다이렉트 (리스트 페이지로 이동)
        return "redirect:/list.re"; // 성공적으로 리뷰가 등록되면 리스트 페이지로 리다이렉트
    }
       
       
    
    
    public String saveFile(MultipartFile upfile, String savePath) {
        String originName = upfile.getOriginalFilename();
        String currentTime = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
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
    
    /*상세조회*/
    

}

