<%@page import="com.smhrd.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% User user = (User)session.getAttribute("login_user"); %>
<!DOCTYPE html>

<html class="no-js">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>ColorSpace</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Free HTML5 Website Template by FreeHTML5.co" />
    <meta name="keywords" content="free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
    <meta name="author" content="FreeHTML5.co" />
    <link rel="shortcut icon" href="favicon.ico">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,300,600,400italic,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="../style/css/animate.css">
    <link rel="stylesheet" href="../style/css/icomoon.css">
    <link rel="stylesheet" href="../style/css/bootstrap.css">
    <link rel="stylesheet" href="../style/css/owl.carousel.min.css">
    <link rel="stylesheet" href="../style/css/owl.theme.default.min.css">
   <link rel="stylesheet" href="../style/css/mypage.css">
    <link rel="stylesheet" href="../style/css/user_orderlist.css"> 
    <script src="js/modernizr-2.6.2.min.js"></script>
    <style>
        @keyframes float {
            0%,
            100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-15px);
            }
        }
    </style>
</head>



<body>
<header>
    <div class="container">
        <div class="fh5co-heading animate-box" data-animate-effect="fadeInLeft">
            <h2 style="display: inline-block; margin-right: 20px;">
                <a href="index.jsp" style="text-decoration: none; color: #000000;">ColorSpace</a>
            </h2>
            <% if (user != null) { %>
                <!-- 로그인 했을 시 -->
                <% if (user.getUser_type().equals("f") || user.getUser_type().equals("t")) { %>
                    <!-- 사용자일때 -->
                    <div class="log">
                        <i class="fa fa-love"></i><a href="../logout">로그아웃</a> <a>|</a> <i class="fa fa-love"><a href="#">mypage</a></i> <a>|</a> <i class="fa fa-love"></i><a href="#">문의하기</a>
                    </div>
                    <div class="line"></div>
                <% } %>
            <% } else { %>
                <!-- 로그인 안했을 시 -->
                <div class="log">
                    <i class="fa fa-love"></i><a href="login.jsp">로그인</a> <a>|</a> <i class="fa fa-love"></i><a href="join.jsp">회원가입</a>
                </div>
            <% } %>
        </div>
        <div class="line"></div>
    </div>
</header>

   <div class="container">

      <main>

         <section class="user-info">
            <br>
            <h2><%=user.getUser_id()%>
               님의 MyPage
            </h2>
            <a href="user_update.jsp"><button>회원정보 수정</button></a>
         </section>
         <br>
         <section class="order-status">
            <h2>주문처리현황</h2>
            <div class="status-details">
               <div class="status-item">
                  <a href="user_orderlist.jsp"> <span class="status-label">배송준비중</span></a>
                  <a href="user_orderlist.jsp"> <span class="status-value">4</span></a>
               </div>
               <div class="status-item">
                  <a href="user_orderlist.jsp"><span class="status-label">배송중</span></a>
                  <a href="user_orderlist.jsp"><span class="status-value">0</span></a>
               </div>
               <div class="status-item">
                  <a href="user_orderlist.jsp"><span class="status-label">배송완료</span></a>
                  <a href="user_orderlist.jsp"><span class="status-value">0</span></a>
               </div>
            </div>

           <!--  <form action="../RoomimageService" method="post" enctype="multipart/form-data">
               <div class="my-room">
                  <h3>my room</h3> -->
           <section class="order-list">
            <!-- <h2>주문 내역</h2> -->
            <article class="order-item">
                <h4 class="order-date">24.06.10 ( 주문날짜 )</h4>
                <div class="product">
                    <img src="/nitro/images/img_1.jpg" alt="로이 항균 먼지없는 4면 고정밴딩 침대패드 SS/Q 19컬러">
                    <div class="product-details">
                        <h4>로이 항균 먼지없는 4면 고정밴딩 침대패드 SS/Q 19컬러</h4>
                        <h5>38500원</h5>
                        <span>1개</span>
                    </div>
                </div>
                <div class="product">
                    <img src="/nitro/images/ex1.jpg" alt="로이 항균 먼지없는 4면 고정밴딩 침대패드 SS/Q 19컬러">
                    <div class="product-details">
                        <h4>로이 항균 먼지없는 4면 고정밴딩 침대패드 SS/Q 19컬러</h4>
                        <h5>17900원</h5>
                        <span>3개</span>
                    </div>
                </div>
            </article>
        </section>
        <a href="mypage.jsp"><button class="mypage-button">마이페이지로</button></a>
    </main> 

  




            <!-- jQuery -->
            <script src="js/jquery.min.js"></script>
            <!-- jQuery Easing -->
            <script src="js/jquery.easing.1.3.js"></script>
            <!-- Bootstrap -->
            <script src="js/bootstrap.min.js"></script>
            <!-- Carousel -->
            <script src="js/owl.carousel.min.js"></script>
            <!-- Stellar -->
            <script src="js/jquery.stellar.min.js"></script>
            <!-- Waypoints -->
            <script src="js/jquery.waypoints.min.js"></script>
            <!-- Counters -->
            <script src="js/jquery.countTo.js"></script>
            <!-- 삭제 -->
            <script src="js/script.js"></script>
            <!-- MAIN JS -->
            <script src="js/main.js"></script>




</body>

</html>




