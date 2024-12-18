// 체크가 되어있는 상태에서 수량변경 시 체크 풀리는 문제
// 체크 상태가 기본상태로??
// +- 비활성화 일때 커서 css 다르게 적용??
// 체크된상태에서 선택삭제로 삭제 후 총 주문금액에 금액 남아있는 문제


$(function () {

	// 페이지 로드 시 목록 조회
	loadCartItems();
	
	// 전체 선택 클릭 이벤트
	$('.total-chcek').on('change', 'input[type="checkbox"]', function () {
		const isChecked = $(this).prop('checked');
		$('.cart-item input[type="checkbox"]').prop('checked', isChecked);
		
		// 체크 상태 변화 시 총 가격 변화
		updateTotalPrice();
	});
	
	// 각 카트 아이템 요소를 개별 선택 시 실행 이벤트
	$('.cart-container').on('change', '.cart-item input[type="checkbox"]', function () {
		const allChecked = $('.cart-item input[type="checkbox"]').length === 
						   $('.cart-item input[type="checkbox"]:checked').length;
		$('.total-chcek input[type="checkbox"]').prop('checked', allChecked);

		// 체크 상태 변화 시 총 가격 변화
		updateTotalPrice();
	});
	
	
	// 선택삭제 버트 클릭 이벤트 > 체크된 요소들의 cartNo 값 쉼표가 추가된 문자열로 가공
	$(document).on('click', '#cart-list-delete-checked', function () {
		const $checkedCartItem = $('.cart-item input[type="checkbox"]:checked');
	
		// 체크된 항목이 없으면
		if ($checkedCartItem.length === 0) {
			alertify.alert("Alert", "선택된 항목이 없습니다.");
			return;
		}
	
		// 체크된 항목이 있으면
		let cartNos = "";
		$checkedCartItem.each(function () {
			// 문자열로 연결하고, 쉼표로 구분
			cartNos += $(this).val() + ",";
		});
		// 마지막 쉼표 제거
		cartNos = cartNos.slice(0, -1);
	
		// console.log(cartNos);
	
		// 카트번호 문자열로 넘기면서 Ajax 호출
		deleteCart(cartNos);
	});
	
	// 동적으로 버튼이 생성되어, id값이 중복되므로 class 선택자로 수정해야함
	// 각 목록의 X삭제버튼 클릭 이벤트 > cartNo 가져오고 넘기면서 삭제 ajax 실행
	$(document).on('click', '.delete-btn', function () {
		// x 삭제버튼의 value 값 가져오기
		const cartNo = $(this).val();
		
		// 카트번호 넘기면서 삭제 Ajax 호출
		deleteCart(cartNo);
	});
	
	// +- 버튼 수량변동 이벤트
	// 수량 감소 버튼 클릭 이벤트
	$(document).on('click', '.quantity-decrease', function () {
		const input = $(this).next('.quantity-input'); // 수량 input 요소 선택
		const currentValue = parseInt(input.val(), 10);
		
		// 수량이 1 이상인 경우에만 감소
		if (currentValue > 1) {
			input.val(currentValue - 1); // 값 감소
		}
		// 수량이 1인 경우 - 버튼 비활성화, 그 외 활성화
		if (parseInt(input.val(), 10) === 1) {
			$(this).prop('disabled', true); // - 버튼 비활성화
		} else {
			$(this).prop('disabled', false); // - 버튼 활성화
		}

		// 수량 값 가져오기
		const quantity = input.val();
		// console.log(quantity);

		// 카트 번호 가져오기
		const cartNo = $(this).closest('.cart-item') // 가장 가까운 .cart-item 부모 요소 선택
							  .find('input[type="checkbox"]') // 체크박스 찾기
							  .val(); // 체크박스의 value 값 가져오기
		// console.log(cartNo);

		// 변동된수량, 카트번호 넘기면서 수량변경 ajax 호출
		updateCartQuantity(cartNo, quantity);
	});

	// 수량 증가 버튼 클릭 이벤트
	$(document).on('click', '.quantity-increase', function () {
		const input = $(this).prev('.quantity-input'); // 바로 이전 요소 선택
		const currentValue = parseInt(input.val(), 10);

		// 수량이 99 이하인 경우에만 증가
		if (currentValue < 99) {
			input.val(currentValue + 1); // 값 증가
		}
		// 수량이 99인 경우 + 버튼 비활성화, 그 외 활성화
		if (parseInt(input.val(), 10) === 99) {
			$(this).prop('disabled', true); // + 버튼 비활성화
		} else {
			$(this).prop('disabled', false); // + 버튼 활성화
		}

		// 수량 값 가져오기
		const quantity = input.val();
		// console.log(quantity);
		// 카트 번호 가져오기
		const cartNo = $(this).closest('.cart-item') // 가장 가까운 .cart-item 부모 요소 선택
							  .find('input[type="checkbox"]') // 체크박스 찾기
							  .val(); // 체크박스의 value 값 가져오기
		//console.log(cartNo);
		// 변동된수량, 카트번호 넘기면서 수량변경 ajax 호출
		updateCartQuantity(cartNo, quantity);
	});

	// 체크된 항목이 없거나, 장바구니가 비어있을 때 
	// submit 막기
	$(document).on('submit', '#orderForm', function (event) {
		// 기본 동작 막기
		event.preventDefault();
	
		const $cartItems = $('.cart-item'); // 장바구니 아이템 요소
		const $checkedItems = $('.cart-item input[type="checkbox"]:checked'); // 체크된 요소
	
		// 장바구니에 아이템이 없는 경우
		if ($cartItems.length === 0) {
			alertify.alert("Alert", "장바구니가 비어있습니다.");
			return;
		}
	
		// 체크된 항목이 없는 경우
		if ($checkedItems.length === 0) {
			alertify.alert("Alert", "선택된 항목이 없습니다.");
			return;
		}
	
		// 위 두 조건을 통과한 경우만 폼 제출
		this.submit();
	});

	
});
//------------------------------------------------------------------------------

