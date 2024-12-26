<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
     .wrap-signup {
         font-family: Arial, sans-serif;
         background-color: #f8f8f8;
         
         display: flex;
         justify-content: center;
         align-items: center;
         height: 700px
         
     }

     .signup-container {
         background-color: #E5F8F5;
         padding: 20px 30px;
         border-radius: 10px;
         box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
         width: 600px; /* 컨테이너 고정 너비 */
         height: 80%;
     }

     h1 {
         font-size: 24px;
         text-align: center;
         margin-bottom: 10px;
     }
     
     .signup-container h1 {
     	font-size: 31px;
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
         
         width: 100%; /* 그룹 너비 고정 */
     }

     .input-group input {
         flex: 1; /* 버튼과 입력 필드 간 비율 조정 */
         width: auto;
         margin-right: 10px;
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
     
     #validateResult {
     	margin-bottom: 5px;
         font-weight: 500;
         font-size: 14px;
         margin-top: 0px;
         color: red;
     }
     
     .explain {
     	font-size : 13px;
     	color: #7e7575;
     	margin-bottom: 40px;
     }
     
     /* 비밀번호 눈표시 */
     .password-wrapper {
         position: relative;
         width: 100%; /* 입력 필드와 동일한 크기 */
     }
     
     

     .password-wrapper input {
         width: 100%; /* 입력 필드 전체 크기 */
         padding-right: 40px; /* 오른쪽에 눈 모양 아이콘이 들어갈 공간 확보 */
         margin
     }

     .password-wrapper .toggle-password {
         position: absolute;
         right: 10px; /* 입력 필드의 오른쪽 끝에서 약간 떨어진 위치 */
         top: 38%;
         transform: translateY(-50%); /* 세로 가운데 정렬 */
         cursor: pointer;
         color: #aaa; /* 기본 색상 */
         transition: color 0.2s ease;
     }

     .password-wrapper .toggle-password:hover {
         color: #333; /* 호버 시 색상 변경 */
     }
     
     .wrap-signup {
    font-family: 'Arial', sans-serif;
    background-color: #f4f8f4; /* 자연을 연상시키는 배경색 */
    display: flex;
    justify-content: center;
    align-items: center;
    height: 700px;
    padding: 20px;
}

.signup-container {
    background-color: #eaf5e8; /* 밝은 녹색 */
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    width: 600px; /* 고정 너비 */
    border: 2px solid #b8d8ba; /* 은은한 녹색 테두리 */
}

.signup-container h1 {
    font-size: 28px;
    font-weight: bold;
    color: #4a774e; /* 짙은 녹색 */
    text-align: center;
    margin-bottom: 25px;
}

form label {
    font-size: 14px;
    font-weight: bold;
    color: #4a774e;
    display: block;
    margin-bottom: 8px;
}

form input {
    width: 100%;
    padding: 12px;
    margin-bottom: 15px;
    border: 1px solid #c2d9c2; /* 연한 녹색 테두리 */
    border-radius: 6px;
    background-color: #ffffff; /* 흰색 배경 */
    font-size: 14px;
    transition: border-color 0.3s ease;
}

form input:focus {
    border-color: #6ca96c; /* 포커스 시 강조 */
    box-shadow: 0 0 6px rgba(108, 169, 108, 0.5);
}

.input-group {
    display: flex;
    align-items: center;
    gap: 10px;
}

.input-group input {
    flex: 1; /* 입력 필드 가변 너비 */
}

.input-group .btn {
    background-color: #6c9c6d; /* 짙은 녹색 */
    color: white;
    padding: 10px 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.input-group .btn:hover {
    background-color: #597e5b; /* 호버 시 색상 변경 */
}

.btn-submit {
    width: 100%; /* 버튼 너비 전체 */
    background-color: #6c9c6d; /* 짙은 녹색 */
    padding: 12px;
    font-size: 16px;
    font-weight: bold;
    color: white;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.btn-submit:hover {
    background-color: #597e5b; /* 호버 시 색상 변경 */
}

.hidden {
    display: none;
}

#validateResult {
    margin-top: 5px;
    font-weight: bold;
    font-size: 14px;
    color: #e57373; /* 오류 메시지 강조 */
    text-align: left;
}
     
     
     



</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	
	<div class="wrap-signup">
	    <div class="signup-container">
	        <h1 style="margin-bottom: 40px;">비밀번호 변경</h1>
	        
	        <form action="changePwd.me" method="post" id="enrollForm" >
	            
	            <div class="explain">
	            	비밀번호를 변경해 주세요. <br>
					다른 아이디나 사이트에서 사용한 적 없는 안전한 비밀번호로 변경해 주세요
				</div>
	            
	            <!-- 비밀번호 -->
	            <label for="memberPwd" style="margin-top: 15px;">새 비밀번호*</label>
	            <div class="password-wrapper">
	            <input type="password" id="memberPwd" name="memberPwd" placeholder="영문 대소문자, 숫자, 특수기호(!@#$%^&)를 포함한 8~15자" required>
				<i class="fa fa-eye fa-lg toggle-password"></i> <!-- 눈 모양 아이콘 -->
  				</div>
				
		
	            <!-- 비밀번호 확인 -->
	            <label for="checkPwd">비밀번호 확인*</label>
	            <div class="password-wrapper">
	            <input type="password" id="checkPwd" name="checkPwd" placeholder="비밀번호를 한번 더 입력하세요" required>
	            <i class="fa fa-eye fa-lg toggle-password"></i> <!-- 눈 모양 아이콘 -->
  				</div>
	            
	            
	            <!-- 회원가입 버튼 -->
	            <button type="submit" class="btn-submit" style="margin-top: 25px;" onclick="return signupValidate(); ">비밀번호 변경</button>
	        </form>
	    </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    
    <script>
    	
    	let timerInterval; // 타이머 관리 변수
    	var isCertChecked = false;
        var isIdChecked = false;
    	
    	
    	
    	// 유효성 검사, 아이디 중복체크 및 인증번호 인증 여부 검사
        function signupValidate() {
    		
    		
    		// 검사할 값들 가져오기
    		
    		
    		let memberPwd = $("#enrollForm input[name=memberPwd]").val();
    		let checkPwd = $("#enrollForm input[name=checkPwd]").val();
    		
    		// 비밀번호 유효성 검사
    		let regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&])[A-Za-z\d!@#$%^&]{8,15}$/;
    		if(!regex.test(memberPwd)) {
    			alert("형식에 맞는 비밀번호를 입력해주세요!");
    			return false;
    		}
    		
    		// 비밀번호, 비밀번호 확인 일치 검사
    		if(memberPwd != checkPwd) {
    			alert("비밀번호와 비밀번호 확인을 동일하게 입력해주세요!");
    			return false;
    		}
        	
        }
    	
    	$(function() {
    		
    		// 비밀번호 표시/숨기기 기능
            $(".toggle-password").on("click", function () {
                const $passwordInput = $(this).siblings("input");
                const inputType = $passwordInput.attr("type");

                if (inputType === "password") {
                    $passwordInput.attr("type", "text");
                    $(this).removeClass("fa-eye").addClass("fa-eye-slash");
                } else {
                    $passwordInput.attr("type", "password");
                    $(this).removeClass("fa-eye-slash").addClass("fa-eye");
                }
            });
    		
    	});
    	
    	
    </script>

</body>
</html>