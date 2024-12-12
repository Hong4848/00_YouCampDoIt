<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="org.apache.commons.codec.binary.Hex" %>
    
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

        

        /* 총 결제 내역 */
        .floating-area {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #000;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px 0;
            z-index: 100;
        }

        .buy-area {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            width: 100%;
            max-width: 1000px;
            padding: 0 20px;
        }

        .total-price {
            font-size: 18px;
            font-weight: bold;
            margin-right: 20px;
            color: #fff;
        }

        .order-btn {
            background-color: #2DB400;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 8px;
        }
    </style>
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
			수량 및 옵션은 장바구니에서 수정해주세요.
			<!-- 
			<br>
			-------------------------<br>
			하단에 결제자 정보 추가
			나중에 결재금액 테이블 히든처리
			        
	        <br>
	        결제에 필요한정보는
			order, orderDetail에서
			member에서
			goods에서 가져오기
			없는 결제 정보들은 String hidden에서 ??
			
			필요정보들 다 채우고 스크립트로 나이스페이 "nicepayStart();" 실행
			<br>
			 -->	
	        	
	        <!-- order, orderDetail 테이블에서 가져온 정보들 출력 -->
	        <!-- 상품명, 상품금액 가져오기 -->
	        <div class="order-info">
	        
		        <span>주문 정보</span>
			    <form name="payForm" method="post" action="payResult.or">
					<table class="order-info-table">
						<!-- 일단, 카드결제만 가능하게 처리 -->
						<tr hidden>
							<th><span>결제 수단</span></th>
							<td><input type="text" name="PayMethod" value="CARD"></td>
						</tr>
						<tr>
							<th><span>결제 상품명</span></th>
							<td><input type="text" name="GoodsName" value="${goodsName}"></td>
						</tr>
						<tr>
							<th><span>결제 상품금액</span></th>
							<td><input type="text" name="Amt" value="${price}" readOnly></td>
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
	        
	    </div>
	    
	    <br><br>

	    <div class="floating-area">
	        <div class="buy-area">
	            <span class="total-price">총 0건 주문금액 ${price}원</span>
	            <a class="order-btn" onClick="nicepayStart();"
	               href="#">
	            	결제하기
	            </a>
	        </div>
	    </div>
    
    </div>
    
    
    <jsp:include page="../common/footer.jsp" />
    
    
    <script src="https://pg-web.nicepay.co.kr/v3/common/js/nicepay-pgweb.js" type="text/javascript"></script>
	<script type="text/javascript">
	//결제창 최초 요청시 실행됩니다.
	function nicepayStart(){
		goPay(document.payForm);
	}
	
	//[PC 결제창 전용]결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
	function nicepaySubmit(){
		document.payForm.submit();
	}
	
	//[PC 결제창 전용]결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
	function nicepayClose(){
		alert("결제가 취소 되었습니다");
	}
	
	</script>


    
</body>
</html>
    