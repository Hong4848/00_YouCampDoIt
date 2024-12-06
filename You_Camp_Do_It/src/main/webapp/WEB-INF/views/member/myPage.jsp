<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 및 활동</title>
    <style>
        /*body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffe7e7;
        }*/

        /* 헤더 스타일 */
        .myPage-header {
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            padding: 15px 20px;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .myPage-header h1 {
            font-size: 20px;
            margin: 0;
            color: #333;
        }

        /* 배경 이미지 */
        .main-img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1; /* 뒤쪽에 배치 */
            overflow: hidden;
        }

        .main-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* 컨테이너 */
        .container {
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

    <!-- 배경 이미지 -->
    <!-- 
    <div class="main-img">
        <img src="https://www.syu.ac.kr/wp-content/uploads/2021/11/%ED%98%B8%ED%94%84%EC%BA%A0%ED%94%84-%EC%B2%B4%ED%97%98%EA%B8%B0-1-%EC%9D%B8%EC%84%B1%EA%B5%90%EC%9C%A1%EC%9B%90-%EC%A0%9C%EA%B3%B5-scaled.jpg" 
             alt="배경 이미지">
    </div>
     -->

    <!-- 마이페이지 헤더 -->
    <div class="myPage-header">
        <h1>마이페이지</h1>
    </div>

    <div class="container">
        <!-- 프로필 섹션 -->
        <div class="profile-section">
            <div class="profile-info">
                <span class="profile-userId">test123아이디 님</span>
                <a href="#">개인정보수정 / 탈퇴</a>
            </div>
        </div>

        <!-- 메뉴 섹션 -->
        <div class="menu-section">
            <a href="#1" class="menu-item">
                <img src="https://via.placeholder.com/40" alt="결제 내역 아이콘">
                <span>결제 내역</span>
            </a>
            <a href="#2" class="menu-item">
                <img src="https://via.placeholder.com/40" alt="장바구니 아이콘">
                <span>장바구니</span>
            </a>
            <a href="#3" class="menu-item">
                <img src="https://via.placeholder.com/40" alt="대여내역 아이콘">
                <span>대여내역</span>
            </a>
            <a href="#4" class="menu-item">
                <img src="https://via.placeholder.com/40" alt="예약내역 아이콘">
                <span>예약내역</span>
            </a>
        </div>

        <div class="menu-section">
            <a href="#5" class="menu-item">
                <img src="https://via.placeholder.com/40" alt="내가 쓴 글 아이콘">
                <span>내가 쓴 글</span>
            </a>
            <a href="#6" class="menu-item">
                <img src="https://via.placeholder.com/40" alt="내가 쓴 댓글 아이콘">
                <span>내가 쓴 댓글</span>
            </a>
            <a href="#7" class="menu-item">
                <img src="https://via.placeholder.com/40" alt="좋아요한 글 아이콘">
                <span>좋아요한 글</span>
            </a>
            <a href="#8" class="menu-item">
                <img src="https://via.placeholder.com/40" alt="찜한 물품 아이콘">
                <span>찜한 물품</span>
            </a>
        </div>
    </div>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>
