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
			
			#section-reserve {
				width: 300px;
				height: 300px;
			}
        </style>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    </head>
    <body>
        <div id="outer">
            <jsp:include page="/WEB-INF/views/admin/pageManagerMenu.jsp"></jsp:include>
            
            
            <div class="manager_content">
            	<div id="section-reserve">
            		<canvas id="myChart" width="200" height="200"></canvas>
            	</div>
			</div>
        </div>
        
        
        <script>
			const ctx = document.getElementById('myChart').getContext('2d');
			const myChart = new Chart(ctx, {
			    type: 'bar',
			    data: {
			        labels: ['포레스트', '밸리', '스카이', '스톤'],
			        datasets: [{
			            label: '# of Votes',
			            data: [12, 19, 3, 5, 2, 3],
			            backgroundColor: [
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			                'rgba(75, 192, 192, 0.2)',
			                'rgba(153, 102, 255, 0.2)',
			                'rgba(255, 159, 64, 0.2)'
			            ],
			            borderColor: [
			                'rgba(255, 99, 132, 1)',
			                'rgba(54, 162, 235, 1)',
			                'rgba(255, 206, 86, 1)',
			                'rgba(75, 192, 192, 1)',
			                'rgba(153, 102, 255, 1)',
			                'rgba(255, 159, 64, 1)'
			            ],
			            borderWidth: 1
			        }]
			    },
			    options: {
			        scales: {
			            y: {
			                beginAtZero: true
			            }
			        }
			    }
			});
		</script>
    </body>
</html>