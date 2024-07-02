<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
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
List<HashMap<String, Object>> orderDetails = (List<HashMap<String, Object>>) session.getAttribute("orderDetails");
// 세션에서 데이터가 올바르게 로드되었는지 디버깅
if (orderDetails == null) {
	System.out.println("제품상세내역 없다고!");
} else {
	System.out.println("제상사이즈: " + orderDetails.size());
}

HashMap<String, Object> orderInfo = orderDetails != null && !orderDetails.isEmpty() ? orderDetails.get(0) : null;

String updateResult = (String) session.getAttribute("updateResult");
session.removeAttribute("updateResult"); // 한 번만 표시하고 제거

// 디버깅 출력
System.out.println("updateResult: " + updateResult);
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
keyframes float { 0%, 100% {
	transform: translateY(0);
}
50
%
{
transform
:
translateY(
-15px
);
}
}
</style>

<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<body>
	<div id="fh5co-main">
		<div class="fh5co-narrow-content">
			<!-- a 태그 안에 로그인전 , 후  다르게 페이지가 이동 되어야함 index or index_main -->
			<h2 class="fh5co-heading animate-box"
				data-animate-effect="fadeInLeft">
				<a style="text-decoration: none; color: #000000;" href="index.jsp">ColorSpace</a>
			</h2>
			<div class="log">
				<i class="fa fa-love"></i><a href="../AdminItemListService">제품수정/추가</a> <a>|</a> <i
					class="fa fa-love"><a href="../AdminOrderService">주문내역</a></i> <a>|</a> <i
					class="fa fa-love"></i><a href="admin_board.jsp">문의내역</a> <a>|</a> <i
					class="fa fa-love"></i><a href="../logout">로그아웃</a>
			</div>
		</div>
		<div class="line" style="margin-top: 0;"></div>

		<div class="con_list" style="margin-top: 30px;">
			<h1>주문 상세 내역</h1>
			<table>
				<thead>
					<tr>
						<th style="width: 1000px;" colspan="4">주문 식별자 : <span
							class="user">&nbsp;<%=orderInfo != null ? orderInfo.get("order_idx") : ""%></span><br>
							주문자 ID : <span class="user">&nbsp;<%=orderInfo != null ? orderInfo.get("user_id") : ""%></span><br>
							배송지 : <span class="user">&nbsp;<%=orderInfo != null ? orderInfo.get("user_addr") : ""%></span><br>
							주문일자 : <span class="user">&nbsp;<%=orderInfo != null ? orderInfo.get("ordered_at") : ""%></span><br>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>제품 ID</th>
						<th>제품 이름</th>
						<th>수량</th>
						<th>가격</th>
					</tr>
					<%
					if (orderDetails != null) {
						for (HashMap<String, Object> detail : orderDetails) {
					%>
					<tr>
						<td><%=detail.get("item_idx")%></td>
						<td><%=detail.get("item_name")%></td>
						<td><%=detail.get("order_cnt")%></td>
						<td><%=detail.get("total_item")%></td>
					</tr>
					<%
					}
					} else {
					%>
					<tr>
						<td colspan="4">주문 상세 정보가 없습니다.</td>
					</tr>
					<%
					}
					%>
					<tr>
						<td colspan="3"></td>
						<td>
							<h4>
								총 주문 금액 : <span><%=orderInfo != null ? orderInfo.get("total_order") + "원" : ""%></span>
							</h4>
						</td>
					</tr>
					<tr>
						<td colspan="3"></td>
						<td class="cs"><span>주문 상태 : </span>
							<form action="../AdminOrderUpdateService" method="post">
								<input type="hidden" name="order_idx"
									value="<%=orderInfo != null ? orderInfo.get("order_idx") : ""%>">
								<select name="order_state">
									<option value="배송중"
										<%="배송중".equals(orderInfo != null ? orderInfo.get("order_state") : "") ? "selected" : ""%>>배송중</option>
									<option value="배송 준비중"
										<%="배송 준비중".equals(orderInfo != null ? orderInfo.get("order_state") : "") ? "selected" : ""%>>배송
										준비중</option>
									<option value="배송완료"
										<%="배송완료".equals(orderInfo != null ? orderInfo.get("order_state") : "") ? "selected" : ""%>>배송완료</option>
								</select></td>
					</tr>
				</tbody>
			</table>
			<div class="sb-btn-container">
				<input type="submit" value="저장하기">
			</div>
			</form>
		</div>
	</div>

	<% if (updateResult != null) { %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script>
        console.log("Update Result: <%= updateResult %>");
        <% if ("success".equals(updateResult)) { %>
        Swal.fire({
            title: '<div style="font-size:22px;">"저장 성공"</div>',
            icon: "success" // "info", "success", "warning", "error" 중 택1
        }).then(() => {
            window.location.href = '../AdminOrderService';    
        });
        <% } else if ("failure".equals(updateResult)) { %>
        Swal.fire({
            title: '<div style="font-size:22px;">"저장 실패"</div>',
            icon: "error" // "info", "success", "warning", "error" 중 택1
        });
        <% } %>
    </script>
    <% } %>

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