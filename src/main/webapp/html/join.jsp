<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,300,600,400italic,700' rel='stylesheet' type='text/css'>
   <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    
    <link rel="stylesheet" href="../style/css/join.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../js/join.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	<script type="text/javascript" src="../js/delete_cookie.js"></script>
	
	<style>
        .form-group.addr input {
            display: inline-block;
            width: auto; /* 필요에 따라 너비 조절 */
            margin-right: 10px; /* 입력 칸 사이에 간격 추가 */
            margin-top: 5px;
        }
        #postcode{
        	width: 20%
        }
        #address{
        	width: 90%;
        }
        #detailAddress{
        	width: 45%;
        }
        #extraAddress{
        	width: 45%;
        }
    </style>
	
</head>
<body>
    <h1 class = log_size><a style=" text-decoration: none; color: #000000;" href="index.jsp">ColorSpace</a></h1>
    <div class="container">
        <h2>회원가입</h2>
        <form action="../join" method="post" id="join-form">
        <div class="group">
            
            <div class="form-group">
                <label for="userid" >아이디</label>
                <input type="text"  id="userid" name="user_id" placeholder="아이디를 입력하세요"  required>
                    <button type="button" id="check-userid">중복확인</button>
            </div>
            </div>
            <span id="userid-message" class="message"></span>
        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="user_pw" placeholder="비밀번호를 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="password">비밀번호 확인</label>
            <input type="password" id="confirm-password" name="confirm-password" placeholder="비밀번호를 입력하세요" required>
            <!-- 비밀번호에 입력한 내용과 일치 여부에 따라 나와야되는 글씨 -->
            <span id="password-message" class="message"></span>
        </div>
        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="user_email" placeholder="이메일을 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="name">성명</label>
            <input type="text" id="name" name="user_name" placeholder="성명을 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="tel" id="phone" name="user_phone" placeholder="전화번호를 입력하세요" required>
        </div>
        <div class="form-group addr">
            <label for="address">배송지 주소</label>
            <!-- <input type="text" id="address" name="user_addr" placeholder="주소를 입력하세요" required> -->
            <input type="text" id="postcode" name="postcode" placeholder="우편번호" required>
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="address" name="address" placeholder="주소" required><br>
			<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" required>
			<input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목">
        </div>
        <div class="form-group">
            <button type="submit">회원 가입하기</button>
        </div>
        <div class="login-link">
            <h5>이미 아이디가 있으신가요? <a href="login.jsp">로그인</a></h5>
        </div>
        </form>
        </div>
   
    
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
</body>
</html>