<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.smhrd.model.User"%>
<%@page import="java.util.List"%>
<%@ page import="java.text.NumberFormat" %>
<%@page import="com.smhrd.model.Item"%>
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
    List<Item> items = (List<Item>) session.getAttribute("items");
	System.out.println(items.get(0));
	NumberFormat formatter = NumberFormat.getInstance();
%>
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
<link rel="shortcut icon" href="data:;base64,iVBORw0KGgo=">
<link href='https://fonts.googleapis.com/css?family=Roboto:400,300,600,400italic,700' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="../style/css/animate.css">
<link rel="stylesheet" href="../style/css/icomoon.css">
<link rel="stylesheet" href="../style/css/bootstrap.css">
<link rel="stylesheet" href="../style/css/owl.carousel.min.css">
<link rel="stylesheet" href="../style/css/owl.theme.default.min.css">
<link rel="stylesheet" href="../style/css/admin.css">
<script src="../js/js2/modernizr-2.6.2.min.js"></script>
<style>
@keyframes float { 0%, 100% {transform: translateY(0);}50%{transform:translateY(-15px);}}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script type="text/javascript" src="../js/delete_cookie.js"></script>
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
        </div>
        <div class="line" style="margin-top: 0;"></div>
        <div class="container">
            <h1>제품 목록</h1>
            <div class="add-btn-container">
                <a href="admin_itemplus.jsp"><button class="add-btn"> + 추가하기</button></a>
            </div>
            <br>
            <table>
                <thead>
                    <tr>
                        <th>제품 ID</th>
                        <th>카테고리</th>
                        <th>제품명</th>
                        <th>톤</th>
                        <th>컬러</th>
                        <th>설명</th>
                        <th>가격</th>
                        <th>첨부파일</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <% if (items != null && !items.isEmpty()) { 
                        for (Item item : items) { %>
                        <%String formattedPrice = formatter.format(item.getItem_price()); %>
                        
                    <tr>
                        <td><%= item.getItem_idx() %></td>
                        <td><%= item.getItem_category() %></td>
                        <td><%= item.getItem_name() %></td>
                        <td><%= item.getItem_tone() %></td>
                        <td><%= item.getItem_color() %></td>
                        <td><%= item.getItem_info() %></td>
                        <td><%= formattedPrice %></td>
                        <td><%= item.getItem_url() %></td>
                        <td><a href="admin_itemupdate.jsp?itemId=<%= item.getItem_idx() %>"><button>수정</button></a></td>
                    </tr>
                    <% } 
                    } else { %>
                    <tr>
                        <td colspan="8">No items found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            
        </div>
    </div>
</body>
</html>
