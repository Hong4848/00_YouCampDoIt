package com.kh.youcamp.goods.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Goods
{
	private int goodsNo;
	private String category;
	private String goodsName;
	private String goodsThumbnail;
	private String goodsContent;
	private String goodsInfo;
	private String mark;
	private int price;
	private double discount;
	private int views;
	private Date enrollDate;
	private int totalStock;
	private int remainStock;
	private String status;
}
