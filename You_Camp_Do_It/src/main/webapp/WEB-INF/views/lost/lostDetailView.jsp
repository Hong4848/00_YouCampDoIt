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
                <h4>분실물게시판 상세보기</h4>
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
            		<td colspan="3">${ requestScope.l.lostTitle }</td>
            	</tr>
			    <tr>
			        <th width="100">작성자</th>
			        <td width="220">관리자</td>
			        <th width="100">작성일시</th>
			        <td width="220">${ requestScope.l.createDate }</td>
			    </tr>
			    <tr>
                    <th>내용</th>
                    <td colspan="3">                       
                    	<c:forEach var="file" items="${ requestScope.list }"> 
							<div class="review-image"> 
								<c:if test="${file.fileLevel eq 1}"> 
									<!-- 썸네일 이미지 --> 
									<img src="${pageContext.request.contextPath}${file.changeName}" class="thumbnail-image"> 
									console.log('이미지 로드 실패:', this.src);
								</c:if> 
								<c:if test="${file.fileLevel eq 2}"> 
									<!-- 상세 이미지 --> 
									<img src="${pageContext.request.contextPath}${file.changeName}" class="detail-image"> 
									console.log('이미지 로드 실패:', this.src);
								</c:if> 
							</div> 
						</c:forEach>
                        <p>${ requestScope.r.reviewContent }</p>                      
                    </td>
                </tr>
            </table>

			<div class="d-flex justify-content-start gap-2 mt-3">
                <c:if test="${sessionScope.loginMember.memberId eq 'admin1'}">
                <!-- 로그인한 아이디가 'admin'일 경우 수정 및 삭제 버튼 표시 -->
                    <a class="btn btn-primary btn-sm" href="javascript:postFormSubmit(1)">수정</a>
                    <a class="btn btn-danger btn-sm" href="javascript:postFormSubmit(2)">삭제</a>
                    <form id="postForm" action="" method="post">
		            	<input type="hidden" name="nno" value="${ requestScope.n.noticeNo }">
		            	<input type="hidden" name="filePath" value="${ requestScope.n.changeName }">
		            </form>
	            
	            <script>
	            	function postFormSubmit(num) {
	            		// console.log(num);
	            		// > num 이 1 일 경우 게시글 수정 페이지를 요청 (updateForm.lo)
	            		//   num 이 2 일 경우 게시글 삭제 요청 (delete.lo)
	            		
	            		// 위의 form 태그의 action 속성값을 상황에 따라 알맞게 지정 후
	            		// 곧바로 submit 시키기!!
	            		// attr : 기타 속성
	            		if(num == 1) { // 수정하기를 클릭했을 경우
	            			 $("#postForm").attr("method", "get"); // GET 요청으로 변경
	            		     $("#postForm").attr("action", "${pageContext.request.contextPath}/updateForm.lo").submit();
	            			// > 제이쿼리의 submit 메소드 : 해당 form 의 submit 버튼을 클릭한 효과
	            		} else { // 삭제하기를 클릭했을 경우
	            			$("#postForm").attr("method", "post"); // POST 요청 유지
	            	        $("#postForm").attr("action", "${pageContext.request.contextPath}/delete.lo").submit();
	            		}
	            	}
	            </script>
                    
                	               
                </c:if>
                <!-- 로그인한 아이디가 'admin'이 아닐 경우 목록 조회 버튼만 표시 -->
                <a class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath}/list.lo">목록</a>
            </div>
            
            <br><br>



            <hr>
            <table id="writeArea" class="table">
                <div>
                    이전글 | 2014.12.01 A구역 10번 에서 잃어버리신 물건 입니다.  <br>
                    다음글 | 2024.12.15 B구역 1번 쪽에서 잃어버리신 물건입니다. <br>
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

</body>
</html>