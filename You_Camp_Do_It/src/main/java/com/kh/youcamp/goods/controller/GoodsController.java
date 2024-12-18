package com.kh.youcamp.goods.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.common.template.Pagination;
import com.kh.youcamp.goods.model.service.GoodsService;
import com.kh.youcamp.goods.model.vo.Goods;
import com.kh.youcamp.goods.model.vo.Search;

@Controller
public class GoodsController
{
	@Autowired
	private GoodsService goodsService;
	
	@GetMapping("product.gs")
	public String selectGoodsList(@RequestParam(value="pageNumber", defaultValue="1")int currentPage,
			HttpSession session, Model model)
	{
		int listCount = goodsService.selectListCount();
		int pageLimit = 5;
		int boardLimit = 8;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Goods> list = goodsService.selectGoodsList(pi);
		
		//섬네일 이미지 추출
		for(Goods g : list)
		{
			String s = "<img src="; // 이미지 태그 찾기
			String body = g.getGoodsThumbnail();
			int start = 0;
			int end = 0;
			
			start = body.indexOf(s);
			body = body.substring(start);
			end = body.indexOf(">");
			body = body.substring(0, end+1);
			
			g.setGoodsThumbnail(body);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "goods/shoppingMall";
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
	public String goodsDetail(@RequestParam(value="goodsNo")int goodsNo, HttpSession session, Model model)
	{
		int result = goodsService.selectViewCount(goodsNo);
		Goods goods = null;
		
		if(result > 0){
			goods = goodsService.selectOneGoods(goodsNo);
			
			String s = "<img src="; // 이미지 태그 찾기
			String body = goods.getGoodsThumbnail();
			int start = 0;
			int end = 0;
			
			start = body.indexOf(s);
			body = body.substring(start);
			end = body.indexOf(">");
			body = body.substring(0, end+1);
			
			goods.setGoodsThumbnail(body);
		}
		
		model.addAttribute("goods", goods);
		return "goods/goodsPage";
	}
	
	@GetMapping("searching.gs")
	public String searchingGoods(@RequestParam(value="pageNumber", defaultValue="1")int currentPage,
			Search search, HttpSession session, Model model)
	{
		int listCount = goodsService.selectListCount();
		int pageLimit = 5;
		int boardLimit = 8;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Goods> list = goodsService.searchingGoods(search, pi);
		
		//섬네일 이미지 추출
		for(Goods g : list)
		{
			String s = "<img src="; // 이미지 태그 찾기
			String body = g.getGoodsThumbnail();
			int start = 0;
			int end = 0;
			
			start = body.indexOf(s);
			body = body.substring(start);
			end = body.indexOf(">");
			body = body.substring(0, end+1);
			
			g.setGoodsThumbnail(body);
		}
		
		if(!(search.getSearchKeyword().equals("")))
		{
			pi.setListCount(list.size());
		}
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("search", search);
		
		return "goods/searchShoppingMall";
	}
	
	
	/* 일단은 배제
	@PostMapping("ajaxSearching.gs")
	public String ajaxSearchingGoods(@RequestParam(value="pageNumber", defaultValue="1")int currentPage,
			Search search, HttpSession session, Model model)
	{
		System.out.println(search);
		int listCount = goodsService.selectListCount();
		int pageLimit = 5;
		int boardLimit = 8;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Goods> list = goodsService.searchingGoods(search, pi);
		
		//섬네일 이미지 추출
		for(Goods g : list)
		{
			String s = "<img src="; // 이미지 태그 찾기
			String body = g.getGoodsThumbnail();
			int start = 0;
			int end = 0;
			
			start = body.indexOf(s);
			body = body.substring(start);
			end = body.indexOf(">");
			body = body.substring(0, end+1);
			
			g.setGoodsThumbnail(body);
		}
		
		pi.setListCount(list.size());
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("search", search);
		
		return "goods/searchShoppingMall";
	}
	*/ 
}
