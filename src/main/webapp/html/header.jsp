<%@page import="com.smhrd.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
User user = (User) session.getAttribute("login_user");
%>
<!DOCTYPE html>

<html class="no-js">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>ColorSpace</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
   content="Free HTML5 Website Template by FreeHTML5.co" />
<meta name="keywords"
   content="free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
<meta name="author" content="FreeHTML5.co" />





<style>
@
keyframes float { 0%, 100% {
   transform: translateY(0);
}

50


%
{
transform


:


translateY
(


-15px


)
;


}
}
   /* background-color: #E4F0D5; */
/*    font-size: 45px; */
   /* margin-bottom: 1em; */
   /* width: 1300px; */
       display: flex;
    align-items: center; /* 세로 정렬 설정 */
}
.log{
   margin-top: 50px;
}
.fh5co-heading h2 {
    margin: 0; /* 기본 마진 제거 */
}

.fh5co-heading .log {
    margin-left: auto; /* 로그인/회원가입 영역을 오른쪽으로 이동 */
}

.fh5co-heading .log a {
    color: #000000; /* 링크 색상 */
    text-decoration: none; /* 밑줄 제거 */
    margin: 0 10px; /* 각 링크 사이 여백 설정 */
}
.line {
   margin-top: 30px;
   border: 1px solid #ccc;
}
</style>

</head>
<body>

<header>
    <div class="fh5co-heading animate-box" data-animate-effect="fadeInLeft">
        <h2 style="display: inline-block; margin-right: 20px;">
            <a href="index.jsp" style="text-decoration: none; color: #000000;">ColorSpace</a>
        </h2>
        <% if (user != null) { %>
            <!-- 로그인 했을 시 -->
            <% if (user.getUser_type().equals("f") || user.getUser_type().equals("t")) { %>
                <!-- 사용자일때 -->
                <div class="log">
                    <i class="fa fa-love"></i><a href="../logout">로그아웃</a> <a>|</a> <i class="fa fa-love"></i><a href="mypage.jsp">mypage</a> <a>|</a> <i class="fa fa-love"></i><a href="user_board.jsp">문의하기</a>
                </div>
                <div class="line"></div>
            <% } %>
        <% } else { %>
            <!-- 로그인 안했을 시 -->
            <div class="log">
                <i class="fa fa-love"></i><a href="login.jsp">로그인</a> <a>|</a> <i class="fa fa-love"></i><a href="join.jsp">회원가입</a>
            </div>
            <div class="line"></div>
        <% } %>
    </div>
</header>
    </body>
