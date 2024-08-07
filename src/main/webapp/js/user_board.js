$(document).ready(function() {
	
	const url = new URL(window.location.href);
	const urlParams = url.searchParams;
	const board_success = urlParams.get('board_success');
	
	if (board_success == "true") {
		swal.fire({
			title: "문의글 작성 완료",
			html: "문의 페이지를 나갑니다.",
			icon: "success" //"info,success,warning,error" 중 택1
		}).then(() => {
                window.history.back();
            });
	}else if(board_success == "false"){
		swal.fire({
			title: "문의글 작성 실패",
			html: "다시 시도해주세요",
			icon: "error" //"info,success,warning,error" 중 택1
		});
	}
	
	
	
	
	
	
	
	
	
	
	
});