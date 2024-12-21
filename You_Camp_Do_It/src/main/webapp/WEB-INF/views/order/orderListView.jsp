<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                    <!-- <img src="https://via.placeholder.com/100" alt="상품 이미지"> -->
                    <div class="item-details">
                        <h3>캠핑용 접이식 의자</h3>
                        <p>옵션: 블랙</p>
                        <span class="status">결제완료</span>
                    </div>
                    <div>
                        <div class="item-price">39,800원</div>
                        <div class="button-group">
                            <button>주문 취소</button>
                        </div>
                    </div>
                </div>

                

                
            </div>
        </div>

	<br>
    </div>

    <script>
        // EL로 데이터를 JavaScript 변수로 전달
        const list = ${list};
        console.log(list); // JavaScript 콘솔에 데이터 출력

        // 각 항목 출력
        list.forEach((item, index) => {
            console.log(`Index: ${index}, Item:`, item);
        });
    </script>

	<jsp:include page="../common/footer.jsp" />

    <script src="${pageContext.request.contextPath}/resources/js/order/orderListView.js"></script>
    
</body>
</html>