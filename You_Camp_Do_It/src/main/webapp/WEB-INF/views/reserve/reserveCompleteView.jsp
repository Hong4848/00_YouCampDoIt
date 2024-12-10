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
    
    .wrap-reserveComplete {
        font-family: Arial, sans-serif;
        font-weight: 400;
        margin: 0;
        padding: 0;
        background-color: #f8f8f8;
        box-sizing: border-box;
        width: 100%;
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

    #content_2 {
        display: flex;
        gap: 20px;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 10px;
        overflow: hidden;
        padding: 20px;
        font-weight: 400;
    }

    
    fieldset {
        width: 100%;
        border: none; 
        padding: 0; 
        margin: 0;
    }

    
    

    .reserve_wrap {
        width: 100%;
        padding: 0; /* 기본 여백 제거 */
        margin: 0;
    }

    .pc_wrap {
        display: flex;
        gap: 20px;
        width: 100%;
    }

    .left_box {
        width: 60%;
        display: flex;
        flex-direction: column;
        gap: 20px;
        height: 50%;
    }

    .left_box .reserve_guide .tit_h3 {
        font-size: 16px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .left_box .reserve_guide .reserv_guide_txt {
        font-size: 14px;
        line-height: 1.5;
        color: #333;
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

    .left_box .site_day {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #f8f8f8;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 15px 20px;
        position: relative;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .site_day .start_day,
    .site_day .end_day {
        width: 45%;
        text-align: center;
    }

    .site_day .start_day span,
    .site_day .end_day span {
        display: block;
        font-size: 14px;
        color: #666;
        margin-bottom: 5px;
    }

    .site_day .start_day strong,
    .site_day .end_day strong {
        font-size: 20px;
        color: #333;
        font-weight: bold;
    }

    .site_day .state_night {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: #ddd;
        color: #333;
        padding: 5px 15px;
        font-size: 12px;
        border-radius: 20px;
        font-weight: bold;
        white-space: nowrap;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        z-index: 1;
    }

    .site_day .state_night::before {
        content: '';
        position: absolute;
        width: 1px;
        height: 50%;
        background-color: #ddd;
        top: 50%;
        left: -5px;
        transform: translateY(-50%);
        z-index: -1;
    }

    .reserv_input {
        background-color: #f8f8f8;
        border: 1px solid #ddd;
        border-radius: 10px;
        
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        
    }

    .left_box_wrap .reserv_input {
        padding: 20px; /* 내부 여백 설정 */
        background-color: #f9f9f9; /* 연한 배경색 */
        border: 1px solid #e0e0e0; /* 테두리 */
        border-radius: 8px; /* 모서리 둥글게 */
        
        margin:  auto; /* 화면 중앙 정렬 */
        font-family: Arial, sans-serif; /* 기본 폰트 */
        font-size: 14px; /* 텍스트 크기 */
        color: #333; /* 텍스트 기본 색상 */
        padding: 10px 20px 10px 20px;
    }

    .input_box ul {
        list-style: none; /* 기본 리스트 스타일 제거 */
        margin: 0;
        padding: 0;
    }

    .input_box li {
        display: flex; /* 제목과 내용을 나란히 배치 */
        
        padding: 10px 0; /* 항목 간 간격 추가 */
        border-bottom: 1px solid #e0e0e0; /* 항목 사이 구분선 */
    }

    .input_box li:last-child {
        border-bottom: none; /* 마지막 항목 구분선 제거 */
    }

    .input_box .title {
        color: #999; /* 제목 색상 */
        font-weight: bold; /* 제목 강조 */
        margin-right: 40px; /* 제목과 내용 간 간격 */
    }




    /* Right Box */
    .right_box {
        width: 40%;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    
    .tit_h3 {
        font-size: 16px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .right_box .reserv_amount {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #f8f8f8;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 15px 20px;
        position: relative;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        
    }

    .amount_box {
        width: 100%;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 15px 20px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        font-family: Arial, sans-serif;
        color: #333;
        margin-bottom: 20px;
        margin: 0px;
    }

    /* 개별 금액 항목 */
    .amount_item ul {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .amount_item ul li {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }

    .amount_item ul li:last-child {
        border-bottom: none; /* 마지막 항목 테두리 제거 */
    }

    /* 날짜 */
    .amount_item .date {
        font-size: 14px;
        color: #666;
        flex: 1;
    }

    /* 예약 항목 이름 */
    .amount_item .item {
        font-size: 16px;
        font-weight: bold;
        flex: 2;
        text-align: left;
    }

    /* 가격 */
    .amount_item .price {
        font-size: 16px;
        color: #e74c3c; /* 빨간색 */
        font-weight: bold;
        flex: 1;
        text-align: right;
    }

    /* 추가 태그 스타일링 */
    .amount_item .item_tag {
        display: inline-block;
        background-color: #6d6d45;
        color: #fff;
        font-size: 12px;
        padding: 2px 10px;
        border-radius: 5px;
        margin-left: 5px;
    }

    /* 합계 영역 */
    .amount_sum {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 15px;
        border-top: 1px solid #ddd;
        font-size: 16px;
    }

    .amount_sum .title {
        font-size: 14px;
        color: #666;
        font-weight: normal;
    }

    .amount_sum .price strong {
        font-size: 20px;
        font-weight: bold;
        color: #333;
    }


    

    .right_box .reserve_guide .reserv_guide_txt {
        font-size: 14px;
        line-height: 1.5;
        color: #333;
    }

    .right_box .select_button {
        display: flex;
        justify-content: space-between;
        align-items: center; /* 수직 중앙 정렬 */
        gap: 10px;
    }


    .select_button .btn_cancel {
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
        height: 45px
        
    }

    .select_button .btnNext {
        display: flex; /* 버튼 내부에서 수직 중앙 정렬 활성화 */
        align-items: center; /* 수직 중앙 정렬 */
        justify-content: center; /* 가로 중앙 정렬 (선택 사항) */
        background-color: #6c5e37;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-align: center;
        font-size: 16px; /* 글자 크기 */
        flex: 2;
        height: 45px;
    }
    
    .select_button .btnNext:hover {
        background-color: #5a4d2e;
    }
        
    .select_button .btn_cancel:hover {
    	background-color: #6c5e37;
    }

    .reserv_guide_txt {
        background-color: #f8f8f8;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    
    .cancel_content{
    	background-color: #f8f8f8;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<div class="wrap-reserveComplete">

        <!-- 실시간 예약 / 예약확인,취소 -->
        <div id="content_1">
            <div class="reserve_wrap">
                <a href="reserveDate.res">실시간 예약</a>
                <a href="reserveList.res">예약확인/취소</a>
            </div>
        </div>
        
        <div class="content">
		    
            <div id="content_2">
                <fieldset>
                    <legend style="display: none;">실시간예약</legend>
                    <div class="pc_wrap">
                        <div class="left_box">
                            
                            <div class="left_box_wrap">
                                <div class="tit_h3" style="margin-top: 10px;">
                                    이용안내
                                </div>
                                <div class="section site_day">
                                    
                                    <div class="start_day">
                                        <span>체크인</span>
                                        <strong id="txt-checkIn">
                                            12.25(수)
                                        </strong>
                                    </div>
                                    <div class="state_night">2박</div>
                                    <div class="end_day">
                                        <span>체크아웃</span>
                                        <strong id="txt-checkOut">
                                            12.27(금)
                                        </strong>
                                    </div>
                                </div>

                                <div class="tit_h3" style="margin-top: 20px;">
                                    결제정보
                                </div>
                                <div class="section reserv_input">
                                    
                                    <div class="input_box">
                                        <ul>
                                            <li>
                                                <span class="title">예약번호</span>
                                                0098274
                                            </li>
                                            <li>
                                                <span class="title">결제일시</span>
                                                2024-12-09 18:08:20
                                            </li>
                                            <li>
                                                <span class="title">예약일자</span>
                                                2024.12.30(1박2일)
                                            </li>
                                            <li>
                                                <span class="title">결제수단</span>
                                                카카오머니 (일시불)
                                            </li>
                                            <li>
                                                <span class="title">승인번호</span>
                                                1234
                                            </li>
                                            <li>
                                                <span class="title">이용금액</span>
                                                30,000원
                                            </li>
                                            <li>
                                                <span class="title">결제금액</span>
                                                30,000원
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="tit_h3" style="margin-top: 20px; padding-bottom: 0px;">
                                    예약자정보
                                </div>
                                <div class="section reserv_input">
                                    
                                    <div class="input_box">
                                        <ul>
                                            <li>
                                                <span class="title">예약자명</span>
                                                정성민
                                            </li>
                                            <li>
                                                <span class="title">예약인원</span>
                                                4명
                                            </li>
                                            <li>
                                                <span class="title">생년월일</span>
                                                20000124
                                            </li>
                                            <li>
                                                <span class="title">휴대폰</span>
                                                &nbsp;&nbsp;&nbsp;&nbsp;010-9077-5766
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                            </div>

                            
                        </div>

                        <div class="right_box">
                            <div class="section bg_none reserve_amount">
                                <div class="tit_h3">
                                    결제예정 금액
                                </div>
                                <div class="amount_box">
                                    <div class="amount_item">
                                        <ul>
                                            <li>
                                                <span class="date">12.17</span>
                                                <span class="item">A섹션-3</span>
                                                <span class="price">
                                                    <strong>30,000원</strong>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="date">12.18</span>
                                                <span class="item">A섹션-3</span>
                                                <span class="price">
                                                    <strong>30,000원</strong>
                                                </span>
                                            </li>
                                        </ul>
                                    </div>
                                    <input type="hidden" name="roomNoArr" value="3,3">
                                    <input type="hidden" name="roomDateArr" value="20241217,20241218">
                                    <div class="amount_sum">
                                        <span class="title">합계</span>
                                        <span class="price">
                                            <strong>60,000원</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="section bg_none reserve_amount">
                                <div class="tit_h3">
                                    취소내역
                                </div>
                                <div class="cancel_content">
                                	<span>취소 내역이 없습니다.</span>
                                </div>
                                
                            </div>

                            <div class="section bg_none reserve_guide">
                                <div class="tit_h3">
                                     이용안내
                                </div>
                                <div class="reserv_guide_txt">
                                    <span style="font-weight:bolder;">[입, 퇴실시간 안내]</span><br> 
                                    · 일~목요일 입실 15:00 이후, 퇴실 11:00 이전<br> 
                                    · 금~토요일(공휴일) 입실 15:00 이후, 퇴실 11:00 이전<br>캠핑장 사정으로 입, 퇴실시간 변경될 수 있습니다. 숙소에 문의해 주세요.<br><br>
                                    <span style="font-weight:bolder;">[주차장 정보]</span><br>
                                    <p>· 객실 1개소 당 주차장 1구획 제공.</p> 		
                                    · 추가 주차는 캠핑장 내 주차장이 없으므로, 캠핑장 외부에 주차해주세요.<br><br>
                                    <span style="font-weight:bolder;">[주의사항]</span> <br>
                                    <!-- · 전력 수급 문제로 인해 텐트를 제외한 캠핑카, 캐라반, 트레일러는 이용이 통제됩니다.<br> -->
                                    · 캠프장내에 반려동물의 출입은 금지되어 있습니다.<br> 
                                    · 캠프장내 불꽃놀이는 전면 금지 되어 있습니다.<br>
                                    · 화로가 아닌 바닥에서 모닥불을 피우는 행위는 금지 되어 있습니다.<br>
                                    <p style="color:#006bb6">· 캠핑장의 모든 이용요금은 카드결제로 진행됩니다.</p>
                                    <p>· 바베큐 화로대, 숯, 장작, 철망은 캠핑장에서 제공하지 않습니다.</p>
                                    <p>· 개인이 지참하시거나 매점에서 대여 가능 합니다. (매점에서 구입가능)</p>
                                    <p>· 전 시설 이용 시 마스크 의무착용 및 예방시축(손 소독 및 발열체크)을 준수해주세요.</p>
                                    <p>· 이용정원은 방문객 포함 4인입니다. <br>(집합금지 명령에 따른 5인 이상 이용불가)</p>
                                    <p>· 이용정원 초과 및 개인파티 적발 시 방역지침에 따라 퇴실(신고) 조치 됩니다.</p> 
                                    <p>· 동일 거주지 영유아 포함된 5인 이상 직계가족은 가족관계증명서 지참 바랍니다.</p>
                                </div>
                            </div>
                            <div class="section select_button">
                                <a href="#cancel" class="btn_cancel wid30">예약취소</a>
                                <button type="button" class="wid_70 btnNext" onclick="goToList();">목록보기</button>
                            </div>
                            
                        </div>
                    </div>
                    
                </fieldset>
                
            </div>
        </div>

    </div>

	<jsp:include page="../common/footer.jsp" />
	
	<script>
		function goToList() {
			
			location.href="reserveList.res";
		}
	</script>

</body>
</html>