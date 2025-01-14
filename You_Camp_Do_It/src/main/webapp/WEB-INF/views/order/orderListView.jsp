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
          href="${pageContext.request.contextPath}/resources/css/order/orderListView.css?ver=1.0">


</head>
<body>

	<jsp:include page="../common/header.jsp" />

    

    <div class="order-outer">

        <div class="order-header">
            <div class="order-header-wrap">
                <a href="">주문 및 결제내역</a>
            </div>
        </div>

        <div class="container">
            
            <!-- 주문내역 섹션 -->
            <div class="order-section">

                <div class="order-item">
                    <div class="table-wrap">
                        <table class="table_basic">
                    
                            <thead>
                                <tr>
                                    <th>주문번호</th>
                                    <th>결제일</th>
                                    <th>결제금액</th>
                                    <th>주문상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${ requestScope.list }" varStatus="status">
                                
                                    <tr class="order-row" style="display: ${status.index < 5 ? 'table-row' : 'none'};">
                                        <td>${ o.orderNo }</td>
                                        <td><fmt:formatDate value="${o.updatedDate}" pattern="yyyy-MM-dd" /></td>
                                        <td><fmt:formatNumber value="${o.totalPrice}" type="number" pattern="#,###" /></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${ o.paymentStatus eq 'PAID' }">
                                                    <span class="state state_point">결제 완료</span>
                                                </c:when>
                                                
                                                <c:when test="${ o.paymentStatus eq 'CANCELED' }">
                                                    <span class="state state_point">취소 진행중</span>
                                                </c:when>
                                                
                                                <c:when test="${ o.paymentStatus eq 'REFUNDED' }">
                                                    <span class="state state_point">취소 완료</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- 더보기 버튼 -->
                <div align="center">
                    <button id="btn-more">더보기</button>
                </div>

            </div>
                
        </div>

	<br>
    </div>

   

	<jsp:include page="../common/footer.jsp" />

    <script>
        const contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/order/orderListView.js?ver=1.2"></script>
    
</body>
</html>