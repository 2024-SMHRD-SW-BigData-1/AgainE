<%@page import="com.fasterxml.jackson.datatype.jsr310.JavaTimeModule"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="com.smhrd.model.User"%>
<%@ page import="com.smhrd.model.User, com.smhrd.model.Item, com.smhrd.model.ItemDAO, com.smhrd.model.BasketDAO, java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%
User user = (User) session.getAttribute("login_user");

if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

// user객체 json직렬화해서 js에서 사용하기
ObjectMapper mapper = new ObjectMapper();
mapper.registerModule(new JavaTimeModule());  // JavaTimeModule 등록
String loginUserJson = mapper.writeValueAsString(user);

// 쿼리스트링 값 가지고 오기
String itemIdxStr = request.getParameter("item_idx");
String cntStr = request.getParameter("cnt");

ItemDAO itemDao = new ItemDAO();

// 쿼리스트링 있을 시
if (itemIdxStr != null && cntStr != null) {
    try {
        int item_idx = Integer.parseInt(itemIdxStr);
        int cnt = Integer.parseInt(cntStr);

        // 아이템 정보 조회
        Item item = itemDao.selectOneItem(item_idx);

     	// 아이템이 없으면 메인 페이지로 이동
        if (item == null) {
            response.sendRedirect("index.jsp"); 
            return;
        }

        // 개별 아이템 결제 처리
        request.setAttribute("item", item);
        request.setAttribute("cnt", cnt);
        request.setAttribute("totalPrice", item.getItem_price() * cnt);

    } catch (NumberFormatException e) {
        response.sendRedirect("index.jsp"); // 형식이 잘못되었으면 메인 페이지로 이동
        return;
    }
}
%>
<%
Item item = (Item) request.getAttribute("item");
Integer cnt = (Integer) request.getAttribute("cnt");
Integer totalPrice = (Integer) request.getAttribute("totalPrice");
NumberFormat formatter = NumberFormat.getInstance();
String formattedPrice = "";

if (totalPrice != null) {
    formattedPrice = formatter.format(totalPrice);
} else {
    formattedPrice = "0"; // 기본값 설정
}
%>
<!DOCTYPE html>
<html lang="en">
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
<link rel="stylesheet" href="../style/css/style.css">
<link rel="stylesheet" href="../style/css/pay.css">
<style>
@keyframes float { 
    0%, 100% {
        transform: translateY(0);
    }
    50% {
        transform: translateY(-15px);
    }
}

/* 로딩 스피너 스타일 */
 .spinner-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.1); /* 반투명 배경 */
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000; /* 다른 요소 위에 표시되도록 */
}

.spinner-overlay img {
    max-width: 100px; /* 이미지의 최대 너비 */
    max-height: 100px; /* 이미지의 최대 높이 */
    object-fit: contain; /* 이미지 비율을 유지하며 맞추기 */
}
    
    /* swal.fire 글씨 크기  */
  .large-popup {
    font-size: 1.2em;  /* 글씨 크기 조정 */
}

.large-popup .swal2-title {
    font-size: 2.5em !important;  /* 타이틀 글씨 크기 조정 */
}

.large-popup .swal2-content {
    font-size: 1.5em !important;  /* 내용 글씨 크기 조정 */
}

.pay_method{
	height : 100px;
}


