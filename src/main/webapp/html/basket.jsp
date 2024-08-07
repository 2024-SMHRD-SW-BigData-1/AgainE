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
%>
<!DOCTYPE html>

<html class="no-js">

<head>
   <meta charset="utf-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <title>ColorSpace</title>
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <meta name="description" content="Free HTML5 Website Template by FreeHTML5.co" />
   <meta name="keywords"
      content="free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
   <meta name="author" content="FreeHTML5.co" />


   
   <link rel="shortcut icon" href="favicon.ico">


   <link href='https://fonts.googleapis.com/css?family=Roboto:400,300,600,400italic,700' rel='stylesheet'
      type='text/css'>
   <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>

   
   <link rel="stylesheet" href="../style/css/animate.css">

   <link rel="stylesheet" href="../style/css/icomoon.css">

   <link rel="stylesheet" href="../style/css/bootstrap.css">

   <link rel="stylesheet" href="../style/css/owl.carousel.min.css">
   <link rel="stylesheet" href="../style/css/owl.theme.default.min.css">
<link rel="stylesheet" href="../style/css/style.css">
<link rel="stylesheet" href="../style/css/basket.css">


   <script src="../js/js2/modernizr-2.6.2.min.js"></script>

    
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
       
                /* 로딩 스피너 스타일 */
 .spinner-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 2000; /* 다른 요소 위에 표시되도록 */
}

.spinner-overlay img {
    max-width: 100px; /* 이미지의 최대 너비 */
    max-height: 100px; /* 이미지의 최대 높이 */
    object-fit: contain; /* 이미지 비율을 유지하며 맞추기 */
}
       
       /* 숫자 입력의 기본 화살표 숨기기 */
		input[type="number"]::-webkit-outer-spin-button,
		input[type="number"]::-webkit-inner-spin-button {
		    -webkit-appearance: none;
		    margin: 0;
		}
		
		input[type="number"] {
		    -moz-appearance: textfield; /* Firefox */
		}
		
		/* readonly 스타일 적용 */
        input[type="number"][readonly] {
            background-color: #f3f3f3;
            cursor: not-allowed;
        }
        
        #deleteBasket {
            color: white; /* 글씨색 */
            background-color: red; /* 배경색 */
            border: none; /* 테두리 제거 */
            cursor: pointer; /* 커서 모양 */
        }

        #deleteBasket:hover {
            background-color: darkred; /* 호버 시 배경색 */
        }
        
         #empty-cart {
         	display: none;
         }
         #exist-cart {
         	display: none;
		}
         	
         }
         

   </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../js/delete_cookie.js"></script>
    <script src="../js/basket.js"></script>
    
</head>

<body>


 
   <div id="fh5co-main">
   <header >
    <div class="fh5co-heading animate-box" data-animate-effect="fadeInLeft">
        <h2 style="display: inline-block; margin-right: 20px;">
            <a href="index.jsp" style="text-decoration: none; color: #000000; font-size:50px; font-weight: 200;">ColorSpace</a>
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
	</header>


            <span><h2>장바구니</h2></span>
            
            		<div id="loading-spinner" class="spinner-overlay" style="display: none;">
			   			<img src="../images/Loading_icon.gif" alt="로딩 중...">
					</div>
            		

					<!--  장바구니 비었을 때  -->
					<div id="empty-cart">
			            <div class="shop_N">
			                <h2>장바구니가 비었습니다.</h2>
			            </div>
			            <div class="shop_im">
			                <img src="../images/장바구니.png" alt="이미지 준비중...">
			            </div>
			            <div class="ma-a">
			                <a href="index.jsp">쇼핑하러 가기</a>
			            </div>
			          </div>  
			            
			           <!-- 장바구니 존재할 때  -->
                        <main id="cart-items">
							<!-- 아이템 동적으로 추가되는 부분 -->
						</main>
						
						
						
						<div id="exist-cart">
							<button id="deleteBasketAll">장바구니 전체 삭제</button>
							
							<div class="total-price" style="margin-top : 30px;">
							<p>총 금액</p>
							<p id="total-price"> 0 원</p>
							</div>
							
							<div class="checkout">
							<a href="pay.jsp"><button>구매하기</button></a>
							</div>
					       <div class="ma-a"> 
					       <a  href="index.jsp">쇼핑하러 가기</a> 
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