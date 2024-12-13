<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날짜 자리 선택</title>
    <style>
    	body {
    		width: 1900px;
    	}
    	
        .wrap-reserveDate {
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
            height : 850px;
            display: flex;
            gap: 20px;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
        }

        .left_box {
            width: 40%;
            height: 75%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .select_night {
            margin-bottom : 15px;
        }

        .select_night ul {
            display: flex;
            justify-content: space-between;
            padding: 0;
            margin: 0;
            list-style: none;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            height: 45px;
        }

        .select_night li {
            flex: 1; /* 각 항목이 동일한 넓이를 가짐 */
        }

        .select_night ul > :first-child {
            border-right: 1px #ddd solid;
            
        }

        .select_night input[type="radio"] {
            display: none; /* 라디오 버튼 숨김 */
        }

        .select_night label {
            display: block;
            padding: 10px 0;
            font-size: 16px;
            cursor: pointer;
            background-color: #fff;
            color: #333;
            border-right: 1px solid #ddd;
            transition: background-color 0.3s, color 0.3s;
        }

        .select_night label:last-child {
            border-right: none; /* 마지막 항목의 오른쪽 테두리 제거 */
        }

        .select_night input[type="radio"]:checked + label {
            background-color: #6c5e37; /* 선택된 항목의 배경색 */
            color: #fff; /* 선택된 항목의 글자색 */
            font-weight: bold;
        }

        .calendar {
            width: 100%;
            height: auto;
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            text-align: center;
            flex-grow: 1; /* 이 설정으로 남은 공간을 차지 */
        }

        .select_button {
            width: 100%;
            text-align: center;
        }

        .select_button .btnSearch {
            display: inline-block;
            width: 100%; /* 부모 .select_button의 너비를 따라감 */
            text-decoration: none;
            font-size: 16px;
            color: #fff;
            background-color: #6c5e37;
            padding: 10px 0;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .select_button .btnSearch:hover {
            background-color: #5a4d2e;
        }

        .right_box {
            width: 60%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .site_day {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f8f8f8;
            padding: 20px 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            position: relative;
            margin-bottom: 10px;
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

        .site_info {
            height: 50%;
        }

        .site_option {
            height: 30%;
            
        }



        .item_box {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .item {
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
            padding: 10px;
            transition: all 0.3s;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            
        }

        .item:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transform: translateY(-5px);
        }

        .item_img img {
            width: 100%;
            height: 230px;
            object-fit: cover;
            border-bottom: 1px solid #ddd;
            margin-bottom: 0px;
        }

        .item_txt {
            border: 1px solid #ddd; /* 얇은 테두리 */
            border-radius: 5px; /* 테두리 모서리를 둥글게 */
            padding: 10px; /* 내부 여백 */
            margin-top: 10px; /* 위쪽 간격 */
            background-color: #fff; /* 배경색 */
            text-align: center; /* 텍스트 가운데 정렬 */
            margin-bottom: 0px;
        }

        .item_title {
            display: block;
            font-size: 16px;
            color: #333;
            margin-bottom: 5px;
        }

        .item_price {
            font-size: 16px;
            color: #f44336;
            font-weight: bold;
        }


        .item a {
            text-decoration: none; /* 기본적으로 밑줄 제거 */
        }
        
        
        
        /* 달력 관련 시작 @@@ */
        .calendar{
            border-radius: 5%;
            width: 100%;
            height: 30%;
            background-color: #EAE3E3;
            color: black;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            
            
        }

        .calendar-title{
            width: 100%;
            display: flex;
            padding-inline: 10px;
            justify-content: space-between;
            text-align: center;
            padding-top: 10px;
            height: 40px;
            font-size: 20px;
            font-weight: 700;
        }

        .calendar-body{
            font-size: 15px;
            
        }

        .calendar-week, .calendar-day{
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-top: 8px;
            text-align: center;
            line-height: 70px;
            align-items: center;
            
        }
        
        .calendar-day {
        	height: 300px;
        }
        
        .day, .week{
        	display: flex;
        	justify-content: center;
        	align-items: center;
            width: 56.6px;
            height: 56.5px;
            font-weight: 600;
            
        }

        .day{
            cursor: pointer;
            
            
            
        }

        .day:hover{
            background-color: rgb(119, 119, 119);
        }

        .sat{
            color: rgb(40, 40, 255);
        }

        .sun{
            color: rgb(255, 0, 0);
        }

        .today{
            
            
            background-color: #CEB8B8;
        }

        .nextMonth, .prevMonth{
            opacity: 0.3;
        }
        /* 달력 관련 종료 */
        
        

    </style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
    
    <div class="wrap-reserveDate">
    
    	<!-- 실시간 예약 / 예약확인,취소 -->
        <div id="content_1">
            <div class="reserve_wrap">
                <a href="reserveDate.res">실시간 예약</a>
                <a href="reserveList.res">예약확인/취소</a>
            </div>
        </div>
        
	    <div class="content">
	        
	        <!-- 캘린더 / 장소선택 -->
	        <div id="content_2">
	            <div class="left_box">
	                <!-- 숙박일 선택 -->
	                <div class="section select_night">
	                    <ul>
	                        <li>
	                            <input type="radio" name="select_night" id="select_night_1" class="select_nigth_radio" value="1" checked="true">
	                            <label for="select_night_1">1박</label>
	                        </li>
	                        <li>
	                            <input type="radio" name="select_night" id="select_night_2" class="select_nigth_radio" value="2">
	                            <label for="select_night_2">2박</label>
	                        </li>
	                    </ul>
	                </div>
	
	                <!-- 캘린더가 들어갈 자리 -->
	                <div id="calendar" class="section calendar">
	                    
	                    
				            <div class="calendar-head">
				                <div class="calendar-title">
				                    <div id="prevCalender"><a onclick="prevMonth();" style="cursor: pointer;">⮜</a></div>
				                    <div style="width: 30%;"></div>
				                    <div id="year" class="yyyy">2024</div>
		                            <div class="yyyy">.</div>
				                    <div id="month" class="yyyy">12</div>
				                    <div style="width: 30%;"></div>
				                    <div id="prevCalender"><a onclick="nextMonth();" style="cursor: pointer;">⮞</a></div>
				                </div>
				            </div>
				            <div class="calendar-body">
				                <div class="calendar-week">
				                    <div class="week sun">SUN</div>
				                    <div class="week">MON</div>
				                    <div class="week">TUE</div>
				                    <div class="week">WED</div>
				                    <div class="week">THU</div>
				                    <div class="week">FRI</div>
				                    <div class="week sat">SAT</div>
				                </div>
				                <div class="calendar-day">
				                    <div class="day sun"></div>
				                    <div class="day mon"></div>
				                    <div class="day tue"></div>
				                    <div class="day wed"></div>
				                    <div class="day thu"></div>
				                    <div class="day fri"></div>
				                    <div class="day sat"></div>
				                    <div class="day sun"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day sat"></div>
				                    <div class="day sun"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day sat"></div>
				                    <div class="day sun"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day"></div>
				                    <div class="day sat"></div>
				                    <div class="day sun"></div>
				                    <div class="day mon"></div>
				                    <div class="day tue"></div>
				                    <div class="day wed"></div>
				                    <div class="day thu"></div>
				                    <div class="day fri"></div>
				                    <div class="day sat"></div>
		                            <div class="day sun"></div>
				                    <div class="day mon"></div>
				                    <div class="day tue"></div>
				                    <div class="day wed"></div>
				                    <div class="day thu"></div>
				                    <div class="day fri"></div>
				                    <div class="day sat"></div>
				                </div>
				            </div>
				        
	                </div>
	                <!-- 예약가능 섹션 검색 -->
	                <div class="section select_button">
	                    <a href="" class="btnSearch">
	                        <span class="ico_search"></span>
	                        예약가능 섹션 검색
	                    </a>
	                </div>
	
	            </div>
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
	                <div class="section item_box">
	                    <div class="item">
	                    	<!-- 숙박일, 체크인/체크아웃 날짜, 섹션값 쿼리 스트링으로 추후에 넘겨줘야함!! -->
	                        <a href="reserveDetail.res">
	                            <p class="item_img">
	                                <img src="resources/images/reserve/reserveDate/forest.jpg" alt="A섹션" width="800">
	                            </p>
	                            <p class="item_txt">
	                                <span class="item_title">
	                                    A섹션
	                                </span>
	                                <span class="item_price">
	                                    <strong>30,000</strong>
	                                    <span class="remain-seats">(5/10)</span> 
	                                </span>
	                            </p>
	                        </a>
	                    </div>
	                    <div class="item">
	                        <a href="reserveDetail.res">
	                            <p class="item_img">
	                                <img src="resources/images/reserve/reserveDate/belly.jpg" alt="B섹션">
	                            </p>
	                            <p class="item_txt">
	                                <span class="item_title">
	                                    B섹션
	                                </span>
	                                <span class="item_price">
	                                    <strong>40,000</strong>
	                                    <span class="remain-seats">(5/10)</span> 
	                                </span>
	                            </p>
	                        </a>
	                    </div>
	                    <div class="item">
	                        <a href="reserveDetail.res">
	                            <p class="item_img">
	                                <img src="resources/images/reserve/reserveDate/sky.jpg" alt="C섹션">
	                            </p>
	                            <p class="item_txt">
	                                <span class="item_title">
	                                    C섹션
	                                </span>
	                                <span class="item_price">
	                                    <strong>50,000</strong>
	                                    <span class="remain-seats">(5/10)</span> 
	                                </span>
	                            </p>
	                        </a>
	                    </div>
	                    <div class="item">
	                        <a href="reserveDetail.res">
	                            <p class="item_img">
	                                <img src="resources/images/reserve/reserveDate/stone.png" alt="D섹션">
	                            </p>
	                            <p class="item_txt">
	                                <span class="item_title">
	                                    D섹션
	                                </span>
	                                <span class="item_price">
	                                    <strong>60,000</strong>
	                                    <span class="remain-seats">(5/10)</span> 
	                                </span>
	                            </p>
	                        </a>
	                    </div>
	                </div>
	
	
	            </div>
	
	        </div>
	        
	    </div>
    </div>
    
    <script>
    
    	// 달력 관련 스크립트
        let date = new Date();
        let currentYear = ""; // 이번 년
        let currentMonth = ""; // 이번 달
        let currentDate = ""; // 오늘 일
        let currentLastDate = "";
        let prevLastDate = "";
        const WEEKDAY = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
        let LastWeek = "";

        $(()=>{
            // 현재 시간 뽑아오기
            currentYear = date.getFullYear();
            currentMonth = date.getMonth()+1;
            currentDate = date.getDate();
            dateInit();
            dateList();
        })

        function dateInit(){
            currentLastDate = new Date(currentYear, currentMonth, 0).getDate();
            prevLastDate = new Date(currentYear, currentMonth-1, 0).getDate();
            
            LastWeek = WEEKDAY[new Date(currentYear+"-"+currentMonth+"-"+currentLastDate).getDay()];
        }

        function dateList(){
            let start = false;
            let dayCount = currentLastDate;
            for(var i = 41; i >= 0; i--)
            {
                if($(".day").eq(i).attr("class").includes(LastWeek) && start == false && i <= 37)
                {
                    start = true;
                    
                    for(var j = 41; j > i; j--)
                    {
                        $(".day").eq(j).text(j-i);
                        $(".day").eq(j).addClass("nextMonth");
                    }
                }
                
                if(start == true)
                {
                    if(dayCount >= 1)
                    {
                        $(".day").eq(i).text(dayCount);
                        $(".day").eq(i).removeClass("prevMonth");
                        $(".day").eq(i).removeClass("nextMonth");
                        
                        if(currentYear == date.getFullYear() && currentMonth == date.getMonth()+1 && $(".day").eq(i).text() == currentDate){
                            $(".day").eq(i).addClass("today");
                        }
                        else{
                            $(".day").eq(i).removeClass("today");
                        }
                        dayCount -= 1;
                    }
                    else{
                        $(".day").eq(i).text(prevLastDate+dayCount);
                        $(".day").eq(i).removeClass("today");
                        $(".day").eq(i).addClass("prevMonth");
                        dayCount -= 1;
                    }
                    
                }
            }
        }

        function nextMonth(){
            if(currentMonth >= 12){
                currentYear += 1;
                currentMonth = 1;
                $("#year").text(currentYear)
                $("#month").text(currentMonth);
            }
            else{
                currentMonth += 1;
                $("#month").text(currentMonth);
            }
            dateInit();
            dateList();
        }

        function prevMonth(){
            if(currentMonth <= 1){
                currentYear -= 1;
                currentMonth = 12;
                $("#year").text(currentYear)
                $("#month").text(currentMonth);
            }
            else{
                currentMonth -= 1;
                $("#month").text(currentMonth);
            }
            dateInit();
            dateList();
        }
    </script>
    
    <script>
    	$(function() {
    		// 초기 체크된 라디오 버튼 값 가져오기
    	    const $stayDay = $("input[name='select_night']:checked").val();
    	    console.log("초기 선택된 값:", $stayDay);

    	    // 라디오 버튼 값이 변경될 때 가져오기
    	    $(".select_nigth_radio").on("change", function() {
    	        $stayDay = $("input[name='select_night']:checked").val();
    	        console.log("변경된 값:", $stayDay);
    	    });

    		
    		
    		
    		
    	});
    	
    </script>
    
    
    
    
    <jsp:include page="../common/footer.jsp" />

</body>
</html>