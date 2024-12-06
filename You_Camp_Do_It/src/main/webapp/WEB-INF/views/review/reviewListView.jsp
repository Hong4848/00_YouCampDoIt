<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>

        .content {
            display: flex;
            flex-direction: column; /* 수직 배치를 위한 플렉스 방향 설정 */
            align-items: center; /* 자식 요소들을 가운데 정렬 */
        }



        /* 메뉴바 스타일 */
        .main-side {
            width: 60%; /* 화면 전체 너비 */
            padding: 10px; /* 내부 여백 설정 */
            text-align: center; /* 텍스트 중앙 정렬 */
            display: flex; /* 가로로 정렬 */
            justify-content: center; /* 메뉴 항목을 가운데 정렬 */
        }

        .sidebar {
            width: 100%; /* 화면 전체 너비 */
            max-width: 800px; /* 메뉴바 최대 너비 */
            padding: 10px 0;

        }
        
        .main-side h1 {text-align: center;}

        .sidebar  ul {
            display: flex; /* 가로로 정렬 */
            justify-content: center; /* 메뉴 항목을 가운데 정렬 */
            list-style: none; /* 기본 리스트 스타일 제거 */
            margin: 0;
            padding: 0;
        }

        .sidebar  ul li {
            margin: 0 15px; /* 메뉴 항목 간격 */
        }

        .sidebar  ul li a {
            text-decoration: none; /* 밑줄 제거 */
            color: black; /* 텍스트 색상 */
            font-size: 16px; /* 글씨 크기 */
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .sidebar  ul li a:hover {
            color: #ffcc00; /* 호버 시 색상 변경 */
        }
    

        /*루트메뉴바*/
        .main-content {
            flex: 1;
            margin-top: 20px; /* 상단 메뉴와의 간격 조정 */
            width: 60%; /* main-side와 동일한 너비 */
        }
        .breadcrumb {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .breadcrumb ul {
            list-style-type: none;
            padding: 0;
            display: flex;
        }
        .breadcrumb li:not(:last-child)::after {
            content: ">";
            margin: 0 5px;
        }



        /*검색창*/
        #search-bar {        
            display: flex;
            justify-content: flex-end; /*오른쪽정렬*/
            align-items: center; /* 세로 정렬 */
            gap: 10px; /* 요소 간 간격 */
            margin-bottom : 15px;
        }
        
        .select, .text, .btn {
            margin: 0;
        }

        .custom-select {
            padding: 5px; /* 선택 박스 여백 */
            padding-right: 25px; /* 화살표 영역 확보 */
        }

        .text input {
            padding: 5px;
            width: 200px; /* 입력창 너비 */
            border-radius: 8px; /* 모서리 둥글게 */
        }

      
        /*후기게시판썸네일목록조회*/
        #content_sub_wrap {
            width: 100%;
            margin: 0 auto;
            padding: 0;
            box-sizing: border-box;
        }

        .content_sub_wrap_box {
            display: flex;
            justify-content: center;
        }

        table.listThmb {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        table.listThmb td {
            width: 25%; /* 한 행에 4개의 게시글이 들어가도록 설정 */
            padding: 10px;
            text-align: center;
            vertical-align: top;
        }

        table.listThmb td a {
            display: block;
            text-decoration: none;
            color: #333;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.3s ease;
            background: #f9f9f9;
            padding: 10px;
        }

        table.listThmb td a:hover {
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            transform: translateY(-5px);
            background: #fff;
        }

        /* 이미지 스타일 */
        table.listThmb td img {
            width: 100%;
            height: auto;
            border-bottom: 1px solid #ddd;
            margin-bottom: 10px;
        }

        /* 날짜 스타일 */
        table.listThmb td .date {
            display: block;
            font-size: 14px;
            color: #999;
            margin-bottom: 5px;
            text-align: left; /* 왼쪽 정렬 */
        }

        /* 제목 한 줄 제한 및 ... 표시 */
        table.listThmb td .title {
            display: block;
            font-size: 16px;
            font-weight: bold;
            color: #333;
            line-height: 1.4em;
            height: 1.4em; /* 한 줄 높이만 허용 (1.4em * 2) */
            overflow: hidden; /* 넘치는 텍스트 숨기기 */
            text-overflow: ellipsis; /* ... 표시 */
            white-space: nowrap; /* 줄 바꿈 방지 */
            word-wrap: break-word; /* 단어가 너무 길면 줄바꿈 */
        }

        

        /*페이징바*/
        #area {
            display: flex;
            justify-content: space-between; /* 좌우로 배치 */
            width: 100%; /* 부모 요소 너비 설정 */
        }
        #pagingArea {
            display: flex;
            margin : 0 auto; /* 가운데 정렬 */
        }
        #write {
            border : none;
            height: 35px;
        }
        #writeBtn {
            display: flex;
            justify-content: flex-end; /* 버튼을 오른쪽 끝으로 배치 */
        }

    </style>
