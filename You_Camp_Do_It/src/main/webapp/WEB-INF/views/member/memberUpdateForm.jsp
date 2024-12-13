<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
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
            display: flex; /* 플렉스 박스 설정 */
		    justify-content: center; /* 가로 중앙 정렬 */
		    align-items: center; /* 세로 중앙 정렬 */
		    text-decoration: none; /* 링크의 밑줄 제거 */
		    width: 100%; /* 버튼 너비 동일화 */
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
        
        .button-group {
		    display: flex; /* 버튼들을 가로로 배치 */
		    gap: 10px; /* 버튼 간 간격 설정 */
		    justify-content: center; /* 버튼들을 가로 중앙 정렬 */
		    margin-top: 20px; /* 위쪽 여백 추가 */
		}



    </style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<div class="wrap-signup">
	    <div class="signup-container">
	        <h1>회원정보 수정</h1>
	        <p class="required-info">*필수입력사항</p>
	        <form action="update.me" method="post" id="enrollForm" >
	        
	        	<input type="hidden" id="memberNo" name="memberNo" 
	        		   value="${ sessionScope.loginMember.memberNo }">
	        	
	            <!-- 아이디 -->
	            <label for="memberId">아이디*</label>
	            <div class="input-group">
	                <input type="text" id="memberId" name="memberId" 
	                	   value="${ sessionScope.loginMember.memberId }" readOnly>
	            </div>
				
	            <!-- 이름 -->
	            <label for="memberName">이름*</label>
	            <input type="text" id="memberName" name="memberName" 
	            	   value="${ sessionScope.loginMember.memberName }" readOnly>
	
	            <!-- 이메일 -->
	            <label for="email">이메일 주소*</label>
	            <div class="input-group">
	                <input type="email" id="email" name="email" 
	                	   value="${ sessionScope.loginMember.email }" readOnly>
	                <!-- <button type="button" class="btn" id="sendCodeButton">인증번호 받기</button> -->
	            </div>
	
	            <!-- 전화번호 -->
	            <label for="phone">전화번호*</label>
	            <input type="text" id="phone" name="phone" 
	            	   value="${ sessionScope.loginMember.phone }" required>
	
	            <!-- 생년월일 -->
	            <label for="birthDate">생년월일*</label>
	            <input type="date" id="birthDate" name="birthDate" 
	            	   value="${ sessionScope.loginMember.birthDate }" required>
	
	            <!-- 도로명 주소 -->
	            <label for="address">도로명 주소*</label>
	            <input type="text" id="address" name="address" 
	            	   value="${ sessionScope.loginMember.address }" required>
	
	            <div class="button-group">
				    <button type="submit" class="btn-submit">회원정보 수정</button>
				    <a href="changePwdForm.me" class="btn-submit">
				        비밀번호 변경
				    </a>
				    <a href="memberDeleteForm.me" class="btn-submit">
				    	회원 탈퇴
				    </a>
				</div>
                
	        </form>
	    </div>
    </div>
    
    
    
    <!-- 회원 탈퇴 모달창 -->
    <div class="modal" id="deleteMemberModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                <h4 class="modal-title">회원 탈퇴</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
            
                <form action="#" method="post" >
                	<!-- Modal body -->
                    <div class="modal-body">
                    	성민님 모달까지 만들어놨어요 여기서부터 회원 탈퇴 수정해서 쓰세요
                    	
                        <label for="memberId" class="mr-sm-2">아이디</label>
                        <input type="text" class="form-control mb-2 mr-sm-2" placeholder="아이디를 입력해주세요" id="memberId" name="memberId" value="" required><br>
                        <label for="memberPwd" class="mr-sm-2">비밀번호</label>
                        <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호를 입력해주세요" id="memberPwd" name="memberPwd" required autoComplete="off"><br>
                    
                    	<div class="text-center">
					        <button type="submit" class="btn btn-primary mb-2">로그인</button>
					    </div>
					    
                    </div>
                    
        
                    <!-- Modal footer -->
                    
					<div id="links">
					    <a href="${ pageContext.request.contextPath }/enrollForm.me">회원가입</a> | 
					    <a href="${ pageContext.request.contextPath }/findId.me">아이디 찾기</a> | 
					    <a href="${ pageContext.request.contextPath }/findPwd.me">비밀번호 찾기</a>
					</div>
					
                    
                </form>
            </div>
        </div>
    </div>


    <script>
        
        
    </script>
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>