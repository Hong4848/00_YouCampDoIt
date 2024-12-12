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
        
        .reDetitle {
        	text-decoration : none;
        	color : black;
        }
        
        #review-centroller .reviewDetail-next {
        
	        display: block;
	    	padding: 0 10px 10px 25px;
    	}
    	
    	#review-centroller .reviewDetail-prev {
        
	        display: block;
	    	padding: 0 10px 20px 25px;
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
            		<th>제목</th>
            	</tr>
			    <tr>
			        <th width="100">작성자</th>
			        <td width="220">관리자</td>
			        <th width="100">작성일시</th>
			        <td width="220">2024-12-02</td>
			    </tr>
			    <tr>
			        <th>첨부파일</th>
			        <td colspan="3">
			            <a href="첨부파일경로" download>첨부파일이름.png</a>
			        </td>
			    </tr>
    			 <!--
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                       
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
                       
                    </td>
                </tr>
                 -->
			    <tr>
			        <th>내용</th>
			        <td colspan="3">
			
			            <p><b>상품 설명:</b> 맑은오토캠핑리조트 / 자연캠핑장 전세</p>
			            <p><b>이용 안내:</b> 매월 14박 이상 예약 시 이용 가능 (예약 접수 가능 시간: 매일 09:00~18:00)</p>
			            <ul>
			                <li>현장 추가 할인: 매월 최대 30%, 추가 할인 적용</li>
			                <li>결제 방식: 카드 결제 가능</li>
			                <li>취소 및 환불: 소비자보호법 기준에 따라 진행</li>
			            </ul>
			            <p><b>유의 사항:</b> 취소 시 소정의 취소 수수료 발생</p>
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
            
             <!-- 이전글, 다음글 -->
             <div align="left" id="review-centroller">  
	             <div class="reviewDetail-next">
	             	<span class="next">다음글</span>
	             	<a href="" class="reDetitle">캠핑 컨셉이 너무 잘나왔네요~~</a>
	             </div>
	             <div class="reviewDetail-prev">
	             	<span class="prev">이전글</span>
	             	<a href="" class="reDetitle">이번 캠핑 너무 즐거웠어요~~!!^--^</a>
	             </div>
             </div>
            
            
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