<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>캠핑 용품 대여</title>
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
			}

			.goods_img{
				width: 320px;
				height: 320px;
			}

			.goods_img>img{
				width: 100%;
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
<!-- 이부분 충돌남 -->
		<div style="border: 1px dashed gray; opacity: 0.5;"></div>
		<div id="shoppingMall_index">
			<div style="width: 10%;"></div>
			<div class="shoppingMall_category">
				캠핑장비 패키지 세트 대여
			</div>
			<div class="shoppingMall_category">
				캠핑용품대여
<!-- 이부분 충돌남 -->
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
<!-- 이부분 충돌남 -->
				<div class="category_list">
					<a href="">텐트/쉘터</a>
					<a href="">침낭/난방기구</a>
					<a href="">의자/테이블</a>
					<a href="">화로/버너/전자</a>
					<a href="">식기/아이스박스</a>
				</div>
			</div>
			<div class="shoppingMall_category">
<!-- 이부분 충돌남 -->
				소비용품판매
<!-- 이부분 충돌남 -->
				<a href="">소비용품판매</a>
<!-- 이부분 충돌남 -->
				<div class="category_list">
					<a href="">연료/가스</a>
					<a href="">식자재</a>
					<a href="">생활용품</a>
				</div>
			</div>
			<div class="shoppingMall_category">
<!-- 이부분 충돌남 -->
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
<!-- 이부분 충돌남 -->
				<a href="">이달의 세일</a>
			</div>
			<div style="width: 10%;"></div>
		</div>
		
		<div id="shoppingMall_header">
			<div class="search">
				<div style="width: 70%; margin: auto; text-align: center;">
					자세한 사항은 전화/챗봇을 통해 상담하세요
				</div>
				<div class="search_content">
					<input type="text" style="width: 350px; height: 30px; border: none; outline: none;">
					<a href=""><img src="resources/images/goods/검색_아이콘.png" style="width: 5%; padding-bottom: 5px;"></a>
				</div>
			</div>
		</div>

<!-- 이부분 충돌남 -->
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
			<div id="pagingArea">
                <ul class="pagination">
                    <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">4</a></li>
                    <li class="page-item"><a class="page-link" href="#">5</a></li>
                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
                </ul>
            </div>
			<div style="height: 100px;"></div>
		</div>
		<script>
			 $(".shoppingMall_category").hover(function(){
                $(this).children(".category_list").css("opacity", "1.0").css("margin-top", "10px").css("z-index", 3);
            },
            function(){
                $(this).children(".category_list").css("opacity", "0.0").css("margin-top", "0px").css("z-index", 1);
            });
		</script>
	</body>
</html>