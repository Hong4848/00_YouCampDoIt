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
	private String searchCategory = "상품분류 선택";
	private String sort = "";
	private String condition = "";
	private int startPrice = 0;
	private int endPrice = 0;
}
