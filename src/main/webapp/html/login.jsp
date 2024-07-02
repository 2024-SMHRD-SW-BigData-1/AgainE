<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="../style/css/login.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../js/login.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	<script type="text/javascript" src="../js/delete_cookie.js"></script>
</head>
<body>
  <h1 class = log_size><a style=" text-decoration: none; color: #000000;" href="index.jsp">ColorSpace</a></h1>
  <div class="container">
      <h2>로그인</h2>
      <form action="../login" method="post" id="login-form">
      <div class="form-group">
          <label for="userid" class="id_over" >아이디</label>
          <input type="text" id="userid" name="user_id" placeholder="아이디를 입력하세요">
          <span id="userid-message" class="message"></span>
          
          <br><br>
          <label for="password">비밀번호</label>
          <input type="password" id="password" name="user_pw" placeholder="비밀번호를 입력하세요">
      	  <span id="password-message" class="message"></span>
      </div>
     
      <div class="form-group">
          <button type="submit">로그인 하기</button>
      </div>
      </form>
      <h5 class="find"><a href="search_id.jsp">아이디찾기</a> <a href="search_pw.jsp">비밀번호 찾기</a></h5>
      <div class="login-link">
          <h5>아직 아이디가 없으신가요?<a href="join.jsp">회원가입</a></h5>
      </div>
      
      
      </div>
      
</body>
</html>