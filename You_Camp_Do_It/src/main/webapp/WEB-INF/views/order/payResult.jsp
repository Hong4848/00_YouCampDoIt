<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문하기</title>
    <style>
        
		.order-outer{
			margin-top: 0; /* 상단 여백 제거 */
		    padding-top: 0; /* 내부 여백 제거 */
		    background-color: #f8f8f8; /* 배경색 유지 */
		}

        /* 헤더부분 */
        .order-header {
		    margin: 0; /* 외부 여백 제거 */
		    padding: 0; /* 내부 여백 제거 */
		    display: flex;
		    justify-content: center; /* 가로 중앙 정렬 */
		    align-items: center; /* 세로 중앙 정렬 */
		    height: 100px; /* 높이 유지 */
		    box-sizing: border-box;
		    background-color: white;
		    font-size: 24px; /* 글씨 크기 추가 */
		    font-weight: bold; /* 글씨 굵기 추가 */
		    color: #333; /* 텍스트 색상 */
		}

        .order-header-wrap a {
            text-decoration: none;
            font-size: 18px;
            color: #333;
            padding: 10px 20px;
            margin-right: 20px;
            border-bottom: 3px solid transparent;
        }

        .order-header-wrap a:first-child {
            color: #f7b500;
            border-bottom: 3px solid #f7b500;
        }

        .order-header-wrap a:hover {
            color: #f7b500;
        }


        /* 컨테이너 */
        .order-container {
            max-width: 1000px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        /* 장바구니 목록조회내역 */
        .order-item {
            display: flex;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #eee;
            position: relative;
        }

        .order-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }

        .item-details {
            flex-grow: 1;
        }

        .item-details h3 {
            margin: 0;
            font-size: 16px;
            color: #333;
        }

        .item-details p {
            margin: 5px 0;
            color: #777;
        }

        .item-options {
            font-size: 14px;
            color: #555;
        }

        /* 수량 조절 컨트롤 */
        .item-quantity {
		    display: flex;
		    align-items: center; /* 세로 중앙 정렬 */
		    justify-content: center; /* 가로 중앙 정렬 */
		    width: 120px; /* 전체 컨트롤의 너비 */
		    height: 40px; /* 컨트롤 높이 */
		    border: 1px solid #ddd; /* 테두리 */
		    border-radius: 4px; /* 모서리 둥글게 */
		    background-color: #fff; /* 배경색 */
		}
		
		/* 인풋 필드 스타일 */
		.item-quantity .quantity-input {
		    width: 60px; /* 입력 필드 너비 */
		    height: 100%; /* 입력 필드 높이를 부모 높이에 맞춤 */
		    text-align: center; /* 텍스트 중앙 정렬 */
		    border: none; /* 테두리 제거 */
		    font-size: 16px; /* 글자 크기 */
		    font-weight: bold; /* 글자 굵게 */
		    background-color: transparent; /* 배경 투명 */
		}
        

        .item-price {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            text-align: right;
        }
        
        /* 주문정보 영역 */
        
        
        /* 테이블 */
        .payResult-info-table {
		    width: 100%; /* 테이블 너비 */
		    border-collapse: collapse; /* 테두리 겹침 제거 */
		    margin: 20px 0; /* 테이블 상하 간격 */
		    background-color: #fff; /* 테이블 배경색 */
		    font-family: 'Arial', sans-serif; /* 폰트 */
		    font-size: 14px; /* 기본 글자 크기 */
		    color: #333; /* 텍스트 색상 */
		    border: 1px solid #ddd; /* 외곽 테두리 */
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 가벼운 그림자 */
		}
		
		.payResult-info-table th,
		.payResult-info-table td {
		    padding: 10px 15px; /* 셀 내부 여백 */
		    text-align: left; /* 기본 왼쪽 정렬 */
		    border-bottom: 1px solid #eee; /* 행 구분선 */
		}
		
		.payResult-info-table th {
		    width: 30%; /* 제목 열 비율 */
		    background-color: #f9f9f9; /* 제목 셀 배경색 */
		    font-weight: bold; /* 제목 굵게 */
		    color: #555; /* 제목 색상 */
		}
		
		.payResult-info-table td {
		    width: 70%; /* 내용 열 비율 */
		    text-align: left; /* 내용 왼쪽 정렬 */
		    color: #333; /* 내용 텍스트 색상 */
		}
		
		.payResult-info-table tr:last-child td {
		    border-bottom: none; /* 마지막 행의 테두리 제거 */
		}
		
		.payResult-info-table input[type="text"] {
		    width: 100%; /* 입력 필드 너비 */
		    padding: 8px; /* 입력 필드 내부 여백 */
		    border: 1px solid #ddd; /* 입력 필드 테두리 */
		    border-radius: 4px; /* 입력 필드 모서리 둥글게 */
		    background-color: #f9f9f9; /* 입력 필드 배경색 */
		    font-size: 14px; /* 입력 필드 글자 크기 */
		    color: #555; /* 입력 필드 텍스트 색상 */
		}

        

       
    </style>
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
	    
	        <!-- Order Items - 주문테이블 목록조회 부분 -->
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
	        
			<!-- 
				결제된 품목 정보 띄우기
			
				결제자 정보, 회원정보 띄우기
			 -->
			 
			 <br>
			
			<div class="payResult-info">
			
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
				               <td>${Amt}</td>
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
			        
	        	
	        
	    </div>
	    
	    <br><br><br><br>
	
	    
    
    </div>
    
    <jsp:include page="../common/footer.jsp" />


    
</body>
</html>
    