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
            transform: rotate(45deg);
        }
        .ico_show_arrow.down {
            transform: rotate(45deg);
        }
        .ico_show_arrow.up {
            transform: rotate(-135deg);
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
            font-weight:520; /* 텍스트 굵게 */
            color: #333; /* 텍스트 색상 */
            margin-bottom: 10px; /* 아래 여백 */
            border-left: 4px solid #6c5e37; /* 왼쪽에 포인트 색상 바 */
            padding-left: 10px; /* 텍스트와 포인트 바 간격 */
            font-weight: bold;
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

        .select_button .btnCancel {
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
        
        .select_button .btnCancel:hover {
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
        
        .agree_box {
        	width: 100%;
        }
        
        .agree_box label {
        	margin-bottom: 0px;
        }
        
        
        .wrap_select_userNo {
        	margin-bottom: 0px;
        	height: 95px;
        }
        
        
        .table-container {
		    max-height: 200px; /* 테이블 높이 제한 */
		    overflow-y: auto; /* 세로 스크롤 추가 */
		    border: 1px solid #ddd; /* 테이블 컨테이너 외곽선 */
		    border-radius: 5px; /* 테두리 둥글게 */
		    padding: 10px; /* 내부 여백 */
		    background-color: #fff; /* 배경색 */
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
		    font-weight: 400;
		}
		
		.table_basic {
		    width: 100%;
		    border-collapse: collapse;
		    text-align: center;
		    font-size: 14px;
		}
		
		.table_basic thead {
			background-color: #d1d1d1;
		}
		
		.table_basic thead th {
		    background-color: #d9d9d9; /* 헤더 배경색 */
		    font-weight: bold; /* 글자 굵게 */
		    color: #333; /* 글자색 */
		    padding: 10px;
		    border-bottom: 2px solid #ddd; /* 헤더 아래쪽 테두리 */
		    
		}
		.table_basic thead td {
		    
		    padding: 10px;
		    background-color
		}
		
		.table_basic tbody td {
		    padding: 10px;
		    border-bottom: 1px solid #ddd; /* 셀 아래쪽 테두리 */+
		    color: #555; /* 글자색 */
		}
		
		.table_basic tbody tr:hover {
		    background-color: #f1f1f1; /* 행에 마우스 오버 시 배경색 */
		}
		
		
		
		.refund {
		    display: block;
		    margin-top: 10px;
		    font-size: 12px;
		    color: #666;
		    
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
                <form id="orderInfoForm" name="cancelForm" 
                      action="reserveCancelRequest.res" method="post" target="_self">
                    
                    <input type="hidden" name="reserveNo" value="${ requestScope.r.reserveNo }">
                    <input type="hidden" name="startDate" value="${ requestScope.r.startDate }">
                    <input type="hidden" name="endDate" value="${ requestScope.r.endDate }">
                    <input type="hidden" name="nights" value="${ requestScope.r.nights }">
                    <input type="hidden" name="price" value="">
                    <input type="hidden" name="memberNo" value="${ requestScope.memberNo }">
                    <input type="hidden" name="campsiteId" value="${ requestScope.r.campsiteId }">
                    <input type="hidden" name="memberCount" value="">

                    <!-- 결제 취소 시 필요한 정보들들 -->
                    <table hidden>
                        <tr>
                            <th>원거래 ID</th>
                            <td><input type="text" name="TID" value="${ requestScope.r.paymentId }" /></td>
                        </tr>
                        <tr>
                            <th>취소 금액</th>
                            <td><input type="text" name="CancelAmt" value="${ requestScope.r.price }" /></td>
                        </tr>
                        <tr>
                            <th>부분취소 여부</th>
                            <td>
                                <input type="radio" name="PartialCancelCode" value="0" checked="checked"/> 전체취소
                                <input type="radio" name="PartialCancelCode" value="1"/> 부분취소
                            </td>
                        </tr>
                    </table>


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
                            
                        
                            
                        
                            
                            
                            
                            
                            <div class="section bg_none reserve_amount">
                                <div class="tit_h3">
                                    취소예정 금액
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
                                            <strong></strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            
                            <div>
	                            <div class="tit_h3">
	                                약관 동의
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
	                                        	<table class="table_basic mb20">
	                                        		<colgroup>
	                                        			<col style="width:30%">
	                                        			<col style="width:35%">
	                                        			<col style="width:35%">
	                                        		</colgroup>
	                                        		<thead>
	                                        			<tr>
	                                        				<td>구분</td>
	                                        				<td>주중</td>
	                                        				<td>주말</td>
	                                        			</tr>
	                                        		</thead>
	                                        		<tbody>
	                                        			<tr>
	                                        				<td>10일전</td>
	                                        				<td>전액환급</td>
	                                        				<td>전액환급</td>
	                                        			</tr>
	                                        			<tr>
	                                        				<td>9~7일전</td>
	                                        				<td>10% 공제</td>
	                                        				<td>10% 공제</td>
	                                        			</tr>
	                                        			<tr>
	                                        				<td>6~5일전</td>
	                                        				<td>30% 공제</td>
	                                        				<td>30% 공제</td>
	                                        			</tr>
	                                        			<tr>
	                                        				<td>4~3일전</td>
	                                        				<td>50% 공제</td>
	                                        				<td>50% 공제</td>
	                                        			</tr>
	                                        			<tr>
	                                        				<td>2일전~당일</td>
	                                        				<td>80% 공제</td>
	                                        				<td>80% 공제</td>
	                                        			</tr>
	                                        		</tbody>
	                                        	</table>
	                                        	
	                                            <span class="refund">※ 예약당일 취소는 전액 환급</span>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                            
                            
                        	</div>
                            
                            

                            <div class="section select_button">
                                <a href="#" onclick="history.back();" class="btn_cancel wid_30">이전</a>
                                <button type="button" class="wid_70 btnCancel" onClick="reqCancel();">취소하기</button>
                                <!-- 이버튼 누르면 취소 요청 들거가게 -->
                                 <!-- 만약 폼테그이면 췌소에 필요한 정보들 들어가게. -->
                            </div>


                        </div>

                    </div>


                </form>
            </fieldset>


        </div>

    </div>
    </div>

    
    <jsp:include page="../common/footer.jsp" />

    <script src="https://pg-web.nicepay.co.kr/v3/common/js/nicepay-pgweb.js" type="text/javascript"></script>

    <script type="text/javascript">
        function reqCancel(){
            document.cancelForm.submit();
        }
    </script>

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
            
            $(".btnCancel").on("click", function(e) {
           	    if (!$("#agree2").is(":checked")) {
            		alert("취소/환불 규정에 대한 약관에 동의해주세요!");
            		return false;
            	} 
           	    
                // db 변동 관련은 post 방식으로
           	    // location.href="reserveCancelRequest.res?reserveNo=${requestScope.r.reserveNo}";
            	
            	
            	
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
            
            
            
            

            


            
        });
        
        
        
        
    </script>
    
    
</body>
</html>