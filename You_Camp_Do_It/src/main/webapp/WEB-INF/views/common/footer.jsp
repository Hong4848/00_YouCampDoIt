<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <style>
        /* div{border:1px solid red;} */
        #footer {
            width:80%;
            height:200px;
            margin:auto;
            margin-top:50px;
        }
        #footer-1 {
            width:100%;
            height:20%;
            border-top:1px solid lightgray;
            border-bottom:1px solid lightgray;
        }
        #footer-2 {width:100%; height:80%;}
        #footer-1, #footer-2 {padding-left:50px;}
        #footer-1>a {
            text-decoration:none;
            font-weight:600;
            margin:10px;
            line-height:40px;
            color:black;
        }
        #footer-2>p {
            margin:0;
            padding:10px;
            font-size:13px;
        }
        #p2 {text-align:center;}
    </style>
</head>
<body>
    <div id="footer">
        <div id="footer-1">
            <a href="#">개인정보취급방침</a> | 
            <a href="#">이메일무단수집거부</a> | 
            <a href="#">오시는길</a> 
        </div>

        <div id="footer-2">
            <p id="p1">
                캠핑장 주소 : 인천광역시 강화군 화도면 해안남로 2478번길 15  <br>
                상호명 : You Camp Do It 대표 정성민 032-246-8468
            </p>
            <p id="p2">Copyright © 1998-2024 You Camp Do It All Right Reserved</p>
        </div>
    </div>
</body>