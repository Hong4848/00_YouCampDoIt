<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			
			#dibs{
				cursor: pointer;
				background-color: none;
			}

			#cart-order-forms{
				display: flex;
				justify-content: right;
			}

			#cart-order-forms button{
				margin-left: 20px;
				margin-top: 100px;
			}
			
		</style>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="wrap">
			<div id="shoppingMall_index">
				<div style="width: 10%;"></div>
				<div class="shoppingMall_category select_this">
					<a href="searching.gs">전체 목록 보기</a>
				</div>
				<div class="shoppingMall_category">
					<a>캠핑용품대여</a>
					<div class="category_list">
						<a href="searching.gs?searchCategory=쉘터텐트">텐트/쉘터</a>
						<a href="searching.gs?searchCategory=침낭방한용품">침낭/난방기구</a>
						<a href="searching.gs?searchCategory=의자테이블">의자/테이블</a>
						<a href="searching.gs?searchCategory=화로버너전자">화로/버너/전자</a>
						<a href="searching.gs?searchCategory=식기아이스박스">식기/아이스박스</a>
					</div>
				</div>
				<div class="shoppingMall_category">
					<a>소비용품판매</a>
					<div class="category_list">
						<a href="searching.gs?searchCategory=연료가스">연료/가스</a>
						<a href="searching.gs?searchCategory=식자재">식자재</a>
						<a href="searching.gs?searchCategory=생활용품">생활용품</a>
					</div>
				</div>
				<div class="shoppingMall_category">
					<a href="discountList.gs">이달의 세일</a>
				</div>
				<div style="width: 10%;"></div>
			</div>
			<div class="locator">
				<a href="${ pageContext.request.contextPath }/">HOME</a> ❯ <a href="${ pageContext.request.contextPath }/product.gs">캠핑용품</a> ❯ <a>캠핑용품대여</a> ❯ <a>텐트/쉘터</a>
			</div>
			<div id="goodsExplain">
				<div class="goodsSummary">
					<div class="thumbnail target">
						${requestScope.goods.goodsThumbnail}
						<c:choose>
							<c:when test="${requestScope.goods.status eq 'N' }">
								<img style="display: block; z-index: 10; position: absolute;" src="resources/images/goods/일시품절.png">
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
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
								<c:if test="${sessionScope.loginMember != null}">
									<img id="dibs" src="resources/images/goods/찜표시3.png">
								</c:if>
							</div>
						</div>
						<div style="border-bottom: 2px solid rgba(128, 128, 128, 0.3); height: 30px;"></div>
						<div style="height: 20px;"></div>
						<div id="goodsPrice">
							<div class="goodsPrice1">가격 :</div>
							<c:choose>
								<c:when test="${requestScope.goods.discount <= 0.0}">
									<div class="goodsPrice3">
										<fmt:formatNumber type="number" maxFractionDigits="0">
											${requestScope.goods.price}
										</fmt:formatNumber>
									</div>
								</c:when>
								<c:otherwise>
									<div class="goodsPrice2">&nbsp;
										<fmt:formatNumber type="number" maxFractionDigits="0">
											${requestScope.goods.price}
										</fmt:formatNumber>
										&nbsp;
									</div>
									<div class="goodsPrice3">
										<fmt:formatNumber type="number" maxFractionDigits="0">
											${requestScope.goods.price - (requestScope.goods.price*requestScope.goods.discount)}
										</fmt:formatNumber>
									</div>
								</c:otherwise>
							</c:choose>
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
									<div id="totalPrice">
										<fmt:formatNumber type="number" maxFractionDigits="0">
											${requestScope.goods.price}
										</fmt:formatNumber>
									</div>
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
								<c:choose>
									<c:when test="${requestScope.goods.status eq 'Y'}">
										<button type="submit" class="btn btn-light" style="border: 1px solid rgb(170, 170, 170);" id="cart-insert-btn">장바구니 담기</button>
									</c:when>
									<c:otherwise>
										<button type="submit" class="btn btn-light" style="border: 1px solid rgb(170, 170, 170);" id="cart-insert-btn" disabled>장바구니 담기</button>
									</c:otherwise>
								</c:choose>
								
							</form>
							<!-- 바로 주문문 -->
							<form id="orderForm" 
								action="${pageContext.request.contextPath}/insert.or" 
								method="POST">
								<!-- 장바구니 데이터가 있는 경우 hidden input에 값을 추가해서 데이터 전송 -->
								<input type="hidden" name="totalPrice" id="totalPriceInput" value="0">
								
								<input type="hidden" name="orderDetails" id="orderDetailsInput" value="0">
								
								<c:choose>
									<c:when test="${requestScope.goods.status eq 'Y'}">
										<button type="submit" class="order-btn btn btn-light" style="border: 1px solid rgb(170, 170, 170);" id="order-btn">주문하기</button>
									</c:when>
									<c:otherwise>
										<button type="submit" class="order-btn btn btn-light" style="border: 1px solid rgb(170, 170, 170);" id="order-btn" disabled>주문하기</button>
									</c:otherwise>
								</c:choose>
								
							</form>
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
	</body>
	
	<!-- 시작 시 -->
    <script>
        $(document).ready(function(){
            if(${sessionScope.loginMember != null}){
            	
				let memberNo = ${sessionScope.loginMember.memberNo};
				let goodsNo = ${requestScope.goods.goodsNo};

				$.ajax({
					url : "dibsCheck.gs",
					type : "post",
					data : {
						memberNo : memberNo,
						goodsNo : goodsNo
					},
					success(result){
						if(result){
							$("#dibs").css("background-color", "#FFD700");
						}
						else{
							$("#dibs").css("background-color", "#FFFFFF");
						}
					},
					error(){
						console.log("실패");
					}
				});
			}
		});
    </script>
	
	<!-- cart insert form 의 btn 클릭 시 수량값을 가져오는 함수 -->
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

	<!-- cart insert form 의 바로주문 시 수량값을 가져오는 함수 -->
	<script>
		// cart insert form 의 btn 클릭 시 수량값을 가져오는 함수
		
		$(function(){

			const selectedItems = [];
			$('#order-btn').on('click', function (e) {
				// 기본 이벤트 방지
				e.preventDefault();
				// 수량
				const quantity = parseInt($("#priceEA").val()) || 1;
				// 항목당 총 금액
				const totalPrice = parseInt(quantity * ${requestScope.goods.price});
				// 상품 번호
				const goodsNo = ${requestScope.goods.goodsNo};
	
				selectedItems.push({
					quantity: quantity,
					totalPrice: totalPrice,
					goodsNo: goodsNo,
				});

				// console.log("selectedItems : ", selectedItems);
	
				// JSON 데이터로 가공 및 hidden input에 추가
				const jsonData = JSON.stringify(selectedItems);
				// console.log("jsonData : ", jsonData);
				$("#orderDetailsInput").val(jsonData);

				$('#totalPriceInput').val(totalPrice); // 총 가격 업데이트

				$('#orderForm').submit();

			});
			
		});
	</script>
	
	
	<!-- 요약내용 출력부분 -->
	<script>
		$(function(){
			let height = $(".sumUpContent").css("height");
			height = height.substring(0, height.length-2);
			if(height <= 150){
				$(".goodsSummary").css("height", 600);
			}
			else{
				height = parseInt(height)+500
				$(".goodsSummary").css("height", height);
			}
		});
	</script>
	
	<!-- 버튼 클릭 시 개수 변경 이벤트 -->
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
			if(amount < ${requestScope.goods.remainStock}){
				amount += 1;
				$("#priceEA").val(amount);
				reckoning();
			}
		});
	</script>

	<!-- 총 비용 계산 -->
	<script>
		function reckoning(){
			let totalP = ${requestScope.goods.price};
			totalP = totalP*parseInt($("#priceEA").val());
			$("#hiddenTotalPrice").val(totalP);
			$("#totalPrice").text(totalP);
			thousands();
		}
	</script>

	<!-- 메뉴바 가려지는 버그 수정용 -->
	<script>
		$(".shoppingMall_category").hover(function(){
		   $(this).children(".category_list").css("opacity", "1.0").css("margin-top", "10px").css("z-index", 3);
	   },
	   function(){
		   $(this).children(".category_list").css("opacity", "0.0").css("margin-top", "0px").css("z-index", 1);
	   });
	</script>

   	<!-- 천의 자리 수 표현용 -->
	<script>
		function thousands(){
			let totalPrice = $("#totalPrice").text();
			let money3 = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$("#totalPrice").text(money3);
		}
	</script>

   	<!-- 섬네일 이미지 확대 기능 -->
	<script>
		$(function(){
			var target = $(".target>img");
			var zoom = 2;

			$(".thumbnail").on("mousemove", magnify).prepend("<div class='magnifier'></div>").children(".magnifier").css({
				"background": "url('" + $(".target>img").attr("src") + "') no-repeat",
				"background-size": target.width() * zoom + "px " + target.height() * zoom+ "px",
				"z-index": 10
			});

			var magnifier = $(".magnifier");
			
			function magnify(e){
				if("${requestScope.goods.status}" != 'N')
				{
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
			}
		});
	</script>

	<!-- 섬네일 이미지 크기 조절 -->
	<script>
		$(".thumbnail>img").css({"height" : 450, "margin" : 0, position: "absolute", display:"block"});
	</script>
	
	<!-- 찜하기 클릭 이벤트 -->
	<script>
		$("#dibs").click(function(){
			let memberNo = ${sessionScope.loginMember.memberNo};
			let goodsNo = ${requestScope.goods.goodsNo};
			
			$.ajax({
				url : "ajaxDibs.gs",
				type : "post",
				data : {
					memberNo : memberNo,
					goodsNo : goodsNo
				},
				success(result){
					console.log(result);
					switch(result){
						case '추가성공':
							alertify.success('상품을 찜 목록에<br>추가했습니다.');
							$("#dibs").css("background-color", "#FFD700");
							break;
						case '추가실패':
							alertify.success('상품을 찜 목록에<br>추가하지 못했습니다.');
							break;
						case '삭제성공':
							alertify.success('상품을 찜 목록에서<br>삭제했습니다.');
							$("#dibs").css("background-color", "#FFFFFF");
							break;
						case '삭제실패':
							alertify.success('상품을 찜 목록에서<br>삭제하지 못했습니다.');
							break;
					}
				},
				error(){
					alertify.success('서버와의 통신에<br>실패했습니다.');
				}
			});
		});
	</script>
</html>