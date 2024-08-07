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
<meta charset="UTF-8">
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

<link rel="stylesheet" href="../style/css/style.css">
<link rel="stylesheet" href="../style/css/user_update.css">
<script src="../js/js2/modernizr-2.6.2.min.js"></script>


<style>
@
keyframes float { 
   0%, 100% {
      transform: translateY(0);
   }
   50% {
      transform:translateY(-15px);
   }
}



</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script   src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<!-- user_update.js로 이동 -->
<script type="text/javascript" src="../js/user_update.js"></script>
    <script type="text/javascript" src="../js/delete_cookie.js"></script>
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
         <span><h2>회원정보수정</h2></span>

      <main>
         <h3 style="background-color: #ccc; padding: 10px;">기본정보</h3>
         <form action="../UserUpdateService" method="post" id="update-form">
            <table>
               <tr>
                  <th><label for="userid">아이디&nbsp;
                        <h6 style="margin: 0;"></h6>
                  </label></th>
                  <td colspan="2"><input type="text" id="userid" name="userid"
                     value=<%=user.getUser_id()%> disabled></td>
               </tr>
               <tr>
                  <th><label for="current-password">새 비밀번호</label></th>
                  <td colspan="2"><input type="password" id="password" name="update_pw" required></td>
               </tr>
               <tr>
                  <th rowspan="2"><label for="new-password">새 비밀번호 확인</label></th>
                  <td style="border: 0px;" colspan="2"><input type="password"   id="confirm-password" name="update_pw_re" required></td>
               </tr>
               <tr>
                  <td colspan="3"><span id="password-message" class="message"></span></td>
               </tr>
               <tr>
                  <th><label for="email">변경할 이메일</label></th>
                  <td colspan="2"><input type="email" id="update_email" name="update_email" required></td>
               </tr>
               <tr>
                  <th><label for="name">변경할 이름</label></th>
                  <td colspan="2"><input type="text" id="update_name" name="update_name" required></td>
               </tr>
               <tr>
                  <th><label for="phone">변경할 전화번호</label></th>
                  <td colspan="2"><input type="tel" id="update_phone" name="update_phone" required></td>
               </tr>
               <tr>
                  <th rowspan="3"><label for="address">변경할 주소</label></th>
                  <!-- <td><input type="text" id="update_address" name="update_addr" required></td> -->
	                <td><input type="text" id="postcode" name="postcode" placeholder="우편번호" required></td>
					<td><input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br></td>
               </tr>
               <tr>
               	<td colspan="2"><input type="text" id="address" name="address" placeholder="주소" required><br></td>
               </tr>
               <tr>
               	<td><input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" required></td>
				<td><input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목"></td>
               </tr>
            </table>

            <div class="button-group">
               <button type="submit" id="update-btn">수정하기</button>
               <button type="button" id="delete-btn">회원탈퇴</button>
            </div>
         </form>
         <!-- <p class="note">누르면 색상 변경<br>수정하고 마저 적기고 끌<br>메인페이지로는 로그아웃해서 알아서 나가게...</p> -->
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


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
</body>

</html>