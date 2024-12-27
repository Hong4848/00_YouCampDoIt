<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유의사항</title>
<style>
	#content_1 {
        display: flex;
        justify-content: center;
        align-items: center;
        
        font-weight: 700;
        height: 100px;
        background-color: white;
        width: 1900px;
        
        
    }

    .reserve_wrap a {
        text-decoration: none;
        font-size: 18px;
        color: #333;
        padding: 10px 20px;
        margin-right: 20px;
        border-bottom: 3px solid transparent;
    }

    .reserve_wrap a:first-child {
        color: #f7b500;
        border-bottom: 3px solid #f7b500;
    }

    .reserve_wrap a:hover {
        color: #f7b500;
    }
    
    
    body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-color: #f8f8f8;
	    width: 1900px;
	}
	
	.info-section {
        display: flex;
    	flex-direction: column; /* 세로로 배치 */
    	align-items: center; /* 가로 가운데 정렬 */
    	width: 100%;
    	margin: 0 auto;
    	padding: 40px 20px;
	}

    #location {
        padding: 10px; /* 기본 여백 */
        display: inline-block; /* 크기 조정 가능 */
    }

    #location:hover {
        text-decoration: underline; /* 호버 시 밑줄 추가 */
        cursor: pointer; /* 커서 포인터로 변경 */
    }

    #adress-phone {
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        gap: 50px; /* 요소 간 간격 */
        padding: 20px 30px; /* 내부 여백을 늘려 크기 확대 */
        background-color: #fff;
        border-top: 1px solid #ddd; /* 상단 구분선 */
        width: 1000px; /* 요소의 너비를 전체로 확장 */
        align-items: center;
    }

    #adress-phone h3 {
        font-size: 22px; /* 글씨 크기 확대 */
        font-weight: bold;
        color: #333;
        margin: 0; /* 불필요한 마진 제거 */
        background-color: rgb(94, 93, 67);
        color: white;
        padding: 7px;
        margin: 0px;
    }

    #adress-phone span {
        font-size: 20px;
        color: #555; /* 텍스트 색상 */
        
    }
    
    
    
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

    <div id="content_1">
        <div class="reserve_wrap">
            <a href="location.ha">대여/반납안내</a>
        </div>
    </div>
	
	<div class="info-section">
        <div id="map" style="width:1200px;height:1300px;">
        	<img src="resources/images/hard/반납안내.png">
        </div>

        <div id="adress-phone">
            <h3>주소</h3>
            <span>강원 인제군 기린면 진동리 618</span>
            <h3>전화</h3>
            <span> 032-246-8468</span>
        </div>
    </div>
	
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>