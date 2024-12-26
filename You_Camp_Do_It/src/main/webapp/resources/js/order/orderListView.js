$(function () {

    // 상세보기 이동 이벤트
    $(".table_basic tbody").on("click", "tr", function () {
        // 클릭한 tr에서 첫 번째 td의 텍스트 값(orderNo) 추출
        const orderNo = $(this).find("td:first").text().trim();

        console.log(orderNo);

        if (orderNo) {
            // 상세 조회 요청 URL로 이동
            location.href = `${contextPath}/orderDetail.or?orderNo=${orderNo}`;
        }
    });

    // 현재 표시된 리스트 수
    let visibleCount = 5; // 초기 표시 개수

    // 더보기 버튼 클릭 이벤트
    $("#btn-more").on("click", function () {
        const rows = $(".order-row"); // 모든 행 선택
        let count = 0;

        // 숨겨진 행 중 5개를 표시
        rows.each(function (index) {
            if ($(this).css("display") === "none" && count < 5) {
                $(this).css("display", "table-row");
                count++;
            }
        });

        visibleCount += count; // 표시된 행 수 업데이트

        // 모든 행이 표시되면 더보기 버튼 숨김
        if (visibleCount >= rows.length) {
            $("#btn-more").hide();
        }
    });
    



});




