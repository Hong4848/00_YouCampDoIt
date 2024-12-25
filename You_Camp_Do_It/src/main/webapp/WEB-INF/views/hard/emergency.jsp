<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>emergency</title>
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

    .reserve_wrap a:nth-child(2) {
        color: #f7b500;
        border-bottom: 3px solid #f7b500;
    }

    .reserve_wrap a:hover {
        color: #f7b500;
    }


    body {
        font-family: 'Arial', sans-serif;
        background-color: #fff;
        margin: 0;
        padding: 0;
        width: 1900px;
        ;
    }

    .container {
        min-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .safety-section {
        display: flex;
        align-items: center;
        gap: 20px;
        margin-bottom: 40px;
        padding-bottom: 20px;
        border-bottom: 1px solid #ddd;
    }

    .icon {
        font-size: 40px;
        color: #bbb;
        flex-shrink: 0;
        margin-left: 40px;
    }

    .content {
        flex: 1;
        margin-left: 40px;
    }

    .content h3 {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
        color: #333;
    }

    .content ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
        
    }

    .content ul li {
        font-size: 16px;
        color: #666;
        line-height: 1.6;
    }

    .content ul li strong {
        color: #333;
        font-weight: bold;
    }

    .content ul li span {
        color: #999;
    }
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<div id="content_1">
        <div class="reserve_wrap">
            <a href="precaution.ha">사용시 유의사항</a>
            <a href="emergency.ha">비상시 대책요령</a>
        </div>
    </div>
	
	<div class="container">
        <div class="safety-section">
            <div class="icon"><img src="resources/images/hard/emergency/불.png" width="50"></div>
            <div class="content">
                <h3>화재시</h3>
                <ul>
                    <li>화재 발생 시 큰소리로 주위에 알린 후, 119에 신고하며, 진동리 국민여가캠핑장 관리자에게 알립니다.</li>
                    <li>관리자의 대피 계획에 따라 신속하게 대피합니다.</li>
                </ul>
            </div>
        </div>

        <div class="safety-section">
            <div class="icon"><img src="resources/images/hard/emergency/구급.png" width="50"></div>
            <div class="content">
                <h3>안전사고</h3>
                <ul>
                    <li>진동리 국민여가캠핑장 관리자에게 구급상자를 요청한 후 초동 조치합니다.</li>
                    <li>위급환자 발생 시 후송대책에 따라 신속히 후송조치합니다.</li>
                </ul>
            </div>
        </div>

        <div class="safety-section">
            <div class="icon"><img src="resources/images/hard/emergency/번개.png" width="50"></div>
            <div class="content">
                <h3>자연재해</h3>
                <ul>
                    <li>사전에 일기예보 등을 확인하고 안전을 해칠 우려가 있다고 판단될 시 이용을 삼가시기 바랍니다.</li>
                    <li>위급을 요하는 경우와 호우, 강풍 등으로 피해가 필요한 경우 관리자의 지시에 따라 주시기 바랍니다.</li>
                </ul>
            </div>
        </div>

        <div class="safety-section">
            <div class="icon"><img src="resources/images/hard/emergency/질서.png" width="50"></div>
            <div class="content">
                <h3>질서유지 및 안전사고 예방</h3>
                <ul>
                    <li><strong>캠핑장 내에서는 사용 시 유의사항을 지키며 질서를 유지하도록 합니다.</strong></li>
                    <li>이용객의 안전을 위해 각종 시설, 장비, 기구 등을 정상적으로 이용 될 수 있도록 유지하도록 합니다.</li>
                    <li>캠핑장과 인접한 곳 재해 위험이 있는 경우에는 위험구역 안내 표지판 설치 및 해당구역 접근 제한 및 안전 이격 거리를 확보합니다.</li>
                    <li>집중호우 시에는 캠핑장이 침수되지 않도록 배수시설을 관리하여야 합니다.</li>
                </ul>
            </div>
        </div>
    </div>
	
	
	
	<jsp:include page="../common/footer.jsp" />

</body>
</html>