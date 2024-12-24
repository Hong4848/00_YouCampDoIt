package com.kh.youcamp.goods.model.vo;

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
public class Search
{
	private String searchKeyword = "";
	private String searchCategory = "상품분류선택";
	private String sort = "신상품순";
	private String condition = "상품이름";
	private String startPrice = "0";
	private String endPrice = "0";
}
