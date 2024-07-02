<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
String targetCookiePw = "found_user_pw";  
String targetCookieId = "target_id";
%> <!-- 가져오고자 하는 쿠키의 이름 --> 
    <%Cookie[] cookies = request.getCookies();
    String found_user_pw = null;
    String target_id = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(targetCookiePw)) {
            	found_user_pw = cookie.getValue();
          }
            if (cookie.getName().equals(targetCookieId)) {
            	target_id = cookie.getValue();
          }
       }
    }
    %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="../style/css/search_id.css">
    <script type="text/javascript" src="../js/search_pw.js"></script>
    
    <style type="text/css">
    	.swal2-icon.swal2-custom-success {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #a5dc86;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            margin: 20px auto;
        }

        .swal2-custom-success svg {
            width: 50%;
            height: 50%;
            fill: #fff;
        }
    </style>
    
</head>
<body>

    <!-- 찾기 전  -->
    <!-- 메인페이지 이동  -->
    <h1 class=log_size>
        <a style="text-decoration: none; color: #000000;" href="index.jsp">ColorSpace</a>
    </h1>
  

    <% if(found_user_pw == null){ %>
    <div class="container">
        <h2>비밀번호 찾기</h2>
        
        <form action="../PwSearchService" method="post">
        
        <div class="form-group">
            <label for="user_id" class="id_over" >아이디</label>
                
            <input type="text" id="userid" name="user_id" placeholder="아이디를 입력하세요">
            
            <div>
                <label for="user_phone">전화번호</label>
                <input type="tel" id="phone" name="user_phone" placeholder="전화번호를 입력하세요">
            </div>
            
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="user_email" placeholder="이메일을 입력하세요">
            </div>

            <div class="form-group">
                <button type="submit">비밀번호 찾기</button>
            </div>
        
        </div>
        
        </form>
    </div>

    <%} else { %>
    <!-- 찾은 후  -->

    <div class="container">
        <h3 style="text-align: center;">새 비밀번호를 설정하세요 </h3>
        
        <form action="../PwUpdateService" method="post">
        <div class="form-group">
            <label for="password">새 비밀번호</label>
            <input type="password" id="new_password" name="new_password" placeholder="비밀번호를 입력하세요">
       
        <div class="form-group">
            <label for="password">비밀번호 확인 </label>
            <input type="password" id="password-check" name="password-check" placeholder="비밀번호를 다시 입력하세요">
        </div>
       
        <div class="form-group">
            <input type="submit" value="비밀번호 변경하기">
        </div>
        
        </div>
        <div>
            <h4>로그인 화면으로 이동합니다.</h4>
        </div>
        </form>
    </div>
    <%} %>
      
</body>
</html>
