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

            .inputType{
                margin: 0px;
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
                        <button id="addProduct" class="btn" style="background-color: rgb(88, 199, 190);">상품등록</button>
                    </div>
                </div>
                <div class="management_content">
                    <div class="choiceMenuBar">
                        <div id="choiceGoods">
                            <div id="choiceName">정보없음</div>
                            <div id="choiceDetail">
                                <div id="choiceDetailTitle">
                                    <div>가격</div>
                                    <div>총 수량</div>
                                    <div>재고</div>
                                    <div>할인율</div>
                                    <div>판매상태</div>
                                </div>
                                <div id="choiceDetailContent">
                                    <div style="display:none" id="choiceNo">0</div>
                                    <div id="choicePrice">
                                        <input class="inputType" type="number" value="0">원
                                    </div>
                                    <div id="choiceTotalStock">
                                        <input class="inputType" type="number" value="0">개
                                    </div>
                                    <div id="choiceStock">
                                        <input class="inputType" type="number" value="0">개
                                    </div>
                                    <div id="choiceDiscount">
                                        <input class="inputType" type="number" value="0">%
                                    </div>
                                    <div id="choiceStatus">
                                        <select name="goodsStatus" id="goodsStatus">
                                            <option value='Y'>판매중</option>
                                            <option value='N'>품절</option>
                                            <option value='H'>숨김</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div style="text-align: right; margin-right: 20px;">
                                <button class="btn btn-sm btn-warning updateBtn">상세내용 수정</button>
                                <button class="btn btn-sm btn-danger submitBtn">상품상태 수정</button>
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
                        <div id="sale_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">판매중</div>
                                <div class="listCount">0</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                        <div id="soldOut_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">품절</div>
                                <div class="listCount">0</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                        <div id="hide_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">숨김</div>
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
        let state = '전체';

        $(document).ready(function(){
            let count = $("#Product").next().children().length;
            $("#Product").next().css("border-color", "rgb(26, 187, 156, 1.0)");
            $("#Product").children(".head_node_right").text("▼");
            $("#Product").next().css("height", count*35);

            $("#ProductList").children().css("color","red");
            ajaxGoodsList(1, state);
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
            state = $(this).find(".listName").text();
            ajaxGoodsList(1, state);
        });
    </script>

    <!-- ajax 통신 -->
    <script>
        function ajaxGoodsList(pageNumber, state){
            $.ajax({
                url : "ajaxGoodsManagement.ma",
	            type : "get",
                data : {
                    pageNumber : pageNumber,
                    state : state
                },
	            success : function(result){
                    let listClass = $(".targetList .listName").text();
                    $("#goodsListContent").children().remove();
                    $("#pagingArea").children().remove();
                    if(result.list.length == 0){
                        let imgD = document.createElement("img")
                        imgD.src = "resources/images/admin/등록된 정보가 없습니다.png";
                        document.getElementById("goodsListContent").appendChild(imgD);
                        $("#goodsListContent>img").css("height", "90%");
                        
                    }
                    else{
                        for(let i = 0; i < result.list.length; i++){
                            ajaxResult(result, i);
                        }
                        $("#goodsListContent>div").addClass("goodsListInfo");
                        $("#goodsListContent>div").addClass("ajaxClick");
                        $(".goodsThumbnail_Info>img").css({"height":"100%", "margin":"0px"});
                    }
                    ajaxTotalList(result);
                    pageBar(result);
                }, 
	            error : function(){
	            	console.log("실패");
	            }
            });
        }
    </script>

    <!-- 총 게시글 수 -->
    <script>
        function ajaxTotalList(result){
            $("#all_list .listCount").text(result.totalCount);
            $("#sale_list .listCount").text(result.onSaleCount);
            $("#soldOut_list .listCount").text(result.offSaleCount);
            $("#hide_list .listCount").text(result.hideCount);
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
    
    <!-- ajax 결과 데이터 처리 -->
    <script>
        function ajaxResult(result, i){
            let resultStr = "";
            let date = result.list[i].enrollDate;
            year = date.substring(8,12);
            month = date.substring(0,2);
            day = date.substring(4,6);
            let status = result.list[i].status;
            switch(status){
                case 'Y':
                    status = '판매중';
                    break;
                case 'N':
                    status = '품절';
                    break;
                case 'H':
                    status = '숨김';
                    break;
            }

            resultStr += "<div class='goodsNo_checkbox'>"
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

    <!-- 상품정보수정 클릭 이벤트 -->
    <script>
        $(document).on("click", ".ajaxClick", function(){
            let goodsNo = $(this).find(".labelClass").text();
            goodsUpdateAjax(goodsNo);
        })
    </script>

    <!-- 상품정보불러오기 ajax통신 -->
    <script>
        function goodsUpdateAjax(goodsNo){
            $(".choiceMenuBar").css({
                "height" : 450,
                "border" : "5px double rgb(255, 129, 97)"
            });
            $.ajax({
                url : "ajaxGoodsDetail.ma",
                type : "get",
                data : {
                    goodsNo : goodsNo
                },
                success(result){
                    $("#choiceName").text(result.goodsName);
                    $("#choiceNo").text(result.goodsNo);
                    $("#choicePrice>input").val(result.price);
                    $("#choiceTotalStock>input").val(result.totalStock);
                    $("#choiceStock>input").val(result.remainStock);
                    $("#choiceDiscount>input").val(parseFloat(result.discount)*100);
                    $("#choiceStatus option").attr("selected", false);
                    $("#choiceStatus option[value="+ result.status +"]").attr("selected", true);
                },
                error(){
                    $(function(){
                        alertify.success('상품의 정보를 불러오지 못했습니다.');
                    })
                }
            });
        }
    </script>

    <!-- 상품정보수정 버튼 이벤트 -->
    <script>
        $(".submitBtn").click(()=>{
            let goodsNo = $("#choiceNo").text();
            let price = $("#choicePrice>input").val();
            let totalStock = $("#choiceTotalStock>input").val();
            let remainStock = $("#choiceStock>input").val();
            let discount = ($("#choiceDiscount>input").val()/100);
            let status = $("#goodsStatus").val();

            let errorMsg = "";
	        if(price < 0 || discount > 1 || discount < 0 || totalStock < 0 || remainStock < 0){
	            if(price < 0){
	                errorMsg += "정상적인 가격을 입력해주세요.<br>";
	            }

                if(totalStock < 0 || remainStock < 0){
                    errorMsg += "비정상적인 재고 수량을 입력하셨습니다.<br>";
                }

                if(discount > 1 || discount < 0){
	                errorMsg += "정상적인 할인율을 입력해주세요(최대 100%)<br>";
	            }
	            
	            alertify.alert('등록 오류<br>해당 이유로 등록이 불가능 합니다.', errorMsg, function(){ alertify.success('상품이 등록되지 않았습니다.'); });
	        }
            else{
                if(parseInt(totalStock) < parseInt(remainStock)){
                    totalStock = remainStock;
                }

                if(remainStock == 0 && status == 'Y'){
                    status = 'N'
                }

                ajaxGoodsDetailUpdate(goodsNo, price, totalStock, remainStock, discount, status);
            }
        });
    </script>
    
    <!-- 상품정보수정 ajax통신 -->
    <script>
        function ajaxGoodsDetailUpdate(goodsNo, price, totalStock, remainStock, discount, status){
            $.ajax({
                url : "ajaxGoodsDetailUpdate.ma",
                type : "get",
                data : {
                    goodsNo : goodsNo,
                    price : price,
                    totalStock : totalStock,
                    remainStock : remainStock,
                    discount : discount,
                    status : status
                },
                success(result){
                    if(result == true){
                        $(function(){
                            alertify.success('상품 정보를 수정했습니다.');
                            let pageNumber = parseInt($(".thisNum").text());
                            ajaxGoodsList(pageNumber, state);
                            goodsUpdateAjax(goodsNo);
                        })
                    }
                    else{
                        $(function(){
                            alertify.success('상품 정보를 수정하지 못했습니다.');
                        })
                    }
                },
                error(){
                    $(function(){
                        alertify.success('통신실패!<br>상품 정보를 수정하지 못했습니다.');
                    })
                }
            });
        }
    </script>

    <!-- 상품 상세 내용 수정 이벤트(페이지 이동) -->
    <script>
        $(".updateBtn").click(()=>{
            let goodsNo = $("#choiceNo").text();
            location.href = "adminUpdateGoods.ma?goodsNo="+goodsNo;
        })
    </script>
</html>