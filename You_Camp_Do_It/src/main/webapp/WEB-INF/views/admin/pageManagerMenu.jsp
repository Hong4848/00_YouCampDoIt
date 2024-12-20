<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>관리자 메뉴</title>
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
        
        <link rel="stylesheet" href="resources/css/summernote/summernote-lite.css">
		<!--
		<script src="resources/js/summernote/lang/summernote-ko-KR.js"></script>
		-->
		<script src="resources/js/summernote/summernote-lite.js"></script>

        <!-- 글꼴 -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
        <!----------------------------------------------------------------------------------------------------------->
		<style>
			body{
				font-family: "Noto Sans KR", sans-serif;
			}

			div{
				box-sizing: border-box;
			}

			.left_side_menu{
				width: 250px;
				height: 100%;
				background-color: rgb(42, 63, 84);
				color: rgb(236, 240, 241);
				position: relative;
			}

			.left_side_menu a{
				color: rgb(236, 240, 241);
				text-decoration: none;
			}

			.left_side_menu a:hover{
				color: rgb(236, 240, 241);
				text-decoration: none;
			}

			.setting_bar{
				width: 250px;
				height: 50px;
				background-color: rgb(23, 45, 68);
				position: absolute;
				display: flex;
				justify-content: space-evenly;
				bottom: 0px;
			}

			.left_side_menu_img{
				width: 25%;
				height: 100%;
				text-align: center;
			}

			.left_side_menu_img>img{
				margin: auto;
				cursor: pointer;
			}
			
			.left_side_title{
				width: 100%;
				height: 100px;
				text-align: center;
				line-height: 90px;
				font-size: 40px;
			}
			.left_side_title>a>img{
				height: 100%;
			}

			.admin_profile{
				width: 100%;
				height: 80px;
				display: flex;
				justify-content: space-evenly;
				text-align: center;
			}

			.admin_profile>div{
				width: 50%;
				height: 100%;	
			}

			.admin_img>img{
				height: 100%;
				filter: invert(100%) sepia(2%) saturate(1236%) hue-rotate(165deg) brightness(100%) contrast(89%);
			}

			.admin_hello{
				padding-top: 12px;
			}

			.head_node{
				width: 100%;
				height: 50px;
				line-height: 45px;
				cursor: pointer;
				display:flex;
				justify-content: space-between;
				transition: all 0.5s;

				border-width: 1px 4px 1px 1px ;
  				border-style: solid;
				border-color: rgba(187, 187, 187, 0.0) rgba(26, 187, 156, 0.0) rgba(49, 49, 49, 0.0) rgba(26, 187, 156, 0.0);
			}

			.head_node_left{
				width: 30%;
				height: 100%;
			}

			.head_node_left>img{
				padding-left: 20px;
				height: 80%;
				filter: invert(100%) sepia(2%) saturate(1236%) hue-rotate(165deg) brightness(100%) contrast(89%);
			}

			.head_node_mid
			{
				width: 50%;
			}
			
			.head_node_right
			{
				width: 20%;
				text-align: center;
			}

			.mid_node{
				width: 100%;
				height: 0px;
				display: flex;
				flex-wrap: wrap;
				overflow: hidden;
				transition: all 1s;

				border-width: 0px 4px 0px 0px ;
  				border-style: solid;
				border-color: rgba(26, 187, 156, 0.0);
			}

			.leaf_node{
				width: 100%;
				height: 35px;
				padding-left: 20px;
				cursor: pointer;
				line-height: 30px;
			}

			.leaf_node:hover{
				background-color: rgb(53, 73, 93);
			}

			.manager_content{
				width: 1650px;
				height: 100%;
			}
		</style>
	</head>
	<body>
        <div class="left_side_menu">
            <div class="left_side_title">
                <a href="">
                    <img src="resources/images/mainPage/로고수정.png" alt="">
                </a>
            </div>
            <div style="height: 50px;"></div>
            <div class="admin_profile">
                <div class="admin_img">
                    <img src="resources/images/admin/관리자.png" alt="">						
                </div>
                <div class="admin_hello">
                    환영합니다<br>
                    관리자 님
                </div>
            </div>
            <div style="height: 50px;"></div>
            <div id="left_list_1" class="left_list">
                <div class="head_node">
                    <div class="head_node_left"><img src="resources/images/admin/사용자.png" alt=""></div>
                    <div class="head_node_mid">사용자관리</div>
                    <div class="head_node_right">▶</div>
                </div>
                <div class="mid_node">
                    <div class="leaf_node"><a>◈ 회원정보일람</a></div>
                </div>
                <div style="height: 20px;"></div>

                <div class="head_node" id="Product">
                    <div class="head_node_left"><img src="resources/images/admin/상품관리.png" alt=""></div>
                    <div class="head_node_mid">상품관리</div>
                    <div class="head_node_right">▶</div>
                </div>
                <div class="mid_node">
                    <div class="leaf_node" id="ProductRegister"><a href="${ pageContext.request.contextPath }/addProduct.ma">◈ 상품정보등록</a></div>
					<div class="leaf_node" id="ProductList"><a href="${ pageContext.request.contextPath }/Management.ma">◈ 상품정보관리</a></div>
                    <div class="leaf_node"><a>◈ 상품주문관리</a></div>
                    <div class="leaf_node"><a>◈ 상품주문통계</a></div>
                </div>
                <div style="height: 20px;"></div>

                <div class="head_node">
                    <div class="head_node_left"><img src="resources/images/admin/게시판관리.png" alt=""></div>
                    <div class="head_node_mid">컨텐츠관리</div>
                    <div class="head_node_right">▶</div>
                </div>
                <div class="mid_node">
                    <div class="leaf_node"><a>◈ 공지사항관리</a></div>
                    <div class="leaf_node"><a>◈ 일반게시판관리</a></div>
                    <div class="leaf_node"><a>◈ 후기게시판관리</a></div>
                    <div class="leaf_node"><a>◈ 댓글관리</a></div>
                </div>
                <div style="height: 20px;"></div>

                <div class="head_node">
                    <div class="head_node_left"><img src="resources/images/admin/예약관리.png" alt=""></div>
                    <div class="head_node_mid">예약관리</div>
                    <div class="head_node_right">▶</div>
                </div>
                <div class="mid_node">
                    <div class="leaf_node"><a>◈ 예약정보관리</a></div>
                    <div class="leaf_node"><a>◈ 예약월별통계</a></div>
                </div>
            </div>
            <div class="setting_bar">
                <div class="left_side_menu_img"></div>
                <div class="left_side_menu_img"></div>
                <div class="left_side_menu_img"><img src="resources/images/admin/뒤로가기.png" alt="뒤로가기" style="width: 80%;"></div>
                <div class="left_side_menu_img"><img src="resources/images/admin/logout.png" alt="로그아웃" style="width: 75%;"></div>
            </div>
        </div>
        <script>
			$(".head_node").click(function(){
				if($(this).children(".head_node_right").text() === "▶")
				{
					let count = $(this).next().children().length;
					$(this).css("border-color", "rgba(187, 187, 187, 1.0) rgba(26, 187, 156, 1.0) rgba(49, 49, 49, 1.0) rgba(26, 187, 156, 0.0)");
					$(this).next().css("border-color", "rgb(26, 187, 156, 1.0)");
					$(this).children(".head_node_right").text("▼");
					$(this).next().css("height", count*35);
				}
				else
				{
					$(this).css("border-color", "rgba(187, 187, 187, 0.0) rgba(26, 187, 156, 0.0) rgba(49, 49, 49, 0.0) rgba(26, 187, 156, 0.0)");
					$(this).next().css("border-color", "rgb(26, 187, 156, 0.0)");
					$(this).children(".head_node_right").text("▶");
					$(this).next().css("height", 0);	
				}
			});
		</script>
	</body>
</html>