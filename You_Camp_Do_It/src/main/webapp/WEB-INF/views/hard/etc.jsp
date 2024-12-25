<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

    .reserve_wrap a:nth-child(5) {
        color: #f7b500;
        border-bottom: 3px solid #f7b500;
    }

    .reserve_wrap a:hover {
        color: #f7b500;
    }
    
    body {
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #fff;
        color: #333;
    }

    .container {
        max-width: 1200px;
        margin: 40px auto;
        padding: 20px;
    }

    .facility-section {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        gap: 20px;
    }

    .facility-card {
        flex: 1;
        min-width: 250px;
        max-width: 30%;
        text-align: left;
    }

    .facility-card img {
        width: 100%;
        height: auto;
        border-radius: 8px;
    }

    .facility-card h3 {
        font-size: 25px;
        margin: 15px 0 10px;
        font-weight: 700;
    }

    .facility-card p {
        font-size: 16px;
        color: #666;
    }

    
    
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

    <div id="content_1">
        <div class="reserve_wrap">
            <a href="forest.ha">포레스트</a>
            <a href="belly.ha">밸리</a>
            <a href="sky.ha">스카이</a>
            <a href="stone.ha">스톤</a>
            <a href="etc.ha">기타시설안내</a>
        </div>
    </div>
    
    <div class="container">
	    <div class="facility-section">
	        <!-- Card 1 -->
	        <div class="facility-card">
	            <img src="resources/images/hard/etc/관리동.png" alt="관리동">
	            <h3>관리동</h3>
	            <p>2구역 밸리에 위치</p>
	        </div>
	        <!-- Card 2 -->
	        <div class="facility-card">
	            <img src="resources/images/hard/etc/화장실.png" alt="화장실">
	            <h3>화장실</h3>
	            <p>1구역 포레스트, 2구역 밸리, 3구역 스카이, 4구역 스톤에 위치하였고 남, 여 구분 되어있음</p>
	        </div>
	        <!-- Card 3 -->
	        <div class="facility-card">
	            <img src="resources/images/hard/etc/샤워실.png" alt="샤워실" >
	            <h3>샤워실</h3>
	            <p>1구역 포레스트, 2구역 밸리에 위치하였고 남, 여 구분 되어있음</p>
	        </div>
	        <!-- Card 4 -->
	        <div class="facility-card">
	            <img src="resources/images/hard/etc/개수장.png" alt="개수장">
	            <h3>개수장</h3>
	            <p>1구역 포레스트, 2구역 밸리에 위치</p>
	        </div>
	    </div>
	</div>
    
    
    
    <jsp:include page="../common/footer.jsp" />

</body>
</html>