<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>YOU CAMP DO IT 상품페이지</title>
		<style>
			div, canvas{
				box-sizing: border-box;
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

			.category_list{
				border: 2px solid rgba(128, 128, 128, 0.3);
				transition: all 0.5s;
				opacity: 0.0;
				background-color: white;
				position: relative;
				line-height: 60px;
				z-index: 1;
			}

			.category_list>a{
				color: black;
				display: block;
			}

			.category_list>a:hover{
				color: white;
				background-color: rgb(180, 180, 180);
			}

			.locator{
				width: 80%;
				height: 70px;
				margin: auto;
				text-align: right;
				font-size: 20px;
				font-weight: 800;
				line-height: 65px;
				padding-right: 20px;
			}

			.locator>a{
				color: black;
			}
			
			.locator>a:hover{
				color: #f7b500;
			}

			#goodsExplain{
				width: 80%;
				height: 1000px;
				margin: auto;
			}

			.goodsSummary{
				width: 100%;
				display: flex;
				justify-content: space-between;
			}

			.thumbnail{
				width: 450px;
				height: 450px;
				margin: 25px;
				position: relative;
			}

			.thumbnail>img{
				width: 100%;
				height: 100%;
				display: block;
			}

			.magnifier {
				width: 150px;
				height: 150px;
				position: absolute;
				
				box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.85), 0 0 3px 3px rgba(0, 0, 0, 0.25);
				display: none;
			}

			.sumUp{
				width: 800px;
				height: 450px;
				margin: 25px;
			}

			#goodsBrand{
				font-size: 20px;
			}
			
			#goodsTitle{
				font-size: 25px;
			}

			#bookmark{
				height: 52.5px;

			}

			#bookmark>img{
				display: block;
				height: 100%;
			}

			#goodsPrice{
				display: flex;
				font-size: 25px;
				font-weight: 600;
				height: 40px;
			}

			.goodsPrice1{
				margin-right: 10px;
			}

			.goodsPrice2{
				font-size: 20px;
				font-weight: 400;
				line-height: 37px;
				color: rgba(128, 128, 128, 0.3);
				text-decoration: line-through;
			}

			.goodsPrice3{
				margin-left: 5px;
			}

			.sumUpContent{
				font-size: 17px;
			}

			#preView{
				width: 400px;
				height: 400px;
				position: absolute;
				right: 0px;
				border-radius: 50%;
			}
		</style>
	</head>
	<body>
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
		<div class="locator">
			<a href="">HOME</a> ❯ <a href="">캠핑용품</a> ❯ <a href="">캠핑용품대여</a> ❯ <a href="">텐트/쉘터</a>
		</div>
		<div id="goodsExplain">
			<div class="goodsSummary">
				<div class="thumbnail">
					<img class="target" src="resources/images/goods/텐트사진1.jpg" data-zoom="2">
				</div>
				<div class="sumUp">
					<div style="display: flex; justify-content: space-between; height: 60px; padding-top: 5px;">
						<div style="height: 100px;">
							<div id="goodsBrand">
								버팔로
							</div>
							<div id="goodsTitle">
								필드돔 4-5인용 텐트(그늘막일체형)
							</div>
						</div>
						<div id="bookmark">
							<img src="resources/images/goods/찜표시.png">
						</div>
					</div>
					<div style="border-bottom: 2px solid rgba(128, 128, 128, 0.3); height: 30px;"></div>
					<div style="height: 20px;"></div>
					<div id="goodsPrice">
						<div class="goodsPrice1">가격 :</div>
						<div class="goodsPrice2">&nbsp;31000&nbsp;</div>
						<div class="goodsPrice3">28000</div>
						<div class="goodsPrice4">&nbsp;&nbsp;원</div>
					</div>
					<div style="height: 20px;"></div>
					<div class="sumUpContent">
						<p>사이즈 : 길이 210*너비 210*높이130 cm</p><p>수용인원 : 4~5인용</p><p>제조사 : 버팔로</p><p>제조국 : 방글라데시</p>
					</div>
				</div>
			</div>
			<div>
			</div>
			<div class="goodsDetail">

			</div>
		</div>
		<script>
			$(".shoppingMall_category").hover(function(){
			   $(this).children(".category_list").css("opacity", "1.0").css("margin-top", "10px").css("z-index", 3);
		   },
		   function(){
			   $(this).children(".category_list").css("opacity", "0.0").css("margin-top", "0px").css("z-index", 1);
		   });
	   </script>

	   <script>
			let goodsPrice2 = $(".goodsPrice2").text();
			let money = goodsPrice2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(".goodsPrice2").text(money);

			let goodsPrice3 = $(".goodsPrice3").text();
			let money2 = goodsPrice3.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(".goodsPrice3").text(money2);
	   </script>

	   <script>
			$(function(){
				var target = $(".target");
				var zoom = target.data('zoom');

				$(".thumbnail").on("mousemove", magnify).prepend("<div class='magnifier'></div>").children(".magnifier").css({
					"background": "url('" + $(".target").attr("src") + "') no-repeat",
					"background-size": target.width() * zoom + "px " + target.height() * zoom+ "px"
				});

				var magnifier = $(".magnifier");

				function magnify(e){
					var mouseX = e.pageX - $(this).offset().left;
					var mouseY = e.pageY - $(this).offset().top;

					if(mouseX < $(this).width() && mouseY < $(this).height() && mouseX > 0 && mouseY > 0){
						magnifier.fadeIn(10);
					}
					else{
						magnifier.fadeOut(10);
					}

					if(magnifier.is(":visible")){
						var rx = -(mouseX * zoom - magnifier.width() /2 );
						var ry = -(mouseY * zoom - magnifier.height() /2 );

						var px = mouseX - magnifier.width() / 2;
						var py = mouseY - magnifier.height() / 2;

						magnifier.css({
							left: px,
							top: py,
							backgroundPosition: rx + "px " + ry + "px"
						});
					}
				}
			});
	   </script>
	</body>
</html>