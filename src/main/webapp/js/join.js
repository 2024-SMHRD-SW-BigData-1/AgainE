$(document).ready(function() {
    // 아이디 중복 체크 결과를 저장할 변수
    let isUseridAvailable = false;

	// 비밀번호 일치 결과를 저장할 변수
    let isUserpwAvailable = false;

	const passwordInput = document.getElementById('password');
	const confirmPasswordInput = document.getElementById('confirm-password');
	const passwordMessage = document.getElementById('password-message');

    const checkUseridButton = document.getElementById('check-userid'); // 아이디 중복 확인 버튼을 가져옴
    const useridInput = document.getElementById('userid'); // 아이디 입력 필드를 가져옴
    const useridMessage = document.getElementById('userid-message'); // 아이디 중복 확인 결과 메시지 요소를 가져옴
    const form = document.getElementById('join-form'); // 폼 요소를 가져옴 
    
    const url = new URL(window.location.href);
    const urlParams = url.searchParams;
    const join_success = urlParams.get('join_success');
    
    if(join_success == "false"){
		swal.fire({
				   title: "회원가입 실패",
				   text: "다시 시도해주세요.",
				   icon: "error" //"info,success,warning,error" 중 택1
				});
	}

	// id 중복확인 체크
    checkUseridButton.addEventListener('click', function() { // 버튼 클릭 이벤트 리스너 추가
        const user_id = useridInput.value; // 입력된 아이디 값을 가져옴

        if (user_id) { // 아이디가 입력되었는지 확인
            useridMessage.textContent = '아이디를 확인 중입니다...'; // 확인 중임을 표시
            useridMessage.style.color = 'blue'; // 메시지 색상을 파란색으로 변경

            // AJAX 요청 생성
            $.ajax({
                url: '../checkUserid', // 서블릿 매핑 경로
                async: false,
                method: 'POST', // HTTP 메서드 (POST 방식)
                data: {
                    "user_id": user_id // 전송할 데이터 (아이디)
                },
                dataType: 'json',
                success: function(res) {
                    //console.log("AJAX 요청 성공");
                    if (res.isAvailable) {
                        isUseridAvailable = true; // 아이디가 사용 가능함을 표시
                        useridMessage.textContent = '사용 가능한 아이디입니다.';
                        useridMessage.style.color = 'green';
                        
                    } else {
                        isUseridAvailable = false; // 아이디가 중복됨을 표시
                        useridMessage.textContent = '이미 사용 중인 아이디입니다.';
                        useridMessage.style.color = 'red';
                    }
                },
                error: function() {
                    console.error("AJAX 요청 실패");
                    isUseridAvailable = false; // 오류 시 중복된 것으로 간주
                    useridMessage.textContent = '아이디 확인에 실패했습니다. 다시 시도해 주세요.';
                    useridMessage.style.color = 'red';
                }
            });

        } else {
            useridMessage.textContent = '아이디를 입력해 주세요.'; // 아이디가 입력되지 않았을 때 메시지 표시
            useridMessage.style.color = 'red'; // 메시지 색상을 빨간색으로 변경
            isUseridAvailable = false; // 아이디가 입력되지 않았을 때 중복된 것으로 간주
            isUseridChecked = false; // 아이디 입력 안했으니까 다시 체크
        }
    });

	// 비밀번호 확인 체크
	confirmPasswordInput.addEventListener('input', function() {
		const password = passwordInput.value;
		const confirmPassword = confirmPasswordInput.value;
		if (confirmPassword !== "") {
			if (password === confirmPassword) {
				passwordMessage.textContent = '비밀번호가 일치합니다';
				passwordMessage.style.color = 'green';
				isUserpwAvailable = true;
			} else {
				passwordMessage.textContent = '비밀번호가 일치하지 않습니다';
				passwordMessage.style.color = 'red';
				isUserpwAvailable = false;
			}
		}
	});

	// 비밀번호 확인 체크
	passwordInput.addEventListener('input', function() {
		const password = passwordInput.value;
		const confirmPassword = confirmPasswordInput.value;

		if (confirmPassword !== "") {
			if (password === confirmPassword) {
				passwordMessage.textContent = '비밀번호가 일치합니다';
				passwordMessage.style.color = 'green';
				isUserpwAvailable = true;
			} else {
				passwordMessage.textContent = '비밀번호가 일치하지 않습니다';
				passwordMessage.style.color = 'red';
				isUserpwAvailable = false;
			}
		}

	});




    // 폼 제출 이벤트 처리
    form.addEventListener('submit', function(event) {
        if (!isUserpwAvailable) { // 비밀번호가 일치하지 않는 경우
            event.preventDefault(); // 폼 제출을 막음
            swal.fire({
				   title: "알림",
				   text: "비밀번호를 일치 시켜주세요.",
				   icon: "warning" //"info,success,warning,error" 중 택1
				})
        }
        if (!isUseridAvailable) { // 아이디 중복 체크를 하지 않았을 경우
            event.preventDefault(); // 폼 제출을 막음
            swal.fire({
				   title: "알림",
				   text: "아이디 중복 체크 또는 다른 아이디로 변경해주세요.",
				   icon: "warning" //"info,success,warning,error" 중 택1
				});
        } 
    });
    
    
    
    
});