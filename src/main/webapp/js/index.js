$(document).ready(function() {
	
	const url = new URL(window.location.href);
    const urlParams = url.searchParams;
    const join_success = urlParams.get('join_success');
    
    if(join_success == "true"){
		swal.fire({
				   title: "회원가입 완료",
				   html: "회원가입이 완료되었습니다! <br> 로그인 하시고 서비스를 이용해보세요!",
				   icon: "success" //"info,success,warning,error" 중 택1
				});
	}
	
	
	
	
	
	
	
	
	
	
});