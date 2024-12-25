$(function () {


    $(".table_basic tbody").on("click", "tr", function () {
        // 클릭한 tr에서 첫 번째 td의 텍스트 값(orderNo) 추출
        const orderNo = $(this).find("td:first").text().trim();

        console.log(orderNo);

        if (orderNo) {
            // 상세 조회 요청 URL로 이동
            location.href = `${contextPath}/orderDetail.or?orderNo=${orderNo}`;
        }
    });
    



});




