<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기게시판 작성</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>



<style>
        .content {
        display: flex;
        flex-direction: column; /* 수직 배치를 위한 플렉스 방향 설정 */
        align-items: center; /* 자식 요소들을 가운데 정렬 */
        }
        
        /* 메뉴바 스타일 */
		.main-side {
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 700;
            height: 100px;
            background-color: white;
            width: 100%;
            margin: 0 auto;
        }

        .sidebar {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .sidebar a {
            text-decoration: none;
            font-size: 18px;
            color: #333;
            padding: 10px 20px;
            margin-right: 20px;
            border-bottom: 3px solid transparent;
        }

        .sidebar a.active {
            color: #f7b500;
            border-bottom: 3px solid #f7b500;
        }

        .sidebar a:hover {
            color: #f7b500;
        }

    

        /*루트메뉴바*/
        .main-content {
            flex: 1;
            margin-top: 20px; /* 상단 메뉴와의 간격 조정 */
            width: 60%; /* main-side와 동일한 너비 */
            margin-left: auto; /* 왼쪽 여백 자동 */
    		margin-right: auto; /* 오른쪽 여백 자동 */
        }
        .breadcrumb {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .breadcrumb ul {
            list-style-type: none;
            padding: 0;
            display: flex;
        }
        .breadcrumb li:not(:last-child)::after {
            content: ">";
            margin: 0 5px;
        }
        
        /*후기게시판*/   

        .container {
            width: 100%;
            max-width: 600px;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 1px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 2rem;
            font-size: 1.8rem;
        }

        
        #reviewForm {
		    display: flex;
		    flex-direction: column; /* 세로로 정렬 */  
		    padding: 0 15px; /* 좌우 여백 */
		}
		
		.form-group {
		    width: 100%; /* 기본적으로 100% 너비 */
		    max-width: 600px; /* 최대 너비를 설정 */
		    margin-bottom: 15px; /* 각 항목 사이의 간격 */
		    display: flex;
		    flex-direction: column;		  
		}
        
        #contentcontroller {
        	padding: 0 250px; /* 좌우 여백 */
        }
        
        #btncontroller{
        	display: flex;
            justify-content: right;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;           
            color: #333;
            font-weight: 500;
        }

        input[type="text"], 
        textarea {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            
        }

        textarea {
            height: 200px;
            resize: vertical;
        }

		.image-upload-section {
            margin-bottom: 2rem;
        }

        .image-grid {
            display: flex;
            gap: 1rem;
            margin-top: 0.5rem;
        }

        .image-upload {
            flex: 1;
            height: 100px; /* 내용 입력칸의 반 정도 크기로 조정 */
        }

        .image-preview {
            width: 100px;
            height: 100px;
            border: 1px dashed #ddd;
            border-radius: 5px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            background-size: cover;
            background-position: center;
            transition: all 0.3s ease;
        }

        .image-preview:hover {
            border-color: #f7b500;
        }

        .upload-icon {
            font-size: 24px;
    		color: #aaa;
        }

        .submit-btn {
            width: 10%;
            padding: 1rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #0056b3;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .detail-images-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .detail-images-grid {
                grid-template-columns: 1fr;
            }
        }
        
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<div class="content">
	    <div class="main-side">
	        <div class="sidebar">
	            <a href="list.no">공지사항</a>
	            <a href="list.re" class="active">후기게시판</a>
	            <a href="list.lo">분실물게시판</a>
	        </div>
	    </div>
		
		<br>
	     <div class="container">
	        <h1>후기게시판 작성하기</h1>
	        <form id="uploadForm" action="list.re" method="POST" enctype="multipart/form-data">
			        <div id="contentcontroller">
			            <div class="form-group">
			                <label for="reviewTitle">제목</label>
			                <input type="text" id="reviewTitle" name="reviewTitle" required>
			            </div>
			
			            <div class="form-group">
			                <label for="reviewContent">내용</label>
			                <textarea id="reviewContent" name="reviewContent" style="resize : none;" required></textarea>
			            </div>
					</div>
			        <div class="image-upload-section">
		                <div class="image-grid">
		                    <div class="image-upload">
		                        <label>대표이미지</label>
		                        <input type="file" name="upfile" id="mainImage" accept="image/*" style="display: none;">
		                        <div class="image-preview" onclick="document.getElementById('mainImage').click()">
		                            <span class="upload-icon">+</span>
		                        </div>
		                    </div>
		                    <div class="image-upload">
		                        <label>상세이미지 1</label>
		                        <input type="file" name="upfile" id="detailImage1" accept="image/*" style="display: none;">
		                        <div class="image-preview" onclick="document.getElementById('detailImage1').click()">
		                            <span class="upload-icon">+</span>
		                        </div>
		                    </div>
		                    <div class="image-upload">
		                        <label>상세이미지 2</label>
		                        <input type="file" name="upfile" id="detailImage2" accept="image/*" style="display: none;">
		                        <div class="image-preview" onclick="document.getElementById('detailImage2').click()">
		                            <span class="upload-icon">+</span>
		                        </div>
		                    </div>
		                </div>
		            </div>
					
					<br>
					<div id="btncontroller">
		            	<button type="submit" class="submit-btn">등록하기</button>
		            </div>
	        </form>
	    </div>
	  
	</div>
	
<script>
document.addEventListener("DOMContentLoaded", function () {
    const fileInputs = document.querySelectorAll('input[type="file"]');

    fileInputs.forEach((input) => {
        input.addEventListener("change", function (event) {
            const file = event.target.files[0];
            const preview = event.target.nextElementSibling;

            if (file && preview && file.type.startsWith("image/")) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    console.log("파일 읽기 성공:", e.target.result); // 디버깅용
                    preview.style.backgroundImage = `url(${e.target.result})`;
                    const icon = preview.querySelector(".upload-icon");
                    if (icon) icon.style.display = "none";
                };
                reader.readAsDataURL(file);
            } else {
                alert("이미지 파일만 업로드할 수 있습니다.");
            }
        });
    });
 // 폼 데이터 제출 처리
    document.getElementById("uploadForm").addEventListener("submit", function (event) {
        event.preventDefault(); // 기본 폼 제출 방지

        const formData = new FormData(this);

        fetch("insert.re", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => { throw new Error(text) });
            }
            window.location.href = "list.re";
        })
        .catch(error => {
            //console.error("전송 중 오류 발생:", error);
            alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
        });

    });
});
</script>


	 
	<jsp:include page="../common/footer.jsp" />
</body>
</html>

