<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>관리자 메뉴</title>
        <style>
            #outer{
				width: 1900px;
				height: 1200px;
				display: flex;
			}
        </style>
    </head>
    <body>
        <div id="outer">
            <jsp:include page="/WEB-INF/views/admin/pageManagerMenu.jsp"></jsp:include>
            <div class="manager_content">
				상품 주문 관리
			</div>
        </div>
    </body>
    
    <!-- 시작 시 현재 메뉴 부분 강조 -->
    <!-- 
    	#Product에는 대분류 id값
    	회원정보관리 : #User
    	컨텐츠관리 : #contentManagement
    	
    	#ProductRegister에는 소분류 id값
    	회원정보일람 : #userInfo
    	예약정보관리 : #reservationInfo
    	예약월별통계 : #monthlyStatistics
    	
    	공지사항 : noticeInfo
    	일반게시판 : boardInfo
    	후기게시판 : postscriptInfo
    	댓글관리 : replyInfo
    -->
    <script>
	    let imgSwitch = false;
	    $(document).ready(function(){
	        let count = $("#Product").next().children().length;
	        $("#Product").next().css("border-color", "rgb(26, 187, 156, 1.0)");
			$("#Product").children(".head_node_right").text("▼");
			$("#Product").next().css("height", count*35);
	
			$("#ProductRental").children().css("color","red");
	    });
    </script>
</html>