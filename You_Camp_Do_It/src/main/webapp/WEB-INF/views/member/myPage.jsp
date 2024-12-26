<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 및 활동</title>
    <style>
        
        .myPage-outer{
			margin-top: 0; /* 상단 여백 제거 */
		    padding-top: 0; /* 내부 여백 제거 */
		    background-color: #f8f8f8; /* 배경색 유지 */
		}
		
		/* 헤더부분 */
		.myPage-header {
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

        .myPage-header-wrap a {
            text-decoration: none;
            font-size: 18px;
            color: #333;
            padding: 10px 20px;
            margin-right: 20px;
            border-bottom: 3px solid transparent;
        }

        .myPage-header-wrap a:first-child {
            color: #f7b500;
            border-bottom: 3px solid #f7b500;
        }

        .myPage-header-wrap a:hover {
            color: #f7b500;
        }
        

        /* 컨테이너 */
        .myPage-container {
            position: relative;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.4); /* 배경 투명도 부여 */
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* 프로필 섹션 */
        .profile-section {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #ddd;
        }

        .profile-info {
            flex-grow: 1;
            display: flex; /* Flexbox 활성화 */
            justify-content: space-between; /* 좌우 요소 분리 */
            align-items: center; /* 수직 가운데 정렬 */
        }

        .profile-info .profile-userId {
            display: inline-block;
            padding: 8px 16px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 4px;
            background-color: #fff;
            color: #333;
            text-align: left;
        }

        .profile-info a {
            display: inline-block;
            padding: 8px 16px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            background-color: #fff;
            color: #333;
            transition: background-color 0.2s ease-in-out;
            text-align: right;
        }

        .profile-info a:hover {
            background-color: #f0f0f0;
        }

        /* 메뉴 섹션 */
        .menu-section {
            display: flex;
            flex-wrap: wrap;
            gap: 100px;
            padding: 20px;
            justify-content: center;
        }

        .menu-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 120px;
            height: 100px;
            border: 1px solid #ddd;
            border-radius: 8px;
            text-align: center;
            background-color: #f9f9f9;
            cursor: pointer;
            text-decoration: none; /* a 태그 스타일링 */
        }

        .menu-item:hover {
            background-color: #f0f0f0;
        }

        .menu-item img {
            width: 40px;
            height: 40px;
            margin-bottom: 10px;
        }

        .menu-item span {
            font-size: 16px; /* 글씨 크기 키움 */
            font-weight: bold; /* 글씨 굵게 */
            color: #333;
        }
    </style>
</head>
<body>

    <jsp:include page="../common/header.jsp" />

    <div class="myPage-outer">
    

	    <!-- 마이페이지 헤더 -->
	    <div class="myPage-header">
            <div class="myPage-header-wrap">
                <a href="">마이페이지</a>
            </div>
        </div>
	
	    <div class="myPage-container">
	        <!-- 프로필 섹션 -->
	        <div class="profile-section">
	            <div class="profile-info">
	                <span class="profile-userId">${sessionScope.loginMember.memberId} 님</span>
	                <a href="${ pageContext.request.contextPath }/updateForm.me">
	                	개인정보수정 / 탈퇴
	                </a>
	            </div>
	        </div>
	
	        <!-- 메뉴 섹션 -->
	        <div class="menu-section">
	            <!--<a href="" class="menu-item">
	                <img src="resources/images/member/PaymentDetailsIcon.png" alt="결제 내역 아이콘">
	                <span>결제내역</span>
	            </a>-->
	            <a href="${ pageContext.request.contextPath }/listForm.ca" class="menu-item">
	                <img src="resources/images/member/CartIcon.png" alt="장바구니 아이콘">
	                <span>장바구니</span>
	            </a>
	            <a href="${ pageContext.request.contextPath }/list.or" class="menu-item">
	                <img src="resources/images/member/GoodsRentalIcon.png" alt="대여내역 아이콘">
	                <span>대여내역</span>
	            </a>
	            <a href="${ pageContext.request.contextPath }/reserveList.res" class="menu-item">
	                <img src="resources/images/member/ReservationListIcon.png" alt="예약내역 아이콘">
	                <span>예약내역</span>
	            </a>
	        </div>
	
	        <div class="menu-section">
	            <a href="${ pageContext.request.contextPath }/myList.re" class="menu-item">
	                <img src="resources/images/member/MyScriptIcon.png" alt="내가 쓴 글 아이콘">
	                <span>내가 쓴 글</span>
	            </a>
	            <a href="#6" class="menu-item">
	                <img src="resources/images/member/MyReplyIcon.png" alt="내가 쓴 댓글 아이콘">
	                <span>내가 댓글 쓴 글</span>
	            </a>
	            <a href="${ pageContext.request.contextPath }/myLikedList.re" class="menu-item">
	                <img src="resources/images/member/MyLikeIcon.png" alt="좋아요한 글 아이콘">
	                <span>좋아요한 글</span>
	            </a>
	            <a href="${ pageContext.request.contextPath }/myDibs.me" class="menu-item">
	                <img src="resources/images/member/MyGoodIcon.png" alt="찜한 물품 아이콘">
	                <span>찜한 물품</span>
	            </a>
	        </div>
	    </div>
	<br>
	</div>    

	<jsp:include page="../common/footer.jsp" />

</body>
</html>
