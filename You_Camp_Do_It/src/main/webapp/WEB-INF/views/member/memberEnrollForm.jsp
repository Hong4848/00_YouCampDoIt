<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
        .wrap-signup {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            
            display: flex;
            justify-content: center;
            align-items: center;
            height: 1000px
            
        }

        .signup-container {
            background-color: #E5F8F5;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 600px; /* 컨테이너 고정 너비 */
        }

        h1 {
            font-size: 24px;
            text-align: center;
            margin-bottom: 10px;
        }
        
        .signup-container h1 {
        	font-size: 31px
        }

        .required-info {
            font-size: 14px;
            text-align: center;
            color: #666;
            margin-bottom: 20px;
            text-align: right;
        }

        form {
            width: 100%; /* 폼 너비 */
        }

        form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            font-size: 14px;
        }

        form input {
            width: 100%; /* 입력 필드 너비 동일화 */
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .input-group {
            display: flex;
            gap: 10px;
            width: 100%; /* 그룹 너비 고정 */
        }

        .input-group input {
            flex: 1; /* 버튼과 입력 필드 간 비율 조정 */
            width: auto;
        }

        .input-group .btn {
       		background-color: #5a4bcf;
            width: 30%; /* 버튼의 비율 고정 */
            flex-shrink: 0;
            height: 43px;
            color: white;
        }

        .btn {
            background-color: #5a4bcf;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        

        .btn-submit {
            width: 100%; /* 회원가입 버튼도 동일한 너비 */
            background-color: #5a4bcf;
            padding: 12px;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            border: 1px white solid;
        }

        .btn-submit:hover {
            background-color: #4b3bb0;
            color: white;
        }
        .btn:hover {
            background-color: #4b3bb0;
            color: white;
            
        }

        .hidden {
            display: none;
        }



    </style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<div class="wrap-signup">
	    <div class="signup-container">
	        <h1>회원가입</h1>
	        <p class="required-info">*필수입력사항</p>
	        <form action="insert.me" method="post" id="enrollForm" >
	            <!-- 아이디 -->
	            <label for="memberId">아이디*</label>
	            <div class="input-group">
	                <input type="text" id="memberId" name="memberId" placeholder="아이디를 입력하세요" required>
	                <button type="button" id="checkId" class="btn">중복확인</button>
	            </div>
	
	            <!-- 비밀번호 -->
	            <label for="memberPwd">비밀번호*</label>
	            <input type="password" id="memberPwd" name="memberPwd" placeholder="비밀번호를 입력하세요" required>
	
	            <!-- 비밀번호 확인 -->
	            <label for="checkPwd">비밀번호 확인*</label>
	            <input type="password" id="checkPwd" name="checkPwd" placeholder="비밀번호를 한번 더 입력하세요" required>
	
	            <!-- 이름 -->
	            <label for="memberName">이름*</label>
	            <input type="text" id="memberName" name="memberName" placeholder="이름을 입력하세요" required>
	
	            <!-- 이메일 -->
	            <label for="email">이메일 주소*</label>
	            <div class="input-group">
	                <input type="email" id="email" name="email" placeholder="이메일 주소를 입력하세요" required>
	                <button type="button" class="btn" id="sendCodeButton">인증번호 받기</button>
	            </div>
	
	            <!-- 인증번호 입력 (초기 숨김 처리) -->
	            <div id="verificationFields" class="hidden">
	                <label for="verificationCode">인증번호*</label>
	                <div class="input-group">
	                    <input type="text" id="verificationCode" name="verificationCode" placeholder="인증번호 6자리를 입력하세요">
	                    <button type="button" id="checkCode" class="btn">인증하기</button>
	                </div>
	            </div>
	
	            <!-- 전화번호 -->
	            <label for="phone">전화번호*</label>
	            <input type="text" id="phone" name="phone" placeholder="전화번호를 입력하세요(-포함)" required>
	
	            <!-- 생년월일 -->
	            <label for="birthDate">생년월일*</label>
	            <input type="date" id="birthDate" name="birthDate" required>
	
	            <!-- 도로명 주소 -->
	            <label for="address">도로명 주소*</label>
	            <input type="text" id="address" name="address" placeholder="도로명 주소를 입력하세요" required>
	
	            <!-- 회원가입 버튼 -->
	            <button type="submit" class="btn-submit">회원가입</button>
	        </form>
	    </div>
    </div>


    <script>
        $(function() {
            // '인증번호 받기' 버튼 클릭 시 인증번호 입력 필드 보이기
            $("#sendCodeButton").click(function() {
                $("#verificationFields").removeClass("hidden");
                // $(".wrap-signup").css("height", "1300px");
            });
            
            
            
            // 아이디 중복체크 이벤트
            /*
            const $idInput = $("#enrollForm input[name=memberId]");
            
            $idInput.keyup(function() {
            	
            	let checkId = $(this).val();
            	
				if(checkId.length >= 5) {
					
					// 5글자 이상일 경우
					// 아이디 중복체크 진행
					$.ajax({
						url : "idCheck.me",
						type : "get",
						data : {
							checkId : checkId
						},
						success : function(result) {
							
							// console.log(result);
							
							if(result == "NNNNN") {
								// 사용 불가 아이디
								
								$("#checkResult").show()
												 .css("color", "red")
												 .text("중복된 아이디가 이미 존재합니다. 다시 입력해주세요.");
								
								// 회원가입 버튼 비활성화
								$("#enrollForm button[type=submin]").attr("disabled", true);
							} else {
								// 사용 가능 아이디
								
								$("#checkResult").show()
												 .css("color", "green")
												 .text("멋진 아이디네요!");
								
								// 회원가입 버튼 활성화
								$("#enrollForm button[type=submit]").attr("disabled", false);
								
							}
							
						},
						error : function() {
							console.log("아이디 중복 체크용 ajax 통신 실패!");
						}
						
					});
				} else {
					
					// 5글자 미만일 경우
					// > 회원가입 버튼 비활성화, 메세지 내용 숨기기
					$("#enrollForm button[type=submit]").attr("disabled", true);
					$("#checkResult").hide();
					
				}
            	
            });
            */
            
            
        });
        
        
        
        
        
        
    </script>
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>