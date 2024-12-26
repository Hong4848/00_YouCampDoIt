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

		/*루트메뉴바*/
        .main-content {
            flex-grow: 1;
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

        /*목록조회table*/
        #noticeList tr td {text-align: center;} /*tbody안의 td 값만 가운데정렬됨...*/
        #noticeList>tbody>tr:hover {cursor:pointer;}


        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        #noticeList td {
		    word-wrap: break-word; /* 긴 텍스트 줄바꿈 */
		    overflow: hidden; /* 넘치는 텍스트 숨기기 */
		    text-overflow: ellipsis; /* 말줄임표 표시 */
		    white-space: nowrap; /* 텍스트 한 줄 유지 */
		}
		
		
		#noticeList th:nth-child(1),
		#noticeList td:nth-child(1) {
		    width: 15%; /* 글번호 열 */
		}
		
		#noticeList th:nth-child(2),
		#noticeList td:nth-child(2) {
		    width: 45%; /* 제목 열 */
		}
		
		#noticeList th:nth-child(3),
		#noticeList td:nth-child(3) {
		    width: 10%; /* 첨부파일여부 열 */
		}
		
		#noticeList th:nth-child(4),
		#noticeList td:nth-child(4) {
		    width: 10%; /* 조회수 열 */
		}
		
		#noticeList th:nth-child(5),
		#noticeList td:nth-child(5) {
		    width: 20%; /* 작성일 열 */
		}
		
		#noticeList {
		    table-layout: fixed; /* 열 크기 고정 */
		    width: 100%; /* 테이블 너비 고정 */
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
        
        /*글작성버튼*/
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
                <a href="list.no" class="active">공지사항</a>
                <a href="list.re">후기게시판</a>
                <a href="list.lo">분실물게시판</a>
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
            <form id="search-bar" action="list.no" method="get" align="right">
			    <div class="select">
			        <select class="custom-select" name="condition">
			            <option value="title" ${condition == 'title' ? 'selected' : ''}>제목</option>
			            <option value="content" ${condition == 'content' ? 'selected' : ''}>내용</option>
			        </select>
			    </div>
			    <div class="text">
			        <input type="text" name="keyword" placeholder="검색어를 입력하세요" value="${keyword}">
			    </div>
			    <button type="submit" class="btn btn-info">검색</button>
			</form>
			
            <!--게시판목록조회-->
            <table id="noticeList" class="table-hover" align="center">
                <thead>
                    <tr>
                        <th style="text-align: center;">글번호</th>
                        <th style="text-align: center;">제목</th>
                        <th style="text-align: center;">첨부파일</th>
                        <th style="text-align: center;">조회수</th>
                        <th style="text-align: center;">작성일</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="n" items="${ requestScope.list }">
	                    <tr>
	                        <td class="nno">${ n.noticeNo }</td>
	                        <td>${ n.noticeTitle }</td>
	                        <td>
	                        	<c:if test="${ not empty n.originName }">
	                        		✔
	                        	</c:if>
	                        </td>
	                        <td>${ n.count }</td>
	                        <td>${ n.createDate }</td>
	                    </tr>
	                </c:forEach>
                </tbody>
            </table>
            <br>

            <script>
            	// 게시글 하나를 나타내는 tr 태그에 클릭이벤트 걸기
            	$(function() {
            		
            		$("#noticeList>tbody>tr").click(function() {
            			
            			// 글번호 뽑기
            			// let bno = $(this).children().eq(0).text();
            			let nno = $(this).children(".nno").text();
            			
            			// 기존의 쿼리스트링 방식
            			location.href = "detail.no?nno=" + nno;
            			
            			// Path Variable 방식
            			// location.href = "board/" + bno;
            			// > url 주소 상에 글번호를 은근히 같이 넘김
            			//   (마치 경로인것 처럼)
            		});
            	});
            </script>

            
            <!-- 페이징 바 -->
         <div id="pagingArea">
                <ul class="pagination">
	                
	                <c:choose>
	                	<c:when test="${ requestScope.pi.currentPage eq 1 }">
		                    <li class="page-item disabled">
		                    	<a class="page-link" href="#">
		                    		Previous
		                    	</a>
		                    </li>
		                </c:when>
		                <c:otherwise>
		                	<li class="page-item">
		                    	<a class="page-link" href="list.no?cpage=${ requestScope.pi.currentPage - 1 }">
		                    		Previous
		                    	</a>
		                    </li>
		                </c:otherwise>
	                </c:choose>
                    
                    <c:forEach var="p" begin="${ requestScope.pi.startPage }"
                    				   end="${ requestScope.pi.endPage }" 
                    				   step="1">
                    	<c:choose>
                    		<c:when test="${ p ne requestScope.pi.currentPage }">			   
			                    <li class="page-item">
			                    	<a class="page-link" href="list.no?cpage=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
		                    </c:when>
		                    <c:otherwise>
		                    	<li class="page-item disabled">
			                    	<a class="page-link" href="list.no?cpage=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
	                    	</c:otherwise>
	                    </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ requestScope.pi.currentPage ne requestScope.pi.maxPage }">
                   			<li class="page-item">
                   				<a class="page-link" href="list.no?cpage=${ requestScope.pi.currentPage + 1 }">
                   					Next
                   				</a>
                   			</li>
                   		</c:when>
                   		<c:otherwise>
                   			<li class="page-item disabled">
                   				<a class="page-link" href="#">
                   					Next
                   				</a>
                   			</li>
                   		</c:otherwise>
                   	</c:choose>
                </ul>
            </div>

            <div id="writeBtn">
			    <c:if test="${ sessionScope.loginMember.memberId eq 'admin' }">
			        <!-- 로그인한 아이디가 'admin'일 경우 글작성 버튼 표시 -->
			        <button class="btn btn-primary" id="write" onclick="location.href='enrollForm.no'">글작성</button>
			    </c:if>
			</div>
            
 
        </div>
    </div> <!--content 영역 끝 -->
    
    
    <jsp:include page="../common/footer.jsp" />
    
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
    
</body>
</html>
