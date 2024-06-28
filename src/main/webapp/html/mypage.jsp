<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.datatype.jsr310.JavaTimeModule" %>
<%@page import="com.smhrd.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("login_user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return; // 리디렉션 후 나머지 코드 실행 방지
    }
    System.out.println(user.getUser_room_color());
    System.out.println(user.getUser_room_tone());
    System.out.println(user.getUser_room_url());
    
    // Assuming you have a UserDTO object in the session
    ObjectMapper mapper = new ObjectMapper();
    mapper.registerModule(new JavaTimeModule());  // JavaTimeModule 등록
    String loginUserJson = mapper.writeValueAsString(user);
%>

<!DOCTYPE html>


<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ColorSpace MyPage</title>
<meta name="description"
   content="Free HTML5 Website Template by FreeHTML5.co" />
<meta name="keywords"
   content="free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
<meta name="author" content="FreeHTML5.co" />



<link rel="shortcut icon" href="data:;base64,iVBORw0KGgo=">



<link rel="stylesheet" href="../style/css/animate.css">

<link rel="stylesheet" href="../style/css/icomoon.css">

<link rel="stylesheet" href="../style/css/bootstrap.css">

<link rel="stylesheet" href="../style/css/owl.carousel.min.css">
<link rel="stylesheet" href="../style/css/owl.theme.default.min.css">

<!-- <link rel="stylesheet" href="../style/css/style.css"> -->
<link rel="stylesheet" href="../style/css/mypage.css">
<script src="../js/js2/modernizr-2.6.2.min.js"></script>

<style>
@
keyframes float { 0%, 100% {
   transform: translateY(0);
	}50%{
	transform:translateY
	(-15px);
	}
}
</style>
 



<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="../js/mypage.js"></script>
</head>




<body>
	<div class="container">
	<header>
        <div class="fh5co-heading animate-box" data-animate-effect="fadeInLeft">
            <h2 style="display: inline-block; margin-right: 20px;">
                <a href="index.jsp" style="text-decoration: none; color: #000000;">ColorSpace</a>
            </h2>

			<div class="log">
				<a href="../logout"  style="color:grey">로그아웃</a>
				<a> | </a> 
				<i><a href="mypage.jsp">mypage</a></i>
				<a> | </a> 
				<a href="user_board.jsp"  style="color:grey">문의하기</a>
			</div>
			
			</div>
			<div class="line"></div>
		</header>
		</div>
		
		
		
		<div class="container">
		<main>
			<section class="user-info">
				<br>
				<h2><%=user.getUser_id()%>
					님의 MyPage
				</h2>
				<a href="user_update.jsp"><button>회원정보 수정</button></a>
			</section>
			<br>
			<section class="order-status">
				<h2>주문처리현황</h2>
				<!-- <div class="status-warning">
                    <p>배송상품 사진을 4장 등록해주세요! 배송완료가 안될 시 배송완료 처리 됩니다!!</p>
                </div> -->
				<div class="status-details">
					<div class="status-item">
						<a href="user_orderlist.jsp"> <span class="status-label">배송준비중</span></a>
						<a href="user_orderlist.jsp"> <span class="status-value">4</span></a>
					</div>
					<div class="status-item">
						<a href="user_orderlist.jsp"><span class="status-label">배송중</span></a>
						<a href="user_orderlist.jsp"><span class="status-value">0</span></a>
					</div>
					<div class="status-item">
						<a href="user_orderlist.jsp"><span class="status-label">배송완료</span></a>
						<a href="user_orderlist.jsp"><span class="status-value">0</span></a>
					</div>
				</div>

				
					<form id="uploadForm" enctype="multipart/form-data" data-login-user-json="<%= loginUserJson.replace("\"", "&quot;") %>" >
					<div class="my-room">
						<h3>my room</h3>
						<div class="status-warning" id="warning-message">
                    <p>회원님의 방 사진을 등록해주세요! 방 분위기에 맞는 가구를 추천해드립니다!!</p>
                		</div> 
						<div id="preview-area"></div>
						<div class="upload">
						 <button type="button" id="upload-area" class="btn-primary">사진올리기</button>
							<input type="file" id="file-input" name="imageFile" accept="image/*">
							<br>
						<button type="submit" class="btn btn-primary">방사진 분석하기</button>
						</div>
						<br>				
						</form>
					</div>
				
			</section>

			<% if(user.getUser_type().equals("f")){ %>  		<!-- 아직 방사진 올린 기록 없을 때 -->
			
			<%} else if(user.getUser_type().equals("t")){ %>	<!-- 방사진 올린 기록 있을 때 -->
			<section class="analysis-result">
				<h2>분석 결과</h2>
				<div class="result-details">
					<div class="result-box">
						<div class="corner"></div>
						<img alt="파일을 찾을 수 없습니다" src="../user_room_img/<%=user.getUser_room_url() %>" class="img-responsive">
						<p>색 : <%=user.getUser_room_color() %></p>
						<p>톤 : <%=user.getUser_room_tone() %></p>
					</div>
				</div>
			<%} %>

			</section>
			<section class="inquiries">
				<h2>문의내용</h2>
				<div class="inquiry">
					<p class="date">2024/06/08</p>
					<h3>> 배송</h3>
					<h4>제품명</h4>
					<span>: 드레스룸 정품 조이해트백 조립식 설치완료제품</span>
					<h4>문의 제목</h4>
					<span>: 하하 배달가 안되어요</span>
					<h4>문의 내용</h4>
					<span>: 하하 배달가 안되어요</span>

					<div class="inquiry1">
						<p>답변</p>
						<p>답변이 아직 달리지 않았습니다.</p>
					</div>
				</div>
				<div class="inquiry">
					<p class="date">2024/06/08</p>
					<h3>> 제품</h3>
					<h4>제품명</h4>
					<span>: 드레스룸 정품 조이해트백 조립식 설치완료제품</span>
					<h4>문의 제목</h4>
					<span>: 하하 배달가 안되어요</span>
					<h4>문의 내용</h4>
					<span>: 배송이 너무 느리고 바쁘고 힘들고 힘들이고 싶고 아주 힘들겠어요 아무 이유없어요 구입했죠?
						구입할거에요;;</span>
					<div class="inquiry1">

						<p>답변제목 : 어쩌구</p>
						<p>답변날짜 : 2024/06/18</p>

						<p>답변내용 : 오우 그러세요 ? ㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈ</p>
					</div>
				</div>
			</section>
		</main>
	</div>
	
</body>
</html>
