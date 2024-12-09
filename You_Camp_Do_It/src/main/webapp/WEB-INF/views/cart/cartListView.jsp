<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <style>
        /* 전체 백그라운드 스타일 
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }*/

        /* 헤더부분 */
        .cart-header {
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            padding: 15px 20px;
            position: sticky;
            top: 0;
            z-index: 100;
            margin: 0;
        }
        .cart-header h1 {
            margin: 0;
            font-size: 20px;
        }

        /* 선택체크박스 부분 */
        .inner-1 {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
            padding: 10px 20px;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            position: sticky;
            top: 60px;
            z-index: 90;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
	
    <div class="cart-header">
        <h1>장바구니</h1>
    </div>

    <div class="inner-1">
        <div class="total-chcek">
            <label>
                <input type="checkbox">전체 선택
            </label>
        </div>

        <div class="delete-checked">
            <button>선택 삭제</button>
        </div>
    </div>

    <div class="cart-container">
        <!-- Cart Items - 장바구니 목록조회 부분 -->
        <div class="cart-item">
            <input type="checkbox">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="item-details">
                <h3>캠핑용 접이식 의자</h3>
                <p class="item-options">선택: 블랙</p>
                <div class="item-quantity">
                    <span class="quantity-decrease">-</span>
                    <input type="text" value="2" class="quantity-input" readonly>
                    <span class="quantity-increase">+</span>
                </div>
            </div>
            <div class="item-price">
                <p>39,800원</p>
            </div>
            <button class="delete-btn">X</button>
        </div>
        
        <!-- 하드코딩 부분 -->
        <div class="cart-item">
            <input type="checkbox">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="item-details">
                <h3>캠핑용 초경량 텐트</h3>
                <p class="item-options">선택: 2인용 / 블루</p>
                <div class="item-quantity">
                    <span class="quantity-decrease">-</span>
                    <input type="text" value="1" class="quantity-input" readonly>
                    <span class="quantity-increase">+</span>
                </div>
            </div>
            <div class="item-price">
                <p>149,000원</p>
            </div>
            <button class="delete-btn">X</button>
        </div>
    
        <div class="cart-item">
            <input type="checkbox">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="item-details">
                <h3>캠핑용 LED 랜턴</h3>
                <p class="item-options">선택: 충전식</p>
                <div class="item-quantity">
                    <span class="quantity-decrease">-</span>
                    <input type="text" value="3" class="quantity-input" readonly>
                    <span class="quantity-increase">+</span>
                </div>
            </div>
            <div class="item-price">
                <p>29,700원</p>
            </div>
            <button class="delete-btn">X</button>
        </div>
    
        <div class="cart-item">
            <input type="checkbox">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="item-details">
                <h3>캠핑용 방수 매트</h3>
                <p class="item-options">선택: 대형</p>
                <div class="item-quantity">
                    <span class="quantity-decrease">-</span>
                    <input type="text" value="1" class="quantity-input" readonly>
                    <span class="quantity-increase">+</span>
                </div>
            </div>
            <div class="item-price">
                <p>59,000원</p>
            </div>
            <button class="delete-btn">X</button>
        </div>
    
        <div class="cart-item">
            <input type="checkbox">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="item-details">
                <h3>캠핑용 아이스박스</h3>
                <p class="item-options">선택: 24L / 화이트</p>
                <div class="item-quantity">
                    <span class="quantity-decrease">-</span>
                    <input type="text" value="1" class="quantity-input" readonly>
                    <span class="quantity-increase">+</span>
                </div>
            </div>
            <div class="item-price">
                <p>89,000원</p>
            </div>
            <button class="delete-btn">X</button>
        </div>
    
        <div class="cart-item">
            <input type="checkbox">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="item-details">
                <h3>캠핑용 휴대용 화로</h3>
                <p class="item-options">선택: 스테인리스</p>
                <div class="item-quantity">
                    <span class="quantity-decrease">-</span>
                    <input type="text" value="1" class="quantity-input" readonly>
                    <span class="quantity-increase">+</span>
                </div>
            </div>
            <div class="item-price">
                <p>119,000원</p>
            </div>
            <button class="delete-btn">X</button>
        </div>
        <div class="cart-item">
            <input type="checkbox">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="item-details">
                <h3>캠핑용 휴대용 테이블</h3>
                <p class="item-options">선택: 알루미늄 소재</p>
                <div class="item-quantity">
                    <span class="quantity-decrease">-</span>
                    <input type="text" value="1" class="quantity-input" readonly>
                    <span class="quantity-increase">+</span>
                </div>
            </div>
            <div class="item-price">
                <p>79,000원</p>
            </div>
            <button class="delete-btn">X</button>
        </div>
        
        <div class="cart-item">
            <input type="checkbox">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="item-details">
                <h3>캠핑용 스테인리스 코펠 세트</h3>
                <p class="item-options">선택: 4인용</p>
                <div class="item-quantity">
                    <span class="quantity-decrease">-</span>
                    <input type="text" value="1" class="quantity-input" readonly>
                    <span class="quantity-increase">+</span>
                </div>
            </div>
            <div class="item-price">
                <p>49,900원</p>
            </div>
            <button class="delete-btn">X</button>
        </div>
        
        <div class="cart-item">
            <input type="checkbox">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="item-details">
                <h3>캠핑용 휴대용 샤워기</h3>
                <p class="item-options">선택: 충전식 / 블루</p>
                <div class="item-quantity">
                    <span class="quantity-decrease">-</span>
                    <input type="text" value="1" class="quantity-input" readonly>
                    <span class="quantity-increase">+</span>
                </div>
            </div>
            <div class="item-price">
                <p>69,000원</p>
            </div>
            <button class="delete-btn">X</button>
        </div>

    </div>
    
    <br><br><br><br>

    <div class="floating-area">
        <div class="buy-area">
            <span class="total-price">총 0건 주문금액 0원</span>
            <button class="order-btn">결제하기</button>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />

    <script>
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
    </script>
</body>
</html>
    