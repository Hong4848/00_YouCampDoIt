<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


        <!-- alert CSS
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>
        -->

        <!-- 글꼴 -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
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
        </style>
    </head>
    <body>
        <div id="app">
            <div class="quick_main">
                <div id="quick_open" onclick="quickOpen();"></div>
                <div id="quickMenu">
                    <div id="userManu" class="quick_a">
                        <a data-toggle="modal" data-target="#loginModal" style="cursor: pointer;"><img src="resources/images/mainPage/로그인icon.png"></a>
                        <a href=""><img src="resources/images/mainPage/회원가입icon.png"></a>
                    </div>
                    <div style="height: 40%;"></div>
                    <div id="convenience" class="quick_a">
                        <a href=""><img src="resources/images/mainPage/장바구니icon.png"></a>
                        <a href=""><img src="resources/images/mainPage/마이페이지icon.png"></a>
                    </div>
                </div>
            </div>
            <div id="header">
                <div id="header_logo" class="header1">
                    <a href=""><img src="resources/images/mainPage/로고수정.png" alt=""></a>
                </div>
                <div id="header_list" class="header1">
                    <div class="header_menuList">
                        <div class="header_menu1">
                            <a href="">큰메뉴이름1</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="">세부내용1</a>
                                <a href="">세부내용2</a>
                                <a href="">세부내용3</a>
                            </div>
                        </div>
                        <div class="header_menu1">
                            <a href="">큰메뉴이름2</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="">세부내용1</a>
                                <a href="">세부내용2</a>
                                <a href="">세부내용3</a>
                            </div>
                        </div>
                        <div class="header_menu1">
                            <a href="">큰메뉴이름3</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="">세부내용1</a>
                                <a href="">세부내용2</a>
                                <a href="">세부내용3</a>
                            </div>
                        </div>
                        <div class="header_menu1">
                            <a href="">큰메뉴이름4</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="">세부내용1</a>
                                <a href="">세부내용2</a>
                                <a href="">세부내용3</a>
                            </div>
                        </div>
                        <div class="header_menu1">
                            <a href="">큰메뉴이름5</a>
                            <div class="border_line"></div>
                            <div class="header_menu2">
                                <a href="">세부내용1</a>
                                <a href="">세부내용2</a>
                                <a href="">세부내용3</a>
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
                    <div class="modal-header">
                    <h4 class="modal-title">로그인</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
            
                    <!-- Modal body -->
                    <form action="">
                        <div class="modal-body">
                            <label for="userId" class="mr-sm-2">아이디 :</label>
                            <input type="text" class="form-control mb-2 mr-sm-2" placeholder="아이디를 입력해주세요" id="userId"><br>
                            <label for="userPwd" class="mr-sm-2">비밀번호 :</label>
                            <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호를 입력해주세요" id="userPwd" autoComplete="off"><br>
                        </div>
            
                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary mb-2">회원가입</button>
                            <button type="reset" class="btn btn-warning mb-2">초기화</button>
                            <button type="button" class="btn btn-danger mb-2" data-dismiss="modal">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
	</body>
</html>