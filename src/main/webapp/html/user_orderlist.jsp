<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Date"%>
<%@ page import="java.text.NumberFormat" %>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.User"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	User user = (User)session.getAttribute("login_user"); 
	List<HashMap<String, Object>> orderDetailCounts = (List<HashMap<String, Object>>) session.getAttribute("orderDetailCounts");
	List<HashMap<String, Object>> orderDetails = (List<HashMap<String, Object>>) session.getAttribute("orderDetails");

	if(user == null){
		response.sendRedirect("index.jsp");
		return;
	}

%>

<!DOCTYPE html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>pay&mdash;</title>
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
    <title>Order Status</title>
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
        
    	/* 주문현황테이블이에요!!  */

		table {
			width: 100%;
			border-collapse: collapse;
		}
		
		table, th, td {
			border: none;
		}
		
		tr:first-child, tr:last-child {
			border-top: 1px solid black;
			border-bottom: 1px solid black;
		}
		
		td {
			padding: 10px;
		}
		
		

    	
    	 
       .order-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }
        .order-card {
            display: flex;
            align-items: center;
            width: 80%;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .order-card img {
            width: 200px;
            height: auto;
            margin-right: 20px;
        }
        .order-details {
            flex-grow: 1;
        }
        
        .order-details h5 #name{
            margin: 5px 0;
            font-size: 15px; /* px 단위로 변경 */
            color: #000000; /* 글자 색상 변경 */
        }
        
		</style>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../js/delete_cookie.js"></script>
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
                        <i class="fa fa-love"></i><a href="../logout">로그아웃</a> <a>|</a> <i class="fa fa-love"><a href="../MypageService">mypage</a></i> <a>|</a> <i class="fa fa-love"></i><a href="user_board.jsp">문의하기</a>
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
     
     
        <div class="container" style="padding-top:0px;">
     <h2><%=user.getUser_id() %> 님의 주문처리현황</h2>
        <main>
        
        
			<section class="order-state">
			<br>
				<!-- <h4><a href="../OrderService">주문처리현황</a></h4> -->
				<%
				if (orderDetailCounts != null) {
					if (!orderDetailCounts.isEmpty()) {
				%>


				<table>
					<tr>
						<td><div class="status-item" id="배송준비중">
								<span class="status-label">배송준비중</span>
								<span class="status-value">
										<%
										int countPreparing = 0;
										for (HashMap<String, Object> detailCount : orderDetailCounts) {
											String orderState = (String) detailCount.get("orderState");
											long detailCountValue = (long) detailCount.get("detailCount");
											if ("배송준비중".equals(orderState)) {
												countPreparing += detailCountValue;
											}
										}
										out.print(countPreparing);
										%>
								</span>
							</div></td>
							
						<td><div class="status-item" id="배송중">
								<span class="status-label">배송중</span>
								<span class="status-value">
										<%
										int countShipping = 0;
										for (HashMap<String, Object> detailCount : orderDetailCounts) {
											String orderState = (String) detailCount.get("orderState");
											long detailCountValue = (long) detailCount.get("detailCount");
											if ("배송중".equals(orderState)) {
												countShipping += detailCountValue;
											}
										}
										out.print(countShipping);
										%>
								</span>
							</div></td>



						<td><div class="status-item" id="배송완료">
								<span class="status-label">배송완료</span>
								<span class="status-value">
										<%
										int countCompleted = 0;
										for (HashMap<String, Object> detailCount : orderDetailCounts) {
											String orderState = (String) detailCount.get("orderState");
											long detailCountValue = (long) detailCount.get("detailCount");
											if ("배송완료".equals(orderState)) {
												countCompleted += detailCountValue;
											}
										}
										out.print(countCompleted);
										%>
								</span>
							</div></td>
					</tr>
					<%
					} else {
					out.print("주문 상세 내역이 없습니다.");
					}
					} else {
					out.print("주문 상세 내역이 없습니다.");
					}
					%>
				</table>
			</section>

			<br>
			

			
        <section class="order-list">
        <h3>주문 내역</h3>
        
        <div class="order-container">
            <% if (orderDetails != null) {
                for (HashMap<String, Object> detail : orderDetails) { %>
            <div class="order-card">
                <img src="../item_image/<%= detail.get("item_url") %>" alt="item image">
                <div class="order-details">
                
                    <%  LocalDateTime orderedAt = (LocalDateTime) detail.get("ordered_at"); 
	                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	                    String formattedDate = orderedAt.format(formatter); 
	                    Integer totalPrice = (Integer)detail.get("total_item");
	                    NumberFormat formatterPrice = NumberFormat.getInstance();
	                    String formattedPrice = "";

	                    if (totalPrice != null) {
	                        formattedPrice = formatterPrice.format(totalPrice);
	                    } else {
	                        formattedPrice = "0"; // 기본값 설정
	                    }
	                    
	                    %>
                    	
                    <h5 id="date"><%= formattedDate %></h5>
                    <h5 id="state">주문 상태: <  <%= detail.get("order_state") %> ></h5>
                    <h5 id="name"><%= detail.get("item_name") %></h5>
                    <h5 id="num">수량: <%= detail.get("order_cnt") %></h5>
                    <h5 id="price">주문 가격: <%= formattedPrice %>원</h5>
                    
                </div>
            </div>
            <% }} else { %>
            <p>주문 내역이 없습니다.</p>
            <% } %>
        </div>
    </section> 
        
        
        <a href="../MypageService"><button class="mypage-button">마이페이지로</button></a>
    </main> 
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




