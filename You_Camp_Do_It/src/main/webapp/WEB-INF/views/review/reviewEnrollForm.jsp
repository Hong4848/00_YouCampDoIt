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

		/* 사이드메뉴 클릭시 약간의 강조 효과 부여 */
        
        .sidebar h3 {
        	text-align: center; /* h3 태그를 가로로 중앙 정렬 */
		    margin-bottom: 20px; /* 아래로 여백 추가 */
		}
        
		/* 기본 스타일 */
		.sidebar ul {
		    display: flex; /* 한 줄로 정렬 */
		    justify-content: center; /* 항목들을 중앙에 정렬 */
		    margin: 0; /* 기본 마진 제거 */
		    padding: 0; /* 기본 패딩 제거 */
		    list-style: none; /* 기본 리스트 스타일 제거 */
		}
		
		.sidebar li {
		    margin: 20px; /* 항목 간격 추가 */
		    margin-right: 60px; /* 항목들 사이에 20px 간격 추가 */
		    padding-left  : 15px;
		}
		
		.sidebar  li:last-child {
		    margin-right: 0; /* 마지막 항목은 간격을 없앰 */
		  }
		
		.sidebar li a {
		    position: relative; /* 밑줄을 위한 기준 */
		    text-decoration: none; /* 기본 밑줄 제거 */
		    color: black; /* 텍스트 색상 */
		    font-size: 18px; /* 텍스트 크기 */
		    font-weight: bold;
		    transition: font-size 0.3s ease, color 0.3s ease; /* 부드러운 애니메이션 */
		}
		
		/* 마우스 오버 시 분홍색 밑줄 */
		.sidebar li a:hover::after {
		    content: "";
		    position: absolute;
		    left: 0;
		    bottom: -5px; /* 밑줄 위치 */
		    width: 100%; /* 밑줄 길이 */
		    height: 3px; /* 밑줄 두께 */
		    background-color: lightpink; /* 밑줄 색상 */
		}
		
		/* 클릭된 상태에서 밑줄 효과 유지 */
		.sidebar li a.active::after {
		    content: "";
		    position: absolute;
		    left: 0;
		    bottom: -5px; /* 밑줄 위치 */
		    width: 100%; /* 밑줄 길이 */
		    height: 3px; /* 밑줄 두께 */
		    background-color: lightpink; /* 밑줄 색상 */
		}
		
		/* 클릭된 상태 (active) */
		.sidebar li a.active {
		    color: blue; /* 클릭된 상태 텍스트 색상 */
		    font-size: 20px; /* 클릭된 상태에서 폰트 크기 증가 */
		}
		
		/* 메뉴바 효과 끝 */
        
        .main-side h1 {text-align: center;}



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
                        <li><a href="${ pageContext.request.contextPath }/list.no"><i class="fas fa-notice"></i>공지사항</a></li>
                        <li><a href="${ pageContext.request.contextPath }/list.re"><i class="fas fa-review"></i>후기게시판</a></li>
                        <li><a href="${ pageContext.request.contextPath }/list.lo"><i class="fas fa-lost"></i>분실물게시판</a></li>
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
	
    <script>
	// 사이드메뉴 클릭하였을 때, 노란밑줄과 확대효과 부여
	// 모든 링크 가져오기
	const links = document.querySelectorAll('.sidebar-menu li a');
	
	// 클릭 이벤트 처리
	link.addEventListener('click', (event) => {
	    event.preventDefault();
	    event.stopPropagation();
	
	    links.forEach(l => l.classList.remove('active'));
	    event.currentTarget.classList.add('active');
	});
	</script>


<jsp:include page="../common/footer.jsp" />

</body>
</html>