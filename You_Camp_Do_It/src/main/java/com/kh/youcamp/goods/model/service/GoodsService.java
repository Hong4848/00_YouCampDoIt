package com.kh.youcamp.goods.model.service;

import java.util.ArrayList;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.goods.model.vo.Goods;
import com.kh.youcamp.goods.model.vo.Search;

public interface GoodsService {
	
	public int insertGoods(Goods g);
	
	public int selectListCount();
	
	public ArrayList<Goods> selectGoodsList(PageInfo pi);
	
	public ArrayList<Goods> searchingGoods(Search search, PageInfo pi);
	
	public int selectViewCount(int goods);
	
	public Goods selectOneGoods(int goods);
	
	public int totalCount(Search search);
	public int onSaleCount(Search search);
	public int offSaleCount(Search search);
	public int hideCount(Search search);
	
	public int ajaxSelectListCount();
	
	public ArrayList<Goods> ajaxGoodsSelect(Search search, PageInfo pi);
}
