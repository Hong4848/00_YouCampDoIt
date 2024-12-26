<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>관리자 메뉴</title>
        <style>
            button:hover{
                border: 2px solid rgb(13, 77, 250);
            }

            #outer{
				width: 1900px;
				height: 1200px;
				display: flex;
                background-color: rgb(221, 221, 221);
			}

            .management_title{
                width: 100%;
                height: 55px;
                font-size: 30px;
                display: flex;
                background-color: white;
                justify-content: space-between;
            }

            .management_content{
                margin-top: 50px;
                position: relative;
            }

            .management_list{
                width: 40%;
                height: 40px;
                margin-left: 50px;
                display: flex;
                line-height: 20px;
                justify-content:left
            }

            .listClass{
                font-size: 17px;
                font-weight: 600;
                width: 20%;
                cursor: pointer;
            }

            .listContent{
                width: 100%;
                height: 38px;
                display: flex;
                justify-content: space-evenly;
            }

            .listCount{
                color: rgb(51, 106, 255);
            }

            .targetList{
                color: rgb(51, 106, 255);
            }

            .listLine{
                width: 0%;
                margin: auto;
                height: 2px;
                background-color: rgb(51, 106, 255);
                transition: all 0.5s;
            }

            #searchSelect{
                width: 100px;
                height: 30px;
                margin-left: 20px;
                margin-top: 5px;
                border: 0px;
            }

            #goodsKeyword{
              width: 960px;  
              height: 30px;
              margin-top: 5px;
              margin-left: 20px;

              outline: none;
              border: none;
            }

            #SearchBtn{
                width: 55px;
                height: 100%;
                font-size: 20px;
                line-height: 40px;
                text-align: center;
                cursor: pointer;
            }

            .goodsList{
                width: 70%;
                margin-left: 50px;
                background-color: white;
            }
            .goodsListInfo{
                width: 100%;
                height: 60px;
                line-height: 58px;
                margin-top: 20px;
                display: flex;
                justify-content:left;
                text-align: center;
            }
            
            .goodsNo_checkbox{
                width: 5%;
                height: 100%;
                margin-left: 20px;
                text-align: left;
            }

            .goodsThumbnail_Info{
                width: 10%;
                height: 100%;
            }

            .goodsThumbnail_Info>img{
                height: 100%;
            }
            
            .goodsName_Info{
                width: 30%;
                height: 100%;
                text-align: left;
            }

            .goodsPrice_Info{
                width: 10%;
                height: 100%;
            }

            .goodsCategory_Info{
                width: 10%;
                height: 100%;
            }
            
            .goodsStatus_Info{
                width: 15%;
                height: 100%;
            }

            .goodsRemainStock_Info{
                width: 10%;
                height: 100%;
            }

            .goodsEnrollDate_Info{
                width: 10%;
                height: 100%;
            }

            .goodsListContent{
                width: 100%;
                height: 800px;
                text-align: center;
            }

            .labelClass{
                padding-left: 5px;
            }

            #pagingArea{
                width: 70%;
                margin-top: 10px;
                margin-left: 50px;
                display: flex;
                justify-content: space-around;
			}

            .page-link{
                cursor: pointer;
                width: 100%;
                height: 100%;
            }

            .choiceMenuBar{
                width: 350px;
                height: 0px;
                background-color: white;
                border: 0px double rgb(255, 129, 97);
                position: absolute;
                transition: all 1s;
                right: 50px; 
                top: 60px;
                overflow:hidden;
            }

            #choiceGoods{
                width: 100%;
                height: 100%;
            }

            #choiceName{
                margin-top: 30px;
                text-align: center;
                font-weight: 700;
                font-size: 17px;
            }

            #choiceDetail{
                width: 280px;
                display: flex;
                margin: 30px;
                justify-content:space-between;
                font-size: 17px;
            }

            #choiceDetailTitle{
                width: 100px;
            }

            #choiceDetailTitle>div{
                height: 30px;
                margin-bottom: 20px;
            }

            .choiceDetailContent{
                width: 150px;
                margin-right: 50px;
            }

            input::-webkit-outer-spin-button,
			input::-webkit-inner-spin-button {
			-webkit-appearance: none;
			margin: 0;
			}

            #choiceDetailContent>div{
                padding: 0px;
                width: 120px;
                height: 30px;
                margin-bottom: 20px;
                text-align: right;
                border: 0px;
                padding-right: 20px;
            }

            #goodsStatus{
                width: 105px;
                height: 30px;
                text-align: right;
                border: 0px;
                outline: 0px;
                appearance:none
            }
            
            .ajaxClick{
            	cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div id="outer">
            <jsp:include page="/WEB-INF/views/admin/pageManagerMenu.jsp"></jsp:include>
            <div class="manager_content">
				<div class="management_title">
                    <div style="line-height: 47px; padding-left: 20px;">상품 정보 관리</div>
                    <div style="padding-right: 20px;">
                    </div>
                </div>
                <div class="management_content">
                    <div class="choiceMenuBar">
                        <div id="choiceGoods">
                            <div id="choiceName">상품이름</div>
                            <div id="choiceDetail">
                                <div id="choiceDetailTitle">
                                    <div>주문번호</div>
                                    <div>ID</div>
                                    <div>이름</div>
                                    <div>대여일</div>
                                    <div>반납일</div>
                                    <div>개수</div>
                                    <div>총금액</div>
                                </div>
                                <div id="choiceDetailContent">
                                    <div id="choiceOrderNo">
                                        0
                                    </div>
                                    <div id="choiceMemberId">
                                        admin
                                    </div>
                                    <div id="choiceMemberName">
                                        관리자
                                    </div>
                                    <div id="choiceStart">
                                        0000-00-00
                                    </div>
                                    <div id="choiceEnd">
                                        0000-00-00
                                    </div>
                                    <div id="choiceCount">
                                        <label for="">0</label>&nbsp;&nbsp;개
                                    </div>
                                    <div id="choiceTotal">
                                        <label for="">0</label>&nbsp;&nbsp;원
                                    </div>
                                </div>
                            </div>
                            <div style="text-align: right; margin-right: 20px;">
                            </div>
                        </div>
                    </div>
                    <div class="management_list">
                        <div id="all_list" class="listClass targetList">
                            <div class="listContent">
                                <div class="listName">전체</div>
                                <div class="listCount">0</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                    </div>
                    <div class="goodsList">
                        <div class="goodsListInfo">
                            <div class="goodsNo_checkbox">
                                <label class="labelClass" for="">No</label>
                            </div>
                            <div class="goodsThumbnail_Info">
                            </div>
                            <div class="goodsName_Info">
                                상품명
                            </div>
                            <div class="goodsPrice_Info">
                                개수
                            </div>
                            <div class="goodsCategory_Info">
                                합산가격
                            </div>
                            <div class="goodsStatus_Info">
                                임차인(아이디)
                            </div>
                            <div class="goodsRemainStock_Info">
                                대여일
                            </div>
                            <div class="goodsEnrollDate_Info">
                                반납일
                            </div>
                        </div>
                        <div style="width: 100%; height: 2px; border: 1px solid rgba(128, 128, 128, 0.3);"></div>
                        <div class="goodsListContent" id="goodsListContent">
                        </div>
                    </div>
                </div>
                <div id="pagingArea">
                </div>
			</div>
        </div>
    </body>

    <!-- 시작 시 -->
    <script>
        let state = '전체';
        $(document).ready(function(){
            let count = $("#Product").next().children().length;
            $("#Product").next().css("border-color", "rgb(26, 187, 156, 1.0)");
            $("#Product").children(".head_node_right").text("▼");
            $("#Product").next().css("height", count*35);

            $("#ProductRental").children().css("color","red");
            ajaxRentalList(1, state);
        });
    </script>

    <!-- 분류 메뉴 호버이벤트 -->
    <script>
        $(".listClass").hover(function(){
            $(this).children(".listLine").css("width", "100%");
        },
        function(){
            $(this).children(".listLine").css("width", "0%");
        });
    </script>

    <!-- ajax 통신 -->
    <script>
        function ajaxRentalList(pageNumber, state){
            $.ajax({
                url : "AjaxRentalList.ma",
                type : "post",
                data : {
                    pageNumber : pageNumber,
                    state : state
                },
                success : function(rental){
                    $("#all_list").find(".listCount").text(rental.pi.listCount)
                    let listClass = $(".targetList .listName").text();
                    $("#goodsListContent").children().remove();
                    $("#pagingArea").children().remove();
                    if(rental.list.length == 0){
                        let imgD = document.createElement("img")
                        imgD.src = "resources/images/admin/등록된 정보가 없습니다.png";
                        document.getElementById("goodsListContent").appendChild(imgD);
                        $("#goodsListContent>img").css("height", "90%");
                        
                    }
                    else{
                        for(let i = 0; i < rental.list.length; i++){
                        	let str = "";

                            str += "<div class='goodsNo_checkbox'>"
                                    + "<label class='labelClass' for='check_" + (i+1) + "'>"+ rental.list[i].orderDetailNo +"</label>"
                                + "</div>"
                                + "<div class='selectGoodsNo' style='display : none'>"
                                    + rental.list[i].goodsNo
                                + "</div>"
                                str += ajaxGoods(rental, i);
                                str += "<div class='goodsPrice_Info'>"
                                    	+ rental.list[i].quantity + "&nbsp;&nbsp;개"
                                	+ "</div>"
                                	+ "<div class='goodsCategory_Info'>"
                                    	+ rental.list[i].totalPrice + "&nbsp;&nbsp;원"
                                	+ "</div>"
                                str += ajaxMember(rental, i);
                            let createDiv = document.createElement("div");
                            createDiv.innerHTML=str;
                            document.getElementById("goodsListContent").appendChild(createDiv);
                        }
                        $("#goodsListContent>div").addClass("goodsListInfo");
                        $("#goodsListContent>div").addClass("ajaxClick");
                        $(".goodsThumbnail_Info>img").css({"height":"100%", "margin":"0px"});
                    }
                    pageBar(rental);
                },
                error : function(){
                    console.log("통신실패");
                }
            });
        }
    </script>

    <!-- 상품정보 가져오기 -->
    <script>
        function ajaxGoods(result, i){
            let ajaxGoodsNo = result.list[i].goodsNo
            let goodsStr = "";
            $.ajax({
                url : "ajaxRentalGoods.ma",
                async: false,
                type : "post",
                data : {
                    goodsNo : ajaxGoodsNo
                },
                success : function(goods){
                	
                    goodsStr += "<div class='goodsThumbnail_Info'>"
                            + goods.goodsThumbnail
                        + "</div>"
                        + "<div class='goodsName_Info'>"
                            + goods.goodsName
                        + "</div>"
                },
                error : function(){
                    console.log("통신실패");
                }
                
            });
            return goodsStr;
        }
    </script>

    <!-- 회원 정보 가져오기 -->
    <script>
        function ajaxMember(result, i){
            let ajaxOrderNo = result.list[i].orderNo
            let memberStr = "";
            $.ajax({
                url : "ajaxRentalMember.ma",
                async: false,
                type : "post",
                data : {
                    orderNo : ajaxOrderNo
                },
                success : function(member){
                    memberStr += "<div class='goodsStatus_Info'>"
                                + member.rental.memberId
                        + "</div>"
                        + "<div class='goodsRemainStock_Info'>"
                                + member.startDate
                        + "</div>"
                        + "<div class='goodsEnrollDate_Info'>"
                                + member.endDate
                        + "</div>"
                        + "<div class='selectMemberName' style='display : none'>"
                                + member.rental.memberName    
                        + "</div>"

                },
                error : function(){
                    console.log("통신실패");
                }
            });
            return memberStr;
        }
    </script>

    <!-- 페이징 바 처리 -->
    <script>
        function pageBar(result){
            let createUl = document.createElement("ul");
            let piStr = "";
            if(result.pi.currentPage == 1){
                piStr += "<li class='page-item disabled'>"
                            + "<a class='page-link'>"
                                + "Previous"
                            + "</a>"
                        + "</li>"
            }
            else{
                piStr += "<li class='page-item'>"
                            + "<a class='page-link pagePrevious'>"
                                + "Previous"
                            + "</a>"
                        + "</li>"
            }
            for(let i = result.pi.startPage; i <= result.pi.endPage; i++){
                if(result.pi.currentPage != i){
                    piStr += "<li class='page-item'>"
                                + "<a class='page-link pageNum'>"
                                    + i
                                + "</a>"
                            + "</li>"
                }
                else{
                    piStr += "<li class='page-item disabled'>"
                                + "<a class='page-link thisNum'>"
                                    + i
                                + "</a>"
                            + "</li>"
                }
            }

            if(result.pi.currentPage != result.pi.maxPage){
                piStr += "<li class='page-item'>"
                                + "<a class='page-link pageNext'>"
                                    + "Next"
                                + "</a>"
                            + "</li>"
            }
            else{
                piStr += "<li class='page-item disabled'>"
                                + "<a class='page-link'>"
                                    + "Next"
                                + "</a>"
                            + "</li>"
            }

            createUl.innerHTML=piStr;
            document.getElementById("pagingArea").appendChild(createUl);
            $("#pagingArea>ul").addClass("pagination");
        }
    </script>
    
    <!-- 페이징 바 이벤트 -->
    <script>
        $(document).on("click", ".pageNum", function(){
            let pageNumber = parseInt($(this).text());
            ajaxGoodsList(pageNumber, state);
        });

        $(document).on("click", ".pagePrevious", function(){
            let pageNumber = parseInt($(".thisNum").text())-1;
            ajaxGoodsList(pageNumber, state);
        });

        $(document).on("click", ".pageNext", function(){
            let pageNumber = parseInt($(".thisNum").text())+1;
            ajaxGoodsList(pageNumber, state);
        });
    </script>

    <!-- 대여 정보 클릭 이벤트 -->
    <script>
        $(document).on("click", ".ajaxClick", function(){
        	$(".choiceMenuBar").css({
                "height" : 450,
                "border" : "5px double rgb(255, 129, 97)"
            });

            let goodsName = $(this).find(".goodsName_Info").text();
            let orderNo = $(this).find(".labelClass").text();
            let memberId = $(this).find(".goodsStatus_Info").text();
            let memberName = $(this).find(".selectMemberName").text();
            let startDate = $(this).find(".goodsRemainStock_Info").text();
            let endDate = $(this).find(".goodsEnrollDate_Info").text();
            let goodsCount = $(this).find(".goodsPrice_Info").text();
            let goodsTotal = $(this).find(".goodsCategory_Info").text();

            $("#choiceName").text(goodsName);
            $("#choiceOrderNo").text(orderNo);
            $("#choiceMemberId").text(memberId);
            $("#choiceMemberName").text(memberName);
            $("#choiceStart").text(startDate);
            $("#choiceEnd").text(endDate);
            $("#choiceCount").text(goodsCount);
            $("#choiceTotal").text(goodsTotal);
        })
    </script>
</html>