$(document).ready(function() {

	// 비밀번호 일치 결과를 저장할 변수
	let isUserpwAvailable = false;

	const passwordInput = $('#password');
	const confirmPasswordInput = $('#confirm-password');
	const passwordMessage = $('#password-message');
	const form = $('#update-form'); // 폼 요소를 가져옴 


	// 수정하기 버튼 누르고 Service 갔다와서 수정이 완료되면 alert 생성!
	const url = new URL(window.location.href);
	const urlParams = url.searchParams;
	const update_success = urlParams.get('update_success');

	if (update_success == "true") {
		swal.fire({
			title: '<div style="font-size:22px;">정보 수정 완료</div>',
			html: '<div style="font-size:18px;">회원 정보가 수정되었습니다.</div>',
			icon: "success" //"info,success,warning,error" 중 택1
			
		}).then((result) => {
			// 확인 버튼을 클릭한 경우에만 이동하도록 처리
			if (result.isConfirmed) {
				// 여기에 원하는 페이지의 URL을 넣어주세요
				window.location.href = "../html/mypage.jsp";
			}
		});
	}else if(update_success == "false"){
		swal.fire({
			title: '<div style="font-size:22px;">정보 수정 실패</div>',
			html: '<div style="font-size:18px;">회원 정보 수정에 실패했습니다. 다시 시도해주세요</div>',
			icon: "error" //"info,success,warning,error" 중 택1
			
		})
	}



	// 비밀번호 확인 체크
	confirmPasswordInput.on('input', function() {
		const password = passwordInput.val();
		const confirmPassword = confirmPasswordInput.val();
		if (confirmPassword !== "") {
			if (password === confirmPassword) {
				passwordMessage.text('비밀번호가 일치합니다');
				passwordMessage.css('color', 'green');
				isUserpwAvailable = true;
			} else {
				passwordMessage.text('비밀번호가 일치하지 않습니다');
				passwordMessage.css('color', 'red');
				isUserpwAvailable = false;
			}
		}
	});

	// 비밀번호 확인 체크
	passwordInput.on('input', function() {
		const password = passwordInput.val();
		const confirmPassword = confirmPasswordInput.val();

		if (confirmPassword !== "") {
			if (password === confirmPassword) {
				passwordMessage.text('비밀번호가 일치합니다');
				passwordMessage.css('color', 'green');
				isUserpwAvailable = true;
			} else {
				passwordMessage.text('비밀번호가 일치하지 않습니다');
				passwordMessage.css('color', 'red');
				isUserpwAvailable = false;
			}
		}
	});

	// 폼 제출 이벤트 처리
	form.on('submit', function(event) {
		if (!isUserpwAvailable) { // 비밀번호가 일치하지 않는 경우
			event.preventDefault(); // 폼 제출을 막음
			swal.fire({
				title: '<div style="font-size:22px;">알림</div>',
				html: '<div style="font-size:18px;">비밀번호를 일치 시켜주세요.</div>',
				icon: "warning" //"info,success,warning,error" 중 택1
			});
		}
	});


	// 탈퇴 버튼 클릭
	$('#delete-btn').on('click', function() {
		swal.fire({
			title: '<div style="font-size:22px;">회원탈퇴</div>',
			html: '<div style="font-size:18px;">정말 탈퇴하시겠습니까?</div>',
			icon: "warning",
			showCancelButton: true,
			confirmButtonText: "탈퇴",
			cancelButtonText: "취소"
		}).then((result) => {
			 if (result.isConfirmed) {
                // 확인을 누른 경우 DeleteuserService로 POST 요청을 보냄
                $.ajax({
                    url: '../UserDeleteService',
                    type: 'POST',
                    success: function(response) {
                        // 성공적으로 처리된 경우, 메인 페이지로 리다이렉트
                        if (response.success) {
	                        swal.fire({
								title: '<div style="font-size:22px;">회원탈퇴 성공</div>',
								html: '<div style="font-size:18px;">메인 페이지로 이동합니다</div>',
								icon: "success",
							}).then(() => {
	                       		window.location.href = "index.jsp";
				            });
			            }else {
		                    swal.fire({
								title: '<div style="font-size:22px;">회원탈퇴 실패</div>',
								html: '<div style="font-size:18px;">회원 탈퇴에 실패했습니다. 다시 시도해주세요.</div>',
								icon: "error",
		                	})
                    	}
                    },
                    error: function(xhr, status, error) {
                        // 오류 처리
                        console.error(error);
                        
                    }
                });
            }
        });
    });

});