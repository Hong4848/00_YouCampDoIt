<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
        width: 1900px;
    }
    
    .wrap-reserveList {
        font-family: Arial, sans-serif;
        font-weight: 400;
        margin: 0;
        padding: 0;
        background-color: #f8f8f8;
        box-sizing: border-box;
        width: 100%;
        height: 580px;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: inherit;
    }

    .content {
        width: 100%;
        max-width: 1200px;
        
        margin: 0 auto;
        padding: 20px;
        padding-top: 0px;
        
    }

    #content_1 {
        display: flex;
        justify-content: center;
        align-items: center;
        
        font-weight: 700;
        height: 100px;
        background-color: white;
        width: 100%;
        margin: 0 auto;
        
    }

    .reserve_wrap {
        display: flex;
        justify-content: center;
        align-items: center;
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

    .content {
        display: flex;
        gap: 20px;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 10px;
        overflow: hidden;
        padding: 20px;
        font-weight: 400;
        
    }

    .tit_h3 {
        display: flex; /* 플렉스 박스로 정렬 */
        align-items: center; /* 세로축 중앙 정렬 */
        justify-content: space-between; /* 좌우 정렬 */
        font-size: 15px; /* 글자 크기 */
        font-weight:520; /* 텍스트 굵게 */
        color: #333; /* 텍스트 색상 */
        margin-bottom: 10px; /* 아래 여백 */
        border-left: 4px solid #6c5e37; /* 왼쪽에 포인트 색상 바 */
        padding-left: 10px; /* 텍스트와 포인트 바 간격 */
        margin-top: 10px;
    }

    .reserv_wrap {
        width: 90%;
        justify-content: center;
        align-items: center;
        margin: auto;
        height: 400px;
        padding-top: 70px;
        
        
        
    }

    .table_basic {
        width: 100%;
        border-collapse: collapse;
    }


    .table_basic th, .table_basic td {
        padding: 12px 15px; /* 셀 내부 여백 */
        border: 1px solid #ddd; /* 셀 테두리 */
    }

    .table_basic th {
        background-color: white; /* 헤더 배경색 */
        font-size: 15px; /* 헤더 글자 크기 */
        font-weight: bold; /* 헤더 글자 굵기 */
        color: #333; /* 헤더 글자 색상 */
        text-align: center; /* 텍스트 중앙 정렬 */
        border-top: 1px black solid;
        height: 30px;
    }

    .table_basic td {
        font-size: 14px; /* 데이터 셀 글자 크기 */
        color: #333; /* 데이터 셀 글자 색상 */
        height: 30px;
        background-color: rgb(247, 239, 239);
    }

    .table_basic .state {
        display: inline-block; /* 상태 텍스트를 박스로 처리 */
        padding: 5px 10px; /* 내부 여백 */
        border-radius: 15px; /* 둥근 모서리 */
        font-size: 12px; /* 글자 크기 */
        color: #fff; /* 텍스트 색상 */
        background-color: #6c5e37; 
        height: 25px;
    }

    
    .table_basic tbody {
        height: 38px;
        text-align: center;
        border-left: 0px white solid;
        border-right: 0px white solid;
        border-bottom: 1px #e6dede solid;

    } 

    .table_basic tbody tr:hover td{
        cursor: pointer;
        background-color: #cfc9c9;
    }

    .select_button .wid_100 {
        display: flex; /* 버튼 내부에서 수직 중앙 정렬 활성화 */
        align-items: center; /* 수직 중앙 정렬 */
        justify-content: center; /* 가로 중앙 정렬 (선택 사항) */
        background-color: #a59e9e;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-align: center;
        flex: 1;
        text-decoration: none;
        font-size: 16px; /* 글자 크기 */
        color: white; /* 텍스트 색상 */
        height: 45px;
        margin-top: 30px;    
    }

    .select_button .wid_100:hover {
        background-color: #6c5e37
    }

</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

    <div class="wrap-reserveList">

        <!-- 실시간 예약 / 예약확인,취소 -->
        <div id="content_1">
            <div class="reserve_wrap">
                <a href="reserveDate.res">실시간 예약</a>
                <a href="reserveList.res">예약확인/취소</a>
            </div>
        </div>

        <div class="content">
            <div class="reserv_wrap">
                <div class="tit_h3" style="margin-top: 10px;">
                    예약현황
                </div>
                <table class="table_basic" border="1">
                    <thead>
                        <tr>
                            <th>예약번호</th>
                            <th>예약일</th>
                            <th>결제금액</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>0998473</td>
                            <td>2024-12-09</td>
                            <td>30,000원</td>
                            <td>
                                <span class="state state_point">예약</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="section select_button">
                    <a href="#" onclick="history.back();" class="wid_100">이전</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(function() {
            $(".table_basic>tbody>tr").click(function() {

                // let rno = $(this).children().eq(0).text();

                // location.href="reserveComplete.res?rno=" + rno;

                location.href="reserveComplete.res";
            })

        });
        

	
    </script>
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>