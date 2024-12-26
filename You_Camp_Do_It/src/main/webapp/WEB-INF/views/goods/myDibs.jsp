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
    <title>내가 찜 한 목록</title>
    <link rel="stylesheet" 
    href="${pageContext.request.contextPath}/resources/css/order/orderListView.css">
</head>
	<body>
		<jsp:include page="../common/header.jsp" />
	
	    <div class="order-outer">
	        <div class="order-header">
	            <div class="order-header-wrap">
	                <a href="">찜한목록</a>
	            </div>
	        </div>
	        <div class="container">
	            <div class="sort-order-button">
	            </div>
	            <!-- 내가 찜 한 목록 보기 -->
	            <div id="dibsSelect" class="order-section">
	            </div>
	        </div>
		<br>
	    </div>
		<jsp:include page="../common/footer.jsp" />
	</body>

	<!-- 페이지 시작 시 초기화 -->
	<script>
		$(document).ready(function(){
			ajaxDibs();
		});
	</script>
	
	<!-- 찜 목록 불러오기 -->
	<script>
		function ajaxDibs(){
			$("#dibsSelect").children().remove();
			let memberNo = ${sessionScope.loginMember.memberNo};
			$.ajax({
				url : "selectDibs.gs",
				type : "post",
				data : {
					memberNo : memberNo
				},
				success(result){
					for(let i = 0; i < result.goods.length; i++)
					{
						let price = result.goods[i].price;
						let priceRE = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						
						let str = "";
						str += result.goods[i].goodsThumbnail
							+ "<div class='item-details'>"
								+ "<h3 style='padding-top:10px'>"
									+ result.goods[i].goodsName
								+ "</h3>"
							+ "</div>"
							+ "<div>"
								+ "<div class='item-price'>"
									+ priceRE
									+ "</div>"
									+ "<div class='button-group'>"
										+ "<button style='width:150px' onclick='dibsDelete("+ result.goods[i].goodsNo +")' class='deleteBtn'>"
											+ "찜 목록에서 제외"
										+ "</button>"
									+ "</div>"
									+ "<div class='button-group'>"
										+ "<button style='width:150px' onclick='gotoDetail("+ result.goods[i].goodsNo +")' class='gotoBtn'>"
											+ "상품 페이지로 이동"
										+ "</button>"
									+ "</div>"
								+ "</div>"
						let createDiv = document.createElement("div");
						createDiv.innerHTML=str;
						document.getElementById("dibsSelect").appendChild(createDiv);
					}
					$("#dibsSelect>div").addClass("order-item");
					$(".order-item>img").css("width", "170px").css("margin-top", "0px");
					
					$(".sort-order-button").text("찜 한 개수 : " + result.ListCount)
				},
				error(){
					alertify.success('서버와의 통신에<br>실패했습니다.');
				}
			});
		}
	</script>
	
	<!-- 찜 목록 제외 이벤트 -->
	<script>
		function dibsDelete(deleteNo){
			let deleteMemberNo = ${sessionScope.loginMember.memberNo};
			$.ajax({
				url : "ajaxDibsDelete.gs",
				type : "post",
				data : {
					goodsNo : deleteNo,
					memberNo : deleteMemberNo
				},
				success(){
					ajaxDibs();
					alertify.success('해당 상품을 찜 목록에서<br>삭제했습니다.');
				},
				error(){
					alertify.success('서버와의 통신에<br>실패했습니다.');
				}
			});
		}
	</script>

	<script>
		function gotoDetail(gotoNo){
			location.href="goodsDetail.gs?goodsNo="+gotoNo;
		}
	</script>
</html>