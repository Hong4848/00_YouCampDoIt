<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <style>
        
		.cart-outer{
			margin-top: 0; /* 상단 여백 제거 */
		    padding-top: 0; /* 내부 여백 제거 */
		    background-color: #f8f8f8; /* 배경색 유지 */
		}

        /* 헤더부분 */
        .cart-header {
		    margin: 0; /* 외부 여백 제거 */
		    padding: 0; /* 내부 여백 제거 */
		    display: flex;
		    justify-content: center; /* 가로 중앙 정렬 */
		    align-items: center; /* 세로 중앙 정렬 */
		    height: 100px;
		    box-sizing: border-box;
		    background-color: white;
		    font-size: 24px; /* 글씨 크기 추가 */
		    font-weight: bold; /* 글씨 굵기 추가 */
		    color: #333; /* 텍스트 색상 */
		}

        .cart-header-wrap a {
            text-decoration: none;
            font-size: 18px;
            color: #333;
            padding: 10px 20px;
            margin-right: 20px;
            border-bottom: 3px solid transparent;
        }

        .cart-header-wrap a:first-child {
            color: #f7b500;
            border-bottom: 3px solid #f7b500;
        }

        .cart-header-wrap a:hover {
            color: #f7b500;
        }


        /* 선택체크박스 부분 */
        .inner-1 {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            margin-bottom: 20px; /* 아래 간격 추가 */
            background-color: #fff;
            border: 1px solid #ddd; /* 테두리 유지 */
            border-radius: 4px; /* 약간 둥글게 처리 */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 가벼운 그림자 */
        }


        .inner-1 label {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .inner-1 input[type="checkbox"] {
            margin: 0;
        }

        .inner-1 button {
            padding: 8px 16px;
            font-size: 14px;
            background-color: #f0f0f0;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
        }

        .inner-1 button:hover {
            background-color: #e0e0e0;
        }

        /* 컨테이너 */
        .cart-container {
            max-width: 1000px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        /* 장바구니 목록조회내역 */
        .cart-item {
            display: flex;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #eee;
            position: relative;
        }

        .cart-item input[type="checkbox"] {
            margin-right: 20px;
        }

        .cart-item img {
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
            align-items: center;
            justify-content: space-between;
            width: 120px; /* 전체 컨트롤의 너비 */
            height: 40px; /* 컨트롤 높이 */
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            background-color: #fff;
        }

        .item-quantity span {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px; /* 버튼 너비 */
            height: 100%; /* 버튼 높이는 부모 컨테이너와 동일 */
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            background-color: #fff;
            user-select: none;
        }

        .item-quantity span.quantity-decrease {
            border-right: 1px solid #ddd; /* - 버튼과 수량 필드 사이의 구분선 */
        }

        .item-quantity span.quantity-increase {
            border-left: 1px solid #ddd; /* 수량 필드와 + 버튼 사이의 구분선 */
        }

        .item-quantity span:hover {
            background-color: #f9f9f9;
        }

        .item-quantity .quantity-input {
            width: 40px; /* 입력 필드 너비 */
            height: 100%;
            text-align: center;
            border: none;
            font-size: 16px;
            font-weight: bold;
            pointer-events: none; /* 입력 비활성화 */
            background-color: #fff;
        }

        .item-price {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            text-align: right;
        }

        /* 삭제 버튼 스타일 */
        .delete-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: none;
            border: none;
            color: #999;
            font-size: 16px;
            cursor: pointer;
            z-index: 10;
        }

        .delete-btn:hover {
            color: #ff0000;
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
	                <button id="cart-list-delete-checked">선택 삭제</button>
	            </div>
	        </div>
	    	
	        <!-- Cart Items - 장바구니 목록조회 부분 -->
	        <c:choose>
	        	<c:when test="${ not empty requestScope.list }">
	        		<c:forEach var="c" items="${ requestScope.list }">
	        			<div class="cart-item">
				            <input type="checkbox" value="${ c.cartNo }">
				            <img src="https://via.placeholder.com/100" alt="상품 이미지">
				            <div class="item-details">
				                <h3>캠핑용 접이식 의자 ${ c.goods.goodsName }</h3>
				                <p class="item-options">선택: 블랙 ${ c.goods.goodsInfo }</p>
				                <div class="item-quantity">
				                    <span class="quantity-decrease">-</span>
				                    <input type="text" value="${ c.quantity }" class="quantity-input" readonly>
				                    <span class="quantity-increase">+</span>
				                </div>
				            </div>
				            <div class="item-price">
				                <p>${ c.price } 원</p>
				                <p>단가 체크 나중에 삭제 ${ c.goods.price } 원</p>
				            </div>
				            <button class="delete-btn" 
				            		id="cart-list-delete"
				            		onclick="deleteCart(${c.cartNo});">
				            	X
				            </button>
				        </div>
	        		</c:forEach>
	        	</c:when>
	        	<c:otherwise>
	        		<div class="cart-item">
		        		<div style="text-align: center; 
		        					font-size: 24px; 
		        					font-weight: bold; 
		        					line-height: 1.5;">
						    장바구니에 담은 용품이 없습니다.
						</div>
	        		</div>
	        	</c:otherwise>
	        </c:choose>
	        
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
	             -->
	            <a class="order-btn"
	               href="${ pageContext.request.contextPath }/insert.or">
	            	주문하기
	            </a>
	        </div>
	    </div>
    
    </div>
    
    <jsp:include page="../common/footer.jsp" />

    <script>
    
    	// 수량 +- 메소드
        document.querySelectorAll('.quantity-decrease').forEach(button => {
            button.addEventListener('click', event => {
                const input = event.target.nextElementSibling;
                const currentValue = parseInt(input.value, 10);
                if (currentValue > 1) {
                    input.value = currentValue - 1;
                }
            });
        });

        document.querySelectorAll('.quantity-increase').forEach(button => {
            button.addEventListener('click', event => {
                const input = event.target.previousElementSibling;
                const currentValue = parseInt(input.value, 10);
                input.value = currentValue + 1;
            });
        });
        
        
        
        // 전체선택 체크박스 메소드
        $(function () {
            // 전체 선택 클릭 이벤트
            $('.total-chcek input[type="checkbox"]').change(function () {
                const isChecked = $(this).prop('checked');
                $('.cart-item input[type="checkbox"]').prop('checked', isChecked);
            });

            // 개별 선택 시 실행 이벤트
            $('.cart-item input[type="checkbox"]').change(function () {
                const allChecked = $('.cart-item input[type="checkbox"]').length === 
                	$('.cart-item input[type="checkbox"]:checked').length;
                $('.total-chcek input[type="checkbox"]').prop('checked', allChecked);
            });
            
        });
        
        
    	  	
    	
    	// 장바구니 목록 삭제 메소드
    	$(function() {
    		
    		// 선택삭제 버튼 클릭 이벤트
    		$('#cart-list-delete-checked').on('click', function () {
    			// 체크된 요소의 hidden input(cartNo) 값 문자열로 가져오기
    			const $checkedCartItem = $('.cart-item input[type="checkbox"]:checked');
    			
    			// 체크된 항목이 없으면
    			if($checkedCartItem.length === 0) {
    				alertify.alert("Alert", "선택된 항목이 없습니다.");
    		        return;
    		    }
    			
    			// 체크된 항목이 있으면
    			let cartNos = "";
    			$checkedCartItem.each(function() {
    				// 문자열로 연결하고,쉼표로 구문
    				cartNos += $(this).val() + ",";
    			});
    			// 마지막 쉼표 빼기
    			cartNos = cartNos.slice(0, -1); 
    			
    			//console.log(cartNos);
    			
    			// 카트번호 문자열로 넘기면서 Ajax 호출
    			deleteCart(cartNos);
    		});
    		
    		
    		
    	});
    	
    	// 삭제 Ajax
		function deleteCart(cartNos){
    		$.ajax({
    			// 삭제할 카트번호 문자열로 넘기고
    			// 쿼리문의 조건절에서 in 구문 사용
    			url : "${pageContext.request.contextPath}/delete.ca",
    			type : "post",
    			data : { cartNos : cartNos },
    			success : function(result){        				
    				console.log(result);
    				
    				if(result == "success") {
	    	            // 페이지 새로고침
	    	            // 일단 새로고침으로 진행, 추후 목록뷰도 에이작스로 수정해야함
	    	            location.reload();
    				} else {
    					alertify.alert("Alert", "장바구니 삭제 실패");
    				}    
    				
    			},
    			error : function(){
    				console.log("장바구니 목록 삭제용 ajax 통신 실패!");
    			}
    			
    		});
    	}
    	
    
    </script>
    
</body>
</html>
    