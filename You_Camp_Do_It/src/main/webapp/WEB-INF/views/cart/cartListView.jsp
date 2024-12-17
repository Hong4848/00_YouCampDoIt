<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    
    <link rel="stylesheet" 
    	  href="${pageContext.request.contextPath}/resources/css/cart/cartListView.css">
    
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<div class="cart-outer">
	
        <div class="cart-header">
            <div class="cart-header-wrap">
                <a href="">장바구니</a>
            </div>
        </div>
	   
	    <div class="cart-container">
	    
	    	<!-- 선택체크박스 부분 -->
	        <div class="inner-1">
	            <div class="total-chcek">
	                <label>
	                    <input type="checkbox">전체 선택
	                </label>
	            </div>
	            <div class="delete-checked">
	                <button id="cart-list-delete-checked">
	                	선택 삭제
	                </button>
	            </div>
	        </div>
	    	
	        <!-- Cart Items - 장바구니 목록조회 부분 -->
			<!-- <div class="cart-item">
				<input type="checkbox" value="${item.cartNo}">
				<img src="https://via.placeholder.com/100" alt="상품 이미지">
				<div class="item-details">
					<h3>${item.goods.goodsName}</h3>
					<p class="item-options">선택: ${item.goods.goodsInfo}</p>
					<div class="item-quantity">
						<span class="quantity-decrease">-</span>
						<input type="text" value="${item.quantity}" class="quantity-input" readonly>
						<span class="quantity-increase">+</span>
					</div>
				</div>
				<div class="item-price">
					<p>${formattedPrice} 원</p>
				</div>
				<button class="delete-btn" value="${item.cartNo}">X</button>
			</div> -->
			
	    </div>
	    
	    <br><br><br><br>
	
	    <div class="floating-area">
	        <div class="buy-area">
	            <span class="total-price">총 0건 주문금액 0원</span>
	            <!-- 
	            	장바구니 항목이없거나, 주문금액이 0인 조건 활용해서
	            	그땐 orderForm 페이지로 넘어가지 않게 처리
	            	
	            	요소 밸류값은 cart 테이블에서 가져오기
	            	요소 네임값은 order 로 저장해서 넘기기

					order post 방식으로 할 방법 고민
	             -->
	            <a class="order-btn"
	               href="${ pageContext.request.contextPath }/insert.or">
	            	주문하기
	            </a>
	        </div>
	    </div>
    
    </div>
    
    <jsp:include page="../common/footer.jsp" />
	

	<script src="${pageContext.request.contextPath}/resources/js/cart/cartListView.js"></script>
	

</body>
</html>
    