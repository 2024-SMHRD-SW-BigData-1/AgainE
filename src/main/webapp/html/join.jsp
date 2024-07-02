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
        <div class="form-group">
            <label for="address">배송지 주소</label>
            <input type="text" id="address" name="user_addr" placeholder="주소를 입력하세요" required>
        </div>
        <div class="form-group">
            <button type="submit">회원 가입하기</button>
        </div>
        <div class="login-link">
            <h5>이미 아이디가 있으신가요? <a href="login.jsp">로그인</a></h5>
        </div>
        </form>
        </div>
   
    
</body>
</html>