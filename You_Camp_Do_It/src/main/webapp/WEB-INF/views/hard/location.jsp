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
    width: 90%;
    margin: 0 auto;
    padding: 40px 20px;
    background-color: #ffffff;
	}
	
	

    #map{
        border: 1px solid #ddd;
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
            <a href="location.ha">찾아오시는길</a>
            <a href="precaution.ha">사용시 유의사항</a>
            <a href="emergency.ha">비상시 대책요령</a>
        </div>
    </div>
	
	<div class="info-section">
        <div id="map" style="width:1000px;height:600px;"></div>

        <div id="adress-phone">
            <h3>주소</h3>
            <span>강원 인제군 기린면 진동리 618</span>
            <h3>전화</h3>
            <span> 032-246-8468</span>
        </div>
    </div>
	
	
	<jsp:include page="../common/footer.jsp" />

    <script type="text/javascript" 
    		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9c91caa4623b0063ff5afc4d3d0a1d9d">
    </script>

    <script>
        
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = { 
                center: new kakao.maps.LatLng(37.968772, 128.419817), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
        
        // 마커를 표시할 위치입니다 
        var position =  new kakao.maps.LatLng(37.968772, 128.419817);

        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
	        position: position,
	        clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
        });

        // 마커를 지도에 표시합니다.
        marker.setMap(map);

        // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
        var iwContent = `<div id="location">진동리 캠핑장</div>`, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
            iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

        // 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            content : iwContent,
            removable : iwRemoveable
        });

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function() {
            // 마커 위에 인포윈도우를 표시합니다
            infowindow.open(map, marker);  
        });

        $(document).on('click', '#location', function () {
            window.location.href = "https://map.kakao.com/link/map/1837432015";
        });

    </script>

</body>
</html>