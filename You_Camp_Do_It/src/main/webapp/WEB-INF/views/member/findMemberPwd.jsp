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



</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<div class="wrap-signup">
	    <div class="signup-container">
	        <h1 style="margin-bottom: 40px;">비밀번호 찾기</h1>
	        
	        <form action="findPwd.me" method="post" id="enrollForm" >
	            
	            <!-- 이름 -->
	            <label for="memberName">이름*</label>
	            <input type="text" id="memberName" name="memberName" placeholder="이름을 입력하세요" required>
	            
	            <!-- 아이디 -->
	            <label for="memberId">아이디*</label>
	            <input type="text" id="memberId" name="memberId" placeholder="아이디를 입력하세요(첫글자 반드시 영문자 / 영문자, 숫자 포함 5~12자)" required>
	
	            <!-- 이메일 -->
	            <label for="email">이메일 주소*</label>
	            <div class="input-group">
	                <input type="email" id="email" name="email" placeholder="이메일 주소를 입력하세요" required>
	                <button type="button" class="btn" id="sendCodeButton" onclick="cert();">인증번호 받기</button>
	            </div>
	
	            <!-- 인증번호 입력 (초기 숨김 처리) -->
	            <div id="verificationFields" class="hidden">
	                <label for="verificationCode">인증번호*</label>
	                <div class="input-group">
	                    <input type="text" id="verificationCode" name="verificationCode" placeholder="인증번호 6자리를 입력하세요" style="margin-bottom: 0px;">
	                    <button type="button" id="checkCode" class="btn" onclick="validate();">인증하기</button>
	                    
	                </div>
	                <div id="validateResult"></div>
	            </div>
	            
	            <!-- 회원가입 버튼 -->
	            <button type="button" class="btn-submit" style="margin-top: 25px;" onclick="signupValidate(); ">비밀번호 찾기</button>
	        </form>
	    </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    
    <script>
    	
    	let timerInterval; // 타이머 관리 변수
    	var isCertChecked = false;
        var isIdChecked = false;
    	
    	
    	// 인증번호 발급용 ajax
    	function cert() {
    		$("#verificationFields").removeClass("hidden");
    		let email = $("#email").val();
    		
    		
    		$.ajax({
    			url : "cert.me",
    			type : "post",
    			data : {
    				email : email
    			},
    			success : function(result) {
    				
    				alert(result);
    				
    				// 인증 관련 요소 보이게 하기
    				$("#verificationFields").removeClass("hidden");
    				
    				// 타이머 초기화 및 시작
    				startTimer(180); // 180초 3분 타이머 시작
    				
    				// 사용자가 계속 인증 요청 보내는 것을 
					// 방지하기 위해 인증번호 발급 후 인증 이메일 입력창
					// 및 인증메일 보내기 버튼 비활성화
					$("#email").attr("readonly", true);
    				$("#sendCodeButton").attr("disabled", true);
    				
    				$("#verificationCode").attr("readonly", false);
					$("#checkCode").attr("disabled", false);
    				
    			}, 
    			error : function() {
    				console.log("인증번호 발급용 ajax 통신 실패!");
    			}
    			
    		});
    	}
    	
    	function startTimer(duration) {
    		let timeRemaining = duration; // 남은시간(초)
    		
    		// 기존 타이머 중복 방지
    		if (timerInterval) clearInterval(timerInterval);
    		
    		// 매초 실행되는 타이머
    		timerInterval = setInterval(function() {
    			
    			let minutes = Math.floor(timeRemaining / 60); // 분 계산
    			let seconds = timeRemaining % 60; // 초 계산
    			
    			// 초가 한 자리일 경우 앞에 0 을 추가
    			seconds = seconds < 10 ? "0" + seconds : seconds;
    			
    			// 남은 시간 표시
    			$("#validateResult").text("남은시간 : " + minutes + ":" + seconds);
    			
    			// 시간이 끝나면 타이머 종료
    			if (--timeRemaining < 0) {
    				clearInterval(timerInterval);
    				$("#validateResult").text("인증 시간이 만료되었습니다. 다시 요청해주세요.");
    				
    				// 이메일 입력 및 인증번호 버튼 활성화
    				$("#email").attr("readonly", false);
    				$("#sendCodeButton").attr("disabled", false);
    				
    				let email = $("#email").val();
    	    		let checkNo = $("#verificationCode").val();
    				
    				$.ajax({
    					url : "timeOut.me",
    					type : "post",
    					data : {
    						email : email
    					},
    					success : function(result) {
    						console.log("db에서 데이터 삭제 완료!");
    						
    						$("#email").val("");
    	    	    		$("#verificationCode").val("");
    					},
    					error : function() {
    						console.log("db에서 데이터 삭제 실패!");
    					}
    					
    					
    				});
    			}
    		}, 1000); // 1초마다 실행
    	}
    	
    	
    	// 사용자의 이메일 주소와 입력받은 인증 번호를 대조해주는 요청 (ajax)
    	function validate() {
    		
    		// 입력값 가져오기
            let checkNo = $("#verificationCode").val();

            // 정규표현식 정의
            let regex = /^[0-9]{6}$/;

            // 유효성 검사
            if (!regex.test(checkNo)) {
                alert("인증번호는 숫자 6자리여야 합니다.");
                return false; // 검사가 실패하면 더 이상 진행하지 않음
            } else {
            	
            	// 이메일, 인증번호 변수에 담기
        		let email = $("#email").val();
        		let checkNo = $("#verificationCode").val();
        		
        		
        		$.ajax({
        			url : "validate.me",
        			type : "post",
        			data : {
        				email : email,
        				checkNo : checkNo
        			},
        			success : function(result) {
        				
        				$("#validateResult").text(result);
        				if(result == "인증 성공") {
        					
        					$("#validateResult").css("color", "green");
        					
        					$("#verificationCode").attr("readonly", true);
        					$("#checkCode").attr("disabled", true);
        					
        					// 타이머 종료
        					clearInterval(timerInterval);
        					
        					isCertChecked = true;
        				} else {
        					clearInterval(timerInterval);
        					$("#validateResult").text("인증 실패! 다시 인증해주세요.");
        					$("#validateResult").css("color", "red");
        					
        					// 인증 실패 시 재인증 하 수 있도록 유도
        					$("#email").attr("readonly", false);
        					$("#sendCodeButton").attr("disabled", false);
        					
        					$("#verificationCode").attr("readonly", true);
        					$("#checkCode").attr("disabled", true);
        					
        					
        					$("#email").val("");
        					$("#verificationCode").val("");
        					
        					isCertChecked = false;
        				}
        				
        			},
        			error : function() {
        				console.log("인증번호 대조용 ajax 통신 실패!!");
        			}
        		});
            	
            }

    	}
    	
    	
    	// 유효성 검사, 아이디 중복체크 및 인증번호 인증 여부 검사
        function signupValidate() {
    		
    		
    		// 검사할 값들 가져오기
    		
    		let memberName = $("#enrollForm input[name=memberName]").val();
    		let memberId = $("#enrollForm input[name=memberId]").val();
    		let email = $("#enrollForm input[name=email]").val();
    		
    		
    		// 회원 이름 유효성 검사
    		let regex = /^[가-힣]{2,}$/;
    		if(!regex.test(memberName)) {
    			alert("2글자 이상의 이름을 입력해주세요!");
    			return false;
    		}
    		
    		// 아이디 유효성 검사
    		regex = /^[a-zA-Z][a-zA-Z0-9]{4,11}$/;
    		if(!regex.test(memberId)) {
    			alert("형식에 맞는 아이디를 입력해주세요!");
    			return false;
    		}
    		
    		// 이메일 인증 여부 검사
    		if(isCertChecked == false) {
    			alert("이메일 인증을 반드시 해야합니다!");
    			return false;
    		}
	
    		
    		$.ajax({
    			url : "findPwd.me",
    			type : "post",
    			data : {
    				email : email,
    				memberName : memberName,
    				memberId : memberId
    			},
    			success : function(result) {
    				if(result == "해당 계정 없음") {
    					alert("입력하신 정보와 일치하는 계정이 존재하지 않습니다.");
    					$("#email").attr("readonly", false);
    					$("#sendCodeButton").attr("disabled", false);
    					$("#memberName").val("");
    					$("#memberId").val("");
    					$("#email").val("");
    					$("#verificationCode").val("");
    					$("#memberName").val("");
    					$("#validateResult").text("");
    					
    					return false;
    					
    				} else {
    					console.log(result);
    					location.href="changePwdForm.me";
    				}
    			},
    			error : function() {
    				console.log("비밀번호 찾기용 ajax 통신 실패!!");
    				
    			}
    		});
    		
    		
        	
        }
    	
    	
    </script>

</body>
</html>