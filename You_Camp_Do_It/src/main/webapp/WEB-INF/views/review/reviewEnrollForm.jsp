<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<!-- Popper.js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
	
	<!-- Bootstrap -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	

	<!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Summernote CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.css" rel="stylesheet">
    
    <!-- Summernote JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.js"></script>
    
    
   
    
    
    <style>

        .content {
            display: flex;
            flex-direction: column; /* 수직 배치를 위한 플렉스 방향 설정 */
            align-items: center; /* 자식 요소들을 가운데 정렬 */
        }

         /* 메뉴바 스타일 */
		.main-side {
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 700;
            height: 100px;
            background-color: white;
            width: 100%;
            margin: 0 auto;
        }

        .sidebar {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .sidebar a {
            text-decoration: none;
            font-size: 18px;
            color: #333;
            padding: 10px 20px;
            margin-right: 20px;
            border-bottom: 3px solid transparent;
        }

        .sidebar a.active {
            color: #f7b500;
            border-bottom: 3px solid #f7b500;
        }

        .sidebar a:hover {
            color: #f7b500;
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
                <a href="list.no">공지사항</a>
                <a href="list.re" class="active">후기게시판</a>
                <a href="list.lo">분실물게시판</a>
            </div>
        </div>
        <!-- 메인 콘텐츠 -->
        <div class="main-content">
            <div class="content-header">
                <h1>후기게시판</h1>
            </div>
            
				<div class="write-form">
				    <form action="/review/enrollForm.re" method="GET">
				        <div class="form-group">
				            <label for="title">Title</label>
				            <input type="text" id="title" name="title" placeholder="Enter title">
				        </div>
				        <div class="form-group">
				            <label for="content">Content</label>
				            <!-- Summernote의 데이터를 저장할 textarea 추가 -->
				            <textarea id="summernote" name="content"></textarea>
				        </div>
				        <button type="submit" class="btn btn-info btn-sm" style="float:right;">글작성</button>
				    </form>
				</div>

        </div>
    </div>

    
    <script>
    $(document).ready(function () {
        $('#summernote').summernote({
            width: 800,
            height: 300, // 에디터 높이 설정
            lang: 'ko-KR', // 언어 설정
        });

        // 폼 제출 시 Summernote 데이터를 textarea에 저장
        $('form').on('submit', function (e) {
            let content = $('#summernote').val(); // 에디터 내용 가져오기
            if ($('#title').val().trim() === '' || content.trim() === '') {
                alert("제목과 내용을 입력해주세요.");
                e.preventDefault(); // 폼 제출 방지
                return false;
            }
        });
    });


    	
    </script>
	<!-- 사이드메뉴바 스크립트 -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const links = document.querySelectorAll(".sidebar a");

            links.forEach(link => {
                link.addEventListener("click", function () {
                    // 모든 a 태그에서 active 클래스 제거
                    links.forEach(item => item.classList.remove("active"));
                    // 클릭된 a 태그에 active 클래스 추가
                    this.classList.add("active");
                });
            });
        });
    </script>


<jsp:include page="../common/footer.jsp" />

</body>
</html>