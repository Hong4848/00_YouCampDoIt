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
                width: 7%;
                height: 100%;
                margin-left: 20px;
                text-align: left;
            }

            
            
            .memberName_Info{
                width: 14%;
                height: 100%;
                text-align: left;
            }

            .startDate_Info{
                width: 17%;
                height: 100%;
            }

            .endDate_Info{
                width: 17%;
                height: 100%;
            }
            
            .nights_Info{
                width: 12%;
                height: 100%;
            }

            .memberCount_Info{
                width: 14%;
                height: 100%;
            }
            
            .paymentStatus_Info{
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
                margin-bottom: 0px;
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
            	cursor:pointer;
            }
            
            /* 목록조회 스타일 */
			



            
        </style>
    </head>
    <body>
        <div id="outer">
            <jsp:include page="/WEB-INF/views/admin/pageManagerMenu.jsp"></jsp:include>
            <div class="manager_content">
				<div class="management_title">
                    <div style="line-height: 47px; padding-left: 20px;">예약 정보 관리</div>
                    <div style="padding-right: 20px;">
                        
                    </div>
                </div>
                <div class="management_content">
                    <div class="choiceMenuBar">
                        <div id="choiceGoods">
                            <div id="choiceName">예약 상세정보</div>
                            <div id="choiceDetail">
                                <div id="choiceDetailTitle">
                                	<div>예약번호</div>
                                    <div>회원이름</div>
                                    <div>결제날짜</div>
                                    <div>결제금액</div>
                                    <div>결제방식</div>
                                    <div>섹션</div>
                                    <div>자리</div>
                                    <div>결제상태</div>
                                </div>
                                <div id="choiceDetailContent">
                                    <div style="display:none" id="x">1</div>
                                    <div id="reserveNo" style="text-align: right;">
                                        <input class="inputType" type="text" value="0" readOnly>
                                    </div>
                                    <div id="memberName">
                                        <input class="inputType" type="text" value="0" readOnly>
                                    </div>
                                    <div id="paymentDate">
                                        <input class="inputType" type="text" value="0" readOnly>
                                    </div>
                                    <div id="price">
                                        <input class="inputType" type="text" value="0" readOnly>
                                    </div>
                                    <div id="paymentMethod">
                                        <input class="inputType" type="text" value="0" readOnly>
                                    </div>
                                    
                                    <div id="section">
                                        <input class="inputType" type="text" value="0" readOnly>
                                    </div>
                                    <div id="spotNo">
                                        <input class="inputType" type="number" value="0" readOnly>
                                    </div>
                                    <div id="choiceStatus">
                                        <select name="goodsStatus" id="goodsStatus">
                                        	<option value="CREATED">결제요청</option>
                                        	<option value="PAID">결제완료</option>
                                            <option value='CANCELED'>결제취소요청</option>
                                            <option value='REFUNDED'>결제취소완료</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div style="text-align: right; margin-right: 20px;">
                            	<button class="btn btn-sm btn-danger submitBtn">결제상태 수정</button>
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
                        <div id="forest_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">포레스트</div>
                                <div class="listCount">0</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                        <div id="belly_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">밸리</div>
                                <div class="listCount">0</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                        <div id="sky_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">스카이</div>
                                <div class="listCount">0</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                        <div id="stone_list" class="listClass">
                            <div class="listContent">
                                <div class="listName">스톤</div>
                                <div class="listCount">0</div>
                            </div>
                            <div class="listLine"></div>
                        </div>
                        
                    </div>
                    
                    <div class="goodsList">
                        <div class="goodsListInfo">
                            <div class="goodsNo_checkbox">
                                <label class="labelClass" for="">예약번호</label>
                            </div>
                            <div class="memberName_Info" style="text-align: center;">
                                회원이름
                            </div>
                            <div class="startDate_Info">
                                체크인
                            </div>
                            <div class="endDate_Info">
                                체크아웃
                            </div>
                            <div class="nights_Info">
                                숙박일
                            </div>
                            <div class="memberCount_Info">
                                이용자수
                            </div>
                            <div class="paymentStatus_Info">
                                결제상태
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
            let count = $("#User").next().children().length;
            $("#User").next().css("border-color", "rgb(26, 187, 156, 1.0)");
            $("#User").children(".head_node_right").text("▼");
            $("#User").next().css("height", count*35);

            $("#reservationInfo").children().css("color","red");
            ajaxGoodsList(1, state);
            
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
            console.log(state);
        });
    </script>

    <!-- ajax 통신 -->
    <script>
        function ajaxGoodsList(pageNumber, state){
            $.ajax({
                url : "ajaxReserveManagement.res",
	            type : "get",
                data : {
                    pageNumber : pageNumber,
                    state : state
                },
	            success : function(result){
                    let listClass = $(".targetList .listName").text();
                    $("#goodsListContent").children().remove();
                    $("#pagingArea").children().remove();
                    $("#goodsListContent").text("");
                    
                    
                    if(result.list.length == 0){
                        let imgD = document.createElement("img")
                        imgD.src = "resources/images/admin/등록된 정보가 없습니다.png";
                        let noData = "등록된 예약 정보가 없습니다.";
                        
                        $("#goodsListContent>img").css("height", "90%");
                        $("#goodsListContent").html("<br>" + noData);
                        
                    } else {
                    	
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
            $("#forest_list .listCount").text(result.forestCount);
            $("#belly_list .listCount").text(result.bellyCount);
            $("#sky_list .listCount").text(result.skyCount);
            $("#stone_list .listCount").text(result.stoneCount);
            
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
            
            let startDate = result.list[i].startDate.substring(0,10);
            let endDate = result.list[i].endDate.substring(0,10);

			
            
            let status = result.list[i].paymentStatus;
            switch(status){
                case 'CREATED':
                    status = '결제요청';
                    break;
                case 'PAID':
                    status = '결제완료';
                    break;
                case 'CANCELED':
                    status = '결제취소요청';
                    break;
                case 'REFUNDED':
                    status = '결제취소완료';
                    break;
            }
            
            
            

            resultStr += "<div class='goodsNo_checkbox'>"
                            + "<label class='labelClass' for='check_" + (i+1) + "'>"+ result.list[i].reserveNo +"</label>"
                        + "</div>"
                        + "<div class='memberName_Info' style='text-align:center;'>"
                            + result.list[i].memberName
                        + "</div>"
                        + "<div class='startDate_Info'>"
                            + startDate
                        + "</div>"
                        + "<div class='endDate_Info'>"
                            + endDate
                        + "</div>"
                        + "<div class='nights_Info'>"
                            + result.list[i].nights
                        + "</div>"
                        + "<div class='memberCount_Info'>"
                            + result.list[i].memberCount
                        + "</div>"
                        + "<div class='paymentStatus_Info'>"
                            + status
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
            let reserveNo = $(this).find(".labelClass").text();
            goodsUpdateAjax(reserveNo);
        })
    </script>

    <!-- 상품정보불러오기 ajax통신 -->
    <script>
        function goodsUpdateAjax(reserveNo){
            $(".choiceMenuBar").css({
                "height" : 550,
                "border" : "5px double rgb(255, 129, 97)"
            });
            $.ajax({
                url : "ajaxReserveDetail.res",
                type : "get",
                data : {
                    reserveNo : reserveNo
                },
                success(result){
                	console.log(result);
                    console.log(result.section);
                    
                    
                    let rNo = result.reserveNo.toString();
                    let paymentDate = result.paymentDate.substring(0, 10);
                    let price = result.price.toLocaleString('ko-KR') + "원";
                    let section = "";
                    let paymentStatus = "";
                    if(result.section == "A"){
                    	section = "포레스트"
                    } else if(result.section == "B") {
                    	section = "밸리"
                    } else if(result.section == "C") {
                    	section = "스카이"
                    } else {
                    	section = "스톤"
                    }
                    
                    if(result.paymentStatus == "CREATED"){
                    	paymentStatus = "결제요청"
                    } else if(result.paymentStatus == "PAID") {
                    	paymentStatus = "결제완료"
                    } else if(result.paymentStatus == "CANCELED") {
                    	paymentStatus = "결제취소요청"
                    } else {
                    	paymentStatus = "결제취소완료"
                    }
                    
                    $("#reserveNo>input").val(rNo);
                    
                    $("#memberName>input").val(result.memberName);
                    $("#paymentDate>input").val(paymentDate);
                    $("#price>input").val(price);
                    $("#paymentMethod>input").val(result.paymentMethod);
                    $("#section>input").val(section);
                    $("#spotNo>input").val(result.spotNo);
                    $("#choiceStatus option").attr("selected", false);
                    $("#choiceStatus option[value="+ result.paymentStatus +"]").attr("selected", true);
                    
                },
                error(){
                    $(function(){
                        alertify.success('예약 정보를 불러오지 못했습니다.');
                    })
                }
            });
        }
    </script>

    <!-- 상품정보수정 버튼 이벤트 -->
    <script>
        $(".submitBtn").click(()=>{
            let reserveNo = $("#reserveNo>input").val();
            let status = $("#goodsStatus").val();

            
	        console.log(reserveNo);
	        console.log(status);

            ajaxGoodsDetailUpdate(reserveNo, status);
            
        });
    </script>
    <!-- 상품정보수정 ajax통신 -->
    <script>
        function ajaxGoodsDetailUpdate(reserveNo, status){
            $.ajax({
                url : "ajaxReserveDetailUpdate.me",
                type : "get",
                data : {
                    reserveNo : reserveNo,
                    paymentStatus : status
                },
                success(result){
                    if(result == true){
                        $(function(){
                            alertify.success('예약 정보를 수정했습니다.');
                            let pageNumber = parseInt($(".thisNum").text());
                            ajaxGoodsList(pageNumber, state);
                            goodsUpdateAjax(reserveNo);
                        })
                    }
                    else{
                        $(function(){
                            alertify.success('예약 정보를 수정하지 못했습니다.');
                        })
                    }
                },
                error(){
                    $(function(){
                        alertify.success('통신실패!<br>예약 정보를 수정하지 못했습니다.');
                    })
                }
            });
        }
    </script>
</html>