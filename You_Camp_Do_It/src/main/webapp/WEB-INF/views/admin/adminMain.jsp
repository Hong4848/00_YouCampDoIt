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
				여기에 내용물넣기
			</div>
        </div>
    </body>
</html>