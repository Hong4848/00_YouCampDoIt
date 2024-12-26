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
	<script>
		$(document).ready(function(){
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
						let str = "";
						console.log(result[i]);
						str += result.goods[i].goodsThumbnail
							+ "<div class='item-details'>"
								+ "<h3 style='padding-top:10px'>"
									+ result.goods[i].goodsName
								+ "</h3>"
							+ "</div>"
							+ "<div>"
								+ "<div class='item-price'>"
									+ result.goods[i].price
									+ "</div>"
									+ "<div class='button-group'>"
										+ "<button style='width:150px' id='dibsDelete'>"
											+ "찜 목록에서 제외"
										+ "</button>"
									+ "</div>"
									+ "<div class='button-group'>"
										+ "<button style='width:150px' id='gotoDetail'>"
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
					console.log("에러")
				}
			});
		});
	</script>
</html>