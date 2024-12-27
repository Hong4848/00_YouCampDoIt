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
        .content_sub_wrap_box {
            display: flex;
            justify-content: center;
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
            height: 180px;
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
        .pagination {
		    display: flex;
		    justify-content: center; /* 수평 가운데 정렬 */
		    align-items: center;    /* 수직 가운데 정렬 */
		    margin-top: 20px;       /* 위쪽 여백 추가 */
		    gap: 10px;              /* 버튼 사이 간격 */
		}
        #write {
            border : none;
            height: 35px;
        }
        #writeBtn {
            display: flex;
            justify-content: flex-end; /* 버튼을 오른쪽 끝으로 배치 */
        }
        
        #content_sub_wrap {
		    display: flex; /* 플렉스박스를 사용하여 내부 요소 정렬 */
		    justify-content: center; /* 가로 중앙 정렬 */
		    align-items: center; /* 세로 중앙 정렬 */
		    position: relative; /* 기준 위치 설정 */
		    width: 100%; /* 너비를 컨테이너 전체로 설정 */
		    height: 400px; /* 현재 높이에 맞게 설정 */
		}
		
		.center-image {

		    margin-right: 20px;
		}
		
		.center-image img {
		    max-width: 100%; /* 이미지가 컨테이너를 넘지 않도록 설정 */
		    max-height: 100%; /* 이미지가 높이를 초과하지 않도록 설정 */
		    margin: auto; /* 여백 자동 정렬 */
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
                <a href="list.re">후기게시판</a>
                <a href="list.lo" class="active">분실물게시판</a>
            </div>
        </div>
        <div class="main-content">
            <!--루트메뉴바-->
            <div class="breadcrumb">
                <h4>ꉂ🤭︎ 분실물게시판</h4>
                <ul>
                    <li>홈</li>
                    <li>커뮤니티</li>
                    <li>분실물게시판</li>
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
            <!--분실물게시판(사진)목록조회-->
            <div id="content_sub_wrap">
			    <div class="content_sub_wrap_box">
			        <table class="listThmb">
			            <tbody>
			                <c:forEach items="${requestScope.list}" var="lost" varStatus="status">
			                    <c:if test="${status.index % 4 == 0}">
			                        <tr>
			                    </c:if>
			                    <td>
			                        <a href="${pageContext.request.contextPath }/detail.lo?lostNo=${review.lostNo}">
			                            <span class="tbumb_hover"></span>
			                            <img src="${pageContext.request.contextPath}${lost.mainImage}" alt="${lost.lostTitle}">
			                            <span class="date">${lost.createDate}</span>
			                            <span class="title">${lost.reviewTitle}</span>
			                        </a>
			                    </td>
			                    <c:if test="${status.index % 4 == 3 || status.last}">
			                        </tr>
			                    </c:if>
			                </c:forEach>
			            </tbody>
			        </table>
			
			        <div id="content_sub_wrap">
					    <!-- 가운데 정렬할 이미지 -->
					    <div class="center-image">
					        <img src="resources/images/lost/roding.png">
					    </div>
					</div>
			    </div>
			</div>

            <br>
            <!-- 페이징 바 와 글작성 버튼-->
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
		                    	<a class="page-link" href="list.lo?cpage=${ requestScope.pi.currentPage - 1 }">
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
			                    	<a class="page-link" href="list.lo?cpage=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
		                    </c:when>
		                    <c:otherwise>
		                    	<li class="page-item disabled">
			                    	<a class="page-link" href="list.lo?cpage=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
	                    	</c:otherwise>
	                    </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ requestScope.pi.currentPage ne requestScope.pi.maxPage }">
                   			<li class="page-item">
                   				<a class="page-link" href="list.lo?cpage=${ requestScope.pi.currentPage + 1 }">
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
            <%--
            <div id="writeBtn">
			    <c:if test="${ sessionScope.loginMember.memberId eq 'admin' }">
			        <!-- 로그인한 아이디가 'admin'일 경우 글작성 버튼 표시 -->
			        <button class="btn btn-primary" id="write" onclick="location.href='enrollForm.lo'">글작성</button>
			    </c:if>
			</div>
			--%>
            
        </div>
    </div> <!--content 영역 끝 -->
    
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