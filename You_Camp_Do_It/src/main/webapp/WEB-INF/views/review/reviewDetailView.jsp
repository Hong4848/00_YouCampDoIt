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
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&icon_names=heart_check" />
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

	<div class="content">
        <br><br>
        <div class="main-side">
            <div class="sidebar">          
                <h3>커뮤니티</h3>
                <br>
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
                <h4>후기게시판 상세보기</h4>
                <ul>
                    <li>홈</li>
                    <li>커뮤니티</li>
                    <li>후기게시판</li>
                </ul>
            </div>
            
            <br><br>

            <table id="contentArea" align="center" class="table table-bordered">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">제목이들어갈자리</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>관리자</td>
                    <th>작성일</th>
                    <td>2024.12.01</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                        <!--
                    	<c:choose>
                    		<c:when test="${ empty requestScope.b.originName }">
                        		첨부파일이 없습니다.
                        	</c:when>
                        	<c:otherwise>
                        		<a href="${ pageContext.request.contextPath }/${ requestScope.b.changeName }" download="${ requestScope.b.originName }">
                        			${ requestScope.b.originName }
                        		</a>
                        	</c:otherwise>
                        </c:choose>
                        -->
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4">
                    	<p style="height:150px;">내용이 들어갈 자리</p>
                    </td>
                </tr>
            </table>

			<c:if test="${ sessionScope.loginUser.userId eq requestScope.b.boardWriter }">
	            <div align="center" id="buttoncentroller">
	                <!-- 
	                	수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 
	                	또한, url 주소상에 해당 게시글의 bno 가 보여지면 안됨~ 그래서 POST방식
	                	으로 변경해주어야 한다~~
	                -->
                    <a class="btn btn-danger btn-sm">
                        <span class="material-symbols-outlined">
                        heart_check
                        </span>
                    </a>
	                <a class="btn btn-success btn-sm" onclick="postFormSubmit(1);">
	               		수정
	                </a>
	                <a class="btn btn-info btn-sm" onclick="postFormSubmit(2);">
	                	삭제
	                </a>
                    <a class="btn btn-warning btn-sm" href="">목록</a>

	            </div>
	            
	            <form id="postForm" action="" method="post">
	            	<input type="hidden" name="bno" value="${ requestScope.b.boardNo }">
	            	<input type="hidden" name="filePath" value="${ requestScope.b.changeName }">
	            </form>
	            
	            <script>
	            	function postFormSubmit(num) {
	            		// console.log(num);
	            		// > num 이 1 일 경우 게시글 수정 페이지를 요청 (updateForm.bo)
	            		//   num 이 2 일 경우 게시글 삭제 요청 (delete.bo)
	            		
	            		// 위의 form 태그의 action 속성값을 상황에 따라 알맞게 지정 후
	            		// 곧바로 submit 시키기!!
	            		// attr : 기타 속성
	            		if(num == 1) { // 수정하기를 클릭했을 경우
	            			$("#postForm").attr("action", "../updateForm.bo").submit();
	            			// > 제이쿼리의 submit 메소드 : 해당 form 의 submit 버튼을 클릭한 효과
	            		} else { // 삭제하기를 클릭했을 경우
	            			$("#postForm").attr("action", "${ pageContext.request.contextPath }/delete.bo").submit();
	            		}
	            	}
	            </script>
	            
            </c:if>
            
            <br><br>



            <hr>
            <table id="writeArea" class="table">
                <div>
                    이전글 | 이번 캠핑 너무 즐거웠어요~~!!^--^  <br>
                    다음글 | 캠핑 컨셉이 너무 잘나왔네요~~ <br>
                </div>
            </table>
            <!-- 댓글 기능은 나중에 ajax 배우고 나서 구현할 예정! 우선은 화면구현만 해놓음 -->
            <table id="replyArea" class="table" align="center">
                <thead>
                    <tr>
                    
                    	<c:choose>
                    		<c:when test="${ empty sessionScope.loginUser }">
                    			<!-- 로그인 전 : 댓글 작성 막기 -->
		                        <th colspan="2">
		                            <textarea class="form-control" cols="55" rows="2" 
		                            		  style="resize:none; width:100%;" readonly>로그인한 사용자만 이용 가능한 서비스 입니다. 로그인 후 이용 바랍니다.</textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn btn-secondary" disabled>등록하기</button></th>
		                    </c:when>
		                    <c:otherwise>
		                    	<!-- 로그인 후 : 댓글 작성 풀기 -->
		                    	<th colspan="2">
		                            <textarea class="form-control" id="content" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
		                        </th>
		                        <th style="vertical-align:middle">
		                        	<button class="btn btn-secondary" onclick="addReply();">
		                       	 		등록하기
		                        	</button>
		                        </th>
		                    </c:otherwise>
                        </c:choose>
                        
                    </tr>
                    <tr>
                        <td colspan="3">댓글(<span id="rcount">0</span>)</td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <br><br>

    </div>

</body>
</html>