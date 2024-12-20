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

            .choiceMenuBar{
                width: 350px;
                height: 10px;
                background-color: black;
                position: absolute;
                right: 50px; 
                top: 60px;
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

            .listSearchBar{
                width: 70%;
                height: 40px;
                margin-left: 50px;
                background-color: white;
                margin-top: 20px;
                display: flex;
                justify-content: left;
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
                width: 15%;
                height: 100%;
            }

            .goodsCategory_Info{
                width: 10%;
                height: 100%;
            }
            
            .goodsStatus_Info{
                width: 10%;
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
        </style>
    </head>
    <body>
        <div id="outer">
            <jsp:include page="/WEB-INF/views/admin/pageManagerMenu.jsp"></jsp:include>
            <div class="manager_content">
				<div class="management_title">
                    <div style="line-height: 47px; padding-left: 20px;">상품 정보 관리</div>
                    <div style="padding-right: 20px;">
                        <button id="addProduct" class="btn" style="background-color: rgb(88, 199, 190);">상품등록</button>
                    </div>
                </div>
                <div class="management_content">
                    <div class="choiceMenuBar">
                    </div>
                    <div class="management_list">
                        <div id="all_list" class="listClass targetList">
                            <div class="listContent">
                                <div class="listName">전체</div>
                                <div class="listCount">10</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                        <div id="sale_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">판매중</div>
                                <div class="listCount">5</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                        <div id="soldOut_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">품절</div>
                                <div class="listCount">3</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                        <div id="hide_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">숨김</div>
                                <div class="listCount">2</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                    </div>
                    <div class="listSearchBar">
                        <div>
                            <select name="" id="searchSelect">
                                <option value="">상품명</option>
                                <option value="">브랜드</option>
                                <option value="">카테고리</option>
                            </select>
                        </div>
                        <div>
                            <input id="goodsKeyword" name="" type="text">
                        </div>
                        <div id="SearchBtn">
                            🔍︎
                        </div>
                    </div>
                    <div class="goodsList">
                        <div class="goodsListInfo">
                            <div class="goodsNo_checkbox">
                                <input type="checkbox" id="" name="">
                                <label class="labelClass" for="">No</label>
                            </div>
                            <div class="goodsThumbnail_Info">
                            </div>
                            <div class="goodsName_Info">
                                상품명
                            </div>
                            <div class="goodsPrice_Info">
                                판매가
                            </div>
                            <div class="goodsCategory_Info">
                                카테고리
                            </div>
                            <div class="goodsStatus_Info">
                                상태
                            </div>
                            <div class="goodsRemainStock_Info">
                                재고
                            </div>
                            <div class="goodsEnrollDate_Info">
                                등록일
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
        $(document).ready(function(){
            let count = $("#Product").next().children().length;
            $("#Product").next().css("border-color", "rgb(26, 187, 156, 1.0)");
            $("#Product").children(".head_node_right").text("▼");
            $("#Product").next().css("height", count*35);

            $("#ProductList").children().css("color","red");
            ajaxTotalList(1);
        });
    </script>

    <!-- 등록페이지로 -->
    <script>
        $("#addProduct").click(function(){
            location.href = "addProduct.ma";
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

        $(".listClass").click(function(){
            $(".listClass").removeClass("targetList");
            $(this).addClass("targetList");
            ajaxTotalList(1);
        });
    </script>

    <!-- ajax 통신 : 총 게시글 수 -->
    <script>
        function ajaxTotalList(pageNumber){
            $.ajax({
                url : "ajaxTotalListCount.ma",
                type : "get",
                success : function(result){
                    $("#all_list .listCount").text(result.totalCount);
                    $("#sale_list .listCount").text(result.onSaleCount);
                    $("#soldOut_list .listCount").text(result.offSaleCount);
                    $("#hide_list .listCount").text(result.hideCount);
                    ajaxGoodsList(pageNumber);
                },
                error : function(){
                    console.log("실패");
                }
            }) 
        }
    </script>

    <!-- ajax 통신 -->
    <script>
        function ajaxGoodsList(pageNumber){
            $.ajax({
                url : "ajaxGoodsManagement.ma",
	            type : "get",
                data : {
                    pageNumber : pageNumber
                },
	            success : function(result){
                    let listClass = $(".targetList .listName").text();
                    $("#goodsListContent").children().remove();
                    $("#pagingArea").children().remove();
	            	for(let i = 0; i < result.list.length; i++){
                        switch(listClass){
                            case "전체":
                                ajaxResult(result, i);
                                break;
                            case "판매중":
                                if(result.list[i].status == "Y" && result.list[i].remainStock > 0){
                                    ajaxResult(result, i);
                                }
                                break;
                            case "품절":
                                if(result.list[i].status == "Y" && result.list[i].remainStock == 0){
                                    ajaxResult(result, i);
                                }
                                break;
                            case "숨김":
                                if(result.list[i].status == "N"){
                                    ajaxResult(result, i);
                                }
                                break;
                        }
                    }
                    $("#goodsListContent>div").addClass("goodsListInfo");
                    $("#goodsListContent>div").addClass("ajaxClick");
                    $(".goodsThumbnail_Info>img").css({"height":"100%", "margin":"0px"});

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
                }, 
	            error : function(){
	            	console.log("실패");
	            }
            });
        }
    </script>

    <!-- ajax 결과 데이터 처리 -->
    <script>
        function ajaxResult(result, i){
            let resultStr = "";
            let date = result.list[i].enrollDate;
            year = date.substring(8,12);
            month = date.substring(0,2);
            day = date.substring(4,6);
            let status = result.list[i].status;
            if(status != "N"){
                if(result.list[i].remainStock == 0){
                    status = "일시품절";
                }
                else{
                    status = "판매중";
                }
            }
            else{
                status = "숨김";
            }

            resultStr += "<div class='goodsNo_checkbox'>"
                            + "<input type='checkbox' id='check_"+ (i+1) +"' name='check_" + (i+1) + "'>"
                            + "<label class='labelClass' for='check_" + (i+1) + "'>"+ result.list[i].goodsNo +"</label>"
                        + "</div>"
                        + "<div class='goodsThumbnail_Info'>"
                            + result.list[i].goodsThumbnail
                        + "</div>"
                        + "<div class='goodsName_Info'>"
                            + result.list[i].goodsName
                        + "</div>"
                        + "<div class='goodsPrice_Info'>"
                            + (result.list[i].price-(result.list[i].price*result.list[i].discount))
                        + "</div>"
                        + "<div class='goodsCategory_Info'>"
                            + result.list[i].category
                        + "</div>"
                        + "<div class='goodsStatus_Info'>"
                            + status
                        + "</div>"
                        + "<div class='goodsRemainStock_Info'>"
                            + result.list[i].remainStock + "/" + result.list[i].totalStock
                        + "</div>"
                        + "<div class='goodsEnrollDate_Info'>"
                            + year + "-" + month + "-" + day
                        + "</div>";
            let createDiv = document.createElement("div");
            createDiv.innerHTML=resultStr;
            document.getElementById("goodsListContent").appendChild(createDiv);
        }
    </script>

    <!-- 페이징 바 이벤트 -->
    <script>
        $(document).on("click", ".pageNum", function(){
            let pageNumber = parseInt($(this).text());
            ajaxTotalList(pageNumber);
        });

        $(document).on("click", ".pagePrevious", function(){
            let pageNumber = parseInt($(".thisNum").text())-1;
            ajaxTotalList(pageNumber);
        });

        $(document).on("click", ".pageNext", function(){
            let pageNumber = parseInt($(".thisNum").text())+1;
            ajaxTotalList(pageNumber);
        });
    </script>
</html>