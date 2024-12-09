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
    	
        .wrap-reserveDetail {
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
            border: none; /* fieldset 테두리 제거 */
            padding: 0; /* 기본 여백 제거 */
            margin: 0;
        }

        legend {
            display: none; /* legend 숨기기 */
        }

        .pc_wrap {
            display: flex;
            gap: 20px;
            width: 100%;
        }


        /* Left Box */
        .left_box {
            width: 60%;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .left_box .site_photo img {
            width: 100%;
            height: auto;
            border-radius: 10px;
        }

        .left_box .site_info {
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .left_box .site_title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .left_box .site_option ul {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
            list-style: none;
            padding: 0;
        }

        .left_box .site_option li {
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px 10px;
            font-size: 14px;
            text-align: center;
            
        }

        .left_box .site_person {
            font-size: 14px;
            color: #666;
            margin-top: 10px;
        }

        .site_photo img {
            width: 100%;
        }

        .site_info {
            height: 21%;
            margin-bottom: 0px;
            padding: 0px;
        }

        .site_option {
            padding: 10px;
            height: 58%;
            border-top: 1px rgb(216, 204, 204) solid;
            border-bottom: 1px rgb(216, 204, 204) solid;
        }

        .site_person {
            padding-top: 10px;
        }

        /* Right Box */
        .right_box {
            width: 40%;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .right_box .site_day {
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

        

        .right_box .site_select .tit_h3 {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        /*
        .right_box .site_select ul {
            list-style: none;
            margin: 0;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;

            background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 10px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .right_box .site_select ul li {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 5px;
            background-color: #fff;
            width: calc(50% - 10px); 
        }
        */

        .site_select ul {
            list-style: none; /* 기본 리스트 스타일 제거 */
            padding: 0;
            margin: 0;
            max-height: 307px; /* 스크롤 영역 높이 제한 */
            overflow-y: auto; /* 세로 스크롤 활성화 */
            border: 1px solid #ddd; /* 리스트 테두리 */
            background-color: #f8f8f8;
            border-radius: 5px; /* 둥근 모서리 */
            padding: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .site_select ul li {
            display: flex; /* 체크박스와 텍스트를 나란히 배치 */
            align-items: center; /* 수직 중앙 정렬 */
            justify-content: space-between; /* 텍스트와 가격을 양쪽 정렬 */
            padding: 0px;
            margin-bottom: 10px; /* 아이템 간 간격 */
            border: 1px solid #ddd; /* 개별 항목 테두리 */
            border-radius: 5px; /* 둥근 모서리 */
            background-color: #fff; /* 배경색 */
            cursor: pointer; /* 마우스 커서를 포인터로 변경 */
            transition: all 0.3s ease; /* 애니메이션 부드럽게 */
            
        }
        
        .site_select ul li label {
        	margin: 0px;
        }

        .site_select ul li:last-child {
            margin-bottom: 0; /* 마지막 아이템 아래 간격 제거 */
        }

        .site_select ul li:hover {
            background-color: #bbb; /* 호버 시 배경색 */
        }

        /* 체크박스 숨김 */
        .site_select ul li input[type="checkbox"] {
            display: none; /* 기본 체크박스 숨김 */
        }

        /* 체크박스 커스텀 디자인 */
        .site_select ul li label::before {
            content: ''; /* 빈 콘텐츠 생성 */
            display: inline-block;
            width: 15px; /* 체크박스 크기 */
            height: 15px;
            margin-right: 0px; /* 체크박스와 텍스트 간격 */
            border: 2px solid #ccc; /* 기본 체크박스 테두리 */
            border-radius: 50%; /* 둥근 체크박스 */
            background-color: #fff; /* 체크박스 배경색 */
            transition: all 0.3s ease;
        }

        .site_select ul li input[type="checkbox"]:checked + label::before {
            border-color: #000; /* 선택 시 체크박스 테두리 색 변경 (검은색) */
            background-color: #6c5e37; /* 선택된 체크박스 배경색 */
            box-shadow: 0 0 0 2px white inset; /* 내부 하얀 원 */
        }

        /* 선택된 항목의 외곽선 */
        .site_select ul li input[type="checkbox"]:checked + label {
            border: 1px solid black; /* 선택 시 검은 테두리 */
            background-color: #e6dddd; /* 선택된 항목의 배경색 */
            
            
        }

        .site_select ul li label {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex: 1; /* 공간을 유연하게 차지 */
            padding: 10px;
            font-size: 15px;
            font-weight: ;
            cursor: pointer; /* 마우스 커서를 포인터로 변경 */
            color: #333; /* 기본 텍스트 색상 */
            gap: 10px; /* 텍스트 간 간격 */
        }

        .site_select ul li .price {
            display: flex;
            align-items: center; /* 가격 텍스트 수직 정렬 */
            gap: 5px; /* 텍스트와 1박 간 간격 */
            font-size: 14px;
            color: #333;
        }

        .site_select ul li .state_night {
            background-color: #ddd; /* 배경색 */
            color: #333; /* 텍스트 색상 */
            padding: 3px 8px; /* 내부 여백 */
            border-radius: 20px; /* 둥근 모서리 */
            font-size: 12px;
            font-weight: bold;
        }

        /* 스크롤바 스타일 */
        .site_select ul::-webkit-scrollbar {
            width: 8px;
        }

        .site_select ul::-webkit-scrollbar-thumb {
            background: #ccc; /* 스크롤바 색상 */
            border-radius: 4px;
        }

        .site_select ul::-webkit-scrollbar-thumb:hover {
            background: #bbb; /* 호버 시 스크롤바 색상 */
        }

        .site_select ul::-webkit-scrollbar-track {
            background: #f0f0f0; /* 스크롤바 트랙 색상 */
        }



        

        .right_box .reserve_guide .tit_h3 {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .right_box .reserve_guide .reserv_guide_txt {
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
        }

        .tit_h3 .btn_map {
            text-decoration: none; /* 밑줄 제거 */
            color: #333; /* 기본 텍스트 색상 */
            font-size: 12px; /* 글자 크기 */
            border: 1px solid #ddd; /* 외곽 테두리 */
            padding: 5px 10px; /* 버튼 내부 여백 */
            border-radius: 20px; /* 둥근 모서리 */
            background-color: #fff; /* 버튼 배경색 */
            transition: background-color 0.3s, color 0.3s; /* 호버 효과 부드럽게 */
        }

        .tit_h3 .btn_map:hover {
            background-color: #6c5e37; /* 호버 시 배경색 변경 */
            color: #fff; /* 호버 시 텍스트 색상 변경 */
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
            background-color: #ddd;
            color: #333;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            flex: 1;
            text-decoration: none;
            font-size: 16px; /* 글자 크기 */
            color: #333; /* 텍스트 색상 */
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

        .reserv_guide_txt {
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
	
	<div class="wrap-reserveDetail">
	
		<!-- 실시간 예약 / 예약확인,취소 -->
        <div id="content_1">
            <div class="reserve_wrap">
                <a href="">실시간 예약</a>
                <a href="">예약확인/취소</a>
            </div>
        </div>
        
        
    <div class="content">
        

        <!-- 사진 및 부가 시설 설명 -->
        <div id="content_2">
            <fieldset> <!-- 사진, 자리선택 div 모두 포함 -->
                <legend style="display: none;">실시간예약</legend>
                <form id="productSelectForm" action="reservation" method="post">
                    <input type="hidden" name="room_area_no" value="">
                    <input type="hidden" name="room_no" value="">
                    <input type="hidden" name="stay_cnt" value="">
                    <input type="hidden" name="check_in" value=""><!-- 체크인 날짜 -->
                    <input type="hidden" name="check_out" value=""><!-- 체크아웃 날짜 -->

                    <div class="pc_wrap">
                        <!-- 캠핑 사이트 사진, 이용가능시설 -->
                        <div class="left_box">
                            <div class="section site_photo">
                                <img src="resources/images/reserve/reserveDetail/forest.jpg" width="700px" alt="A섹션">
                            </div>
                            <div class="section site_info">
                                <div class="site_title">포레스트</div>
                                <div class="site_option">
                                    <ul>
                                        <li><span class="option_txt">계곡</span></li>
                                        <li><span class="option_txt">산책로</span></li>
                                        <li><span class="option_txt">샤워실</span></li>
                                        <li><span class="option_txt">개수대</span></li>
                                        <li><span class="option_txt">수세식</span></li>
                                        <li><span class="option_txt">전기</span></li>
                                        <li><span class="option_txt">온수</span></li>
                                        <li><span class="option_txt">불가능</span></li>
                                        <li><span class="option_txt">파쇄석</span></li>
                                    </ul>
                                </div>
                                <div class="site_person"> 
                                    최대 이용인원 4명 
                                </div>
                            </div>
                        </div>
                        <!-- 체크인/아웃 날짜 및 사이트 가격, 주의사항 부분 -->
                        <div class="right_box">
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
                            <div class="section bg_none site_select">
                                <div class="tit_h3">
                                     사이트정보
                                    <a href="#" class="btn_map">지도보기</a>
                                </div>
                                
                                <ul>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_1" value="1">
                                        <label for="room_1">
                                             A섹션 - 1
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_2" value="2">
                                        <label for="room_2">
                                             A섹션 - 2
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_3" value="3">
                                        <label for="room_3">
                                             A섹션 - 3
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_4" value="4">
                                        <label for="room_4">
                                             A섹션 - 4
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_5" value="5">
                                        <label for="room_5">
                                             A섹션 - 5
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_6" value="6">
                                        <label for="room_6">
                                             A섹션 - 6
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_7" value="7">
                                        <label for="room_7">
                                             A섹션 - 7
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_8" value="8">
                                        <label for="room_8">
                                             A섹션 - 8
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_9" value="9">
                                        <label for="room_9">
                                             A섹션 - 9
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="roomNoArr" id="room_10" value="10">
                                        <label for="room_10">
                                             A섹션 - 10
                                            <span class="price">
                                                <span class="state state_night">1박</span>
                                                30,000원
                                            </span>
                                        </label>
                                    </li>
                                    
                                </ul>
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
                                <a href="#" onclick="history.back();" class="btn_cancel wid30">취소</a>
                                <button type="button" class="wid_70 btnNext" onclick="goToPayment();">다음단계</button>
                            </div>
                        </div>
                    </div>
                </form>
            </fieldset>
        </div>
    </div>
    </div>

    <script>
        
        // 모든 체크박스를 가져옵니다.
        const checkboxes = document.querySelectorAll('.site_select ul li input[type="checkbox"]');

        // 체크박스 1개만 선택
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                // 다른 체크박스 선택 해제
                checkboxes.forEach(cb => {
                    if (cb !== this) cb.checked = false;
                });
            });
        });
        
        function goToPayment() {
        	location.href="reservePayment.res";
        }



    </script>
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>