
$(function () {

    // 썸네일의 기존 인라인 스타일 제거
    $('.thumbnail img').removeAttr('style');

});


//결제창 최초 요청시 실행됩니다.
function nicepayStart(){
    goPay(document.payForm);
}

//[PC 결제창 전용]결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
function nicepaySubmit(){
    document.payForm.submit();
}

//[PC 결제창 전용]결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
function nicepayClose(){
    alert("결제가 취소 되었습니다");
}

