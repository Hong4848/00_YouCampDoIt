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
			<!-- ajax 로 동적생성 -->
			
			
	    </div>
	    
	    <br><br><br><br>
	
	    <div class="floating-area">
	        <div class="buy-area">
	            <span class="total-price">총 0건 주문금액 0원</span>
	            
				<form id="orderForm" 
				 	  action="${pageContext.request.contextPath}/insert.or" 
					  method="POST">
					<!-- 장바구니 데이터가 있는 경우 hidden input에 값을 추가해서 데이터 전송 -->
					<input type="hidden" name="totalPrice" id="totalPriceInput" value="0">
    				<!-- <input type="hidden" name="totalCount" id="totalCountInput" value="0"> 선택한 장바구니 수 (전체수량이 아님) -->
					<input type="hidden" name="orderDetails" id="orderDetailsInput" value="0">
					
					<button type="submit" class="order-btn">주문하기</button>
				</form>
	        </div>
	    </div>
    
    </div>
    
    <jsp:include page="../common/footer.jsp" />
	

	<script src="${pageContext.request.contextPath}/resources/js/cart/cartListView.js"></script>
	

</body>
</html>
    