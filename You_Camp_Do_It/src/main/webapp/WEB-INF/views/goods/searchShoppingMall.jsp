<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>YOU CAMP DO IT 캠핑용품대여</title>
		<style>
			div{
				box-sizing: border-box;
			}

			#shoppingMall_header{
				width: 80%;
				height: 100px;
				margin: auto;
				display: flex;
				justify-content:right;
			}

			.logo{
				width: 30%;
				height: 100%;
			}

			.logo img{
				margin-left: 80px;
				height: 100%;
			}

			.title{
				width: 40%;
				height: 100%;
			}

			.search{
				width: 30%;
				height: 100%;
				margin-top: 30px;
			}

			.search_content
			{
				width: 85%;
				margin: auto;
				border: 2px solid gray;
			}

			.goods_number{
				display: none;
			}
			
			#shoppingMall_index{
				margin: auto;
				width: 80%;
				height: 100px;
				display: flex;
				justify-content: center;
			}

			.shoppingMall_category{
				width: 16%;
				text-align: center;
				line-height: 90px;
				font-size: 18px;
				font-weight: 700;
				cursor: pointer;
				z-index: 1px;
				
			}

			.category_list{
				border: 2px solid rgba(128, 128, 128, 0.3);
				transition: all 0.5s;
				opacity: 0.0;
				background-color: white;
				position: relative;
				line-height: 60px;
				z-index: 1;
			}

			.shoppingMall_category>a{
				padding: 10px 20px;
				color: black;
			}
			.shoppingMall_category>a:hover{
				color: #f7b500;
			}

			.select_this>a{
				color: #f7b500;
				border-bottom: 3px solid #f7b500;
			}

			.category_list>a{
				color: black;
				display: block;
			}
			.category_list>a:hover{
				color: white;
				background-color: rgb(180, 180, 180);
			}

			#search_title{
				margin: auto;
				margin-top: 20px;
				width: 80%;
				height: 65px;
				text-align: center;
				line-height: 60px;
				font-size: 50px;
				border: 1px solid rgba(110, 110, 110, 0.5);
				position: relative;
				z-index: 2;
			}

			#search_format{
				margin: auto;
				width: 80%;
				height: 240px;
				display: flex;
				margin-top: 20px;
				border: 3px solid rgba(110, 110, 110, 0.5);
				padding: 20px;
				position: relative;
				z-index: 2;
			}

			.search_img img{
				
				height: 200px;
			}
			
			.format_title{
				text-align: right;
				padding-left: 50px;
				padding-top: 20px;
				padding-right: 10px;
				line-height: 200%;
				font-weight: 800;
			}

			.format_content{
				width: 40%;
				height: 100%;
				padding-left: 70px;
				padding-top: 20px;
				padding-right: 10px;
				line-height: 200%;
				font-weight: 800;
			}

			.price_range{
				width: 112px;
				height: 25px;
				border: 1px solid rgba(110, 110, 110, 0.5);
				display: inline;
				font-weight: 400;
				color: gray;
			}

			input::-webkit-outer-spin-button,
			input::-webkit-inner-spin-button {
			-webkit-appearance: none;
			margin: 0;
			}
			.price_range>input{
				width: 137px;
				height: 20px;
				
				border: none;
				outline: none;
			}

			#goods_content{
				width: 80%;
				height: 1100px;
				margin: auto;
			}

			.goods_list{
				width: 100%;
				height: 95%;
				display: flex;
				justify-content:left;
				flex-wrap: wrap;
			}

			.goods_container{
				width: 320px;
				height: 480px;
				margin-top: 10px;
				margin-inline: 29px;

				cursor: pointer;
			}

			.goods_img{
				width: 320px;
				height: 320px;
				text-align: center;
				position: relative;
			}
			
			.goods_title{
				height: 50px;
				font-size: 15px;
				text-align: center;
			}
			
			.goods_name{
				margin: auto;
			}

			.goods_information{
				text-align: center;
			}

			.goods_information>div{
				height: 25px;
				margin: 0px;
				padding: 0px;
			}

			.goods_maker{
				font-size: 17px;
			}

			.goods_price{
				font-size: 12px;
				text-decoration:line-through;
			}

			.goods_discounted{
				font-size: 20px;
			}

			#paging_bar{
				width: 1000px;
				margin: auto;
				display: flex;
				font-size: 30px;
				text-align: center;
				padding: 10px;
				background-color: rgb(89, 131, 171);
				border-radius: 10px;
				
			}

			.divBtn:hover{
				background-color: rgb(218, 227, 236);
				cursor: pointer;
				border-radius: 10px;
			}

			.arrowBtn{
				width: 5%;
			}

			.pNum{
				width: 8%;
			}

			#pageNumber{
				width: 60%;
				border-radius: 10px;
				display: flex;
                justify-content: space-evenly;
				background-color: rgb(89, 131, 171);
			}
			
			.category_set{
				width: 80%;
				height: 70px;
				margin: auto;
				margin-top: 50px;
				border: 1px solid rgba(110, 110, 110, 0.5);
				display: flex;
				justify-content:space-evenly;
				flex-wrap: wrap;
			}

			.category_set>div{
				cursor: pointer;
				text-align: center;
				line-height: 65px;
			}

			#pagingArea{
				width:fit-content;
				margin:auto;
			}
		</style>
	</head>
	<body>
		<!-- 헤더 추가 -->
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div id="shoppingMall_index">
			<div style="width: 10%;"></div>
			<div class="shoppingMall_category select_this">
				<a href="">전체 목록 보기</a>
			</div>
			<div class="shoppingMall_category">
				<a href="">캠핑장비 패키지 세트 대여</a>
			</div>
			<div class="shoppingMall_category">
				<a href="">캠핑용품대여</a>
				<div class="category_list">
					<a href="">텐트/쉘터</a>
					<a href="">침낭/난방기구</a>
					<a href="">의자/테이블</a>
					<a href="">화로/버너/전자</a>
					<a href="">식기/아이스박스</a>
				</div>
			</div>
			<div class="shoppingMall_category">
				<a href="">소비용품판매</a>
				<div class="category_list">
					<a href="">연료/가스</a>
					<a href="">식자재</a>
					<a href="">생활용품</a>
				</div>
			</div>
			<div class="shoppingMall_category">
				<a href="">이달의 세일</a>
			</div>
			<div style="width: 10%;"></div>
		</div>

		<div id="search_title">
			상품 검색
		</div>
		<div id="search_format">
			<div style="width: 10%;"></div>
			<div class="search_img">
				<img src="resources/images/goods/검색_아이콘.png">
			</div>
			<div class="format_title">
				상품분류 <br>
				검색조건 <br>
				가격범위 <br>
				검색정렬기준 <br>
 			</div>
			<div class="format_content">
				<form id="searchForm" action="searching.gs" method="get">
					<select name="searchCategory" id="searchCategory" style="width: 344px;">
						<option value="상품분류선택">상품분류 선택</option>
						<option value="캠핑용품대여">캠핑용품대여</option>
						<option value="쉘터텐트">캠핑용품대여 ⮞ 쉘터/텐트</option>
						<option value="침낭방한용품">캠핑용품대여 ⮞ 침낭/방한용품</option>
						<option value="의자테이블">캠핑용품대여 ⮞ 의자/테이블</option>
						<option value="화로버너전자">캠핑용품대여 ⮞ 화로/버너/전자</option>
						<option value="식기아이스박스">캠핑용품대여 ⮞ 식기/아이스박스</option>
						<option value="소비용품판매">소비용품판매</option>
						<option value="연료가스">소비용품판매 ⮞ 연료/가스</option>
						<option value="식자재">소비용품판매 ⮞ 식자재</option>
						<option value="생활용품">소비용품판매 ⮞ 생활용품</option>
					</select>
					<br>
					<select name="condition" id="condition" style="width: 120px;">
						<option value="검색조건선택">검색조건 선택</option>
						<option value="상품이름">상품이름</option>
						<option value="브랜드">브랜드</option>
					</select>
					<input id="searchKeyword" class="enterClass" name="searchKeyword" type="text" style="width: 220px; height: 26px; outline: none; margin: 0px;" value="${requestScope.search.searchKeyword}">
					<br>
					<div class="price_range">
						<input id="startPrice" class="enterClass" name="startPrice" type="number" min="0">원
					</div>
					&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;
					<div class="price_range">
						<input id="endPrice" class="enterClass" name="endPrice" type="number" min="0">원
					</div>
					<br>
					<select name="sort" id="sort" style="width: 344px;">
						<option value="신상품순">신상품 순</option>
						<option value="상품명순">상품명 순</option>
						<option value="낮은가격순">낮은가격 순</option>
						<option value="높은가격순">높은가격 순</option>
						<option value="조회수순">조회수 순</option>
					</select>
				</form>
				<div style="height: 10px;"></div>
				<button id="searchBtn" class="btn btn-secondary" style="width: 150px;">검색하기</button>
			</div>
		</div>

		<div class="category_set">
			<c:choose>
				<c:when test="${(requestScope.search.searchCategory eq '캠핑용품대여')
				or (requestScope.search.searchCategory eq '쉘터텐트')
				or (requestScope.search.searchCategory eq '침낭방한용품')
				or (requestScope.search.searchCategory eq '의자테이블')
				or (requestScope.search.searchCategory eq '화로버너전자')
				or (requestScope.search.searchCategory eq '식기아이스박스')}">
					<div>텐트/쉘터</div>
					<div>침낭/난방기구</div>
					<div>의자/테이블</div>
					<div>화로/버너/전자</div>
					<div>식기/아이스박스</div>
				</c:when>
				<c:when test="${(requestScope.search.searchCategory eq '소비용품판매')
				or (requestScope.search.searchCategory eq '연료가스')
				or (requestScope.search.searchCategory eq '식자재')
				or (requestScope.search.searchCategory eq '생활용품')}">
					<div>연료/가스</div>
					<div>식자재</div>
					<div>생활용품</div>
				</c:when>
				<c:otherwise>
					<div>텐트/쉘터</div>
					<div>침낭/난방기구</div>
					<div>의자/테이블</div>
					<div>화로/버너/전자</div>
					<div>식기/아이스박스</div>
					<div>연료/가스</div>
					<div>식자재</div>
					<div>생활용품</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div id="goods_content">
			<div style="margin: 10px; font-size: 17px;">등록 제품 : ${requestScope.pi.listCount}</div>
			<div class="goods_list">
				<c:choose>
					<c:when test="${empty requestScope.list}">
						<div style="text-align: center;">
							<img alt="" src="resources/images/admin/등록된 정보가 없습니다.png" style="width:40%">
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="g" items="${requestScope.list}">
							<div class="goods_container">
								<div class="goods_number">${g.goodsNo}</div>
								<div class="goods_img">${g.goodsThumbnail}
									<c:choose>
										<c:when test="${g.status eq 'N'}">
											<img style="display: block; z-index: 10; position: absolute;" src="resources/images/goods/일시품절.png">
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
								</div>
								<div class=goods_title>
									<div class="goods_name">${g.goodsName}</div>
								</div>
								<div class="goods_information">
									<div class="goods_maker">
										${g.mark}
									</div>
									<c:choose>
										<c:when test="${g.discount <= 0.0}">
											<div class="goods_discounted">
												<fmt:formatNumber type="number">
													${g.price}
												</fmt:formatNumber>
											</div>
										</c:when>
										<c:otherwise>
											<div class="goods_price">
												<fmt:formatNumber type="number">
													${g.price}
												</fmt:formatNumber>
											</div>
											<div class="goods_discounted">
												<fmt:formatNumber type="number" maxFractionDigits="0">
													${g.price - (g.price*g.discount)}
												</fmt:formatNumber>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<div id="pagingArea">
                <ul class="pagination">
	                <c:choose>
	                	<c:when test="${ requestScope.pi.currentPage eq 1 }">
		                    <li class="page-item disabled">
		                    	<a class="page-link" href="#">
		                    		Previous
		                    	</a>
		                    </li>
		                </c:when>
		                <c:otherwise>
		                	<li class="page-item">
		                    	<a class="page-link" href="searching.gs?pageNumber=${ requestScope.pi.currentPage - 1 }">
		                    		Previous
		                    	</a>
		                    </li>
		                </c:otherwise>
	                </c:choose>
                    
                    <c:forEach var="p" begin="${ requestScope.pi.startPage }" end="${ requestScope.pi.endPage }" step="1">
                    	<c:choose>
                    		<c:when test="${ p ne requestScope.pi.currentPage }">			   
			                    <li class="page-item">
			                    	<a class="page-link" href="searching.gs?pageNumber=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
		                    </c:when>
		                    <c:otherwise>
		                    	<li class="page-item disabled">
			                    	<a class="page-link" href="searching.gs?pageNumber=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
	                    	</c:otherwise>
	                    </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ (requestScope.pi.currentPage ne requestScope.pi.maxPage) and (requestScope.pi.listCount ne 0) }">
                   			<li class="page-item">
                   				<a class="page-link" href="searching.gs?pageNumber=${ requestScope.pi.currentPage + 1 }">
                   					Next
                   				</a>
                   			</li>
                   		</c:when>
                   		<c:otherwise>
                   			<li class="page-item disabled">
                   				<a class="page-link" href="#">
                   					Next
                   				</a>
                   			</li>
                   		</c:otherwise>
                   	</c:choose>
                </ul>
            </div>
			<div style="height: 100px;"></div>
		</div>
		<script>
			$(function(){
				selectedfunc();
			});

			function selectedfunc(){
				$("#searchCategory option[value=${requestScope.search.searchCategory}]").attr("selected", true);
				$("#condition option[value=${requestScope.search.condition}]").attr("selected", true);
				$("#condition option[value=${requestScope.search.sort}]").attr("selected", true);
				$("#startPrice").val(${requestScope.search.startPrice});
				$("#endPrice").val(${requestScope.search.endPrice});
			}
		</script>

		<script>
			 $(".shoppingMall_category").hover(function(){
                $(this).children(".category_list").css("opacity", "1.0").css("margin-top", "10px").css("z-index", 3);
            },
            function(){
                $(this).children(".category_list").css("opacity", "0.0").css("margin-top", "0px").css("z-index", 1);
            });
		</script>

		<script>
			$(".goods_container").click(function(){
				let goodsNo = $(this).children(".goods_number").text();
				location.href="goodsDetail.gs?goodsNo="+goodsNo;
			});
		</script>

		<script>
			$(".goods_img>img").css({"height" : 300, "margin" : 0, position: "absolute", display:"block"});
		</script>

		<script>
			$(".enterClass").on("keyup", function(key){
				if(key.keyCode == 13){
					searching();
				}
			});

			$("#searchBtn").click(function(){
				searching();
			});

			function searching(){
				$("#searchForm").submit();
			}
		</script>
		
	</body>
</html>