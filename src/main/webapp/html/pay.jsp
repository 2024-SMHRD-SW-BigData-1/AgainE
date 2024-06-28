<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="com.smhrd.model.User"%>
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
    <title>pay&mdash;</title>
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
    <link rel="stylesheet" href="../style/css/pay.css">

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
</head>

<body>


    <div id="fh5co-main">
        <div class="fh5co-narrow-content">
            <div>
                <h2 class="fh5co-heading animate-box" data-animate-effect="fadeInLeft"> <a
                        style=" text-decoration: none; color: #000000;" href="index.jsp">ColorSpace</a>

                    <div class="log">
                        <i class="fa fa-love"></i><a href="../logout">로그아웃</a>
                        <a>|</a>
                        <i class="fa fa-love"><a href="mypage.jsp">MyPage</a></i>
                        <a>|</a>
                        <i class="fa fa-love"></i><a href="">문의하기</a>
                    </div>
                    <div class="line"></div>

            </div>
            
 
 <h3>결제페이지</h3>
 <div class="or">
     <form class="or">
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
         <h4>주문상품 &nbsp; ? 건</h4>
         <div class="or_b">
             <div>
                 어쩌고 저쩌고 어쩌고 저쩌고
             </div>
             <div>
                 수량
             </div>
             <div>
                 가격
             </div>
         </div>

         <div class="or_b">
             <div>
                 어쩌고 저쩌고 어쩌고 저쩌고
             </div>
             <div>
                 수량
             </div>
             <div>
                 가격
             </div>
         </div>
                   
                   
                    
        <h4>결제수단</h4>
		<div class="Su"> 
		    <form>
		        <label>
		            <input type="radio" name="option" value="1"> 무통장입금 (계좌이체)
		            &nbsp;&nbsp;&nbsp;&nbsp; 065328451286366 &nbsp; 광주은행 
		        </label>
		        <br>
		
		        <label>
		            <input type="radio" name="option" value="2"  onclick="toggleCardOptions()" > 카드
		        </label>

        
        		<div id="card-options"   onclick="toggleCardOptions()">
		            	<label>
			                <select id="card_Type" class="custom-select"  >
			                    <option value="" disabled selected>카드를 선택해주세요. </option>
			                    <option value="">우리</option>
			                    <option value="">KB국민</option>
			                    <option value="">NH농협</option>
			                    <option value="">BC</option>
			                    <option value="">신한</option>
			                    <option value="">현대</option>
			                    <option value="">롯데</option>
			                    <option value="">카카오뱅크</option>
			                    <option value="">씨티</option>
			                    
			                </select>
			            </label>
			            <br>
			            <div class="C">
			                카드 번호
			            </div>

			            <label class="in">
			                <input type="text" name="card-number" placeholder="카드 번호를 입력해주세요." style="border: none;  outline :  none;">
			            </label>
       			 </div>
				        <div>
				            <button type="submit" id="submit-btn"> ???? 원 결제 하기</button>
				        </div>

    				</form>
				</div>
            </form>
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

            <script>
                // 카드 선택했다가 현금 선택하면 사라져야하는데 안사라져요... 자바킹 도와줘!!!!!!!!!!!!
                function toggleCardOptions() {
                    var cardOptions = document.getElementById('card-options');
                    var cardRadio = document.querySelector('input[name="option"][value="2"]');
                    if (cardRadio.checked) {
                        cardOptions.style.display = 'block';
                    } else {
                        cardOptions.style.display = 'none';
                    }
                }
        
                // 페이지 로드 시 초기 설정 (현금 선택 시 카드 옵션 숨김)
                window.onload = function() {
                    var cashRadio = document.querySelector('input[name="option"][value="1"]');
                    if (cashRadio.checked) {
                        document.getElementById('card-options').style.display = 'none';
                    }
                };
            </script>



</body>

</html>