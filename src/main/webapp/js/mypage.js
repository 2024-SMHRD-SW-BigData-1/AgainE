 $(document).ready(function() {
	
	var loginUserJson = $('#uploadForm').data('login-user-json');
    //console.log(loginUserJson); // JSON 문자열 출력

	$('#upload-area').click(function() {
                $('#file-input').click();
                $('#warning-message').css('display', 'block');
      });
      
	$('#file-input').on('change', function(event) {
                const previewArea = $('#preview-area');
                previewArea.empty(); // 기존의 미리보기를 초기화합니다.

                const files = event.target.files;
                if (files.length > 0) {
                	const file = files[0];
                    const reader = new FileReader();

                    reader.onload = function(e) {
                        const img = $('<img>').attr('src', e.target.result).addClass('preview-image');
                        previewArea.append(img);
                    };

                    reader.readAsDataURL(file);
                    document.getElementById('warning-message').style.display = 'none';
                    document.getElementById('upload-area').textContent = '다시 올리기';
                }
            });
            
	// 플라스크 ajax
    $('#uploadForm').submit(function(event) {
		
        event.preventDefault(); // 폼 제출 기본 동작 방지
        var formData = new FormData($(this)[0]);
        formData.append("loginUserJson", JSON.stringify(loginUserJson));
        var fileInput = $('#file-input')[0];
        
        if (fileInput.files.length === 0) {
            alert("사진을 선택해주세요.");
            return; // 파일이 선택되지 않은 경우에는 여기서 종료
        }
        
			$('#loading-spinner').show(); // 로딩 스피너 표시
        $.ajax({
            url: 'http://192.168.219.200:5058/flaskServer',
            type: 'POST',
            data: formData,
            processData: false,  // 데이터 처리를 jQuery가 하지 않도록 설정
            contentType: false,  // 데이터 유형을 설정하지 않도록 설정
            xhrFields: {
                    withCredentials: true  // 크로스 도메인 쿠키 전송 설정
                },
            success: function(response) {
				let user = response.user;
                //console.log('업로드 성공:', response);
                //console.log('파일명:', user.user_room_url);
               
                updateLoginSession(user);
                displayFurniture(user);
                
                $('#loading-spinner').hide(); // 작업이 끝난 후 로딩 스피너 숨기기
				 
            },
            error: function(jqXHR, textStatus, errorThrown) {
                if (jqXHR.status === 400) {
		            var errorResponse = jqXHR.responseJSON;
		            if (errorResponse && errorResponse.error) {
		                console.log('Error:', errorResponse.error);
		                // 에러 메시지를 사용자에게 보여주기
		                alert('Error: ' + errorResponse.error);
		                $('#loading-spinner').hide(); // 작업이 끝난 후 로딩 스피너 숨기기
		            }
		        } else {
		            console.log('Unexpected error:', textStatus, errorThrown);
		            $('#loading-spinner').hide(); // 작업이 끝난 후 로딩 스피너 숨기기
		        }
            }
        });
        
    });
	
	
	
	
	
	// 가구 이미지를 화면에 표시하는 함수
	function displayFurniture(user) {
		var containers = $('.result-details'); // 모든 요소를 선택
			//console.log(user)
			
			var container1 = containers.eq(0); // 컨테이너 설정
			$('#user-type-f').css('display', 'block');
			var container2 = containers.eq(1); // 컨테이너 설정
			var user_img = user.user_room_url; // 사용자 방 이미지 파일 이름
			//console.log(user_img)
			var user_color = user.user_room_color; // 컬러
			var user_tone = user.user_room_tone; // 톤

			container1.empty();
			container2.empty();
	

			// 태그 생성
			var resultElement = $('<div>').addClass('result-box'); // 결과창 div 추가
			var cornerElement = $('<div>').addClass("corner"); // 코너 추가
			var imageElement = $('<img>').attr({
				'src': `../user_room_img/${user_img}`,
				'class': 'img-responsive',
				'alt': "파일을 찾을 수 없습니다"
			});
			var colorElement = $('<p>').text("색 : "+ user_color); // 색상
			var toneElement = $('<p>').text("톤 : " + user_tone); // 톤

			// 요소들을 순서대로 추가
			resultElement.append(cornerElement);
			resultElement.append(imageElement);
			resultElement.append(colorElement);
			resultElement.append(toneElement);
			container1.append(resultElement);
			container2.append(resultElement);
	}



	function updateLoginSession(user) {
                $.ajax({
                    url: '../updateLoginSession', // 세션 업데이트를 위한 두 번째 AJAX 요청 엔드포인트
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(user),
                    success: function(response) {
                        //console.log('세션 업데이트 성공:', response);
                    },
                    error: function(xhr, status, error) {
                        console.log('세션 업데이트 실패:', error);
                    }
                });
            }






});
