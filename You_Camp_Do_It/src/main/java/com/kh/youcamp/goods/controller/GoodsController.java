package com.kh.youcamp.goods.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.goods.model.service.GoodsService;
import com.kh.youcamp.goods.model.vo.Goods;

@Controller
public class GoodsController
{
	@Autowired
	private GoodsService goodsService;
	
	@GetMapping("product.gs")
	public ModelAndView selectList(ModelAndView mv, HttpSession session)
	{
		mv.setViewName("goods/shoppingMall");
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value="enrollGoods.gs", produces="text/html; charset=UTF-8")
	public String insertGoods(Goods g, HttpSession session)
	{
		int result = goodsService.insertGoods(g);
		
		if(result > 0)
		{
			// 성공
			session.setAttribute("alertMsg", "상품 등록에 성공했습니다");
			return "manager.ma";
		}
		else
		{
			// 실패
			session.setAttribute("errorMsg", "상품 등록에 실패했습니다");
			return "manager.ma";
		}
	}
	
	@GetMapping("goodsDetail.gs")
	public ModelAndView goodsDetail(ModelAndView mv, HttpSession session)
	{
		mv.setViewName("goods/goodsPage");
		return mv;
	}
	
}
