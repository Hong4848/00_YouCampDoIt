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
    <link rel="stylesheet" 
    	  href="${pageContext.request.contextPath}/resources/css/order/payResult.css">
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<div class="order-outer">
	
        <div class="order-header">
            <div class="order-header-wrap">
                <a href="">주문완료(결제완료) 내역</a>
            </div>
        </div>
	   
	    <div class="order-container">
			
			<div class="payResult-info">
			<!-- 여기 el 구문들 어디서 갖고온거????? -->
				<h3>결제정보</h3>
				<table class="payResult-info-table">
				   <c:choose>
				       <c:when test="${resultJsonStr eq '9999'}">
				           <tr>
				               <th>승인 통신 실패로 인한 망취소 처리 진행 결과</th>
				               <td>[${ResultCode}]${ResultMsg}"</td>
				           </tr>
				       </c:when>
				       <c:otherwise>
				           <tr>
				               <th>결과 내용</th>
				               <td>[${ResultCode}]${ResultMsg}</td>
				           </tr>
				           <tr>
				               <th>결제수단</th>
				               <td>${PayMethod}</td>
				           </tr>
				           <tr>
				               <th>상품명</th>
				               <td>${GoodsName}</td>
				           </tr>
				           <tr>
				               <th>결제 금액</th>
				               <td><fmt:formatNumber value="${Amt}" type="number" />원</td>
							   
				           </tr>
				           <tr>
				               <th>거래 번호</th>
				               <td>${TID}</td>
				           </tr>
				           <%--<!--<%/*if(Signature.equals(paySignature)){%>
				           <tr>
				               <th>Signature</th>
				               <td><%=Signature%></td>
				           </tr>
				           <%}else{%>
				           <tr>
				               <th>승인 Signature</th>
				               <td><%=Signature%></td>
				           </tr>
				           <tr>
				               <th>생성 Signature</th>
				               <td><%=paySignature%></td>
				           </tr> 
				           <%}*/}%> -->--%>
				       </c:otherwise>
				   </c:choose>
				</table>
			</div>	
			
			<p>*테스트 아이디인경우 당일 오후 11시 30분에 취소됩니다.</p>

			<!-- Order Items - 주문테이블 목록조회 부분 -->
			<!-- 어디서 포워딩하지?? 데이터 어디서 넘겨야함????? -->
        	<div class="order-item">
	            <img src="https://via.placeholder.com/100" alt="상품 이미지">
	            <div class="item-details">
	                <h3>캠핑용 접이식 의자</h3>
	                <p class="item-options">선택: 블랙</p>
	                <div class="item-quantity">
	                    <input type="text" value="2" class="quantity-input" readonly>
	                </div>
	            </div>
	            <div class="item-price">
	                <p>39,800원</p>
	            </div>
	        </div>
			        
	        	
	        
	    </div>
	    
	    <br><br><br><br>
	
	    
    
    </div>
    
    <jsp:include page="../common/footer.jsp" />


    
</body>
</html>
    