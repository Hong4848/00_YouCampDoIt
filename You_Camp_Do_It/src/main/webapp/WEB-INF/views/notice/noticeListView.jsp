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
            flex-grow: 1;
            padding: 20px;
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
        <div class="main-content">
            <!--루트메뉴바-->
            <div class="breadcrumb">
                <h4>ꉂ🤭︎ 공지사항</h4>
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
    
    <script>
 // 모든 링크 가져오기
    const links = document.querySelectorAll('.sidebar li a');

    // 클릭 이벤트 추가
    links.forEach(link => {
        link.addEventListener('click', (event) => {
            // 모든 링크에서 active 클래스 제거
            links.forEach(l => l.classList.remove('active'));

            // 클릭된 링크에 active 클래스 추가
            event.currentTarget.classList.add('active');
        });
    }
	</script>
    
</body>
</html>
