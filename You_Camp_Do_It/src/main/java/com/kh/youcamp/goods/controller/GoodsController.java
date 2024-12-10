package com.kh.youcamp.goods.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class GoodsController
{
	@GetMapping("product.gs")
	public ModelAndView selectList(ModelAndView mv)
	{
		mv.setViewName("goods/shoppingMall");
		return mv;
	}
}
