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
				position: relative;
				z-index: 2;
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

			.goodsVolume{
				display: flex;
				margin-top: 30px;
				justify-content:space-between;
			}
			
			.btnMinus, .btnPlus{
				width: 50px;
				height: 50px;
				font-size: 30px;
				font-weight: 800;
				text-align: center;
				line-height: 43px;
				border: 2px solid black;
				box-sizing: border-box;
				border-radius: 100%;
				background-color: rgb(240, 240, 240);
				cursor: pointer;
			}

			#priceEA{
				width: 50px;
				height: 50px;
				font-size: 30px;
				font-weight: 600;

				text-align: center;
				
			}

			input::-webkit-outer-spin-button,
			input::-webkit-inner-spin-button {
				-webkit-appearance: none;
				margin: 0;
			}

			.total{
				font-size: 40px;
			}

			.priceBtn{
				margin-top: 7px;
			}

			.priceCalculator{
				margin-top: 10px;
			}

			.goodsDetail{
				width: 80%;
				margin: auto;
			}

			.goodsDetail p{
				padding: 0px;
				margin: auto;
				text-align: center;
			}
		</style>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="wrap">
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
					<div class="thumbnail target">
						${requestScope.goods.goodsThumbnail}
					</div>
					<div class="sumUp">
						<div style="display: flex; justify-content: space-between; height: 60px; padding-top: 5px;">
							<div style="height: 60px;">
								<div id="goodsBrand">
									${requestScope.goods.mark}
								</div>
								<div id="goodsTitle">
									${requestScope.goods.goodsName}
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
							<div class="goodsPrice2">&nbsp;${requestScope.goods.price}&nbsp;</div>
							<div class="goodsPrice3">${requestScope.goods.price}</div>
							<div class="goodsPrice4">&nbsp;&nbsp;원</div>
						</div>
						<div style="height: 20px;"></div>
						<div class="sumUpContent">
							${requestScope.goods.goodsInfo}
						</div>
						<div style="height: 20px;"></div>
						<div style="border-bottom: 1px solid rgba(128, 128, 128, 0.3); height: 30px;"></div>
						<div class="priceCalculator">
							<div style="height: 30px; font-weight: 700; font-size: 20px;">
								수량
							</div>
							<div class="goodsVolume">
								<div class="priceBtn" style="display: flex;">
									<div class="btnMinus">
										&#10134;
									</div>
									<div style="width: 10px;"></div>
									<div>
										<input id="priceEA" type="number" value="1" readonly>
									</div>
									<div style="width: 10px;"></div>
									<div class="btnPlus">
										&#10133;
									</div>
								</div>
								<div class="total" style="display: flex;">
									<div id="totalPrice">${requestScope.goods.price}</div>
									<div style="width: 10px;"></div>
									<div>원</div>
									<input id="hiddenTotalPrice" type="hidden" value="0">
								</div>
							</div>
						</div>

						<!-- 장바구니 담기 및 구매 버튼 추가 24.12.20 윤홍문 -->
						<div id="cart-order-forms">
							<form action="${pageContext.request.contextPath}/insert.ca" 
								  method="post"
								  id="cart-insert-form">
								<input type="hidden" id="" 
									   name="goodsNo" value="${requestScope.goods.goodsNo}">
								<input type="hidden" id="quantity-input"
									   name="quantity" value="">
								<button type="submit" id="cart-insert-btn">장바구니 담기</button>
							</form>
							<!-- 
							바로 구매는 여유있으면 구현 예정
							
							<form action="">
								<button>구매하기</button>
							</form>
							-->
						</div>
					</div>
				</div>
				<div style="border-bottom: 1px solid rgba(128, 128, 128, 0.3); height: 30px; margin-top: 30px; margin-bottom: 30px;"></div>
				<div class="goodsDetail">
					${requestScope.goods.goodsContent}
				</div>
				<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
			</div>
		</div>
		
		<script>
			// cart insert form 의 btn 클릭 시 수량값을 가져오는 함수
			$(function(){
				$(document).on('submit', '#cart-insert-form', function (event) {
					let amount = parseInt($("#priceEA").val());
					// console.log(amount);
					$("#quantity-input").val(amount);
				});


			});
		</script>
		<script>
			$(function(){
				let height = $(".sumUpContent").css("height");
				height = height.substring(0, height.length-2);
				if(height <= 150){
					$(".goodsSummary").css("height", 500);
				}
				else{
					height = parseInt(height)+400
					$(".goodsSummary").css("height", height);
				}
			});
		</script>
		<script>
			let amount = parseInt($("#priceEA").val());
			$(".btnMinus").click(function(){
				if(amount > 1){
					amount -= 1;
					$("#priceEA").val(amount);
					reckoning();
				}
			});

			$(".btnPlus").click(function(){
				if(amount < 100){
					amount += 1;
					$("#priceEA").val(amount);
					reckoning();
				}
			});



		</script>

		<script>
			function reckoning(){
				let totalP = ${requestScope.goods.price};
				totalP = totalP*parseInt($("#priceEA").val());
				$("#hiddenTotalPrice").val(totalP);
				$("#totalPrice").text(totalP);
				thousands();
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
			let goodsPrice2 = $(".goodsPrice2").text();
			let money = goodsPrice2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(".goodsPrice2").text(money);

			let goodsPrice3 = $(".goodsPrice3").text();
			let money2 = goodsPrice3.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(".goodsPrice3").text(money2);

			let totalPrice = $("#totalPrice").text();
			let money3 = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$("#totalPrice").text(money3);

			function thousands(){
				let totalPrice = $("#totalPrice").text();
				let money3 = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$("#totalPrice").text(money3);
			}
	   	</script>

	   	<script>
			$(function(){
				var target = $(".target>img");
				var zoom = 2;

				$(".thumbnail").on("mousemove", magnify).prepend("<div class='magnifier'></div>").children(".magnifier").css({
					"background": "url('" + $(".target>img").attr("src") + "') no-repeat",
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

		<script>
			$(".thumbnail>img").css({"height" : 450, "margin" : 0});
		</script>
	</body>
</html>