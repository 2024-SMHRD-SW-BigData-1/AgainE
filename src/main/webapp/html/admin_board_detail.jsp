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
<link rel="stylesheet" href="../style/css/admin_board_detail.css">
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

<script>
        // JavaScript에서 사용하기 위해 JSP에서 쿼리 스트링 데이터를 출력합니다.
        var b_idx = '<%= request.getParameter("b_idx") %>';
</script>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
   
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script type="text/javascript" src="../js/admin_board_detail.js"></script>
</head>

<body>
<div id="fh5co-main">
      <div class="fh5co-narrow-content">
         <!-- a 태그 안에 로그인전 , 후  다르게 페이지가 이동 되어야함 index or index_main -->
         <h2 class="fh5co-heading animate-box"
            data-animate-effect="fadeInLeft">
            <a style="text-decoration: none; color: #000000;"
               href="index.jsp">ColorSpace</a>
         </h2>

         <div class="log">
            <i class="fa fa-love"></i><a href="../AdminItemListService">제품수정/추가</a> <a>|</a> <i
               class="fa fa-love"><a href="../AdminOrderService">주문내역</a></i> <a>|</a> <i
               class="fa fa-love"></i><a href="admin_board.jsp">문의내역</a> <a>|</a> <i
               class="fa fa-love"></i><a href="../logout">로그아웃</a>
         </div>
      </div>
      </div>
      <div class="line" style="margin-top: 0;"></div>

       <div class="container">
            <div class="con_list">
                <h3>문의 상세 내역</h3>
                <br>
                
                <div id="user-board-detail">
                <!-- <div class="que">
                    <p>상품 > Q 침대에 헤드가 빠졌습니다.</p>
                    <div class="que_f">
                        <img src="../images/장바구니.png" alt="">
                        <div class="que_w">
                            <p>문의 내용:</p>
                            <h4>
                                내용들어가는 곳
                            </h4>
                            <div class="que_q">
                                <span>작성자:</span><span>woolee0822</span><br>
                                <span>작성일자:</span><span class="date">2024/06/10</span>
                            </div>
                        </div>
                    </div>
                </div> -->
               </div>
<br>



               
                    <div class="que">
                    <br>
                        <p> 답변달기 </p>
                        <br>
                        <form method="post" enctype="multipart/form-data" id="uploadForm">
                        <div class="que_f">
                            <!-- <input type="file"> -->

                            <input type="file" id="fileInput" name="photo" style="display: none;" accept="image/*" required>

                            <!-- 커스텀 버튼을 추가합니다. -->
                            <label for="fileInput" id="customFileUploadButton">파일 업로드</label>
                            
                            <!-- 파일 선택 후 파일명을 표시할 영역 예시 -->
                            <div id="fileNameDisplay"></div>


                            <div class="que_w">
                               <input type="text" name="title" placeholder="답변 제목" required style="width:100%; height:20%" required>
                               <input type="text" name="content" placeholder="답변 내용" required style="width:100%; height:80%" required>
                            </div>
                            
                            
                            
                        </div>
				                <div class="que_sub">
				               <button id="submit_btn" type="button">답변 올리기</button>
				                </div>
                        </form>
                    </div>
            </div>
        </div>
    </div>

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
