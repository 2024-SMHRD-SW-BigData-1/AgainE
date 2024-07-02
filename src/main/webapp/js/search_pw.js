$(document).ready(function() {
    const url = new URL(window.location.href);
    const urlParams = url.searchParams;
    const search_success = urlParams.get('search_success');
    const update_success = urlParams.get('update_success');
    
    if(search_success == "false"){
      Swal.fire({
            icon: "error",
            title: "비번 찾기 실패",
            text: "값을 제대로 입력했는지 확인해주세요"
               
            });
   }
   if(update_success == "true"){
      Swal.fire({
             title: '비번 수정 성공',
            html: `
            	로그인 페이지로 이동합니다
                <div class="swal2-icon swal2-custom-success">
                    <svg viewBox="0 0 52 52">
                        <path d="M26 0C11.664 0 0 11.664 0 26s11.664 26 26 26 26-11.664 26-26S40.336 0 26 0zm0 50C12.458 50 2 39.542 2 26S12.458 2 26 2s24 10.458 24 24-10.458 24-24 24zm-4-17.17l-7.071-7.071a2 2 0 1 1 2.828-2.828L24 28.829l10.243-10.243a2 2 0 1 1 2.828 2.828L24 35.659z"/>
                    </svg>
                </div>
            `,
            showConfirmButton: true
            }).then(() => {
                window.location.href = '../html/login.jsp';
            });
   }
   if(update_success == "false"){
      Swal.fire({
            icon: "error",
            title: "비번 수정 실패",
            text: "다시 시도해주세요"
               
            });
   }
});