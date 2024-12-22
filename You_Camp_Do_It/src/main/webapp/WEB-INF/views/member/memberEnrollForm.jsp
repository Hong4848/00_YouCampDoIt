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
	        <h1>회원가입</h1>
	        <p class="required-info">*필수입력사항</p>
	        <form action="insert.me" method="post" id="enrollForm" >
	            <!-- 아이디 -->
	            <label for="memberId">아이디*</label>
	            <input type="text" id="memberId" name="memberId" style="margin-bottom: 0px;" placeholder="첫글자는 반드시 영문자이고 영문자, 숫자 포함 5~12자" required>
	            
	            <div id="checkResult" style="font-size: 0.8em; display: none;">
	            
	            </div>
	
	            <!-- 비밀번호 -->
	            <label for="memberPwd" style="margin-top: 15px;">비밀번호*</label>
	            <input type="password" id="memberPwd" name="memberPwd" placeholder="영문 대소문자, 숫자, 특수기호(!@#$%^&)를 포함한 8~15자" required>
	
	            <!-- 비밀번호 확인 -->
	            <label for="checkPwd">비밀번호 확인*</label>
	            <input type="password" id="checkPwd" name="checkPwd" placeholder="비밀번호를 한번 더 입력하세요" required>
	
	            <!-- 이름 -->
	            <label for="memberName">이름*</label>
	            <input type="text" id="memberName" name="memberName" placeholder="영문 대소문자/한글 2자 이상" required>
	
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
	                    <input type="text" id="verificationCode" name="verificationCode" placeholder="인증번호 숫자 6자리를 입력하세요" style="margin-bottom: 0px;">
	                    <button type="button" id="checkCode" class="btn" onclick="validate();">인증하기</button>
	                    
	                </div>
	                <div id="validateResult"></div>
	            </div>
	
	            <!-- 전화번호 -->
	            <label for="phone">전화번호*</label>
	            <input type="text" id="phone" name="phone" placeholder="-포함한 숫자 13자" required>
	
	            <!-- 생년월일 -->
	            <label for="birthDate">생년월일*</label>
	            <input type="date" id="birthDate" name="birthDate" required>
	
	            <!-- 도로명 주소 -->
	            <label for="address">도로명 주소*</label>
	            <input type="text" id="address" name="address" placeholder="도로명 주소를 입력하세요" required>
	
	            <!-- 회원가입 버튼 -->
	            <button type="submit" class="btn-submit" onclick="return signupValidate();">회원가입</button>
	        </form>
	    </div>
    </div>


    <script>
    	
    	let timerInterval; // 타이머 관리 변수
    	var isCertChecked = false;
        var isIdChecked = false;
    	
    	
    	// 인증번호 발급용 ajax
    	function cert() {
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
    		let memberId = $("#enrollForm input[name=memberId]").val();
    		let memberPwd = $("#enrollForm input[name=memberPwd]").val();
    		let checkPwd = $("#enrollForm input[name=checkPwd]").val();
    		let memberName = $("#enrollForm input[name=memberName]").val();
    		let email = $("#enrollForm input[name=email]").val();
    		let phone = $("#enrollForm input[name=phone]").val();
    		
    		
    		// 아이디 유효성 검사
    		let regex = /^[a-zA-Z][a-zA-Z0-9]{4,11}$/;
    		if(!regex.test(memberId)) {
    			alert("형식에 맞는 아이디를 입력해주세요!");
    			$("#enrollForm input[name=memberId]").focus();
    			return false;
    		} 
    		
			if(isIdChecked == false) {
	        		
        		alert("아이디 중복체크를 반드시 해야합니다!");
        		return false;
        		
        	}
    		
    		// 비밀번호 유효성 검사
    		regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&])[A-Za-z\d!@#$%^&]{8,15}$/;
    		if(!regex.test(memberPwd)) {
    			alert("형식에 맞는 비밀번호를 입력해주세요!");
    			$("#enrollForm input[name=memberPwd]").focus();
    			return false;
    		}
    		
    		// 비밀번호, 비밀번호 확인 일치 검사
    		if(memberPwd != checkPwd) {
    			alert("비밀번호와 비밀번호 확인을 동일하게 입력해주세요!");
    			$("#enrollForm input[name=checkPwd]").focus();
    			return false;
    		}
    		
    		// 회원 이름 유효성 검사
    		regex = /^[A-Za-z가-힣]{2,}$/;
    		if(!regex.test(memberName)) {
    			alert("2글자 이상의 이름을 입력해주세요!");
    			$("#enrollForm input[name=memberName]").focus();
    			return false;
    		}
    		
    		// 이메일 유효성 검사
    		regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    		if (!regex.test(email)) {
    		    alert("형식에 맞는 이메일 주소를 입력해주세요!");
    		    $("#enrollForm input[name=email]").focus();
    		    return false;
    		}
    		
    		// 이메일 인증 여부 검사
    		if(isCertChecked == false) {
    			alert("이메일 인증을 반드시 해야합니다!");
    			
    			return false;
    		}
    		
    		// 전화번호 유효성 검사
    		regex = /^\d{3}-\d{4}-\d{4}$/;
    		if(!regex.test(phone)) {
    			alert("형식에 맞는 전화번호를 입력해주세요!");
    			$("#enrollForm input[name=phone]").focus();
    			return false;
    		}
    		
        }
    	
    	
    
        $(function() {
            // '인증번호 받기' 버튼 클릭 시 인증번호 입력 필드 보이기
            $("#sendCodeButton").click(function() {
                $("#verificationFields").removeClass("hidden");
                // $(".wrap-signup").css("height", "1300px");
            });
            
            const $emailInput = $("#email");
            const $sendCodeButton = $("#sendCodeButton");

            // 이메일 유효성 검사 함수
            function isEmailValid(email) {
                const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // 이메일 형식 정규표현식
                return regex.test(email);
            }

            // 이메일 입력 시 유효성 검사
            $emailInput.on("input", function () {
                const emailValue = $(this).val().trim();

                if (isEmailValid(emailValue)) {
                    $sendCodeButton.prop("disabled", false); // 유효한 경우 버튼 활성화
                    $emailInput.css("border-color", "green"); // 입력 필드 강조
                } else {
                    $sendCodeButton.prop("disabled", true); // 유효하지 않으면 버튼 비활성화
                    $emailInput.css("border-color", "red"); // 입력 필드 강조
                }
            });

            // 초기 상태에서 버튼 비활성화
            $sendCodeButton.prop("disabled", true);
            
            
            // 아이디 중복체크 이벤트
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
												 .text("중복된 아이디가 이미 존재합니다. 다시 입력해주세요!");
								
								// 회원가입 버튼 비활성화
								// $("#enrollForm button[type=submin]").attr("disabled", true);
								isIdChecked = false;
							} else {
								// 사용 가능 아이디
								
								$("#checkResult").show()
												 .css("color", "green")
												 .text("사용 가능한 아이디입니다!");
								
								// 회원가입 버튼 활성화
								// $("#enrollForm button[type=submit]").attr("disabled", false);
								isIdChecked = true;
							}
							
						},
						error : function() {
							console.log("아이디 중복 체크용 ajax 통신 실패!");
						}
						
					});
				} else {
					
					// 5글자 미만일 경우
					// > 회원가입 버튼 비활성화, 메세지 내용 숨기기
					// $("#enrollForm button[type=submit]").attr("disabled", true);
					$("#checkResult").hide();
					isIdChecked = false;
					
				}
            	
            });
            
            
         
            
            
        });
        
        
    </script>
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>