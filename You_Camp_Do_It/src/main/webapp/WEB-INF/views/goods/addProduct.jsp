<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>관리자 메뉴</title>
        <!-- 폰트추가 -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Dongle&family=Jua&family=Nanum+Pen+Script&family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Yeon+Sung&display=swap" rel="stylesheet">

        <!-- 섬머노트 추가 -->
        
        <!--
        <script src="resources/js/summernote/lang/summernote-ko-KR.js"></script>
        <script src="resources/js/summernote/summernote-lite.js"></script>
        <link rel="stylesheet" href="resources/css/summernote/summernote-lite.css">
		-->
		
        <style>
            div{
                box-sizing: border-box;
                /*border: 1px solid red;*/
            }
            #outer{
				width: 1900px;
				display: flex;
                height: 920px;
			}

            .goods_enrollment{
                width: 1650px;

                /*
                font-family: "Yeon Sung", system-ui;
                font-weight: 400;
                font-style: normal;
                */
            }

            .title_enrollment{
                width: 100%;
                height: 50px;
                font-size: 30px;
                display: flex;
                justify-content: space-between;
            }
            .content_enrollment{
                width: 100%;
                height: 870px;
                display: flex;

                background-color: rgb(221, 221, 221);
            }

            .main_enrollment{
                width: 70%;
                height: 100%;
            }

            .sub_enrollment{
                width: 30%;
                height: 100%;
            }

            .productBasic{
                width: 100%;
                height: 325px;
                margin-top: 20px;
                display: flex;
                justify-content: space-evenly;
            }

            .productForm{
                width: 500px;
                height: 300px;
                border: 1px solid rgba(156, 156, 156, 0.3);
                background-color: white;
                padding-inline: 20px;
            }

            #Thumbnail_Area{
                width: 100%;
                height:260px;
                margin-top: 10px;
                text-align: center;

                cursor: pointer;
            }

            #Thumbnail_Area>img{
                margin-top: 60px;
                height: 30%;
            }

            #fileCall
			{
				visibility: hidden;
			}

            .productInput{
                width: 95%;
                margin-top: 5px;
                border-width: 0 0 2px;
                border-color: rgb(141, 171, 255);
                outline: none;
            }

            .detail_content{
                width: 92.5%;
                height: 470px;
                margin: auto;
                margin-top: 25px;
                border: 1px solid rgba(156, 156, 156, 0.3);
                background-color: white;
                padding: 20px;
            }

            .sub_enrollment{
                margin: 20px;
                height: 750px;
                border: 1px solid rgb(231, 231, 231);
                background-color: rgb(255, 255, 255);
                box-shadow: 5px 0px 5px 0px rgba(128, 128, 128, 0.363);
                padding: 20px;
                font-size: 20px;
                position: relative;
            }

            .select_Category{
                width: 88%;
                height: 0px;
                z-index: 5;
                padding-inline: 20px;
                padding-top: 0px;
                border: 0px solid rgba(156, 156, 156, 0.3);
                box-shadow: 0px 0px 0px rgba(128, 128, 128, 0.363);
                border-radius: 15px;
                overflow: hidden;
				transition: all 1s;
                position: absolute;
                background-color: white;
            }

            .category_header{
                height: 32px;
            }

            .category_body{
                padding-left: 30px;
                height: 32px;
                display: flex;
            }

            .category_body:hover{
                background-color: rgb(218, 218, 218);
                cursor: pointer;
                
            }

            input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
                -webkit-appearance: none;
            }

            .detail_header{
                margin-bottom: 10px;
            }

            #detail_summernote{
                width: 100%;
                height: 100%;
            }
        </style>
    </head>
    <body>
        <div id="outer">
            <jsp:include page="/WEB-INF/views/admin/pageManagerMenu.jsp"></jsp:include>
            <c:if test="${ not empty sessionScope.alertMsg }">
                <script>
                    alertify.alert('등록 결과', '${ sessionScope.alertMsg }', function(){ alertify.success('상품이 등록되었습니다.'); });
                </script>
                <c:remove var="alertMsg" scope="session" />
            </c:if>

            <c:if test="${ not empty sessionScope.errorMsg }">
                <script>
                    alertify.alert('등록 결과', '${ sessionScope.errorMsg }', function(){ alertify.success('상품이 등록에 실패했습니다.'); });
                </script>
                <c:remove var="errorMsg" scope="session" />
            </c:if>
            <div class="goods_enrollment">
                <div class="title_enrollment">
                    <div style="line-height: 47px; padding-left: 20px;">상품 등록</div>
                    <input id="fileCall" type="file" onchange="loadImg(this);">
                    <div style="padding-right: 20px;">
                        <button class="btn" style="background-color: rgb(147, 255, 195);">취소</button>
                        <button id="submit" class="btn" style="background-color: rgb(88, 199, 190);">등록</button>
                    </div>
                </div>
                <div class="content_enrollment">
                    <div class="main_enrollment">
                        <div class="productBasic">
                            <div id="productThumbnail" class="productForm">
                                <div style="padding: 10px; height: 30px; display: flex; justify-content: space-between;">
                                    <div>섬네일이미지</div>
                                    <div>이미지 삽입</div>
                                </div>
                                <div id="Thumbnail_Area">
                                    <img src="resources/images/goods/이미지삽입.png" onclick="onImg()" class="temporary"><br>
                                    <div class="temporary" style="color: rgba(0, 0, 0, 0.5);">여기를 눌러 이미지 추가</div>
                                </div>
                            </div>
                            <div id="productInfo" class="productForm">
                                <div id="productInfo_header">
                                    <div style="padding-top: 10px;">상품명</div>
                                    <div><input id="goodsTitle" type="text" class="productInput" name="" value="" maxlength="200" autocomplete="off"></div>
                                    <div style="color: rgba(0, 0, 0, 0.5);">요약 설명. 상품 상세정보 상단에 출력됩니다.</div>
                                </div>
                                <div id="goodsInfo">
                                </div>
                            </div>
                        </div>
                        <div class="detail_content">
                            <div class="detail_header">
                                상세설명
                            </div>
                            <div id="goodsContent">
                            </div>
                        </div>
                    </div>
                    <div class="sub_enrollment">
                        <div>분류</div>
                        <div><input type="text" id="category" class="productInput" name="category" value="" maxlength="200" autocomplete="off" readonly Placeholder="카테고리를 선택해주세요"></div>
                        <div class="select_Category">
                            <div class="category_header">카테고리</div>
                            <div class="category_body">
                                <div>➥</div>
                                <div style="width: 10px;"></div>
                                <div class="val">쉘터/텐트</div>
                            </div>
                            <div class="category_body">
                                <div>➥</div>
                                <div style="width: 10px;"></div>
                                <div class="val">침낭/방한용품</div>
                            </div>
                            <div class="category_body">
                                <div>➥</div>
                                <div style="width: 10px;"></div>
                                <div class="val">의자/테이블</div>
                            </div>
                            <div class="category_body">
                                <div>➥</div>
                                <div style="width: 10px;"></div>
                                <div class="val">화로/버너/전자</div>
                            </div>
                            <div class="category_body">
                                <div>➥</div>
                                <div style="width: 10px;"></div>
                                <div class="val">식기/아이스박스</div>
                            </div>
                            <div class="category_body">
                                <div>➥</div>
                                <div style="width: 10px;"></div>
                                <div class="val">연료/가스</div>
                            </div>
                            <div class="category_body">
                                <div>➥</div>
                                <div style="width: 10px;"></div>
                                <div class="val">식자재</div>
                            </div>
                            <div class="category_body">
                                <div>➥</div>
                                <div style="width: 10px;"></div>
                                <div class="val">생활용품</div>
                            </div>
                        </div>
                        <div style="height: 30px;"></div>
                        <div>브랜드</div>
                        <div><input id="brand" type="text" class="productInput" name="brand" value="" maxlength="200" autocomplete="off" Placeholder="브랜드를 입력해주세요"></div>
                        <div style="height: 30px;"></div>
                        <div>가격</div>
                        <div><input id="price" type="number" class="productInput" name="price" value="0" maxlength="200" autocomplete="off" Placeholder="가격을 입력해주세요" min="0"></div>
                        <div style="height: 30px;"></div>
                        <div>재고수량</div>
                        <div><input id="totalStock" type="number" class="productInput" name="totalStock" value="0" maxlength="200" autocomplete="off" Placeholder="재고를 입력해주세요" min="0"></div>
                    </div>
                </div>
			</div>
        </div>
    </body>
    <!-- 시작 시 현재 메뉴 부분 강조 -->
    <script>
        let imgSwitch = false;
	    $(document).ready(function(){
	        let count = $("#Product").next().children().length;
	        $("#Product").next().css("border-color", "rgb(26, 187, 156, 1.0)");
			$("#Product").children(".head_node_right").text("▼");
			$("#Product").next().css("height", count*35);
	
			$("#ProductRegister").children().css("color","red");
	    });
    </script>
    
    <!-- 인풋 요소 강조 -->
    <script>
	    $(".productInput").on("focus", function(){
	        $(this).css("border-color", "rgb(28, 89, 255)");
	    });
	
	    $(".productInput").on("blur", function(){
	        $(this).css("border-color", "rgb(141, 171, 255)");
	    });
	</script>
	
	<!-- 카테고리 드롭바 관련 -->
	<script>
	    $("#category").on("focus", function(){
	        $(".select_Category").css("padding-top", 20).css("border", "1px solid rgba(156, 156, 156, 0.3)").css("box-shadow", "5px 5px 5px rgba(128, 128, 128, 0.363)").css("height", 328);
	        
	    });
	
	    $("#category").on("blur", function(){
	        $(".select_Category").css("padding-top", 0).css("border", "0px solid rgba(156, 156, 156, 0.3)").css("box-shadow", "0px 0px 0px rgba(128, 128, 128, 0.363)").css("height", 0);
	    });
	
	    $(".category_body").on("click", function(){
	        let selectC = $(this).children(".val").text();
	        console.log(selectC);
	        $("#category").val(selectC);
	    });
	   
	</script>
	
    <!-- 섬네일 이미지 등록 -->
	<script>
	    function onImg(){
		    let myInput = document.getElementById("fileCall");
		    myInput.click();
	    }
	
	    function loadImg(inputFile)
	    {
            let reader = new FileReader();
            reader.readAsDataURL(inputFile.files[0]);
            reader.onload = function(e)
            {
                var createImg = document.createElement("img");
                var createDiv = document.createElement("div");
                createImg.src = e.target.result;
                createDiv.id = "Thumbnail_Img"
                $("#Thumbnail_Area").children().remove();
                document.getElementById("Thumbnail_Area").appendChild(createDiv);
                document.getElementById("Thumbnail_Img").appendChild(createImg);
                $("#Thumbnail_Img").css("width", "100%").css("height", 260).css("margin-top", 10).css("cursor", "pointer");
                $("#Thumbnail_Img>img").css("height", "170px").css("margin-top", 30);
                $("#Thumbnail_Img").click(function(){
                    onImg();
                });
                
                imgSwitch = true;
            }
        }
	</script>
	
    <!-- 상품 기본 내용 서머노트 -->
	<script>
	    $(function () {
	        $("#goodsInfo").summernote({
	            lang: 'ko-KR',
                width: '100%',   //가로값 설정
                height: 100,    // 높이값 설정
                toolbar: [
                    // [groupName, [list of button]]
                    ['fontname', ['fontname']],
                    ['fontsize', ['fontsize']],
                    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
                    ['color', ['forecolor','color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                ],
                fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
                fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
                disableResizeEditor: true
            });
	    });
	
        $(function () {
            $("#goodsContent").summernote({
                lang: 'ko-KR',
                width: '100%',   //가로값 설정
                height: 340,    // 높이값 설정
                toolbar: [
                    // [groupName, [list of button]]
                    ['fontname', ['fontname']],
                    ['fontsize', ['fontsize']],
                    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
                    ['color', ['forecolor','color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                    ['insert',['picture','link','video']],
                ],
                fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
                fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
                disableResizeEditor: true
            });
        });
	</script>
	<script>
	    $("#submit").click(function(){
	        let productThumbnail = $("#Thumbnail_Area").html();
	        let goodsTitle = $("#goodsTitle").val();
	        let goodsInfo = $("#goodsInfo").summernote('code');
	        let category = $("#category").val();
	        let brand = $("#brand").val();
	        let price = $("#price").val();
	        let totalStock = $("#totalStock").val();
	        let goodsContent = $("#goodsContent").summernote('code');
	
	        let errorMsg = "";
	        if(goodsTitle == "" || category == "" || goodsTitle.length > 20 || imgSwitch == false){
	            if(goodsTitle == ""){
	                errorMsg += "상품의 이름이 입력되지 않았습니다.<br>";
	            }
	
	            if(goodsTitle.length > 20){
	                errorMsg += "상품의 이름이 너무 깁니다. 20자로 제한해주세요.<br>";
	            }
	
	            if(category == ""){
	                errorMsg += "상품이 분류되지 않았습니다.<br>";
	            }

                if(imgSwitch == false){
                    errorMsg += "상품의 섬네일 이미지가 등록되지 않았습니다.<br>";
                }
	            
	            alertify.alert('등록 오류<br>해당 이유로 등록이 불가능 합니다.', errorMsg, function(){ alertify.success('상품이 등록되지 않았습니다.'); });
	        }
	        else{
	            let formData = new FormData();
	            formData.append('goodsThumbnail', productThumbnail);
	            formData.append('goodsName', goodsTitle);
	            formData.append('goodsInfo', goodsInfo);
	            formData.append('category', category);
	            formData.append('mark', brand);
	            formData.append('price', price);
	            formData.append('totalStock', totalStock);
	            formData.append('goodsContent', goodsContent);
	
	            $.ajax({
	                url : "enrollGoods.gs",
	                type : "post",
	                data : formData,
	                contentType: false,
	                processData: false,
	                success : function(result)
	                {
	                    location.replace(result);
	                },
	                error : function()
	                {
	                    console.log("실패");
	                }
	            });
	        }
	    });
	</script>
</html>