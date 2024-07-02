<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    List<HashMap<String, Object>> adminOrders = (List<HashMap<String, Object>>) session.getAttribute("adminOrders");
    System.out.println(adminOrders); // 디버깅 용도
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
<link rel="stylesheet" href="../style/css/admin.css">
<script src="js/modernizr-2.6.2.min.js"></script>
<style>
	@
	keyframes float { 0%, 100% {transform: translateY(0);}50%{transform:translateY(-15px);}}
</style>
</head>



<body>
	<div id="fh5co-main">
		<div class="fh5co-narrow-content">
			<!-- a 태그 안에 로그인전 , 후  다르게 페이지가 이동 되어야함 index or index_main -->
			<h2 class="fh5co-heading animate-box"
				data-animate-effect="fadeInLeft">
				<a style="text-decoration: none; color: #000000;"
					href="admin.jsp">ColorSpace</a>
			</h2>

			<div class="log">
				<i class="fa fa-love"></i><a href="../AdminItemListService">제품수정/추가</a> <a>|</a> <i
					class="fa fa-love"><a href="../AdminOrderService">주문내역</a></i> <a>|</a>
				<i class="fa fa-love"></i><a href="admin_board.jsp">문의내역</a> <a>|</a> <i
					class="fa fa-love"></i><a href="../logout">로그아웃</a>
			</div>
		</div>
		<div class="line" style="margin-top: 0;"></div>

		<div class="container" style="margin-top: 30px;">
			<h1>주문 내역</h1>
			<table>
				<thead>
					<tr>
						<th>주문 식별자</th>
						<th>주문자 id</th>
						<th>주문 일시</th>
						<th>총 주문 금액</th>
						<th>주문 상태</th>
					</tr>
				</thead>
				
				 <tbody>
                    <% System.out.println(adminOrders); // 디버깅 용도
                       if (adminOrders != null) {
                           for (HashMap<String, Object> order : adminOrders) { %>
                    <tr>
                        <td><a href="../AODService?order_idx=<%=order.get("order_idx")%>"><%=order.get("order_idx")%></a></td>
                        <td><%=order.get("user_id")%></td>
                        <td><%=order.get("ordered_at")%></td>
                        <td><%=order.get("total_order")%></td>
                        <td><%=order.get("order_state")%></td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="5">주문 내역이 없습니다.</td>
                    </tr>
                    <% } %>
                </tbody>
			</table>

		</div>
	</div>

</body>









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

</html>




