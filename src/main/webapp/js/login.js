$(document).ready(function() {
	
	const passwordInput = document.getElementById('password');
	const useridInput = document.getElementById('userid');
	const passwordMessage = document.getElementById('password-message');
	const useridMessage = document.getElementById('userid-message'); // 아이디 입력 됐는지 표시
	const form = document.getElementById('login-form'); // 폼 요소를 가져옴
	
	const url = new URL(window.location.href);
    const urlParams = url.searchParams;
    const login_success = urlParams.get('login_success');
    
    if(login_success == "false"){
		swal.fire({
				   title: "로그인 실패",
				   text: "값을 제대로 입력했는지 확인해주세요",
				   icon: "error" //"info,success,warning,error" 중 택1
				});
	}
	
	
	
	form.addEventListener('submit', function(event) {
		const user_id = useridInput.value; // 입력된 아이디 값을 가져옴
		const password = passwordInput.value;
		
        if (user_id) {
            
            
        }else{
			event.preventDefault(); // 폼 제출을 막음
            useridMessage.textContent = '아이디를 입력해 주세요.'; // 아이디가 입력되지 않았을 때 메시지 표시
            useridMessage.style.color = 'red'; // 메시지 색상을 빨간색으로 변경
		}
        if (password) {
            
        }else{
			event.preventDefault(); // 폼 제출을 막음
            passwordMessage.textContent = '비밀번호를 입력해 주세요.'; // 아이디가 입력되지 않았을 때 메시지 표시
            passwordMessage.style.color = 'red'; // 메시지 색상을 빨간색으로 변경
		}
    });
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});