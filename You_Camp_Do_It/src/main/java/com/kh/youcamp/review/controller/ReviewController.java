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

import com.kh.youcamp.member.model.vo.Member;
import com.kh.youcamp.review.model.service.ReviewService;
import com.kh.youcamp.review.model.vo.Review;
import com.kh.youcamp.review.model.vo.ReviewAttachment;

@Controller
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    /*게시글등록*/
    @GetMapping("enrollForm.re")
    public String showEnrollForm() {
        return "review/reviewEnrollForm";
    }

    @PostMapping("insert.re")
    public String insertReview(Review r, 
                               @RequestParam("upfile") MultipartFile[] upfiles,
                               HttpSession session ) {

        
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
            }
        }

        r.setReviewAttachments(attachments);

        reviewService.insertReview(r);
        

        return "redirect:/list.re";
    }
    
    @GetMapping("list.re")
    public String selectList(Model model) {
        List<Review> list = reviewService.selectReviewList();
        
        if(list != null && !list.isEmpty()) {
            model.addAttribute("list", list); // "list"로 속성 이름 변경
        }
        
        return "review/reviewListView";
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

