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
        	margin:auto;
            display: flex;
            width : 1200px;
        }
        /*사이드메뉴바*/
        .main-side{padding: 20px;}
        .sidebar {
            width: 250px;
            background-color: #4CAF50;
            color: white;
            height: 50%;
            padding: 20px;
        }
        .sidebar hr {background-color : #C63C51;}

        .sidebar h1 {
            margin-bottom: 15px;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }
        .sidebar li {
            margin-bottom: 15px;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        .sidebar i {
            margin-right: 10px;
        }
        .sidebar ul li a:hover {
            background-color: #8dd384bd;
            border-radius: 5px;
        }


        .main-content {
            flex-grow: 1;
            padding: 20px;
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

        /*목록조회table*/
        #boardList tr td {text-align: center;} /*tbody안의 td 값만 가운데정렬됨...*/
        #boardList>tbody>tr:hover {cursor:pointer;}

        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }

        /*페이징바*/
        #pagingArea {width:fit-content; margin:auto;}

    </style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
    <div class="content">
        <!--사이드메뉴바-->
        <div class="main-side">
            <div class="sidebar">          
                <h3>커뮤니티</h3>
                <hr>
                <div>
                    <ul>
                        <li><a href="#"><i class="fas fa-notice"></i> 공지사항</a></li>
                        <li><a href="#"><i class="fas fa-review"></i> 후기게시판</a></li>
                        <li><a href="#"><i class="fas fa-lost"></i> 분실물게시판</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="main-content">
            <!--루트메뉴바-->
            <div class="breadcrumb">
                <h2>공지사항</h2>
                <ul>
                    <li>홈</li>
                    <li>커뮤니티</li>
                    <li>공지사항</li>
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
            <!--게시판목록조회-->
            <table id="boardList" class="table-hover" align="center">
                <thead>
                    <tr>
                        <th style="text-align: center;">번호</th>
                        <th style="text-align: center;">제목</th>
                        <th style="text-align: center;">작성자</th>
                        <th style="text-align: center;">조회수</th>
                        <th style="text-align: center;">등록일</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>5</td>
                        <td>2024년 새해맞이 이벤트 안내</td>
                        <td>관리자</td>
                        <td>1234</td>
                        <td>2024.01.10</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>겨울 캠프 참가자 모집</td>
                        <td>관리자</td>
                        <td>856</td>
                        <td>2024.01.09</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>12월 정기 점검 안내</td>
                        <td>관리자</td>
                        <td>567</td>
                        <td>2024.01.08</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>신규 프로그램 오픈 안내</td>
                        <td>관리자</td>
                        <td>890</td>
                        <td>2024.01.07</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>홈페이지 이용 안내</td>
                        <td>관리자</td>
                        <td>432</td>
                        <td>2024.01.06</td>
                    </tr>
                </tbody>
            </table>
            <br>
            <!-- 페이징 바 -->
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
        </div>
    </div> <!--content 영역 끝 -->
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>