// 장바구니 목록 삭제 ajax
function deleteCart(cartNos){
	$.ajax({
		// 삭제할 카트번호 문자열로 넘기고
		// 외부방식으로 사용 시 경로에 el 구문 사용불가, 상대경로방식 사용해야함
		url : "./delete.ca",
		type : "post",
		data : { cartNos : cartNos },
		success : function(result){        				
			// console.log(result);
			
			if(result == "success") {
				// 목록조회 ajax 호출
				loadCartItems();
			} else {
				alertify.alert("Alert", "장바구니 삭제 실패");
			}
			
		},
		error : function(){
			console.log("장바구니 목록 삭제용 ajax 통신 실패!");
		}
		
	});
}

// +- 버튼으로 장바구니 수량 변경 ajax
function updateCartQuantity(cartNo, quantity){
	$.ajax({
		// 변경할 cartNo, quantity
		url : "./updateQuantity.ca",
		type : "post",
		data : { 
			cartNo : cartNo,
			quantity : quantity
		 },
		success : function(result){        				
			if(result == "success") {
				// 목록조회 ajax 호출
				loadCartItems();
			} else {
				alertify.alert("Alert", "장바구니 수량 변경 실패");
			}
			
		},
		error : function(){
			console.log("장바구니 수량 변경용 ajax 통신 실패!");
		}
		
	});
}

// 장바구니 목록조회 ajax 함수
function loadCartItems() {
	$.ajax({
		url: "./list.ca",
		type: "GET",
		dataType: "json",
		success: function (data) {
			// console.log("AJAX 요청 성공:", data);
			renderCartItems(data);
		},
		error: function () {
			console.error("장바구니 목록 조회 실패!");
		}
	});
}

// 장바구니 목록 렌더링 함수
function renderCartItems(items) {
	const $cartContainer = $(".cart-container");
	$cartContainer.find(".cart-item").remove(); // 기존 목록 초기화

	if (items.length === 0) {
		$cartContainer.append(`
			<div style="text-align: center; font-size: 24px; font-weight: bold;">
				장바구니에 담은 용품이 없습니다.
			</div>`);
		return;
	}

	items.forEach(item => {
		// 가격에 콤마 추가 (toLocaleString 사용)
		const formattedPrice = item.price.toLocaleString();

		const cartItem = `
			<div class="cart-item">
				<input type="checkbox" value="${item.cartNo}">
				<img src="https://via.placeholder.com/100" alt="상품 이미지">
				<div class="item-details">
					<h3>${item.goods.goodsName}</h3>
					<p class="item-options">선택: ${item.goods.goodsInfo}</p>
					<div class="item-quantity">
						<span class="quantity-decrease">-</span>
						<input type="text" value="${item.quantity}" class="quantity-input" readonly>
						<span class="quantity-increase">+</span>
					</div>
				</div>
				<div class="item-price">
					<p>${formattedPrice} 원</p>
				</div>
				<button class="delete-btn" value="${item.cartNo}">X</button>
			</div>`;
		$cartContainer.append(cartItem);
	});

	// 수량 버튼 상태 초기화 (생성된 요소에 적용)
	// css 도 적용하고 싶은데 안됨
	$('.quantity-input').each(function () {
        const currentValue = parseInt($(this).val(), 10);
        const decreaseButton = $(this).siblings('.quantity-decrease');
        const increaseButton = $(this).siblings('.quantity-increase');

        // 수량이 1이면 - 버튼 비활성화
        if (currentValue === 1) {
            decreaseButton.prop('disabled', true);
        } else {
            decreaseButton.prop('disabled', false);
        }

        // 수량이 99면 + 버튼 비활성화
        if (currentValue === 99) {
            increaseButton.prop('disabled', true);
        } else {
            increaseButton.prop('disabled', false);
        }
    });
}

// 총 갯수 및 가격 변화 함수
function updateTotalPrice(){
	let totalPrice = 0; // 총 가격
    let totalCount = 0; // 선택된 항목 개수

	// 체크된 각 요소에 대해 가격과 수량을 계산
    $('.cart-item input[type="checkbox"]:checked').each(function () {
        const $cartItem = $(this).closest('.cart-item'); // 해당 체크박스의 부모 요소
        const price = parseInt($cartItem.find('.item-price p').text().replace(/,/g, '').replace(' 원', ''), 10);
       

        totalPrice += price; // 총 가격 누적
        totalCount++; // 체크된 항목 개수 누적
    });

    // 결과를 .total-price 요소에 표시
    $('.total-price').text(`총 ${totalCount}건 주문금액 ${totalPrice.toLocaleString()}원`);

}













