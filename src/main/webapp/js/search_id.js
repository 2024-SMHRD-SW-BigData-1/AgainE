$(document).ready(function() {
    const url = new URL(window.location.href);
    const urlParams = url.searchParams;
    const search_success = urlParams.get('search_success');
    
    if(search_success == "false"){
      Swal.fire({
            icon: "error",
            title: "아이디 찾기 실패",
            text: "값을 제대로 입력했는지 확인해주세요"
               
            });
   }
});
