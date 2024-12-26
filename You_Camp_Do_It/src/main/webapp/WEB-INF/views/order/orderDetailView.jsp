<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제완료</title>
	<!-- 경로수정 -->
    <link rel="stylesheet" 
    	  href="${pageContext.request.contextPath}/resources/css/order/orderDetailView.css?ver=1.1">
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<div class="order-outer">
	
        <div class="order-header">
            <div class="order-header-wrap">
                <a href="${ pageContext.request.contextPath }/list.or">주문완료(결제완료) 내역</a>
            </div>
        </div>
	   
	    <div class="order-container">
			
			<div class="payResult-info">
				<h3>결제정보</h3>
				<table class="payResult-info-table">
					<tr>
						<th>주문 번호</th>
						<td>${requestScope.order.orderNo}</td>
					</tr>
					<tr>
						<th>결제 상태</th>
						<c:choose>
							<c:when test="${ requestScope.order.paymentStatus eq 'PAID' }">
								<td>결제 완료</td>
							</c:when>
							
							<c:when test="${ requestScope.order.paymentStatus eq 'CANCELED' }">
								<td>취소 진행 중</td>
							</c:when>
							
							<c:when test="${ requestScope.order.paymentStatus eq 'REFUNDED' }">
								<td>취소 완료</td>
							</c:when>
						</c:choose>
					</tr>
					<tr>
						<th>결제 수단</th>
						<td>${requestScope.order.paymentMethod}</td>
					</tr>
					<tr>
						<th>결제 날짜</th>
						<td><fmt:formatDate value="${requestScope.order.updatedDate}" 
											pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<th>결제 금액</th>
						<td><fmt:formatNumber value="${requestScope.order.totalPrice}" 
											  type="number" />원</td>
					</tr>
					<tr hidden>
						<th>거래 번호</th>
						<td>${requestScope.order.paymentId}</td>
					</tr>
				</table>
				<button type="button" class="btn-lg" id="cancel-btn" onClick="reqCancel();">결제 취소</button>
			</div>	

			<!-- 결제 취소 시 필요한 정보들 -->
			<form name="cancelForm" action="orderCancelRequest.or" method="post" target="_self">
				<input type="hidden" name="orderNo" value="${requestScope.order.orderNo}">
				<table hidden>
					<tr>
						<th>원거래 ID</th>
						<td>
							<input type="text" name="TID" 
								   value="${requestScope.order.paymentId}" />
						</td>
					</tr>
					<tr>
						<th>취소 금액</th>
						<td>
							<input type="text" name="CancelAmt" 
								   value="${requestScope.order.totalPrice}" />
						</td>
					</tr>
					<tr>
						<th>부분취소 여부</th>
						<td>
							<input type="radio" name="PartialCancelCode" value="0" checked="checked"/> 전체취소
							<input type="radio" name="PartialCancelCode" value="1"/> 부분취소
						</td>
					</tr>
				</table>
			</form>
			
			<!-- Order Items - 주문테이블 목록조회 부분 -->
        	<c:forEach var="od" items="${ requestScope.list }">
				<div class="order-item">
					<input type="hidden" name="goodsNo" value="${od.goods.goodsNo}">
					<div class="thumbnail">
						${thumbnailMap[od.goods.goodsNo]}
					</div>
					<div class="item-details">
						<h3 class="goodsName">${od.goods.goodsName}</h3>
						<!-- <p class="item-options">${od.goods.goodsInfo}</p> -->
						<br>
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
    
    </div>
    
    <jsp:include page="../common/footer.jsp" />

	<script src="https://pg-web.nicepay.co.kr/v3/common/js/nicepay-pgweb.js" type="text/javascript"></script>

    <script type="text/javascript">

		$(function () {
			// 썸네일의 기존 인라인 스타일 제거
			$('.thumbnail img').removeAttr('style');

			// 결제 상태 확인하여 버튼 비활성화 처리
			const paymentStatus = "${requestScope.order.paymentStatus}";

			if (paymentStatus === "CANCELED") {
				const cancelButton = $("#cancel-btn");
				cancelButton.prop("disabled", true); // 버튼 비활성화
			}

			// .thumbnail 또는 .goodsName 클릭 시 이벤트 처리
			$(document).on('click', '.thumbnail, .goodsName', function () {
				// 해당 요소의 부모에서 hidden input의 값을 찾아 goodsNo를 가져옴
				const goodsNo = $(this).closest('.order-item').find('input[name="goodsNo"]').val();

				// goodsNo를 이용해 상품 상세 페이지로 이동
				location.href = "goodsDetail.gs?goodsNo=" + goodsNo;
    		});

		});

        function reqCancel(){
            document.cancelForm.submit();
        }
    </script>

    
</body>
</html>
    