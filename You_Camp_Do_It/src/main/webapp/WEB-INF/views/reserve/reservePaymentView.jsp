<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        body {
    		width: 1900px;
    	}
    	
        .wrap-reservePayment {
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

        .left_box {
            width: 60%;
            display: flex;
            flex-direction: column;
            gap: 20px;
            height: 50%;
        }

        .left_box .site_photo img {
            width: 659px;
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

        .left_box .site_option {
            height: 19%;
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
            padding-top: 10px;
        }

        .left_box .site_person .avail_num {
            font-size: 16px;
            font-family: bold;
            font-weight: 600;
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

        

        .site_person .reserv_guide_txt {
            border-top: 1px rgb(216, 204, 204) solid;
            margin-top: 20px;
            padding-top: 20px;
            text-align: left;
            margin-bottom: 0px;
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

        .right_box .reserv_agree1 {
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
        

        


        .content_box {
            border: 1px solid #ccc; /* 연한 테두리 */
            border-radius: 5px; /* 모서리를 부드럽게 */
            padding: 15px 10px; /* 위아래 15px, 좌우 10px 패딩 */
            background: #f9f9f9; /* 약간의 배경색 */
            line-height: 1.6; /* 줄 간격 조정 */
            font-size: 14px; /* 글자 크기 조정 */
            color: #333; /* 글자 색상 */

            overflow-y: auto; /* 스크롤 활성화 */
            max-height: 400px;
            
            
        }
        .content_box p {
            margin-bottom: 10px; /* 단락 사이 간격 */
        }
        .btn_show {
            cursor: pointer;
            text-decoration: underline;
            color: #007bff; /* 보기 버튼 색상 */
            
        }
        
        .btn_show:hover {
        	color: black;
        }
        
        .privacyBox {
            margin-top: 10px;
            max-height: 400px;
        }

        .agree_txt {
            display: none;
        }

        /* 보기 버튼 스타일 */
        .btn_show {
            
            cursor: pointer;
            color: #666;
            font-size: 14px;
            text-decoration: none; /* 밑줄 제거 */
            display: inline-flex;
            align-items: center;
            margin: 0px;
            padding: 0px;
            
        }
        .ico_show_arrow {
            display: inline-block;
            margin-left: 5px;
            width: 8px;
            height: 8px;
            border: solid #666;
            border-width: 0 2px 2px 0;
        }
        .ico_show_arrow.down {
            transform: rotate(45deg);
        }
        .ico_show_arrow.up {
            transform: rotate(-135deg);
        }

        .reserv_agree1>label {
            padding-right: 5px;
            display: inline-block;
            margin-right: 5px;
        }

        .right_box .reserv_agree2 {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px 20px;
            position: relative;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
            
        }

        .use_content3 {
            /* border: 1px solid #ccc; 연한 테두리 */
            border-radius: 5px; /* 모서리를 부드럽게 */
            padding: 15px 10px; /* 위아래 15px, 좌우 10px 패딩 */
            background: #f9f9f9; /* 약간의 배경색 */
            line-height: 1.6; /* 줄 간격 조정 */
            font-size: 14px; /* 글자 크기 조정 */
            color: #333; /* 글자 색상 */
            margin-top: 10px;
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

        .select_button .btnPay {
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
        
        .select_button .btnPay:hover {
            background-color: #5a4d2e;
        }
        
        .select_button .btn_cancel:hover {
        	background-color: #6c5e37;
        }

        

        /* 결제 박스 스타일 */
        .pay_box {
            width: 100%;
            background-color: #eaf5ff; /* 연한 파란 배경색 */
            border: 1px solid #ddd; /* 연한 회색 테두리 */
            border-radius: 5px; /* 모서리를 부드럽게 */
            padding: 15px 20px; /* 내부 여백 */
            font-family: Arial, sans-serif;
            color: #666; /* 기본 텍스트 색상 */
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 약간의 그림자 */
        }

        /* 리스트 아이템 스타일 */
        .pay_box ul {
            list-style: none; /* 기본 리스트 스타일 제거 */
            margin: 0;
            padding: 0;
        }

        .pay_box ul li {
            display: flex;
            align-items: center; /* 세로 중앙 정렬 */
            gap: 10px; /* 요소 간 간격 */
        }

        /* 제목 스타일 */
        .pay_box .title {
            font-size: 14px; /* 제목 글씨 크기 */
            color: #666; /* 연한 회색 */
            flex-shrink: 0; /* 제목 크기 고정 */
            width: 80px; /* 일정한 제목 폭 설정 */
            text-align: left; /* 왼쪽 정렬 */
        }

        /* 라디오 버튼 스타일 */
        input[type="radio"] {
            margin: 0; /* 기본 여백 제거 */
            accent-color: #007bff; /* 라디오 버튼 색상 (파란색) */
            cursor: pointer; /* 포인터 표시 */
        }

        .absolute_none {
            font-size: 14px; /* 레이블 글씨 크기 */
            color: #333; /* 다소 진한 색상 */
            cursor: pointer; /* 클릭 가능한 요소로 표시 */
            margin-bottom: 0px;
        }

        .reserv_agree3 {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px 20px;
            position: relative;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            
        }

        .pay_box {
            margin-bottom: 0px;
        }
        
        .agree_box label {
        	margin-bottom: 0px;
        }
        
        
        .custom-dropdown {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            position: relative;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            height: 60px;
            
        }
        
        .wrap_select_userNo {
        	margin-bottom: 0px;
        	height: 95px;
        }
        
		/* 드롭다운 메뉴 */
		.custom-dropdown {
		    display: flex;
		    width: 100%;
		    font-family: Arial, sans-serif;
		    margin-bottom: 20px;
		    align-items: center;
		    gap: 60px;
		    
		}
		
		.custom-dropdown label {
		    display: block;
		    margin-bottom: 5px;
		    font-size: 14px;
		    color: #555;
		    white-space: nowrap;
		    margin: 0px;
		}
		
		.dropdown {
		    position: relative;
		    width: 100%;
		}
		
		.dropdown-toggle {
		    width: 150px;
		    padding: 10px;
		    font-size: 16px;
		    text-align: left;
		    background: #fff;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    cursor: pointer;
		    position: relative;
		    font-size: 14px;
		    
		}
		
		.dropdown-toggle::after {
		    content: "▼";
		    position: absolute;
		    right: 10px;
		    top: 50%;
		    transform: translateY(-50%);
		    font-size: 12px;
		    color: #aaa;
		}
		
		.dropdown-menu {
		    display: none;
		    position: absolute;
		    width: 100%;
		    border: 1px solid #ccc;
		    background: #fff;
		    z-index: 10;
		    border-radius: 4px;
		    margin-top: 5px;
		    padding: 0;
		    list-style: none;
		    max-height: 150px;
		    overflow-y: auto;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}
		
		.dropdown-menu li {
		    padding: 10px;
		    cursor: pointer;
		    font-size: 14px;
		}
		
		.dropdown-menu li:hover {
		    background: #f0f0f0;
		}
		
		.dropdown-menu li.active {
		    background: #007bff;
		    color: #fff;
		}
		
		


        
    </style>
</head>
<body>

	<!-- 전달값들 뽑기 -->
	<c:set var="nights" value="${ requestScope.r.nights }" />
	<c:set var="section" value="${ requestScope.r.section }" />
	<c:set var="startDate" value="${ requestScope.r.startDate }" />
	<c:set var="endDate" value="${ requestScope.r.endDate }" />
	<c:set var="price" value="${ requestScope.r.price }" />
	<c:set var="campsiteId" value="${ requestScope.r.campsiteId }" />
	<c:set var="spotNo" value="${ requestScope.r.spotNo }" />
	
	

	<jsp:include page="../common/header.jsp" />

	<div class="wrap-reservePayment">
	
		<!-- 실시간 예약 / 예약확인,취소 -->
        <div id="content_1">
            <div class="reserve_wrap">
                <a href="reserveDate.res">실시간 예약</a>
                <a href="reserveList.res">예약확인/취소</a>
            </div>
        </div>

    <div class="content">
        

        <!-- 사진, 설명, 약관 부분 -->
        <div id="content_2">
            <fieldset>
                <legend style="display: none;">실시간예약</legend>
                <form id="orderInfoForm" name="orderInfoForm" action="reserveRequirePay.res" method="post">
                    
                    <input type="hidden" name="startDate" value="${ requestScope.r.startDate }">
                    <input type="hidden" name="endDate" value="${ requestScope.r.endDate }">
                    <input type="hidden" name="nights" value="${ requestScope.r.nights }">
                    <input type="hidden" name="price" value="">
                    <input type="hidden" name="memberNo" value="${ requestScope.memberNo }">
                    <input type="hidden" name="campsiteId" value="${ requestScope.r.campsiteId }">
                    <input type="hidden" name="memberCount" value="">

                    <div class="pc_wrap">
                        <!-- 캠핑 사이트 사진, 이용가능시설-->
                        <div class="left_box">
                            <div class="section site_photo">
                                <c:choose>
                            		<c:when test="${ requestScope.r.section eq 'A' }">
                            			<img src="resources/images/reserve/reserveDetail/forest.jpg" width="700px" alt="A섹션">
                            		</c:when>
                            		<c:when test="${ requestScope.r.section eq 'B' }">
                            			<img src="resources/images/reserve/reserveDetail/belly.jpg" width="700px" alt="A섹션">
                            		</c:when>
                            		<c:when test="${ requestScope.r.section eq 'C' }">
                            			<img src="resources/images/reserve/reserveDetail/sky.jpg" width="700px" alt="A섹션">
                            		</c:when>
                            		<c:when test="${ requestScope.r.section eq 'D' }">
                            			<img src="resources/images/reserve/reserveDetail/stone.png" width="700px" alt="A섹션">
                            		</c:when>
                            	</c:choose>
                            </div>
                            <div class="section site_info">
                            	<c:choose>
                            		<c:when test="${ requestScope.r.section eq 'A' }">
                            			<div class="site_title">A섹션</div>
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
                            	
                            		</c:when>
                            		<c:when test="${ requestScope.r.section eq 'B' }">
                            			<div class="site_title">B섹션</div>
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
                            	
                            		</c:when>
                            		<c:when test="${ requestScope.r.section eq 'C' }">
                            			<div class="site_title">C섹션</div>
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
                            	
                            		</c:when>
                            		<c:when test="${ requestScope.r.section eq 'D' }">
                            			<div class="site_title">D섹션</div>
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
                            	
                            		</c:when>
                            	</c:choose>
                            	
                            
                                
                                <div class="site_person"> 
                                	
                                	<c:choose>
	                            		<c:when test="${ requestScope.r.section eq 'A' }">
	                            			
	                            			<span class="avail_num">기준 이용인원 4명 / 최대 이용인원 4명</span>
	                            		</c:when>
	                            		<c:when test="${ requestScope.r.section eq 'B' }">
	                            			
	                            			<span class="avail_num">기준 이용인원 4명 / 최대 이용인원 4명</span>
	                            		</c:when>
	                            		<c:when test="${ requestScope.r.section eq 'C' }">
	                            			
	                            			<span class="avail_num">기준 이용인원 6명 / 최대 이용인원 6명</span>
	                            		</c:when>
	                            		<c:when test="${ requestScope.r.section eq 'D' }">
	                            			
	                            			<span class="avail_num">기준 이용인원 6명 / 최대 이용인원 6명</span>
	                            		</c:when>
	                            	</c:choose>
                                    
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
                            </div>
                        </div>
                        <!-- 체크인/아웃 날짜 및 규정, 결제 부분 -->
                        <div class="right_box">
                            <div class="section site_day">
                                <div class="start_day">
                                    <span>체크인</span>
                                    <strong id="txt-checkIn">
                                        
                                    </strong>
                                </div>
                                <div class="state_night"><c:out value="${ requestScope.r.nights }" />박</div>
                                <div class="end_day">
                                    <span>체크아웃</span>
                                    <strong id="txt-checkOut">
                                        
                                    </strong>
                                </div>
                            </div>
                            
                        
                            
                        <div>
                            <div class="tit_h3">
                                이용안내
                            </div>
                            <div class="section reserv_agree1">
                                
                                <div class="agree_box">
                                    <!-- 체크박스 -->
                                    <input type="checkbox" name="agree1" id="agree1" class="custum_checkbox">
                                    <label for="agree1" > 개인정보 수집, 이용 및 제공 (필수동의)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>

                                    <!-- 보기 버튼 -->
                                    <a href="" class="btn_show">
                                        보기
                                        <span class="ico ico_show_arrow"></span>
                                    </a>

                                    <!-- 약관 내용 -->
                                    <div class="agree_txt" >
                                        <div class="privacy privacyBox">
                                            <div class="content_box">
                                                <article class="box_style mb20">
                                                    ('https://jindongri.zapza.me/'이하 '진동리국민여가캠핑장')은(는) 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.<br>
                                                    '진동리국민여가캠핑장'은 개인정보처리방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.
                                                </article>
                                                <p>
                                                    1. 개인정보의 처리 목적
                                                    '진동리국민여가캠핑장'는 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다. 
                                                    <br><br>
                                                    <strong>가. 홈페이지 회원가입 및 관리</strong><br>
                                                    "회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 처리합니다."
                                                    <br>
                                                    <strong>나. 민원사무 처리</strong><br>
                                                    민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등을 목적으로 개인정보를 처리합니다.
                                                    <br>
                                                    <strong>다. 재화 또는 서비스 제공</strong><br>
                                                    서비스 제공, 본인인증, 연령인증, 요금결제·정산 등을 목적으로 개인정보를 처리합니다.
                                                    <br>
                                                    <strong>라. 마케팅 및 광고에의 활용</strong><br>
                                                    신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공 , 인구통계학적 특성에 따른 서비스 제공 및 광고 게재 , 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.
                                                    <br><br>
                                                    2. 개인정보 파일 현황
                                                    ‘진동리국민여가캠핑장’이 개인정보 보호법 제32조에 따라 등록·공개하는 개인정보파일의 처리목적은 다음과 같습니다.
                                                    <br><br>
                                                    <strong>가. 개인정보 파일명 : 진동리국민여가캠핑장 개인정보처리방침</strong>
                                                    <br><br>
                                                    개인정보 항목 : 자택주소, 비밀번호, 생년월일, 자택전화번호, 로그인ID, 휴대전화번호, 이름, 이메일, 결제기록, 접속 IP 정보, 쿠키, 서비스 이용 기록, 접속 로그
                                                    <br>
                                                    수집방법 : 홈페이지<br>
                                                    보유근거 : 회원이용약관<br>
                                                    보유기간 : 지체없이 파기<br>
                                                    관련법령 : 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년, 대금결제 및 재화 등의 공급에 관한 기록 : 5년, 계약 또는 청약철회 등에 관한 기록 : 5년
                                                    <br>
                                                    ※ 기타 '진동리국민여가캠핑장'의 개인정보파일 등록사항 공개는 행정안전부 개인정보보호 종합지원 포털(www.privacy.go.kr) → 개인정보민원 → 개인정보열람등 요구 → 개인정보파일 목록검색 메뉴를 활용해주시기 바랍니다.
                                                    <br><br><br>
                                                    3. 개인정보처리 위탁
                                                    <br><br>
                                                    ① '진동리국민여가캠핑장'는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.
                                                    <br>
                                                    《진동리국민여가캠핑장 홈페이지》
                                                    <br><br>
                                                    위탁받는 자(수탁자) : (주)임팩시스<br>
                                                    위탁하는 업무의 내용 : 홈페이지, 서버관리 및 운영<br>
                                                    ② '진동리국민여가캠핑장'는 위탁계약 체결시 개인정보 보호법 제25조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적·관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리·감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.
                                                    <br>
                                                    ③ 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.
                                                    <br><br><br>
                                                    4. 정보주체의 권리,의무 및 그 행사방법 이용자는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다.
                                                    <br><br>
                                                    가. 개인정보의 처리 목적
                                                    <br><br>
                                                    ① 정보주체는 '진동리국민여가캠핑장'에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.
                                                    <br><br>
                                                    개인정보 열람요구<br>
                                                    오류 등이 있을 경우 정정 요구<br>
                                                    삭제요구<br>
                                                    처리정지 요구<br>
                                                    ② 제1항에 따른 권리 행사는 '진동리국민여가캠핑장'에 대해 개인정보 보호법 시행규칙 별지 제8호 서식에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 '진동리국민여가캠핑장'는 이에 대해 지체 없이 조치하겠습니다.
                                                    <br>
                                                    ③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 '진동리국민여가캠핑장'는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.
                                                    <br>
                                                    ④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.
                                                    <br><br>
                                                    5. 처리하는 개인정보의 항목 작성<br>
                                                    '진동리국민여가캠핑장'는 다음의 개인정보 항목을 처리하고 있습니다.
                                                    <br><br>
                                                    가. 홈페이지 회원가입 및 관리
                                                    <br><br>
                                                    필수항목 : 개인정보의 처리 목적, 개인정보파일 현황, 개인정보의 처리 및 보유 기간, 개인정보처리의 위탁에 관한 사항, 정보주체의 권리·의무 및 그 행사방법에 관한 사항, 처리하는 개인정보의 항목, 개인정보의 파기에 관한 사항, 개인정보 보호책임자에 관한 사항, 개인정보 처리방침의 변경에 관한 사항, 개인정보의 안전성 확보조치에 관한 사항
                                                    <br>
                                                    선택항목 : 개인정보의 열람청구를 접수·처리하는 부서, 정보주체의 권익침해에 대한 구제방법
                                                    <br><br>
                                                    6. 개인정보의 파기<br>
                                                    '진동리국민여가캠핑장'는 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.
                                                    <br><br>
                                                    가. 홈페이지 회원가입 및 관리
                                                    <br><br>
                                                    파기절차 : 이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.
                                                    <br>
                                                    파기기한 : 이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.
                                                    <br>
                                                    파기방법 : 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.
                                                    <br><br><br>
                                                    7. 개인정보의 안전성 확보 조치
                                                    '진동리국민여가캠핑장'는 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.
                                                    <br><br>
                                                    <strong>1. 개인정보 취급 직원의 최소화 및 교육</strong><br>
                                                    개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.
                                                    <br>
                                                    <strong>2. 내부관리계획의 수립 및 시행</strong><br>
                                                    개인정보의 안전한 처리를 위하여 내부관리계획을 수립하고 시행하고 있습니다.
                                                    <br>
                                                    <strong>3. 개인정보의 암호화</strong><br>
                                                    이용자의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.
                                                    <br>
                                                    <strong>4. 개인정보에 대한 접근 제한</strong><br>
                                                    개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.
                                                    <br>
                                                    <strong>5. 접속기록의 보관 및 위변조 방지</strong><br>
                                                    개인정보처리시스템에 접속한 기록을 최소 6개월 이상 보관, 관리하고 있으며, 접속 기록이 위변조 및 도난, 분실되지 않도록 보안기능 사용하고 있습니다.
                                                    <br>
                                                    <strong>6. 비인가자에 대한 출입 통제</strong><br>
                                                    개인정보를 보관하고 있는 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.
                                                    <br><br>
                                                    8. 개인정보 보호책임자 작성
                                                    <br><br>
                                                    ① '진동리국민여가캠핑장'는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
                                                    <br>
                                                    개인정보 처리책임자 / (주)임팩시스
                                                    <br><br>
                                                    소장<br>
                                                    성명 : 이종환<br>
                                                    소속 : 기업부설연구소<br>
                                                    연락처 : 033-911-6510<br>
                                                    개인정보 처리담당자<br><br>
                                                    성명 : 진승우<br>
                                                    소속 : 기업부설연구소 개발팀<br>
                                                    직급 : 대리<br>
                                                    연락처 : 070-7004-7520<br>
                                                    ② 정보주체께서는 '진동리국민여가캠핑장'의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. '진동리국민여가캠핑장'는 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.
                                                    <br><br><br>
                                                    9. 개인정보 열람청구
                                                    <br><br>
                                                    ① 정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. '진동리국민여가캠핑장'는 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.
                                                    개인정보 열람청구 접수·처리 부서
                                                    <br><br>
                                                    부서명 : 기업부설연구소<br>
                                                    담당자 : 이종환 소장<br>
                                                    연락처 : 033-911-6510<br>
                                                    ② 정보주체께서는 제1항의 열람청구 접수·처리부서 이외에, 행정안전부의 ‘개인정보보호 종합지원 포털’ 웹사이트(www.privacy.go.kr)를 통하여서도 개인정보 열람청구를 하실 수 있습니다.
                                                    <br><br>
                                                    행정안전부 개인정보보호 종합지원 포털 → 개인정보 민원 → 개인정보 열람등 요구 (본인확인을 위하여 아이핀(I-PIN)이 있어야 함)
                                                    <br><br>
                                                    10. 개인정보보호문의처
                                                    아래의 기관은 '진동리국민여가캠핑장'과는 별개의 기관으로서, '진동리국민여가캠핑장'의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다.
                                                    <br><br>
                                                    개인정보 침해신고센터 (한국인터넷진흥원 운영)
                                                    <br><br>
                                                    소관업무 : 개인정보 침해사실 신고, 상담 신청<br>
                                                    홈페이지 : privacy.kisa.or.kr<br>
                                                    전화 : (국번없이) 118<br>
                                                    주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터
                                                    <br>
                                                    개인정보 분쟁조정위원회 (한국인터넷진흥원 운영)
                                                    <br><br>
                                                    소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)
                                                    <br>
                                                    홈페이지 : privacy.kisa.or.kr<br>
                                                    전화 : (국번없이) 118<br>
                                                    주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터
                                                    <br>
                                                    대검찰청 사이버범죄수사단
                                                    <br><br>
                                                    02-3480-3573 (www.spo.go.kr)<br>
                                                    경찰청 사이버범죄수사단<br><br>
                                                    1566-0112 (cyberbureau.police.go.kr)<br><br><br>
                                                    11. 개인정보 처리방침 변경<br>
                                                    이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.
                                                    <br><br><br>
                                                    12. 동의를 거부할 권리 및 불이익 내용
                                                    정보주체는 개인정보의 수집·이용목적에 대한 동의를 거부할 수 있으며, 동의 거부시 진동리국민여가캠핑장 홈페이지에 회원가입이 되지 않으며, 진동리국민여가캠핑장 홈페이지에서 제공하는 서비스를 이용할 수 없습니다.
                                                    <br><br>
                                                </p>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <div class="section reserv_agree2">
                                <div class="agree_box">
                                    <input type="checkbox" name="agree2" id="agree2" class="custum_checkbox">
                                    <label for="agree2"> 취소/환불 규정에 대한 동의 (필수동의)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <a href="" class="btn_show">
                                        보기
                                        <span class="ico ico_show_arrow"></span>
                                    </a>
                                    <div class="agree_txt">
                                        <div class="use_content3">
                                            <em>※ 예약당일 취소는 전액 환급</em>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            
                            </div>
                            
                            
                            <div class="section wrap_select_userNo">
                            	<div class="tit_h3">
	                                이용인원 선택
	                            </div>
	                            
	                            	
	                            	<div class="custom-dropdown">
									    <label for="dropdown">캠핑장 이용인원을 선택해주세요</label>
									    <div class="dropdown">
									        <button type="button" class="dropdown-toggle">선택해주세요</button>
									        <ul class="dropdown-menu">
									        	<c:choose>
									        		<c:when test="${ requestScope.r.section eq 'A' || requestScope.r.section eq 'B' }">
									        			<li data-value="1">1명</li>
											            <li data-value="2">2명</li>
											            <li data-value="3">3명</li>
											            <li data-value="4">4명</li>
									        		</c:when>
									        		<c:when test="${ requestScope.r.section eq 'C' || requestScope.r.section eq 'D' }">
									        			<li data-value="1">1명</li>
											            <li data-value="2">2명</li>
											            <li data-value="3">3명</li>
											            <li data-value="4">4명</li>
											            <li data-value="5">5명</li>
											            <li data-value="6">6명</li>
											            
									        		</c:when>
									        	</c:choose>
									            
									        </ul>
									        <input type="hidden" id="dropdown" name="dropdown" value="">
									    </div>
									</div>

	                            	
	                            
                            </div>
                            
                            <div class="section bg_none reserve_amount">
                                <div class="tit_h3">
                                    결제예정 금액
                                </div>
                                <div class="amount_box">
                                    <div class="amount_item">
                                    
                                    	<c:choose>
                                    		<c:when test="${ requestScope.r.nights eq 1 }">
                                    			<ul>
		                                            <li>
		                                                <span class="date"></span>
		                                                <span class="item">
		                                                	<c:out value="${ requestScope.r.section }" />섹션 - <c:out value="${ requestScope.r.spotNo }" />
		                                                </span>
		                                                <span class="price">
		                                                    <strong></strong>
		                                                </span>
		                                            </li>
		                                        </ul>
                                    		</c:when>
                                    		<c:otherwise>
                                    			<ul>
		                                            <li>
		                                                <span class="date"></span>
		                                                <span class="item">
		                                                	<c:out value="${ requestScope.r.section }" />섹션 - <c:out value="${ requestScope.r.spotNo }" />
		                                                </span>
		                                                <span class="price">
		                                                    <strong></strong>
		                                                </span>
		                                            </li>
		                                            <li>
		                                                <span class="date"></span>
		                                                <span class="item">
		                                                	<c:out value="${ requestScope.r.section }" />섹션 - <c:out value="${ requestScope.r.spotNo}" />
		                                                </span>
		                                                <span class="price">
		                                                    <strong></strong>
		                                                </span>
		                                            </li>
		                                        </ul>
                                    		</c:otherwise>
                                    	
                                    	</c:choose>
                                        
                                        
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
                            
                            <div class="section bg_none reserv_pay">
                                <div class="tit_h3">
                                    결제정보
                                </div>
                                <div class="pay_box">
                                    <ul>
                                        <li>
                                            <span class="title">결제수단</span>
                                            <input type="radio" name="pay_method" id="pay_method1" checked="checked">
                                            <label for="pay_method1" class="absolute_none" style="font-weight:550">나이스페이</label>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="section reserv_agree3">
                                <div class="agree_box">
                                    <input type="checkbox" name="agree3" id="agree3" data-gtm-form-interact-field-id="0">
                                    <label for="agree3">위 상품의 구매조건 확인 및 결제진행 동의 (필수동의)</label>
                                </div>
                            </div>

                            <div class="section select_button">
                                <a href="#" onclick="history.back();" class="btn_cancel wid_30">취소</a>
                                <button type="submit" class="wid_70 btnPay">결제</button>
                            </div>


                        </div>

                    </div>


                </form>
            </fieldset>


        </div>

    </div>
    </div>

    <script>
        $(function() {
            $(".btn_show").on("click", function (e) {
		        e.preventDefault();
		        const $agreeTxt = $(this).siblings(".agree_txt");
		        const $arrow = $(this).find(".ico_show_arrow");
		
		        // 약관 상태에 따라 슬라이드 및 화살표 방향 전환
		        $agreeTxt.slideToggle(200, function () {
		            if ($agreeTxt.is(":visible")) {
		                $arrow.removeClass("down").addClass("up"); // 위쪽 화살표
		            } else {
		                $arrow.removeClass("up").addClass("down"); // 아래쪽 화살표
		            }
		        });
		    });
            
            $(".btnPay").on("click", function(e) {
           	    if (!$("#agree1").is(":checked")) {
            		alert("개인정보 수집, 이용 및 제공 약관에 동의해주세요!");
            		return false;
            	} else if (!$("#agree2").is(":checked")) {
            		alert("취소/환불 규정에 대한 약관에 동의해주세요!");
            		return false;
            	} else if ($(".dropdown-toggle").text() == "선택해주세요") {
            		alert("캠핑장 이용인원을 선택해주세요!");
            		return false;
            	} else if (!$("#agree3").is(":checked")) {
            		alert("구매조건 확인 및 결제진행에 최종 동의해주세요!");
            		return false;
            	} 
            	
            	
            	
            });
            
            
            // 받아온 전달값들 뽑기
            let nights = "${requestScope.r.nights}";
            let startDate = "${requestScope.r.startDate}";
            let endDate = "${requestScope.r.endDate}";
            let price = "${requestScope.r.price}";
            let campsiteId = "${requestScope.r.campsiteId}";
            let section = "${requestScope.r.section}";
            let spotNo = "${requestScope.r.spotNo}";
            
            
            // 체크인/체크아웃 날짜 표시
            let date = new Date(startDate);
    		let checkInMonth = (date.getMonth() + 1).toString().padStart(2, "0");
    		let checkInDay = date.getDate().toString().padStart(2, "0");
    		let weekDayNames = ["일", "월", "화", "수", "목", "금", "토"];
    		let weekDay = weekDayNames[date.getDay()];
    		
  			$("#txt-checkIn").text(`\${checkInMonth}.\${checkInDay}(\${weekDay})`);
  			
  			
  			date = new Date(endDate);
  			let checkOutMonth = (date.getMonth() + 1).toString().padStart(2, "0");
  			let checkOutDay = date.getDate().toString().padStart(2, "0");
  			weekDay = weekDayNames[date.getDay()];
  			
  			$("#txt-checkOut").text(`\${checkOutMonth}.\${checkOutDay}(\${weekDay})`);
  			
  			date = new Date(startDate);
  			date.setDate(date.getDate() + 1);
  			
  			let centerMonth = (date.getMonth() + 1).toString().padStart(2, "0");
  			let centerDay = date.getDate().toString().padStart(2, "0");
  			
  			
  			// 하루 숙박 가격 표시
  			$(".amount_item .price strong").text(new Intl.NumberFormat('ko-KR').format(price) + "원");
            
            
            // 1박/2박 여부에 따라 case 갈림
            
            if(nights == 1) {
            	
            	$(".date").text(`\${checkInMonth}.\${checkInDay}`);
            	$(".amount_sum .price strong").text(new Intl.NumberFormat('ko-KR').format(price) + "원");
            	$("input[name='price']").val(price);
            	
            } else {
            	
            	let totalPrice = price * nights;
            	
            	$(".amount_item ul>li:eq(0) .date").text(`\${checkInMonth}.\${checkInDay}`);
            	$(".amount_item ul>li:eq(1) .date").text(`\${centerMonth}.\${centerDay}`);
            	$(".amount_sum .price strong").text(new Intl.NumberFormat('ko-KR').format(totalPrice) + "원");
            	$("input[name='price']").val(totalPrice);
            }
            
            // console.log($("input[name='price']").val());
            
            
            
            // 드롭다운 메뉴 열기/닫기
            $(".dropdown-toggle").on("click", function () {
                $(this).next(".dropdown-menu").toggle(); // 메뉴 보이기/숨기기
            });

            // 옵션 선택 시
            $(".dropdown-menu li").on("click", function () {
                let value = $(this).data("value");
                let text = $(this).text();

                // 선택된 값 버튼에 표시
                $(this).closest(".dropdown").find(".dropdown-toggle").text(text);

                // 선택된 값 hidden input에 저장
                $(this).closest(".dropdown").find("input[type='hidden']").val(value);

                // 메뉴 닫기
                $(this).parent().hide();
                
                $("input[name='memberCount']").val(text.replace("명", ""));
                
                
                
                
            });

            // 페이지 다른 곳 클릭 시 메뉴 닫기
            $(document).on("click", function (e) {
                if (!$(e.target).closest(".dropdown").length) {
                    $(".dropdown-menu").hide();
                }
            });


            
        });
        
        
        
        
    </script>
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>