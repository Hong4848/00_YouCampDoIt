<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&icon_names=heart_check" />
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


        /*상세조회스타일*/
        table * {margin:5px;}
        table {width:100%;}

        #buttoncentroller {
            display: flex;
            justify-content: flex-end; /*오른쪽정렬*/
            gap: 5px; /* 요소 간 간격 */
        }
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
	<div class="content">
        <br><br>
        <div class="main-side">
	        <div class="main-side">
	            <div class="sidebar">          
	                <a href="list.no" class="active">공지사항</a>
	                <a href="list.re">후기게시판</a>
	                <a href="list.lo">분실물게시판</a>
	            </div>
	        </div>
        </div>
        <div class="main-content">
            <!--루트메뉴바-->
            <div class="breadcrumb">
                <h4>공지사항 상세보기</h4>
                <ul>
                    <li>홈</li>
                    <li>커뮤니티</li>
                    <li>분실물게시판</li>
                </ul>
            </div>
            
            <br><br>

			<table id="contentArea" align="center" class="table table-bordered">
            	<tr>
            		<th>제목</th>
            		<td colspan="3">${ requestScope.n.noticeTitle }</td>
            	</tr>
			    <tr>
			        <th width="100">작성자</th>
			        <td width="220">관리자</td>
			        <th width="100">작성일시</th>
			        <td width="220">${ requestScope.n.createDate }</td>
			    </tr>

                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                       
                    	<c:choose>
                    		<c:when test="${ empty requestScope.n.originName }">
                        		첨부파일이 없습니다.
                        	</c:when>
                        	<c:otherwise>
                        		<a href="${ pageContext.request.contextPath }/${ requestScope.n.changeName }" download="${ requestScope.n.originName }">
                        			${ requestScope.n.originName }
                        		</a>
                        	</c:otherwise>
                        </c:choose>
                       
                    </td>
                </tr>

			    <tr>
			        <th>내용</th>
			        <td colspan="3">
						<p style="height:150px;">${ requestScope.n.noticeContent }</p>
			        </td>
			    </tr>
            </table>

			<c:if test="${ sessionScope.loginUser.userId eq requestScope.n.noticeWriter }">
	            <div align="center" id="buttoncentroller">
                    <a class="btn btn-warning btn-sm" href="../list.no">목록</a>
	            </div>
	            
	            <form id="postForm" action="" method="post">
	            	<input type="hidden" name="nno" value="${ requestScope.n.noticeNo }">
	            	<input type="hidden" name="filePath" value="${ requestScope.n.changeName }">
	            </form>
	            
	            <script>
	            	function postFormSubmit(num) {
	            		// console.log(num);
	            		// > num 이 1 일 경우 게시글 수정 페이지를 요청 (updateForm.no)
	            		//   num 이 2 일 경우 게시글 삭제 요청 (delete.no)
	            		
	            		// 위의 form 태그의 action 속성값을 상황에 따라 알맞게 지정 후
	            		// 곧바로 submit 시키기!!
	            		// attr : 기타 속성
	            		if(num == 1) { // 수정하기를 클릭했을 경우
	            			$("#postForm").attr("action", "../updateForm.no").submit();
	            			// > 제이쿼리의 submit 메소드 : 해당 form 의 submit 버튼을 클릭한 효과
	            		} else { // 삭제하기를 클릭했을 경우
	            			$("#postForm").attr("action", "${ pageContext.request.contextPath }/delete.no").submit();
	            		}
	            	}
	            </script>
	            
            </c:if>
            
            <br><br>



            <hr>
            <table id="writeArea" class="table">
	            <div class="my-3 p-3 bg-white rounded shadow-sm">
					<c:choose >
					<c:when test="${move.next != 9999}">
						다음글 |<a href="/board/readView?bno=${move.next}" style="color: black"> ${move.nexttitle} </a>
					</c:when>
					
					<c:when test="${move.next == 9999}">
						다음글이 없습니다
					</c:when>
					</c:choose>
					<br/>
					<c:choose>
					<c:when test="${move.last != 9999}">
						이전글 |<a href="/board/readView?bno=${move.last}" style="color: black"> ${move.lasttitle} </a>
					</c:when>
					
					<c:when test="${move.last == 9999}">
						이전글이 없습니다
					</c:when>
					</c:choose>
				
				</div>
            </table>
            
        </div>
        <br><br>

    </div>
    
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