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
   <link rel="shortcut icon" href="favicon.ico">
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
   <link rel="stylesheet" href="../style/css/style.css">
   <link rel="stylesheet" href="../style/css/admin_board.css">
   <script src="js/modernizr-2.6.2.min.js"></script>
   <style>
   @keyframes 
   float { 0%, 100% {   transform: translateY(0);}50%{transform:translateY(-15px);
   }
   }
   </style>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script type="text/javascript" src="../js/admin_board.js"></script>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>

<body>
   <div id="fh5co-main">
      <div class="fh5co-narrow-content">
         <!-- a 태그 안에 로그인전 , 후  다르게 페이지가 이동 되어야함 index or index_main -->
         <h2 class="fh5co-heading animate-box" data-animate-effect="fadeInLeft">
            <a style="text-decoration: none; color: #000000;" href="admin.jsp">ColorSpace</a>
         </h2>
         <div class="log">
            <i class="fa fa-love"></i><a href="../AdminItemListService">제품수정/추가</a> <a>|</a> <i
               class="fa fa-love"><a href="../AdminOrderService">주문내역</a></i> <a>|</a> <i
               class="fa fa-love"></i><a href="admin_board.jsp">문의내역</a> <a>|</a> <i
               class="fa fa-love"></i><a href="../logout">로그아웃</a>
         </div>
      <div class="line" style="margin-top: 0;"></div>
      
         <div class="con_list" style="margin-top: 30px;">
         
            <h1>문의 내역</h1>
         
            <div class="inquiry-type" id="inquiry-type">
               <button class="active" name="상품">상품</button>
               <button class="delivery" name="배송">배송</button>
               <button class="return" name="반품">반품</button>
               <button class="exchange" name="교환">교환</button>
               <button class="return" name="환불">환불</button>
               <button class="etc" name="기타">기타</button>
            </div>

            

            <div class="table">
               <div class="table-row">
                  <div class="table-cell">
                     <!-- <a href="">문의제목을 써라아아ㅏㅏ아아아ㅏ아아ㅏ아아아아</a> -->
                  </div>
                  <div class="table-cell">
                     <!-- <a href="">문의제목을 써라아아ㅏㅏ아아아ㅏ아아ㅏ아아아아</a> -->
                  </div>
               </div>
               
               
               
               
               
               
            </div>
           </div>
           </div>
      </div>
</body>



</html>