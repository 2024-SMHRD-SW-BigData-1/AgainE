<%@page import="com.smhrd.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
User user = (User) session.getAttribute("login_user");

if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

if(user != null){
	
if(!user.getUser_type().equals("a")){
	response.sendRedirect("index.jsp?access=false");
	return;
}
}
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
<link rel="shortcut icon" href="data:;base64,iVBORw0KGgo=">
<link
   href='https://fonts.googleapis.com/css?family=Roboto:400,300,600,400italic,700'
   rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700'
   rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="../style/css/animate.css">
<link rel="stylesheet" href="../style/css/icomoon.css">
<link rel="stylesheet" href="../style/css/bootstrap.css">
<link rel="stylesheet" href="../style/css/owl.carousel.min.css">
<link rel="stylesheet" href="../style/css/owl.theme.default.min.css">
<link rel="stylesheet" href="../style/css/admin.css">
<script src="../js/js2/modernizr-2.6.2.min.js"></script>
<style>
@
keyframes float { 0%, 100% {  transform: translateY(0);}50%{transform:translateY(-15px);}}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
   <script type="text/javascript" src="../js/delete_cookie.js"></script>
</head>


<body>
<header>
   <div id="fh5co-main">
      <div class="fh5co-narrow-content">
         <div><!-- a 태그 안에 로그인전 , 후  다르게 페이지가 이동 되어야함 index or index_main -->
            <h2 class="fh5co-heading animate-box" data-animate-effect="fadeInLeft">
             <a style=" text-decoration: none; color: #000000;" href="admin.jsp">ColorSpace</a>
             </h2>
               </header>
               <div class="line"></div>
               <div class="main">
                  <a href="../AdminItemListService"><h3> 제품 수정/추가 </h3></a>
                  <a href="../AdminOrderService"><h3>주문 내역</h3></a>
                  <a href="admin_board.jsp"><h3>문의 내역</h3></a>
                  <a href="../logout"><h3> 로그아웃</h3></a>
               </div>
         </div>
</div>
</div>



   <!-- jQuery -->
   <script src="../js/js2/jquery.min.js"></script>
   <!-- jQuery Easing -->
   <script src="../js/js2/jquery.easing.1.3.js"></script>
   <!-- Bootstrap -->
   <script src="../js/js2/bootstrap.min.js"></script>
   <!-- Carousel -->
   <script src="../js/js2/owl.carousel.min.js"></script>
   <!-- Stellar -->
   <script src="../js/js2/jquery.stellar.min.js"></script>
   <!-- Waypoints -->
   <script src="../js/js2/jquery.waypoints.min.js"></script>
   <!-- Counters -->
   <script src="../js/js2/jquery.countTo.js"></script>
   <!-- 삭제 -->
   <script src="../js/js2/script.js"></script>
   <!-- MAIN JS -->
   <script src="../js/js2/main.js"></script>


</body>

</html>