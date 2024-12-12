<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>

		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Nanum+Pen+Script&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
		<style>
			div{
				box-sizing: border-box;
			}

			#shoppingMall_header{
				width: 80%;
				height: 300px;
				margin: auto;
				display: flex;
				justify-content: space-between;
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
				padding-top: 100px;
			}

			.search_content
			{
				width: 85%;
				margin: auto;
				border: 2px solid gray;
			}

			#shoppingMall_index{
				margin: auto;
				width: 80%;
				height: 70px;
				display: flex;
				justify-content: space-between;
			}

			.shoppingMall_category{
				width: 15%;
				text-align: center;
				line-height: 60px;
				font-size: 25px;
				font-family: "Nanum Pen Script", cursive;
				font-weight: 500;
				font-style: normal;
				cursor: pointer;
				z-index: 5px;
				
			}

			.category_list{
				border: 2px solid rgba(128, 128, 128, 0.3);
				border-top: none;
				transition: all 0.5s;
				opacity: 0.0;
			}

			.shoppingMall_category a{
				color: black;
				display: block;
			}
			.shoppingMall_category a:hover{
				color: white;
				background-color: rgb(180, 180, 180);
			}

			#search_title{
				margin: auto;
				margin-top: 300px;
				width: 80%;
				height: 65px;
				text-align: center;
				line-height: 65px;
				font-size: 50px;
				font-family: "Nanum Pen Script", cursive;
				font-weight: 500;
				border: 1px solid rgba(110, 110, 110, 0.5);
			}

			#search_format{
				margin: auto;
				width: 80%;
				height: 240px;
				display: flex;
				margin-top: 20px;
				border: 3px solid rgba(110, 110, 110, 0.5);
				padding: 20px;
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
				width: 112px;
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

				text-align: center;
				font-family: "Dongle", sans-serif;
				font-weight: 400;
				font-style: normal;
			}

			.goods_img{
				width: 320px;
				height: 320px;
			}

			.goods_img>img{
				width: 100%;
			}
			
			.goods_title{
				height: 75px;
				font-size: 25px;
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
				font-size: 25px;
			}

			.goods_price{
				font-size: 17px;
				text-decoration:line-through;
			}

			.goods_discounted{
				font-size: 25px;
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
		</style>
	</head>
	<body>
		<!-- 헤더 추가 -->
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div style="border: 1px dashed gray; opacity: 0.5;"></div>
		<div id="shoppingMall_index">
			<div style="width: 10%;"></div>
			<div class="shoppingMall_category">
				캠핑장비 패키지 세트 대여
			</div>
			<div class="shoppingMall_category">
				캠핑용품대여
				<div class="category_list">
					<a href="">텐트/쉘터</a>
					<a href="">침낭/난방기구</a>
					<a href="">의자/테이블</a>
					<a href="">화로/버너/전자</a>
					<a href="">식기/아이스박스</a>
				</div>
			</div>
			<div class="shoppingMall_category">
				소비용품판매
				<div class="category_list">
					<a href="">연료/가스</a>
					<a href="">식자재</a>
					<a href="">생활용품</a>
				</div>
			</div>
			<div class="shoppingMall_category">
				 이달의 세일
			</div>
			<div class="shoppingMall_category">
				대여/반납 안내
			</div>
			<div class="shoppingMall_category">
				자주묻는질문
			</div>
		</div>
		<div style="border: 1px solid gray; opacity: 0.3;"></div>
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
				<select name="" id="" style="width: 295px;">
					<option value="">상품분류 선택</option>
					<option value="">캠핑장비 패키지 세트 대여</option>
					<option value="">캠핑용품대여</option>
					<option value="">캠핑용품대여 ⮞ 텐트/쉘터</option>
					<option value="">캠핑용품대여 ⮞ 침낭/난방기구</option>
					<option value="">캠핑용품대여 ⮞ 의자/테이블</option>
					<option value="">캠핑용품대여 ⮞ 화로/버너/전자</option>
					<option value="">캠핑용품대여 ⮞ 식기/아이스박스</option>
					<option value="">소비용품판매</option>
					<option value="">소비용품판매 ⮞ 연료/가스</option>
					<option value="">소비용품판매 ⮞ 식자재</option>
					<option value="">소비용품판매 ⮞ 생활용품</option>
				</select>
				<br>
				<select name="" id="" style="width: 295px;">
					<option value="">검색조건 선택</option>
					<option value="">상품이름</option>
					<option value="">제조사</option>
					<option value="">브랜드</option>
				</select>
				<br>
				<div class="price_range">
					<input type="number" min="0">원
				</div>
				&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;
				<div class="price_range">
					<input type="number" min="0">원
				</div>
				<br>
				<select name="" id="" style="width: 295px;">
					<option value="">정렬기준 선택</option>
					<option value="">신상품 순</option>
					<option value="">상품명 순</option>
					<option value="">낮은가격 순</option>
					<option value="">높은가격 순</option>
					<option value="">제조사명 순</option>
					<option value="">조회수 순</option>
				</select>
				<div style="height: 10px;"></div>
				<button class="btn btn-secondary" style="width: 150px;">검색하기</button>
			</div>
		</div>
		<div class="category_set">
			<div>텐트/쉘터(20)</div>
			<div>침낭/난방기구(등록개수)</div>
			<div>의자/테이블(10)</div>
			<div>화로/버너/전자(20)</div>
			<div>식기/아이스박스(5)</div>
		</div>
		<div id="goods_content">
			<div style="margin: 10px; font-size: 17px;">등록 제품 : 20</div>
			<div class="goods_list">
				<div class="goods_container">
					<div class="goods_img"><img src="resources/images/goods/텐트사진1.jpg"></div>
					<div class="goods_title">
						<div class="goods_name">5-6인 고급원터치자동 텐트 (업계최저가격 / 단체행사베스트상품 / 간단설치 우수원단)</div>
					</div>
					<div class="goods_information">
						<div class="goods_maker">
							캠프타운
						</div>
						<div class="goods_price">
							32,000원
						</div>
						<div class="goods_discounted">
							27,000원
						</div>
					</div>
				</div>
				<div class="goods_container">
					<div class="goods_img"><img src="resources/images/goods/텐트사진1.jpg"></div>
					<div class="goods_title">
						<div class="goods_name">5-6인 고급원터치자동 텐트 (업계최저가격 / 단체행사베스트상품 / 간단설치 우수원단)</div>
					</div>
					<div class="goods_information">
						<div class="goods_maker">
							캠프타운
						</div>
						<div class="goods_price">
							32,000원
						</div>
						<div class="goods_discounted">
							27,000원
						</div>
					</div>
				</div>
				<div class="goods_container">
					<div class="goods_img"><img src="resources/images/goods/텐트사진1.jpg"></div>
					<div class="goods_title">
						<div class="goods_name">5-6인 고급원터치자동 텐트 (업계최저가격 / 단체행사베스트상품 / 간단설치 우수원단)</div>
					</div>
					<div class="goods_information">
						<div class="goods_maker">
							캠프타운
						</div>
						<div class="goods_price">
							32,000원
						</div>
						<div class="goods_discounted">
							27,000원
						</div>
					</div>
				</div>
				<div class="goods_container">
					<div class="goods_img"><img src="resources/images/goods/텐트사진1.jpg"></div>
					<div class="goods_title">
						<div class="goods_name">5-6인 고급원터치자동 텐트 (업계최저가격 / 단체행사베스트상품 / 간단설치 우수원단)</div>
					</div>
					<div class="goods_information">
						<div class="goods_maker">
							캠프타운
						</div>
						<div class="goods_price">
							32,000원
						</div>
						<div class="goods_discounted">
							27,000원
						</div>
					</div>
				</div>
				<div class="goods_container">
					<div class="goods_img"><img src="resources/images/goods/텐트사진1.jpg"></div>
					<div class="goods_title">
						<div class="goods_name">5-6인 고급원터치자동 텐트 (업계최저가격 / 단체행사베스트상품 / 간단설치 우수원단)</div>
					</div>
					<div class="goods_information">
						<div class="goods_maker">
							캠프타운
						</div>
						<div class="goods_price">
							32,000원
						</div>
						<div class="goods_discounted">
							27,000원
						</div>
					</div>
				</div>
			</div>
			<div id="paging_bar">
				<div class="divBtn arrowBtn">⮜⮜</div>
				<div style="width: 5%;"></div>
				<div class="divBtn arrowBtn">⮜</div>
				<div style="width: 5%;"></div>
				<div id="pageNumber">
					<div class="pNum divBtn">1</div>
					<div class="pNum divBtn">2</div>
					<div class="pNum divBtn">3</div>
					<div class="pNum divBtn">4</div>
					<div class="pNum divBtn">5</div>
				</div>
				<div style="width: 5%;"></div>
				<div class="divBtn arrowBtn">⮞</div>
				<div style="width: 5%;"></div>
				<div class="divBtn arrowBtn">⮞⮞</div>
			</div>
			<div style="height: 200px;"></div>
		</div>
		<script>
			 $(".shoppingMall_category").hover(function(){
                $(this).children(".category_list").css("opacity", "1.0").css("margin-top", "10px");
            },
            function(){
                $(this).children(".category_list").css("opacity", "0.0").css("margin-top", "0px");
            });
		</script>
	</body>
</html>