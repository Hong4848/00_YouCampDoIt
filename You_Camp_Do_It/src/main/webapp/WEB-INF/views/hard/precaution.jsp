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
	}
	
	.info-section {
	    width: 90%;
	    max-width: 1200px;
	    margin: 0 auto;
	    padding: 40px 20px;
	    background-color: #ffffff;
	}
	
	.icons {
	    display: flex;
	    justify-content: center;
	    gap: 100px;
	    margin-bottom: 30px;
	}
	
	.icon-item {
	    text-align: center;
	}
	
	.icon-item img {
	    width: 180px;
	    height: 180px;
	    margin-bottom: 10px;
	}
	
	.icon-item p {
	    font-size: 15px;
	    background-color: #f9f3ea;
	    padding: 10px 20px;
	    border-radius: 15px;
	    color: #9c7d65;
	}
	
	.info-table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 20px;
	}
	
	.info-table td {
	    padding: 15px;
	    border: 1px solid #ddd;
	    vertical-align: top;
	}
	
	.info-table .title {
	    width: 30%;
	    background-color: #f7f4ef;
	    font-weight: bold;
	    color: #333;
	}
	
	.info-table .content {
	    background-color: #ffffff;
	    color: #555;
	    line-height: 1.6;
	    
	}
	
	.info-table td {
	    padding: 15px;
	    border: 1px solid #ddd;
	    vertical-align: middle; /* 위아래로 중앙 정렬 */
	    height: 100px; /* 셀의 높이를 균일하게 설정 */
	}
	
	.info-table .title {
	    width: 30%;
	    background-color: #f7f4ef;
	    font-weight: bold;
	    color: #333;
	    text-align: center; /* 텍스트를 중앙 정렬 */
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
	
	<div class="info-section">
        <div class="icons">
            <div class="icon-item">
                <img src="resources/images/hard/precaution/반려견금지.png" alt="반려견 출입금지">
                <p>반려견 출입금지</p>
            </div>
            <div class="icon-item">
                <img src="resources/images/hard/precaution/매너타임.png" alt="매너타임 PM 10:00">
                <p>매너타임 PM 10:00</p>
            </div>
            <div class="icon-item">
                <img src="resources/images/hard/precaution/금연.png" alt="전 시설 금연">
                <p>전 시설 금연</p>
            </div>
        </div>
        <br><br>
        <table class="info-table">
            <tbody>
                <tr>
                    <td class="title">입, 퇴실 시간 안내</td>
                    <td class="content">
                        - 입실 14:00 이후, 퇴실 12:00 이전<br>
                        - 캠핑장 사정으로 입, 퇴실 시간이 변경될 수 있습니다. 캠핑장에 문의해 주세요.
                    </td>
                </tr>
                <tr>
                    <td class="title">주차장 정보</td>
                    <td class="content">
                        - 객실 1개소 당 주차장 1구획 제공.<br>
                        - 추가 주차는 캠핑장 내 주차장이 없으므로, 캠핑장 외부에 주차해 주세요.
                    </td>
                </tr>
                <tr>
                    <td class="title">주의사항</td>
                    <td class="content">
                        - 캠핑장 내 반려동물의 출입은 금지되어 있습니다.<br>
                        - 캠핑장 내 불꽃놀이는 전면 금지되어 있습니다.<br>
                        - 화로가 아닌 바닥에서 모닥불을 피우는 행위는 금지되어 있습니다.<br>
                        - 캠핑장의 모든 이용요금은 카드결제로 진행됩니다.<br>
                        - 바베큐 화로대, 숯, 장작, 철망은 캠핑장에서 제공하지 않습니다.<br>
                          &nbsp;&nbsp;홈페이지에서 대여 및 구매 가능합니다.<br>
                        
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
	
	
	
	<jsp:include page="../common/footer.jsp" />

</body>
</html>