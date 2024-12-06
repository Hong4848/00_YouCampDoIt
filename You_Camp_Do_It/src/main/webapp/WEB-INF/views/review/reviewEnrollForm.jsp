<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Summernote CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.css" rel="stylesheet">
    
    
    <style>

        .content {
            display: flex;
            flex-direction: column; /* 수직 배치를 위한 플렉스 방향 설정 */
            align-items: center; /* 자식 요소들을 가운데 정렬 */
        }

         /* 메뉴바 스타일 */
        .main-side {
            width: 80%; /* 화면 전체 너비 */
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

        .main-content {
            flex: 1;
            padding: 30px;
        }
        .content-header {
            margin-bottom: 20px;
        }
        .content-header h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .write-form {
            width: 100%;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 10px;
        }
        .form-group input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .submit-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #0056b3;
        }


		.btn btn-secondary {
			height : 30px;
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
        <!-- 메인 콘텐츠 -->
        <div class="main-content">
            <div class="content-header">
                <h1>후기게시판</h1>
            </div>
            <div class="write-form">
                <form>
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" id="title" placeholder="Enter title">
                    </div>
                    <div class="form-group">
                        <label for="content">Content</label>
                        <div id="summernote"></div>
                    </div>
                    <a class="btn btn-info btn-sm" style="float:right;" href="enrollForm.re">글작성</a>
                </form>
            </div>
        </div>
    </div>

    </div>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Summernote JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.js"></script>
    
    
    <script>
	    $(document).ready(function () {
	        $('#summernote').summernote({
	        	width: 800,
	            height: 300, // 에디터 높이 설정
	            lang: 'ko-KR', // 언어 설정
	        });
	    });
    	
    </script>

<jsp:include page="../common/footer.jsp" />

</body>
</html>