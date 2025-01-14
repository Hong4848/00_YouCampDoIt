<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>YOU CAMP DO IT</title>

        <!--여기에 외부 코드 등록-->
        <!----------------------------------------------------------------------------------------------------------->
        <!-- J쿼리 -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

        <!-- 부트스트랩 -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


        <!-- alert CSS -->
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>
        

        <!-- 글꼴 -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
        
        <!-- 비밀번호 눈표시 -->
        <link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <!----------------------------------------------------------------------------------------------------------->
        <style>
            body{
                width: 1900px;
                margin: 0px;
                padding: 0px;
                font-size: 15px;
                font-family: "Noto Sans KR", sans-serif;
            }
            a{
                text-decoration: none;
                color: white;
            }
            a:hover{
                text-decoration: none;
                color: white;
                font-weight: 900;
            }            

            #header{
                width: 100%;
                height: 130px;

                display: flex;
                justify-content: space-between;
                position: absolute;
                top: 0px;
                left: 0px;
                z-index: 10;
            }

            .header1{
                box-sizing: border-box;
            }

            #header_logo img{
                height: 100%;
            }

            .header_menuList{
                display: flex;
                margin-right: 140px;
            }

            .header_menu1{
                width: 200px;
                text-align: center;
                margin-top: 15px;
                padding: 30px;
                position: relative;
                font-size: 25px;
            }

            .border_line{
                margin: auto;
                right: 0px;
                left: 0px;
                position: absolute;
                width: 1px;
                height: 0px;
                background-color: white;
                transition: all 0.5s;
            }

            .header_menu2{
                right: 0px;
                left: 0px;
                display: block;
                font-size: 17px;
                position: absolute;
                background-color: #5e5d43;
                opacity: 0;
                transition: all 0.5s;
                padding-top: 20px;
                padding-bottom: 20px;
            }
            .header_menu2>a{
                display: block;
                text-align: center;
                padding-top: 5px;
            }

            #quick_open
            {
                display: flex;
                margin: auto;
                right: 70px;
                top: 0px;
                bottom: 0px;
                flex-direction: column;
                justify-content: space-between;
                height: 100px;
                width: 15px;
                position: fixed;
                background-color: gray;
                z-index: 10;
                transition: all 0.5s;
                cursor: pointer;
                border-radius: 10px 0px 0px 10px;
            }

            #quickMenu{
                display: flex;
                margin: auto;
                right: 0px;
                flex-direction: column;
                justify-content: space-between;
                height: 100%;
                width: 70px;
                position: fixed;
                background-color: white;
                z-index: 20;
                transition: all 0.5s;
                opacity: 1.0;

				  background-color: white;
				  box-shadow: -6px 0 10px rgba(0, 0, 0, 0.1); /* 왼쪽에 그림자 */
            }

            .quick_a{
                margin: auto;
                writing-mode: vertical-lr;
            }

            .quick_a img{
                margin-top: 10px;
                width: 50px;
            }

            #menuImg>img{
                width: 100%;
                box-sizing: border-box;
                object-fit: fill;
            }

            @media (max-width: 1425px){
                .header_menuList{
                    display: none;
                }
            }
            
            /* 로그인폼 css */
            .modal-content {
	            font-family: Arial, sans-serif;
	            border-radius: 10px;
	        }
	        
	        #links {
	        	text-align: center;
	        	margin-bottom : 20px;
	        	margin-top: 0px;
	        }
	        
	        #links a {
	        	color: black;
	        }
	        
	        /* Camping Theme */
	.camping-theme {
	    font-family: 'Arial', sans-serif;
	    background: #f5f5dc; /* 캠핑 느낌의 베이지 배경 */
	    padding: 20px;
	    border-radius: 10px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	    border: 2px solid #8b5e3c; /* 나무 느낌의 테두리 */
	}
	
	.modal-header {
	    text-align: center;
	    margin-bottom: 20px;
	    display: flex;
	    align-items: center;
	    height: 80px;
	}
	
	.modal-logo {
	    width: 120px;
	    height: auto;
	    margin-bottom: 10px;
	}
	
	.modal-title {
	    font-size: 24px;
	    font-weight: bold;
	    color: #4b5320; /* 짙은 녹색 */
	}
	
	.form-label {
	    font-size: 14px;
	    font-weight: bold;
	    margin-bottom: 5px;
	    color: #6b4226; /* 갈색 텍스트 */
	}
	
	.form-control {
	    font-size: 14px;
	    padding: 10px;
	    border: 1px solid #d4af37; /* 금색 느낌의 테두리 */
	    border-radius: 4px;
	    background: #fffaf0; /* 부드러운 배경색 */
	}
	
	.form-control:focus {
	    border-color: #8b4513; /* 짙은 갈색 테두리 */
	    box-shadow: 0 0 5px rgba(139, 69, 19, 0.5);
	}
	
	.btn-primary {
	    background-color: #4b5320; /* 짙은 녹색 */
	    border: none;
	    font-size: 16px;
	    padding: 10px;
	    border-radius: 4px;
	    transition: background-color 0.3s ease;
	    color: #fff;
	}
	
	.btn-primary:hover {
	    background-color: #2f4f4f; /* 더 짙은 녹색 */
	}
	
	#links {
	    font-size: 14px;
	    margin-top: 20px;
	    font-family: 'Arial', sans-serif;
	}
	
	.modal-link {
	    color: #8b4513; /* 갈색 */
	    text-decoration: none;
	    margin: 0 5px;
	    transition: color 0.3s ease;
	}
	
	.modal-link:hover {
	    color: #4b5320; /* 녹색 */
	    text-decoration: underline;
	}
	        
	        
	        
            
            
            
        </style>
    </head>
    <body>
    
    
   	<c:if test="${ not empty sessionScope.alertMsg }">
	<script>
		alertify.alert('Alert', '${ sessionScope.alertMsg }', function(){ alertify.success('Ok'); });
	</script>
	<c:remove var="alertMsg" scope="session" />
	</c:if>
    
    
        <div id="app">
            <div class="quick_main">
                <div id="quick_open" onclick="quickOpen();"></div>
                <div id="quickMenu">
                    <div id="userManu" class="quick_a">
                    	<c:choose>
                    		<c:when test="${ empty sessionScope.loginMember }">
                    			<a data-toggle="modal" data-target="#loginModal" style="cursor: pointer;"><img src="resources/images/mainPage/로그인.png"></a>
                    		</c:when>
                    		<c:otherwise>
                    			<a href="${ pageContext.request.contextPath }/logout.me" style="cursor: pointer;"><img src="resources/images/mainPage/로그아웃icon.png"></a>
                    		</c:otherwise>
                    	</c:choose>
                        
                        <c:choose>
                        	<c:when test="${sessionScope.loginMember.memberId == 'admin'}">
                        		<a href="${ pageContext.request.contextPath }/adminMain.ma"><img src="resources/images/mainPage/관리자icon.png"></a>
                        	</c:when>
                        	<c:otherwise></c:otherwise>
                        </c:choose>
                    </div>
                    <div style="height: 40%;"></div>
                    <div id="convenience" class="quick_a">
                        <a href="${ pageContext.request.contextPath }/listForm.ca">
                        	<img src="resources/images/mainPage/장바구니icon.png">
                        </a>
                        <c:choose>
                    		<c:when test="${ empty sessionScope.loginMember }">
                    			
                    		</c:when>
                    		<c:otherwise>
                    			<a href="${ pageContext.request.contextPath }/myPage.me">
		                        	<img src="resources/images/mainPage/마이페이지.png">
		                        </a>
                    		</c:otherwise>
                    	</c:choose>
                        
                    </div>
                </div>
            </div>
            <div id="header">
                <div id="header_logo" class="header1">
                    <a href="${ pageContext.request.contextPath }/"><img src="resources/images/mainPage/로고수정.png" alt=""></a>
                </div>
                <div id="header_list" class="header1">
                    <div class="header_menuList">
                        <div class="header_menu1">
                            <a href="${ pageContext.request.contextPath }/product.gs">캠핑용품</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="${ pageContext.request.contextPath }/product.gs">용품목록</a>
                                <a href="${ pageContext.request.contextPath }/rentalInfo.ha">대여/반납안내</a>
                            </div>
                        </div>
                        <div class="header_menu1">
                            <a href="${ pageContext.request.contextPath }/list.no">커뮤니티</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="${ pageContext.request.contextPath }/list.no">공지사항</a>
                                <a href="${ pageContext.request.contextPath }/list.re">후기게시판</a>
                                <a href="${ pageContext.request.contextPath }/list.lo">분실물게시판</a>
                            </div>
                        </div>
                        <div class="header_menu1">
                            <a href="${ pageContext.request.contextPath }/reserveDate.res">실시간 예약</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="${ pageContext.request.contextPath }/reserveDate.res">실시간 예약</a>
                                <a href="${ pageContext.request.contextPath }/reserveList.res">예약확인/취소</a>
                            </div>
                        </div>
                        <div class="header_menu1">
                            <a href="${ pageContext.request.contextPath }/forest.ha">시설소개</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="${ pageContext.request.contextPath }/forest.ha">포레스트</a>
                                <a href="${ pageContext.request.contextPath }/belly.ha">밸리</a>
                                <a href="${ pageContext.request.contextPath }/sky.ha">스카이</a>
                                <a href="${ pageContext.request.contextPath }/stone.ha">스톤</a>
                                <a href="${ pageContext.request.contextPath }/etc.ha">기타시설안내</a>
                            </div>
                        </div>
                        <div class="header_menu1">
                            <a href="">이용안내</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="${ pageContext.request.contextPath }/location.ha">찾아오시는길</a>
                                <a href="${ pageContext.request.contextPath }/precaution.ha">사용시 유의사항</a>
                                <a href="${ pageContext.request.contextPath }/emergency.ha">비상시 대책요령</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="menuImg">
                <img src="resources/images/mainPage/메뉴바이미지.jpg" alt="">
            </div>
		</div>
		
		<!-- 상단 메뉴바 -->
        <script>
            $(".header_menu1").hover(function(){
                $(this).children(".border_line").css("height", "25px");
                $(this).children(".header_menu2").css("opacity", "1.0").css("margin-top", "30px");
            },
            function(){
                $(this).children(".border_line").css("height", "0px");
                $(this).children(".header_menu2").css("opacity", "0.0").css("margin-top", "0px");
            });
        </script>

        <!-- 퀵 메뉴 열기/닫기 -->
        <script>
            let quick_switch = true;

            function quickOpen()
            {
                if(quick_switch == true)
                {
                    $("#quickMenu").css("width", "0px").css("opacity", "0.0");
                    $("#quick_open").css("right", "0px");
                    quick_switch = false;
                }
                else{
                    $("#quickMenu").css("width", "70px").css("opacity", "1.0");
                    $("#quick_open").css("right", "70px");
                    quick_switch = true;
                }
            }
        </script>

        <!-- 로그인 모달창 -->
        <div class="modal" id="loginModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Modal Header -->
                    
                    
                    <!-- 
                    	로그인 요청 시 
                    	http://localhost:8006/youcamp/login.me
                    -->
            
                    
                    <form action="${ pageContext.request.contextPath }/login.me" method="post" >
                    	<!-- Modal body -->
						<div class="modal-body camping-theme">
						    <div class="modal-header text-center">
						        <img src="resources/images/mainPage/메인로고.png" alt="캠핑장 로고" class="modal-logo">
						        <h3 class="modal-title">로그인 </h3>
						    </div>
						    <label for="memberId" class="form-label">아이디</label>
						    <input type="text" class="form-control" placeholder="아이디를 입력해주세요" id="memberId" name="memberId" required>
						    <label for="memberPwd" class="form-label mt-3">비밀번호</label>
						    <input type="password" class="form-control" placeholder="비밀번호를 입력해주세요" id="memberPwd" name="memberPwd" required autocomplete="off">
						    <button type="submit" class="btn btn-primary w-100 mt-4">로그인</button>
						    <div id="links">
						    <a href="${ pageContext.request.contextPath }/enrollForm.me">회원가입</a> | 
						    <a href="${ pageContext.request.contextPath }/findIdForm.me">아이디 찾기</a> | 
						    <a href="${ pageContext.request.contextPath }/findPwdForm.me">비밀번호 찾기</a>
						</div>
						</div>
            
                        <!-- Modal footer -->
						
                        
                    </form>
                </div>
            </div>
        </div>
        
        <script>
        	
        </script>
	</body>
</html>












