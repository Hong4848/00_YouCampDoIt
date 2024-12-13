<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
     	font-size : 15px;
     	color: #black;
     	margin-bottom: 40px;
     }
     
     .red-text {
     	color: red;
     }



</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	
	
	
	<div class="wrap-signup">
	    <div class="signup-container">
	        <h1 style="margin-bottom: 40px;">회원 탈퇴</h1>
	        
	        <form action="memberDelete.me" method="post" id="enrollForm" >
	            
	            <div class="explain">
	            	<span class="red-text">탈퇴 전 반드시 확인해주세요!!</span> <br><br>
					탈퇴 시 <span class="red-text">계정은 영구적으로 삭제</span>되며<br>
					동일한 계정으로 <span class="red-text">재가입 역시 불가능합니다.</span><br>
					또한 사이트 내에 <span class="red-text">모든 데이터 복구가 불가능</span>합니다.<br><br><br>
					<spa class="red-text"n>정말 탈퇴를 원하신다면 아래에 비밀번호를 입력해주세요!!</span>
				</div>
	            
	            <!-- 비밀번호 -->
	            <label for="memberPwd" style="margin-top: 15px;">비밀번호*</label>
	            <input type="password" id="memberPwd" name="memberPwd" placeholder="비밀번호를 입력하세요" style="margin-bottom: 60px;" required>
	
	            
	            <!-- 회원탈퇴 버튼 -->
	            <button type="submit" class="btn-submit" style="margin-top: 25px;" onclick="return signupValidate(); ">회원탈퇴</button>
	        </form>
	    </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    
    <script>
    	
    	
    	// 유효성 검사, 아이디 중복체크 및 인증번호 인증 여부 검사
        function signupValidate() {
    		
    		// 검사할 값들 가져오기		
    		let memberPwd = $("#enrollForm input[name=memberPwd]").val();
    		
    		// 비밀번호 유효성 검사
    		let regex = /^[0-9a-zA-Z!@#$%^&]{8,15}$/;
    		if(!regex.test(memberPwd)) {
    			alert("형식에 맞는 비밀번호를 입력해주세요!");
    			return false;
    		}
    		
    		
    		
    		
        }
    	
    	
    </script>

</body>
</html>