<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문(결제) 내역</title>
    <link rel="stylesheet" 
    href="${pageContext.request.contextPath}/resources/css/order/orderListView.css">

    


</head>
<body>

	<jsp:include page="../common/header.jsp" />

    

    <div class="order-outer">

        <div class="order-header">
            <div class="order-header-wrap">
                <a href="">결제내역</a>
            </div>
        </div>

        <div class="container">
            <!-- 주문 정보 -->
            <div class="sort-order-button">
                <button>전체</button>
                <button>예약 결제내역</button>
                <button>용품 결제내역</button>
                <button>취소 / 환불내역</button>
            </div>

            <!-- 주문 섹션 -->
            <div class="order-section">

                <div class="order-item">
                    <img src="https://via.placeholder.com/100" alt="상품 이미지">
                    <div class="item-details">
                        <h3>캠핑용 접이식 의자</h3>
                        <p>옵션: 블랙</p>
                        <span class="status">결제완료</span>
                        <div class="item-quantity">
							<input type="text" value="2" class="quantity-input" readonly>
						</div>
                    </div>
                    <div>
                        <div class="item-price">39,800원</div>
                        <div class="button-group">
                            <button>주문 취소</button>
                        </div>
                    </div>
                </div>
            


                

                <!-- 
                    n건 주문 order 정보
                    orderDetail 정보 n개

                    m건 주문 order정보
                    orderDeatil 정보 m개
                    ..
                -->
                
                <c:forEach var="order" items="${requestScope.list}">
                    <div class="order-item">
                        <!-- Order 기본 정보 -->
                        <div>
                            <input type="hidden" value="${order.orderNo}">
                            <input type="hidden" value="${order.paymentId}">
                            
                            <p>Payment Status: ${order.paymentStatus}</p>
                            <p>Payment Method: ${order.paymentMethod}</p>
                            <p>Total Price: <fmt:formatNumber value="${order.totalPrice}" type="number" /> 원</p>
                        </div>
                        
                        
                        <br><br>

                        <!-- Goods 정보 -->
                        <div class="thumbnail">
                            <!-- Thumbnail 값이 비어 있는 경우 대체 텍스트를 표시 -->
                            <c:choose>
                                <c:when test="${not empty order.goods.goodsThumbnail}">
                                    ${order.goods.goodsThumbnail}
                                </c:when>
                                <c:otherwise>
                                    <p>Thumbnail 없음</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="item-details">
                            <h3>${order.goods.goodsName}</h3>
                        

                        <!-- OrderDetail 리스트 출력 -->
                            <h3>Order Details:</h3>
                            <ul>
                                <c:forEach var="detail" items="${order.orderDetail}">
                                    <li>
                                        Detail No: ${detail.orderDetailNo} | 
                                        Product No: ${detail.goodsNo} | 
                                        Quantity: ${detail.quantity} | 
                                        
                                        Price: <fmt:formatNumber value="${detail.price}" type="number" /> 원 | 
                                        <!--
                                        변수명이 겹침
                                        Total Price: <fmt:formatNumber value="${detail.totalPrice}" type="number" /> 원
                                        -->
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    
                </c:forEach>

            </div>
                
            
        </div>

	<br>
    </div>


   

	<jsp:include page="../common/footer.jsp" />

    <script src="${pageContext.request.contextPath}/resources/js/order/orderListView.js"></script>
    
</body>
</html>