<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="org.apache.commons.codec.binary.Hex" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문하기</title>
    <link rel="stylesheet" 
    	  href="${pageContext.request.contextPath}/resources/css/order/orderForm.css">
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<div class="order-outer">
	
        <div class="order-header">
            <div class="order-header-wrap">
                <a href="">주문하기</a>
            </div>
        </div>
	   
	    <div class="order-container">

			<div class="order-info">
	        
		        <h3>주문정보</h3>
			    <form name="payForm" method="post" action="update.or">
					<table class="order-info-table">
						<!-- 일단, 카드결제만 가능하게 처리 -->
						<tr hidden>
							<th><span>결제 수단</span></th>
							<td><input type="text" name="PayMethod" value="CARD"></td>
						</tr>
						<!-- 다 건 주문시 첫 번째 항목의 제품명 가져옴 -->
						<tr hidden>
							<th><span>결제 상품명</span></th>
							<c:choose>
								<c:when test="${not empty requestScope.list[0]}">
									<td><input type="text" name="GoodsName" value="${requestScope.list[0].goods.goodsName}"></td>
								</c:when>
								<c:otherwise>
									<td><input type="text" name="GoodsName" value="데이터 없음"></td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr hidden>
							<th><span>결제 상품금액</span></th>
							<td><input type="text" name="Amt" value="${requestScope.order.totalPrice}" readOnly></td>
						</tr>				
						<tr hidden>
							<th><span>상점 아이디</span></th>
							<td><input type="text" name="MID" value="${merchantID}"></td>
						</tr>	
						<tr>
							<th><span>상품 주문번호</span></th>
							<td><input type="text" name="Moid" value="${moid}" readOnly></td>
						</tr> 
						<tr>
							<th><span>구매자명</span></th>
							<td><input type="text" name="BuyerName" value="${sessionScope.loginMember.memberName}"></td>
						</tr>	 
						<tr>
							<th>구매자명 이메일</th>
							<td><input type="text" name="BuyerEmail" value="${sessionScope.loginMember.email}"></td>
						</tr>			
						<tr>
							<th><span>구매자 연락처</span></th>
							<td><input type="text" name="BuyerTel" value="${sessionScope.loginMember.phone}"></td>
						</tr>	 
						<%--<tr>
							<th><span>인증완료 결과처리 URL<!-- (모바일 결제창 전용)PC 결제창 사용시 필요 없음 --></span></th>
							<td><input type="text" name="ReturnURL" value="${returnURL}"></td>
						</tr> 
						<tr>
							<th>가상계좌입금만료일(YYYYMMDD)</th>
							<td><input type="text" name="VbankExpDate" value=""></td>
						</tr> --%>		
						
									
						<!-- 옵션 --> 
						<input type="hidden" name="GoodsCl" value="1"/>						<!-- 상품구분(실물(1),컨텐츠(0)) -->
						<input type="hidden" name="TransType" value="0"/>					<!-- 일반(0)/에스크로(1) --> 
						<input type="hidden" name="CharSet" value="utf-8"/>					<!-- 응답 파라미터 인코딩 방식 -->
						<input type="hidden" name="ReqReserved" value=""/>					<!-- 상점 예약필드 -->
									
						<!-- 변경 불가능 -->
						<input type="hidden" name="EdiDate" value="${ediDate}"/>			<!-- 전문 생성일시 -->
						<input type="hidden" name="SignData" value="${hashString}"/>	<!-- 해쉬값 -->
					</table>
					<!-- <a href="#" class="btn_blue" onClick="nicepayStart();">요 청</a> -->
				</form>	
	        </div>

			<span>※ 수량은 장바구니에서 수정해주세요.</span>
	    
			<c:forEach var="od" items="${ requestScope.list }">
				<div class="order-item">
					<img src="https://via.placeholder.com/100" alt="상품 이미지">
					<div class="item-details">
						<h3>${od.goods.goodsName}</h3>
						<p class="item-options">${od.goods.goodsInfo}</p>
						<div class="item-quantity">
							<input type="text" value="${od.quantity}" class="quantity-input" readonly>
						</div>
					</div>
					<div class="item-price">
						<p><fmt:formatNumber value="${od.totalPrice}" type="number" />원</p>
					</div>
				</div>
			</c:forEach>	
				        
	    </div>
	    
	    <br><br>
		
	    <div class="floating-area">
	        <div class="buy-area">
				<span class="total-price">
					총 
            		<c:out value="${fn:length(requestScope.list)}" /> 건 주문금액 
					<fmt:formatNumber value="${requestScope.order.totalPrice}" type="number" />원
				</span>
	            <a class="order-btn" onClick="nicepayStart();"
	               href="#">
	            	결제하기
	            </a>
	        </div>
	    </div>
    
    </div>
    
    
    <jsp:include page="../common/footer.jsp" />
    
    
    <script src="https://pg-web.nicepay.co.kr/v3/common/js/nicepay-pgweb.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/resources/js/order/orderForm.js" type="text/javascript"></script>



    
</body>
</html>
    