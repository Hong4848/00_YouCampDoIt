<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
		<style>
			/* 메인페이지 용 css 시작 */

            /* 상단 이미지 관련 시작 */
            #mainImg{
                box-sizing: border-box;
                height: 950px;
            }
            
            #mainImg>img{
                transition: all 1s;
                position: absolute;
            }
            /* 상단 이미지 관련 종료 */


            /* 달력 및 날씨 관련 시작 */
            
            #dayWeather{
                width: 100%;
                margin: auto;
                left: 0px;
                right: 0px;
                display: flex;
                justify-content:center
            }

            /* 달력 관련 시작 */
            .calendar{
                border-radius: 5%;
                width: 490px;
                background-color: rgb(87, 87, 87);
                color: white;
            }

            .calendar-title{
                width: 100%;
                display: flex;
                padding-inline: 10px;
                justify-content: space-between;
                text-align: center;
                padding-top: 10px;
                height: 40px;
                font-size: 30px;
            }

            .calendar-body{
                font-size: 17px;
            }

            .calendar-week, .calendar-day{
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                margin-top: 8px;
                text-align: center;
                line-height: 70px;
            }
            
            .day, .week{
                width: 70px;
                height: 70px;
                font-weight: 800;
            }

            .day{
                cursor: pointer;
                border-radius: 10%;
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
                border-radius: 100%;
                
                background-color: rgba(0, 189, 0, 0.7);
            }

            .nextMonth, .prevMonth{
                opacity: 0.5;
            }
            /* 달력 관련 종료 */

            /* 날씨 관련 시작 */
            .weather{
                background-color: rgb(190, 190, 190);
                width: 490px;
                border-radius: 5%;
            }

            .weather_header{
                height: 120px;
            }

            #weather_location{
                font-size: 30px;
                padding-top: 5px;
                padding-left: 15px;
                font-weight: 800;
            }

            #current_temp{
                display: flex;
                justify-content:space-between
            }

            #temp{
                font-size: 40px;
                line-height: 50px;
            }

            #current_img>img{
                height: 50px;
            }

            .sunny{
                filter: invert(10%) sepia(94%) saturate(7010%) hue-rotate(11deg) brightness(120%) contrast(122%);
            }

            .cloudy{
                filter: invert(63%) sepia(21%) saturate(303%) hue-rotate(147deg) brightness(93%) contrast(85%);
            }

            .rainy{
                filter: invert(39%) sepia(83%) saturate(543%) hue-rotate(175deg) brightness(106%) contrast(94%);
            }
            /* 날씨 관련 종료 */
            /* 달력 및 날씨 관련 종료 */
            /* 메인페이지 용 css 종료 */
            #menuImg{
            	display:none;
            }

            .yyyy{
                transition: all 1s;
            }
            
            .camp-information {
            	width: 100%;
            	height: 1200px;
            	background-color: rgb(246, 233, 219);
            	margin: 0 auto;
            }
            
			.info-title{
				text-align: center;
			}

            .info-title h1 {
            	padding-top: 100px;
            	margin-bottom: 100px;
            	text-align: center;
            }
            
            .info-content {

			    display: flex; /* Flexbox로 좌우 배치 */
			    gap: 20px; /* 요소 사이 여백 */
			}
			
			.info-img{
			  flex: 1.5; /* 이미지 영역 크기 */
			  height: 700px; /* 임의 높이 */
			  position: relative;
			}
			
			.info-img>img{
				width: 1000px;
				height: 600px;
				transition: all 1s;
                position: absolute;
				margin: auto;
				margin-top: 120px;
				margin-left: 30px;
			}
			
			.info-explain {
			  flex: 1; /* 설명 영역 크기 */
			  margin-top: 100px;
			  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
			}
            
            .info-explain {
			  
			  padding: 20px;
			  border-radius: 8px;
			  box-shadow: none;
			  line-height: 1.6;
			  color: #555;
			  font-size: 16px;
			  margin: 100px 200px 160px 100px;
			  
			  background-color: #fdf7ef; 
			  
			}
			
			.section-title {
			  display: flex;
			  align-items: center;
			  margin-bottom: 16px;
			}
			
			.section-title .badge {
				
			  background-color: #566841; /* 배지 색상 */
			  color: white;
			  padding: 10px 20px;
			  
			  font-size: 20px;
			  margin-right: 10px;
			}
			
			.section-title h2 {
			  font-size: 30px;
			  color: #333;
			  margin: 0;
			}
			
			.description {
			  margin-bottom: 20px;
			  color: #444;
			}
			
			.details {
			  list-style: none;
			  padding: 0;
			  margin-bottom: 20px;
			}
			
			.details li {
			  margin-bottom: 8px;
			}
			
			.details strong {
			  color: #333;
			}
			
			.tags {
			  display: flex;
			  flex-wrap: wrap;
			  gap: 8px;
			}
			
			.tags span {
			  background-color: #f8f0e8;
			  color: #666;
			  padding: 5px 10px;
			  border-radius: 16px;
			  font-size: 14px;
			  transition: background-color 0.3s;
			}
			
			.tags span:hover {
			  background-color: #fdd835; /* 호버 시 강조 색상 */
			  color: #fff;
			}

			.infoNo{
				width: 100%;
				height: 900px;
				position: absolute;
				display: flex;
			}
		</style>
	</head>
	<body>
		<!-- 여기부터는 메인페이지 -->
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<c:if test="${sessionScope.wrongMsg eq '잘못된 접근입니다.'}">
			<script>
				alertify.alert('wrongMsg', '${ sessionScope.wrongMsg }', function(){ alertify.success('관리자 계정으로 로그인 후<br> 이용해주세요'); });
			</script>
			<c:remove var="wrongMsg" scope="session" />
		</c:if>
		<div class="mainContent" >
		    <!-- 상단 이미지 영역 -->
		    <div id="mainImg">
		        <img src="resources/images/mainPage/배경1.jpg" id="imgNo_01">
		        <img src="resources/images/mainPage/배경2.jpg" id="imgNo_02">
		        <img src="resources/images/mainPage/배경3.jpg" id="imgNo_03">
		    </div>
		    
		    <div class="camp-information" >
				<div class="info-title" style="height:300px">
					<h1>캠핑장 소개</h1>
				</div>
				<div class="infoNo">
					<div class="info-content">
						<div class="info-img">
							<img src="resources/images/mainPage/forest.png" id="infoNo1">
							<img src="resources/images/mainPage/belly.png" id="infoNo2">
							<img src="resources/images/mainPage/sky.png" id="infoNo3">
							<img src="resources/images/mainPage/stone.png" id="infoNo4">
						</div>
						<div class="info-explain">
							<div class="section-title">
								<span class="badge">1구역</span>
								<h2>&nbsp;포레스트</h2>
							</div>
							<br>
							<p class="description">
								계곡을 가운데 끼고 산으로 둘러싸인 인제 진동리, 복잡한 도심에서 벗어나 힐링을 하고 싶다면 여기
								진동리 캠핑장으로 당장 떠나자. 새소리와 물소리를 들으며 아침에 눈을 뜨게 되고 상쾌한 아침공기를
								마시며 가만히 앉아있으면 마음이 평온해진다.
							</p>
							<ul class="details">
								<li><strong>사이트 &nbsp;&nbsp;</strong> 파쇄석 18개</li>
								<li><strong>시설 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 남/여 화장실, 남/여 샤워실, 취사장</li>
							</ul>
							<div class="tags">
								<span>#숲속</span>
								<span>#물소리</span>
								<span>#새소리</span>
								<span>#밤나무</span>
								<span>#힐링스팟</span>
							</div>
						</div>
					</div>
				</div>
		    </div>

		
			<!-- 
		    <div id="dayWeather">
		        <div class="calendar">
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
                <div style="width: 50px;">

                </div>
		        <div class="weather">
		            <div class="weather_header">
		                <div id="weather_location">
		                    영등포구 양평2동
		                </div>
                        
		                <div id="current_temp">
		                    <div style="width: 20%;"></div>
		                    <div id="temp">
		                        3.1°C
		                    </div>
		                    <div id="current_img" class="sunny">
		                        <img src="" alt="맑음">
		                    </div>
		                    <div style="width: 20%;"></div>
		                </div>
		            </div>
		            <div style="margin: auto; left: 0px; right: 0px; background-color: rgb(153, 153, 153); width: 90%; height: 2px;"></div>
		            <div class="weather_content">
		
		            </div>
		        </div>
		    </div>
		    <div>
		        여기는 아직
		    </div>
		</div>
		-->
		
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
		
		
		<!-- 메인페이지 용 스크립트 -->
        <script>
            let imgNumber = 2;
            let infoNumber = 1;
            
            let timer1 = setInterval(nextImg, 2000)
            
            function nextImg()
            {
                // 추후 EL 구문으로 재작성
                switch(imgNumber)
                {
                    case 1 :
                        $("#imgNo_01").css("opacity", "0.0");
                        $("#imgNo_02").css("opacity", "1.0");
                        $("#imgNo_03").css("opacity", "0.0");
                        imgNumber = 2;
                        break;
                    case 2 :
                        $("#imgNo_01").css("opacity", "0.0");
                        $("#imgNo_02").css("opacity", "0.0");
                        $("#imgNo_03").css("opacity", "1.0");
                        imgNumber = 3;
                        break;
                    case 3 :
                        $("#imgNo_01").css("opacity", "1.0");
                        $("#imgNo_02").css("opacity", "0.0");
                        $("#imgNo_03").css("opacity", "0.0");
                        imgNumber = 1;
                        break;
                }
                
            }

            let timer2 = setInterval(nextInfo, 4000)
            function nextInfo() {
            	switch(infoNumber){
	            	case 1 :
						$("#infoNo1").css("opacity", "0.0");
						$("#infoNo2").css("opacity", "1.0");
						$("#infoNo3").css("opacity", "0.0");
						$("#infoNo4").css("opacity", "0.0");
						console.log("왜");
		                infoNumber = 2;
		                break;
		            case 2 :
						$("#infoNo1").css("opacity", "0.0");
						$("#infoNo2").css("opacity", "0.0");
						$("#infoNo3").css("opacity", "1.0");
						$("#infoNo4").css("opacity", "0.0");
		                infoNumber = 3;
		                break;
					case 3 :
						$("#infoNo1").css("opacity", "0.0");
						$("#infoNo2").css("opacity", "0.0");
						$("#infoNo3").css("opacity", "0.0");
						$("#infoNo4").css("opacity", "1.0");
		                infoNumber = 1;
		                break;
					case 4 :
						$("#infoNo1").css("opacity", "1.0");
						$("#infoNo2").css("opacity", "0.0");
						$("#infoNo3").css("opacity", "0.0");
						$("#infoNo4").css("opacity", "0.0");
		                infoNumber = 1;
		            break;

            	}
            }
        </script>

        <script>
            let weatherIcon = "맑음" // 날씨 정보 불러온 거
            switch(weatherIcon)
            {
                case "맑음" :
                    $("#current_img").attr("class", "sunny").children("img").attr("src", "resources/images/weather/맑음.png").attr("alt", "맑음");
                    break;
                case "흐림" : 
                    $("#current_img").attr("class", "cloudy").children("img").attr("src", "resources/images/weather/흐림.png").attr("alt", "흐림");
                    break;
                case "비" :
                    $("#current_img").attr("class", "rainy").children("img").attr("src", "resources/images/weather/비.png").attr("alt", "비");
                    break;
            }
        </script>

        <script>
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
                        console.log(i);
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
	</body>
</html>