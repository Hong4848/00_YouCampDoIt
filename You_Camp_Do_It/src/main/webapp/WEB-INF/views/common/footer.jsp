<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* div{border:1px solid red;} */
        #footer {
            width:80%;
            height:200px;
            margin:auto;
            margin-top:50px;
        }
        #footer-1 {
            width:100%;
            height:20%;
            border-top:1px solid lightgray;
            border-bottom:1px solid lightgray;
        }
        #footer-2 {width:100%; height:80%;}
        #footer-1, #footer-2 {padding-left:50px;}
        #footer-1>a {
            text-decoration:none;
            font-weight:600;
            margin:10px;
            line-height:40px;
            color:black;
        }
        #footer-2>p {
            margin:0;
            padding:10px;
            font-size:13px;
        }
        #p2 {text-align:center;}
        
        .modal {
		    display: none; /* 초기 상태 */
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
		    z-index: 1000;
		    justify-content: center;
		    align-items: center;
		}
		
		.modal_content {
		    background: #fff;
		    padding: 20px;
		    border-radius: 8px;
		    max-width: 600px;
		    width: 90%;
		    height: auto;
		    text-align: center;
		    position: relative;
		    overflow-y: auto; /* 내용이 많으면 스크롤 가능하도록 설정 */
		    max-height: 80%; /* 모달이 너무 커지지 않게 최대 높이 제한 */
		}
		
		.close_modal {
		    position: absolute;
		    top: 10px;
		    right: 10px;
		    background: none;
		    border: none;
		    font-size: 16px;
		    cursor: pointer;
		}
		
		.modal_cover {
		    position: absolute;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background: transparent;
		}
    </style>
</head>
<body>
    <div id="footer">
        <div id="footer-1">
            <a href="javascript:void(0);" id="showPrivacyPolicy">개인정보취급방침</a> | 
            <a href="javascript:void(0);" id="showEmailPolicy">이메일무단수집거부</a> | 
            <a href="#">오시는길</a> 
        </div>

        <div id="footer-2">
            <p id="p1">
                캠핑장 주소 : 인천광역시 강화군 화도면 해안남로 2478번길 15  <br>
                상호명 : You Camp Do It 대표 정성민 032-246-8468
            </p>
            <p id="p2">Copyright © 1998-2024 You Camp Do It All Right Reserved</p>
        </div>
        
        
         <!-- 개인정보취급방침 모달 -->
	    <div id="privacyModal" class="modal" style="display: none;">
	        <div class="modal_cover"></div>
	        <div class="modal_content">
	            <button id="closePrivacyModal" class="close_modal">닫기</button>
	            <div id="privacyContent">
	                <!-- 약관 내용이 여기에 동적으로 삽입됩니다 -->
	            </div>
	        </div>
	    </div>
	    
	    <!-- 이메일무단수집방침 모달 -->
	    <div id="emailModal" class="modal" style="display: none;">
	        <div class="modal_cover"></div>
	        <div class="modal_content">
	            <button id="closeEmailModal" class="close_modal">닫기</button>
	            <div id="emailContent">
	                <!-- 약관 내용이 여기에 동적으로 삽입됩니다 -->
	            </div>
	        </div>
	    </div>
        
        
        <script>
        $(document).ready(function () {
            // 개인정보취급방침 모달
            $("#showPrivacyPolicy").on("click", function () {
                $.ajax({
                    url: "<%= request.getContextPath() %>/privacy-policy", // 서버 URL
                    method: "GET",
                    dataType: "html",
                    success: function (data) {
                        $("#privacyContent").html(data);
                        $("#privacyModal").css("display", "flex");
                    },
                    error: function () {
                        alert("약관 내용을 불러오는 데 실패했습니다.");
                    }
                });
            });

            $("#closePrivacyModal, #privacyModal .modal_cover").on("click", function () {
                $("#privacyModal").css("display", "none");
            });

            // 이메일무단수집방침 모달
            $("#showEmailPolicy").on("click", function () {
                $.ajax({
                    url: "<%= request.getContextPath() %>/email-policy", // 서버 URL
                    method: "GET",
                    dataType: "html",
                    success: function (data) {
                        $("#emailContent").html(data);
                        $("#emailModal").css("display", "flex");
                    },
                    error: function () {
                        alert("약관 내용을 불러오는 데 실패했습니다.");
                    }
                });
            });

            $("#closeEmailModal, #emailModal .modal_cover").on("click", function () {
                $("#emailModal").css("display", "none");
            });
        });
		</script>
    </div>
</body>