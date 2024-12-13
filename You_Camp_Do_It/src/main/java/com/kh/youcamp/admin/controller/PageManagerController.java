package com.kh.youcamp.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.goods.model.service.GoodsService;
import com.kh.youcamp.goods.model.vo.Goods;

@Controller
public class PageManagerController
{
	@GetMapping("manager.ma")
	public ModelAndView adminPage1(ModelAndView mv)
	{
		mv.setViewName("goods/addProduct");
		return mv;
	}
}
