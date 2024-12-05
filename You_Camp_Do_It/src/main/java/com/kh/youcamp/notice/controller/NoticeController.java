package com.kh.youcamp.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NoticeController {
	
	@GetMapping(value="list.no")
	public String selectList() {
		return "notice/noticeListView";
	}

}
