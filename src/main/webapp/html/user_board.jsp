<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 문의하기</title>
<link rel="stylesheet" href="../style/css/user_board.css">
</head>

<body>
	<div class="container">
		<div class="header">
			<button class="popup-close" onclick="closePopup()">x</button>
			<h2>상품 문의하기</h2>
		</div>


		<form action="../boardWrite" method="post"
			enctype="multipart/form-data">
			<div>
				<h3>문의 유형</h3>
			</div>

			<div>
				<select id="inquiryType" name="kind" class="custom-select" required>
					<option value="" disabled selected>문의 유형 선택</option>
					<option value="배송">배송</option>
					<option value="반품">반품</option>
					<option value="교환">교환</option>
					<option value="환불">환불</option>
					<option value="기타">기타</option>
				</select>
			</div>
			<div>
				<h3>문의 제목</h3>
			</div>
			<div class="inquiry-content-title">
				<input type="text" name="title" placeholder="문의 제목을 간단히 작성해 주세요" required>
			</div>

			<div>
				<h3>문의 내용</h3>
			</div>
			<div class="inquiry-content">
				<input type="text" name="content" placeholder="문의할 내용을 입력하세요" required>
			</div>
			<div class="footer">
				<p>- 문의내용에 대한 답변은 '마이페이지 > 나의 문의내역' 에서 확인 가능합니다.</p>
				<p>- 상품과 관련 없거나 부적합한 내용을 기재하시는 경우, 사전 고지 없이 삭제 또는 차단될 수 있습니다.</p>
			</div>
			<div class="ph_in">
				<input type="file" name="photo" accept="image/*">
			</div>

			<input type="submit" value="제출하기" class="submit-btn" id="submit-btn">
			<h5 id="confirmation-message"></h5>
		</form>
	</div>


	<script>
		// document.getElementById('inquiry-type').addEventListener('click', function(e) {
		//     if (e.target.tagName === 'BUTTON') {
		//         let buttons = document.querySelectorAll('.inquiry-type button');
		//         buttons.forEach(button => button.classList.remove('active'));
		//         e.target.classList.add('active');
		//     }
		// });

		document.getElementById('submit-btn').addEventListener(
				'click',
				function() {
					let messageElement = document
							.getElementById('confirmation-message');
					
					messageElement.style.display = 'block';
				});
		function closePopup() {
			window.history.back();
		}
	</script>
</body>
</html>
