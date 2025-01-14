package com.kh.youcamp.goods.model.service;

import java.util.ArrayList;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.goods.model.vo.Goods;
import com.kh.youcamp.goods.model.vo.Rental;
import com.kh.youcamp.goods.model.vo.Search;
import com.kh.youcamp.order.model.vo.OrderDetail;

public interface GoodsService {
	
public int insertGoods(Goods g);
	
	public int selectListCount();
	
	public ArrayList<Goods> selectGoodsList(PageInfo pi);
	
	public int searchingListCount(Search search);
	
	public ArrayList<Goods> searchingGoods(Search search, PageInfo pi);
	
	public int selectViewCount(int goods);
	
	public Goods selectOneGoods(int goods);
	
	public int totalCount(Search search);
	public int onSaleCount(Search search);
	public int offSaleCount(Search search);
	public int hideCount(Search search);
	
	public int ajaxSelectListCount(String state);
	
	public ArrayList<Goods> ajaxGoodsSelect(Search search, PageInfo pi, String state);
	
	public Goods ajaxGoodsDetail(int goodsNo);

	public int ajaxGoodsDetailUpdate(Goods g);
	
	public Goods adminUpdateGoods(int goodsNo);

	public int updateGoods(Goods g);
	
	public int dibsCheck(int memberNo, int goodsNo);
	
	public int ajaxDibsInsert(int memberNo, int goodsNo);
	
	public int ajaxDibsDelete(int memberNo, int goodsNo);
	
	public ArrayList<Goods> selectDibs(int memberNo);
	
	public int selectDibsCount(int memberNo);
	
	public int discountListCount();
	
	public ArrayList<Goods> discountList(PageInfo pi);
	
	public int AjaxRentalListCount();
	
	public ArrayList<OrderDetail> AjaxRentalList(PageInfo pi);
	
	public Goods ajaxRentalGoods(int goodsNo);
	
	public Rental ajaxRentalMember(int orderNo);
	
	public int AjaxRentalCount();
	
	public int AjaxReturnCount();
/************************************************************************************************************************/	
/************************************************************************************************************************/
/************************************************************************************************************************/
	
	// 카트리스트조회 시 썸네일만 가져오는 용도
	public ArrayList<Goods> selectGoodsThumbnailList(int memberNo);
	// 주문 정보 생성 시 썸네일만 가져오는 용도
	public ArrayList<Goods> selectGoodsThumbnailListByOrderNo(int orderNo);
}
