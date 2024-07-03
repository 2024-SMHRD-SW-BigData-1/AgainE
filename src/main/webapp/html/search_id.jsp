<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<% 
String targetCookieId = "found_user_id";  
String targetCookieName = "found_user_name";
%> <!-- 가져오고자 하는 쿠키의 이름 --> 
    <%Cookie[] cookies = request.getCookies();
    String found_user_id = null;
    String found_user_name = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(targetCookieId)) {
               found_user_id = cookie.getValue();
          }
            if (cookie.getName().equals(targetCookieName)) {
               found_user_name = cookie.getValue();
          }
       }
    }
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ID찾기</title>
<link rel="stylesheet" href="../style/css/search_id.css">
<style>
/* .container {
   margin-top: 100px;
}

a {
   display: block; +6+
   text-align: center;
   color: black;
   margin-bottom: 50px;
   margin-top: 50px;
}

span {
   font-size: 30px;
}

h4 {
   text-align: right;
}

.user_id {
   font-size: medium;
   margin-left: 30px;
   background-color: rgb(221, 218, 213);
   padding: 5px;
   color: blue;
   font-weight: 600;
} */
</style>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script type="text/javascript" src="../js/search_id.js"></script>
</head>

<body>

   <!-- 찾기 전  -->
   <!-- 메인페이지  -->

   <h1 class=log_size>
      <a style="text-decoration: none; color: #000000;"
         href="index.jsp">ColorSpace</a>
   </h1>
   <%
   if (found_user_id == null) {
   %>
   <div class="container">
      <h2>아이디 찾기</h2>

      <form action="../IdSearchService" method="post">

         <div class="form-group">
            <label for="name">이름</label> <input type="text" id="name"
               name="user_name" placeholder="이름을 입력하세요" required>
         </div>
         <div class="form-group">
            <label for="email">이메일</label> <input type="email" id="email"
               name="user_email" placeholder="이메일을 입력하세요" required>
         </div>
         <div class="form-group">
            <button type="submit">아이디 찾기</button>
         </div>

      </form>
   </div>
   <%
   } else {
   %>
   <div class="container">
      <!-- 메인페이지  -->
      <h3>
        <!--  <a style="text-decoration: none; color: #000000;"
            href="../style/css/Search_id.css">ColorSpace</a> -->
            <%=found_user_name%> 님의
      </h3>
      <div class="form-group">
         <span>아이디 :</span>


         <!-- 아이디 찾아서 이쪽에 -->

         <span class="user_id"> <%=found_user_id%>
         </span> 
         <span> &nbsp&nbsp 입니다.</span>
         
          <br> <a class="f" href="search_pw.jsp"> 비밀번호 찾기 </a>


         <div class="form-group">
            <a href = "login.jsp"><button type="submit">로그인 하기</button></a>
         </div>

         <div>
            <h4>로그인 화면으로 이동합니다.</h4>

         </div>


      </div>

   </div>
   <%
   }
   %>







</body>
</html>