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
	@GetMapping("addProduct.ma")
	public ModelAndView addProduct(ModelAndView mv)
	{
		mv.setViewName("goods/addProduct");
		return mv;
	}
	
	@GetMapping("Management.ma")
	public ModelAndView productManagement(ModelAndView mv)
	{
		mv.setViewName("goods/productManagement");
		return mv;
	}
}