</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>
<body>
    <div id="fh5co-main">
        <div class="fh5co-narrow-content">
            <h2 class="fh5co-heading animate-box" data-animate-effect="fadeInLeft">
                <a style="text-decoration: none; color: #000000;" href="index.jsp">ColorSpace</a>
            </h2>

            <div class="log">
                <i class="fa fa-love"></i><a href="../logout">로그아웃</a> 
                <a>|</a> 
                <i class="fa fa-love"><a href="../MypageService">마이페이지</a></i> 
                <a>|</a> 
                <i class="fa fa-love"></i><a href="user_board.jsp">문의하기</a>
            </div>
            <div class="line" style="margin-top: 0;"></div>
        </div>
    </div>

    <div class="or">
        <form id="payment-form" class="or">
            <h3>결제페이지</h3>
            <table>
                <h4>주문자</h4>
                <tr>
                    <th><label for="userid">아이디&nbsp;&nbsp;&nbsp;</label></th>
                    <td><span id="userid"><%=user.getUser_id() %></span></td>
                </tr>
                <tr>
                    <th><label for="name">이름&nbsp;&nbsp;</label></th>
                    <td><span id="name"><%=user.getUser_name() %></span></td>
                </tr>
                <tr>
                    <th><label for="phone">전화번호&nbsp;&nbsp;</label></th>
                    <td><span id="phone"><%=user.getUser_phone() %></span></td>
                </tr>
                <tr>
                    <th><label for="address">배송지&nbsp;&nbsp;</label></th>
                    <td><span id="address"><%=user.getUser_addr() %></span></td>
                </tr>
                <tr>
                    <th><label for="email">이메일&nbsp;&nbsp;</label></th>
                    <td><span id="email"><%=user.getUser_email() %></span></td>
                </tr>
            </table>
            
            
            <div id="loading-spinner" class="spinner-overlay" style="display: none;">
			    <img src="../images/Loading_icon.gif" alt="로딩 중...">
			</div>

            <% if (item != null && cnt != null && totalPrice != null) { %>    <!-- 바로 결제 시 (아이템 한 종류) -->
            <h4>주문상품 &nbsp; 1건</h4>
            <div class="or_b">
                <div>
                    상품명 : <%=item.getItem_name()%>
                </div>
                <div>
                    수량 : <%=cnt%>개
                </div>
                <div>
                    가격 : <%=formattedPrice%>원
                </div>
            </div>
            <% } else { %>
            <h4 id="pay-item-cnt">주문상품 &nbsp; 건</h4>
            <div id="basket-items"></div>
            <% } %>  
        
            <h4>결제수단</h4>
            <div class="Su" style="font-family: 'Roboto', Arial, sans-serif;">
            
            	<!-- <button type="button" class="pay_method">
            		<img alt="" src="../images/nice.png">
            		<span style="padding:0px;">NicePayment</span>
            	</button>
            	
            	<button type="button" class="pay_method">
            		<span style="padding:0px;">무통장입금</span>
            	</button> -->
            	
               <label> 
                    <input type="radio" name="option" value="virtual"> 무통장입금
                    <!-- 무통장입금 (계좌이체) &nbsp;&nbsp;&nbsp;&nbsp; 065328451286366 &nbsp; 광주은행 -->
                </label>
                <br> 
                <label> 
                    <input type="radio" name="option" value="card"> 카드결제  <!-- 나이스페이먼츠로 진행 -->
                </label>

                <!-- <div id="card-options">
                    <label> 
                        <select id="card_Type" name="cardType" class="custom-select">
                            <option value="" disabled selected>카드를 선택해주세요.</option>
                            <option value="우리">우리</option>
                            <option value="국민">KB국민</option>
                            <option value="농협">NH농협</option>
                            <option value="BC">BC</option>
                            <option value="신한">신한</option>
                            <option value="현대">현대</option>
                            <option value="롯데">롯데</option>
                            <option value="카뱅">카카오뱅크</option>
                            <option value="씨티">씨티</option>
                        </select>
                    </label>
                    <br>
                    <div class="C">카드 번호입력</div>

                    <label class="in"> 
                        <input type="text" name="cardNumber" id="card-number" placeholder="카드 번호를 입력해주세요." style="border: none; outline: none;">
                    </label>
                </div> -->

                <div>
                    <button type="button" id="submit-btn"> 총 <%=formattedPrice %> 원 결제 하기</button>
                </div>
            </div>
        </form>
    </div>
    
<script type="text/javascript">
	var totalPrice = <%= totalPrice != null ? totalPrice : 0 %>;
	console.log("totalPrice"+totalPrice);
	var payTotalPrice = totalPrice;
	console.log("payTotalPrice"+payTotalPrice);
	var itemIdx = '<%= itemIdxStr != null ? itemIdxStr : "" %>';
	var cnt = '<%= cntStr != null ? cntStr : "" %>';
	var loginUserJson = <%= loginUserJson %>;
</script>
            
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/pay.js"></script>
<script type="text/javascript" src="../js/delete_cookie.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
</body>
</html>