</head>
<body>
	
	<jsp:include page="../common/header.jsp" />
	
    <div class="content">
        <!--사이드메뉴바-->
        <div class="main-side">
            <div class="sidebar">          
                <h3>커뮤니티</h3>
                <br>
                <div>
                    <ul>
                        <li><a href="#"><i class="fas fa-notice"></i>공지사항</a></li>
                        <li><a href="#"><i class="fas fa-review"></i>후기게시판</a></li>
                        <li><a href="#"><i class="fas fa-lost"></i>분실물게시판</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="main-content">
            <!--루트메뉴바-->
            <div class="breadcrumb">
                <h4>ꉂ🤭︎ 후기게시판</h4>
                <ul>
                    <li>홈</li>
                    <li>커뮤니티</li>
                    <li>후기게시판</li>
                </ul>
            </div>
            <!--검색창-->
            <form id="search-bar" action="" method="get" align="right">
                <div class="select">
                    <select class="custom-select" name="condition">
                        <option value="title">제목</option>
                        <option vlaue="content">내용</option>
                        <option value="writer">작성자</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" name="keyword" placeholder="검색어를 입력하세요">
                </div>
                <button type="button" class="btn btn-info">검색</button>
            </form>
            <!--후기게시판(사진)목록조회-->
            <div id="content_sub_wrap">
                <div class="content_sub_wrap_box">
                    <table class="listThmb">
                        <tbody>
                            <tr>
                                <td>
                                    <a href="/contextroot1">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example2.jpg" alt="게시글1">
                                        <span class="date">2024. 10. 14</span>
                                        <span class="title">재미있는 캠핑이였습니다. 하하하 호호호호 글씨가 넘어가나요???</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot2">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example2.jpg" alt="게시글 이미지 2">
                                        <span class="date">2024. 11. 01</span>
                                        <span class="title">가을 풍경이 아름다웠어요.</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot3">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example3.jpg" alt="게시글 이미지 3">
                                        <span class="date">2024. 12. 06</span>
                                        <span class="title">즐거운 겨울 여행!</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot4">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example3.jpg" alt="게시글 이미지 3">
                                        <span class="date">2024. 12. 06</span>
                                        <span class="title">즐거운 겨울 여행!</span>
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="/contextroot5">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example4.jpg" alt="게시글 이미지 4">
                                        <span class="date">2024. 09. 20</span>
                                        <span class="title">여름 바다에서의 추억</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot6">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example5.jpg" alt="게시글 이미지 5">
                                        <span class="date">2024. 08. 15</span>
                                        <span class="title">산속에서 힐링하기</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot7">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example6.jpg" alt="게시글 이미지 6">
                                        <span class="date">2024. 07. 10</span>
                                        <span class="title">초여름의 숲속 캠핑</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot8">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example3.jpg" alt="게시글 이미지 3">
                                        <span class="date">2024. 12. 06</span>
                                        <span class="title">즐거운 겨울 여행!</span>
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="/contextroot9">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example4.jpg" alt="게시글 이미지 4">
                                        <span class="date">2024. 09. 20</span>
                                        <span class="title">여름 바다에서의 추억</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot10">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example5.jpg" alt="게시글 이미지 5">
                                        <span class="date">2024. 08. 15</span>
                                        <span class="title">산속에서 힐링하기</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot11">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example6.jpg" alt="게시글 이미지 6">
                                        <span class="date">2024. 07. 10</span>
                                        <span class="title">초여름의 숲속 캠핑</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot12">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example3.jpg" alt="게시글 이미지 3">
                                        <span class="date">2024. 12. 06</span>
                                        <span class="title">즐거운 겨울 여행!</span>
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="/contextroot13">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example4.jpg" alt="게시글 이미지 4">
                                        <span class="date">2024. 09. 20</span>
                                        <span class="title">여름 바다에서의 추억</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot14">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example5.jpg" alt="게시글 이미지 5">
                                        <span class="date">2024. 08. 15</span>
                                        <span class="title">산속에서 힐링하기</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot15">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example6.jpg" alt="게시글 이미지 6">
                                        <span class="date">2024. 07. 10</span>
                                        <span class="title">초여름의 숲속 캠핑</span>
                                    </a>
                                </td>
                                <td>
                                    <a href="/contextroot16">
                                        <span class="tbumb_hover"></span>
                                        <img src="images/example3.jpg" alt="게시글 이미지 3">
                                        <span class="date">2024. 12. 06</span>
                                        <span class="title">즐거운 겨울 여행!</span>
                                    </a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <br>
            <!-- 페이징 바 와 글작성 버튼-->
            <div id="area">
                <div id="pagingArea">
                    <ul class="pagination">
                        <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">4</a></li>
                        <li class="page-item"><a class="page-link" href="#">5</a></li>
                        <li class="page-item"><a class="page-link" href="#">Next</a></li>
                    </ul>
                </div>
                <div id="writeBtn">
                	<!-- 로그인 상태일 경우만 보여지는 글쓰기 버튼 -->
               	    <button class="btn btn-primary" id="write" onclick="location.href='enrollForm.re'">글작성</button>
                </div>
            </div> 
        </div>
    </div> <!--content 영역 끝 -->
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>