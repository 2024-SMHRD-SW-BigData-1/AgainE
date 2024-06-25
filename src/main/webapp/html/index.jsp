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
	<meta name="keywords"
		content="free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
	<meta name="author" content="FreeHTML5.co" />


	
	<link rel="shortcut icon" href="data:;base64,iVBORw0KGgo=">


	<link href='https://fonts.googleapis.com/css?family=Roboto:400,300,600,400italic,700' rel='stylesheet'
		type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>

	
	<link rel="stylesheet" href="../style/css/animate.css">

	<link rel="stylesheet" href="../style/css/icomoon.css">

	<link rel="stylesheet" href="../style/css/bootstrap.css">

	<link rel="stylesheet" href="../style/css/owl.carousel.min.css">
	<link rel="stylesheet" href="../style/css/owl.theme.default.min.css">

	<link rel="stylesheet" href="../style/css/style.css">


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
	</style>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="../js/index.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>

<body>


	<div id="fh5co-main">
		<div class="fh5co-narrow-content">
			<div><!-- a 태그 안에 로그인전 , 후  다르게 페이지가 이동 되어야함 index or index_main -->
				<h2 class="fh5co-heading animate-box" data-animate-effect="fadeInLeft"> 
				<a style=" text-decoration: none; color: #000000;" href="index.jsp">ColorSpace</a>
				 <% if(user != null){ %>  <!-- 로그인 했을 시  -->
				 	<%if(user.getUser_type().equals("f") ||  user.getUser_type().equals("t")){ %> <!-- 사용자일때 -->
				 <div class="log">
						<i class="fa fa-love"></i><a href="../logout">로그아웃</a>
						<a>|</a>
						<i class="fa fa-love"></i><a href="#">mypage</a>
						<a>|</a>
						<i class="fa fa-love"></i><a href="#">문의하기</a>
					</div>
					<div class="line"></div>
					<%} %>
				<% } else { %>  <!-- 로그인 안했을 시  -->
					<div class="log">
						<i class="fa fa-love"></i><a href="login.jsp">로그인</a>
						<a>|</a>
						<i class="fa fa-love"></i><a href="join.jsp">회원가입</a>
					</div>
					<div class="line"></div> 
				<% } %> 
			</h2>
			</div>
			
			<!-- ------------------------------------------------------------------------------   -->
			<!--                               카테고리 시작                                         -->
			<!-- ------------------------------------------------------------------------------   -->
			
			<% if(user != null){ %>  <!-- 로그인 했을 시  -->
				 	<%if(user.getUser_type().equals("f") ||  user.getUser_type().equals("t")){ %> <!-- 사용자일때 -->
			<div class="row animate-box" data-animate-effect="fadeInLeft">
				<h4 style="margin-right: 50px; padding: 40px"> 카테고리
					<br>
					<br>
					<span class="con_btn" style="background-color: rgb(255, 255, 255); color: black;">
						<div class="con">
							<button class="con_btn category_btn" id="침대"><img class=con_img src="../images/침대.png" alt="">
								<span class="caption">침대</span>
							</button>

							<button class="con_btn category_btn" id="소파"> 
								<img class=con_img src="../images/소파.png" alt="">
								<span class="caption">쇼파</span>
							</button>
							<button class="con_btn category_btn" id="서랍"> <img class=con_img src="../images/서랍.png" alt="">
								<span class="caption">서랍</span>
							</button>
							<button class="con_btn category_btn" id="옷장"> <img class=con_img src="../images/옷장.png" alt="">
								<span class="caption">옷장</span>
							</button>
							<button class="con_btn category_btn" id="의자"> <img class=con_img src="../images/의자.png" alt="">
								<span class="caption">의자</span>
							</button>
							<button class="con_btn category_btn" id="식탁"><img class=con_img src="../images/식탁.png" alt="">
								<span class="caption">식탁</span>
							</button>
							<button class="con_btn category_btn" id="책상"><img class=con_img src="../images/책상.png" alt="">
								<span class="caption">책상</span>
							</button>
							<button class="con_btn category_btn" id="책장"><img class=con_img src="../images/책장.png" alt="">
								<span class="caption">책장</span>
							</button>
							</div>
					</span>
				</h4>
			</div>
				<%} }else { %> <!-- 로그인 안했을 때 -->
				<div class="row animate-box" data-animate-effect="fadeInLeft">
				<h4 style="margin-right: 50px; padding: 40px"> 카테고리
					<br>
					<br>
					<span class="con_btn" style="background-color: rgb(255, 255, 255); color: black;">
						<div class="con">
							<button class="con_btn category_btn" id="침대"><img class=con_img src="../images/침대.png" alt="">
								<span class="caption">침대</span>
							</button>

							<button class="con_btn category_btn" id="소파"> <img class=con_img src="../images/소파.png" alt="">
								<span class="caption">쇼파</span>
							</button>
							<button class="con_btn category_btn" id="서랍"> <img class=con_img src="../images/서랍.png" alt="">
								<span class="caption">서랍</span>
							</button>
							<button class="con_btn category_btn" id="옷장"> <img class=con_img src="../images/옷장.png" alt="">
								<span class="caption">옷장</span>
							</button>
							<button class="con_btn category_btn" id="의자"> <img class=con_img src="../images/의자.png" alt="">
								<span class="caption">의자</span>
							</button>
							<button class="con_btn category_btn" id="식탁"><img class=con_img src="../images/식탁.png" alt="">
								<span class="caption">식탁</span>
							</button>
							<button class="con_btn category_btn" id="책상"><img class=con_img src="../images/책상.png" alt="">
								<span class="caption">책상</span>
							</button>
							<button class="con_btn category_btn" id="책장"><img class=con_img src="../images/책장.png" alt="">
								<span class="caption">책장</span>
							</button>
							</div>
					</span>
				</h4>
			</div>
				<%} %>
				
			<!-- ------------------------------------------------------------------------------   -->
			<!--                               색상선택 시작                                         -->
			<!-- ------------------------------------------------------------------------------   -->

				<% if(user != null){ %>  <!-- 로그인 했을 시  -->
				 	<%if(user.getUser_type().equals("f") ||  user.getUser_type().equals("t")){ %> <!-- 사용자일때 -->
			<h4 style=" padding: 40px"> 색상선택
				<br>
				<br>
				<div class="color_lst">
					<div class="color-option" id="레드" style="background-color: #FF0000;"></div>
					<div class="color-option" id="오렌지" style="background-color: #FF7F00;"></div>
					<div class="color-option" id="옐로우" style="background-color: #FFFF00;"></div>
					<div class="color-option" id="그린" style="background-color: #00FF00;"></div>
					<div class="color-option" id="라이트블루" style="background-color: #00FFFF;"></div>
					<div class="color-option" id="네이비" style="background-color: #0000FF;"></div>
					<div class="color-option" id="퍼플" style="background-color: #8B00FF;"></div>
					<div class="color-option" id="핑크" style="background-color: #FF00FF;"></div>
					<div class="color-option" id="베이지" style="background-color: #FFE4B5;"></div>
					<div class="color-option" id="브라운" style="background-color: #8B4513;"></div>
					<div class="color-option" id="그레이" style="background-color: #808080;"></div>
					<div class="color-option" id="화이트" style="background-color: #F5F5F5;"></div>
					<div class="color-option" id="블랙" style="background-color: #000000;"></div>
				</div>
			</h4>
				<%} }else { %> <!-- 로그인 안했을 때 -->
					<h4 style=" padding: 40px"> 색상선택
				<br>
				<br>
				<div class="color_lst">
					<div class="color-option" id="레드" style="background-color: #FF0000;"></div>
					<div class="color-option" id="오렌지" style="background-color: #FF7F00;"></div>
					<div class="color-option" id="옐로우" style="background-color: #FFFF00;"></div>
					<div class="color-option" id="그린" style="background-color: #00FF00;"></div>
					<div class="color-option" id="라이트블루" style="background-color: #00FFFF;"></div>
					<div class="color-option" id="네이비" style="background-color: #0000FF;"></div>
					<div class="color-option" id="퍼플" style="background-color: #8B00FF;"></div>
					<div class="color-option" id="핑크" style="background-color: #FF00FF;"></div>
					<div class="color-option" id="베이지" style="background-color: #FFE4B5;"></div>
					<div class="color-option" id="브라운" style="background-color: #8B4513;"></div>
					<div class="color-option" id="그레이" style="background-color: #808080;"></div>
					<div class="color-option" id="화이트" style="background-color: #F5F5F5;"></div>
					<div class="color-option" id="블랙" style="background-color: #000000;"></div>
				</div>
					</h4>
				<%} %>
				
				
				<% if(user != null){ %>  <!-- 로그인 했을 시  -->
				 	<%if(user.getUser_type().equals("t")){ %> <!-- 방 이미지를 업로드한 사용자에게만 보여지도록 -->
			<div class="tone-description" id="balloon">
				<div class="message-tone">
					<div class="message-box">
						<span>톤온톤 인테리어란?</span>
						<br>
						<h5>같은 색상 계열이지만 밝기의 정도와 선명도를 달리해서 조화를 주는 인테리어!</h5>

						<span>톤인톤 인테리어란?</span>
						<br>
						<h5>다른 계열의 색상이라도 비슷한 명도, 채도의 색상을 배색하는 인테리어!</h5>
					</div>
				</div>
			</div>
			<div id="clickMe"><img src="../images/느낌표.png" alt=""></div>
			<div class="tone">

				<h2 class="tone">톤온톤</h2>
				<h4 class="tone">톤인톤</h4>
			</div>
			<div class="line_tone"></div>
			<%}} %>


			<!-- ------------------------------------------------------------------------------   -->
			<!--                               상품 보여주기 시작                                     -->
			<!-- ------------------------------------------------------------------------------   -->



		<% if(user != null){ %>  <!-- 로그인 했을 시  -->
				 	<%if(user.getUser_type().equals("f") ||  user.getUser_type().equals("t")){ %> <!-- 사용자일때 -->
				<div class="item_container">
					<div class="col-md-4 col-sm-6 col-xs-6 col-xxs-12 work-item">
						<a class="showPopup">
							<img src="#" class="img-responsive" alt="Product Thumbnail">
							<h5 class="title">로딩중...</h5>
							<h3 class="price">로딩중...</h3>
						</a>
					</div>
				</div>
				<div class="item_container">
					<div class="col-md-4 col-sm-6 col-xs-6 col-xxs-12 work-item">
						<a class="showPopup">
							<img src="#" class="img-responsive" alt="Product Thumbnail">
							<h5 class="title">로딩중...</h5>
							<h3 class="price">로딩중...</h3>
						</a>
					</div>
				</div>
				<div class="item_container">
					<div class="col-md-4 col-sm-6 col-xs-6 col-xxs-12 work-item">
						<a class="showPopup">
							<img src="#" class="img-responsive" alt="Product Thumbnail">
							<h5 class="title">로딩중...</h5>
							<h3 class="price">로딩중...</h3>
						</a>
					</div>
				</div>
			<div class="item_container">
					<div class="col-md-4 col-sm-6 col-xs-6 col-xxs-12 work-item">
						<a class="showPopup">
							<img src="#" class="img-responsive" alt="Product Thumbnail">
							<h5 class="title">로딩중...</h5>
							<h3 class="price">로딩중...</h3>
						</a>
					</div>
				</div>
			<div class="item_container">
					<div class="col-md-4 col-sm-6 col-xs-6 col-xxs-12 work-item">
						<a class="showPopup">
							<img src="#" class="img-responsive" alt="Product Thumbnail">
							<h5 class="title">로딩중...</h5>
							<h3 class="price">로딩중...</h3>
						</a>
					</div>
				</div>
			<div class="item_container">
					<div class="col-md-4 col-sm-6 col-xs-6 col-xxs-12 work-item">
						<a class="showPopup">
							<img src="#" class="img-responsive" alt="Product Thumbnail">
							<h5 class="title">로딩중...</h5>
							<h3 class="price">로딩중...</h3>
						</a>
					</div>
				</div>
			 
			<%}else if(user.getUser_type().equals("a")){ %>   <!-- 관리자로 로그인 시 -->
				<div>
					<h1>제품수정/추가</h1>
					<h1>주문내역</h1>
					<h1>문의내역</h1>
					<a href="../logout"><h1>로그아웃</h1></a>
				
				</div>
			
			
			<%}}else { %>  <!-- 로그인 안했을 때 -->
				<div class="item_container">
					
				</div>
			<%} %>




			<!-- 팝업 창 -->
			<div class="overlay" id="overlay">
			<div class="popup" id="popup">
				<span class="popup-close" onclick="closePopup()">X</span>
				<div>카테고리 경로</div>
				<div class="popup-content">
					<img src="../images/hero.jpg" alt="Product Image">
					<div class="popup-details">
						<h4>드레스덴 정품 조이헤브릭 호텔식 의자</h4>
						<h4>299,000원</h4>
						<div class="quantity-control">
							<button id="decrease-quantity">—</button>
							<input type="number" id="quantity" value="1" min="1">
							<button id="increase-quantity">+</button>
						</div>
						<br>
						<div class="pbtn">
							<button class="po_btn">장바구니</button>
							<button class="p_btn">바로구매</button>
						</div>
							<br>
							<div>
								<h4><strong> [간단설명] </strong></h4>
								<p>모던한 느낌의 빈티지카 어쿠르 저지코 뒤쪽에 위치</p>
								<p>사이즈: l: 0.47*0.5245, 35 35&65, 6.45</p>
							</div>
							<button class="o_btn" onclick="contactUs()">문의하기</button>
						</div>
						
					</div> <!-- 팝업 콘텐츠 끝태그 -->
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