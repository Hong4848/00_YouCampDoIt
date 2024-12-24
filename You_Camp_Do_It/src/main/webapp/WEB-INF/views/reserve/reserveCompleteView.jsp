<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    
    #content_thank {
    	
        
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 10px;
        overflow: hidden;
        padding-top: 35px;
        font-weight: 400;
        height: 130px;
        text-align: center;
        margin-bottom: 30px;
        
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
		    
		    <c:choose>
		    	<c:when test="${ not empty requestScope.afterPayment }">
		    		<div id="content_thank">
				    	<h4>감사합니다. 예약이 완료되었습니다.</h4>
				    	<span>캠핑장 이용시 본인 확인을 위해 신분증을 반드시 지참해 주시기 바랍니다.</span>
				    	
				    </div>
		    	</c:when>
		    	<c:when test="${ empty requestScope.afterPayment }">
		    	
		    	</c:when>
		    	
		    </c:choose>
		    
		    
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
                                            
                                        </strong>
                                    </div>
                                    <div class="state_night">${ requestScope.r.nights }박</div>
                                    <div class="end_day">
                                        <span>체크아웃</span>
                                        <strong id="txt-checkOut">
                                            
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
                                                ${ requestScope.r.reserveNo }
                                            </li>
                                            <li>
                                                <span class="title">결제일시</span>
                                                ${ requestScope.r.paymentDate.substring(0, 10) }
                                            </li>
                                            <li>
                                                <span class="title">예약일자</span>
                                                ${ requestScope.r.startDate.substring(0, 10) }
                                            </li>
                                            <li>
                                                <span class="title">결제수단</span>
                                                ${ requestScope.r.paymentMethod }
                                            </li>
                                            
                                            <c:choose>
                                            	<c:when test="${ requestScope.r.nights eq 1}">
		                                            <li>
		                                                <span class="title">이용금액</span>
		                                                <fmt:formatNumber value="${ requestScope.r.price }" pattern="#,###" />원
		                                            </li>
		                                            <li>
		                                                <span class="title">결제금액</span>
		                                                <fmt:formatNumber value="${ requestScope.r.price }" pattern="#,###" />원
		                                            </li>
                                            	</c:when>
                                            	<c:when test="${ requestScope.r.nights eq 2}">
                                            		<li>
		                                                <span class="title">이용금액</span>
		                                                <fmt:formatNumber value="${ requestScope.r.price * 2 }" pattern="#,###" />원
		                                            </li>
		                                            <li>
		                                                <span class="title">결제금액</span>
		                                                <fmt:formatNumber value="${ requestScope.r.price * 2 }" pattern="#,###" />원
		                                            </li>
                                            		
                                            	</c:when>
                                            </c:choose>
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
                                                ${ sessionScope.loginMember.memberName }
                                            </li>
                                            <li>
                                                <span class="title">예약인원</span>
                                                ${ requestScope.r.memberCount }
                                            </li>
                                            <li>
                                                <span class="title">생년월일</span>
                                                ${ sessionScope.loginMember.birthDate }
                                            </li>
                                            <li>
                                                <span class="title">휴대폰</span>
                                                &nbsp;&nbsp;&nbsp;&nbsp;${ sessionScope.loginMember.phone }
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                            </div>

                            
                        </div>

                        <div class="right_box">
                            <div class="section bg_none reserve_amount">
                            
                            	<c:choose>
                            		<c:when test="${ requestScope.r.paymentStatus eq 'PAID' || requestScope.r.paymentStatus eq 'CANCELED' || requestScope.r.paymentStatus eq 'CREATED' }">
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
		                                            <strong></strong>
		                                        </span>
		                                    </div>
		                                </div>
                            			
                            		</c:when>
                            		
                            		<c:when test="${ requestScope.r.paymentStatus eq 'REFUNDED' }">
                            			<div class="tit_h3">
		                                    취소내역
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
                            		
                            		</c:when>
                            	
                            	</c:choose>
                            	
                                
                                    
                                    
                                    
                                    
                            </div>
							
							
							<c:choose>
							
								<c:when test="${ requestScope.r.paymentStatus eq 'PAID' || requestScope.r.paymentStatus eq 'CANCELED' || requestScope.r.paymentStatus eq 'CREATED' }">
									<div class="section bg_none reserve_amount">
		                                <div class="tit_h3">
		                                    취소내역
		                                </div>
		                                <div class="cancel_content">
		                                	<span>취소 내역이 없습니다.</span>
		                                </div>
		                                
		                            </div>
								</c:when>
								<c:when test="${ requestScope.r.paymentStatus eq 'REFUNDED' }">
									
								
								</c:when>
							
							</c:choose>

                            
                            
                            

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
                            
                            <c:choose>
                            	
                            	<c:when test="${ not empty requestScope.afterPayment }">
                            		<div class="section select_button">
		                                <a href="${ pageContext.request.contextPath }/" class="btn_cancel wid30">메인으로</a>
		                                <button type="button" class="wid_70 btnNext" onclick="goToList();">목록보기</button>
		                            </div>
                            		
                            	</c:when>
                            	
                            	<c:otherwise>
                            		<c:choose>
                            			<c:when test="${ requestScope.r.paymentStatus eq 'PAID' || requestScope.r.paymentStatus eq 'CANCELED' || requestScope.r.paymentStatus eq 'CREATED' }">
		                            		<div class="section select_button">
				                                <a href="reserveCancel.res?reserveNo=${ requestScope.r.reserveNo }" class="btn_cancel wid30">예약취소</a>
				                                <button type="button" class="wid_70 btnNext" onclick="goToList();">목록보기</button>
				                            </div>
		                            	</c:when>
		                            	<c:when test="${ requestScope.r.paymentStatus eq 'REFUNDED' }">
		                            		<div class="section select_button">
				                                
				                                <button type="button" class="wid_70 btnNext" onclick="goToList();">목록보기</button>
				                            </div>
		                            	</c:when>
                            		</c:choose>
                            	</c:otherwise>
                            </c:choose>
                        		
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
		
		
		$(function() {
			let nights = "${requestScope.r.nights}";
            let startDate = "${requestScope.r.startDate}";
            let endDate = "${requestScope.r.endDate}";
            let price = "${requestScope.r.price}";
            let campsiteId = "${requestScope.r.campsiteId}";
            let section = "${requestScope.r.section}";
            let spotNo = "${requestScope.r.spotNo}";
			
            console.log(nights);
            
			let memberName = "${sessionScope.loginMember.memberName}";
			let birthDate = "${sessionScope.loginMember.birthDate}";
			let phone = "${sessionScope.loginMember.phone}";
			
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
  			
		});
		
		
		
		
		
		
	</script>

</body>
</html>