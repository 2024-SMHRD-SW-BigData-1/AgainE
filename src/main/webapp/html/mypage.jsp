<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.datatype.jsr310.JavaTimeModule" %>
<%@page import="com.smhrd.model.User"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("login_user");
	if (user == null) {
	    response.sendRedirect("login.jsp");
	    return; // 리디렉션 후 나머지 코드 실행 방지
	}
	List<HashMap<String, Object>> orderDetailCounts = (List<HashMap<String, Object>>) session.getAttribute("orderDetailCounts");
	List<HashMap<String, Object>> orderDetails = (List<HashMap<String, Object>>) session.getAttribute("orderDetails");
	List<HashMap<String, Object>> boardDetails = (List<HashMap<String, Object>>) session.getAttribute("boardDetails");
    
    System.out.println(user.getUser_room_color());
    System.out.println(user.getUser_room_tone());
    System.out.println(user.getUser_room_url());
    
    // Assuming you have a UserDTO object in the session
    ObjectMapper mapper = new ObjectMapper();
    mapper.registerModule(new JavaTimeModule());  // JavaTimeModule 등록
    String loginUserJson = mapper.writeValueAsString(user);
   // System.out.println(loginUserJson);
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
    z-index: 1000; /* 다른 요소 위에 표시되도록 */
}

.spinner-overlay img {
    max-width: 100px; /* 이미지의 최대 너비 */
    max-height: 100px; /* 이미지의 최대 높이 */
    object-fit: contain; /* 이미지 비율을 유지하며 맞추기 */
}

</style>
 



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="../js/mypage.js"></script>
    <script type="text/javascript" src="../js/delete_cookie.js"></script>
</head>




<body>
	<div id="loading-spinner" class="spinner-overlay" style="display: none;">
	    <p><img src="../images/Loading_icon.gif" alt="로딩 중..."></p>
	    <br>
	    <p style="color:white">방 사진을 분석중입니다...     </p>
	    <br>
	    <p style="color:white">네트워크 상태에 따라 오래 걸릴 수 있습니다.</p>
	</div>
	<div class="container">
	<header>
        <div class="fh5co-heading animate-box" data-animate-effect="fadeInLeft">
            <h2 style="display: inline-block; margin-right: 20px;">
                <a href="index.jsp" style="text-decoration: none; color: #000000;">ColorSpace</a>
            </h2>

			<div class="log">
				<a href="../logout" style="color:grey">로그아웃</a>
				<a> | </a> 
				<i><a href="../MypageService">mypage</a></i>
				<a> | </a> 
				<a href="user_board.jsp" style="color:grey">문의하기</a>
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
			
			<!-- ----------------------------------------------------------------------------------------------------------- -->
			<section class="order-status">
				<h2><a href="../OrderService">주문처리현황</a></h2>
				<%
				if (orderDetailCounts != null) {
					if (!orderDetailCounts.isEmpty()) {
						System.out.println("orderDetailCounts" + orderDetailCounts);
				%>
				<div class="status-details">
					<div class="status-item">
						<a href="../OrderService"> <span class="status-label">배송준비중</span></a>
						<a href="../OrderService"> <span class="status-value">
						<%	int countPreparing = 0;
							for (HashMap<String, Object> detailCount : orderDetailCounts) {
								String orderState = (String) detailCount.get("orderState");
								long detailCountValue = (long) detailCount.get("detailCount");
								if ("배송준비중".equals(orderState)) {
									countPreparing += detailCountValue;
								}
							}
							out.print(countPreparing);
							%>
							</span></a>
					</div>
					<div class="status-item">
						<a href="../OrderService"><span class="status-label">배송중</span></a>
						<a href="../OrderService"><span class="status-value">
						<%	int countShipping = 0;
							for (HashMap<String, Object> detailCount : orderDetailCounts) {
								String orderState = (String) detailCount.get("orderState");
								long detailCountValue = (long) detailCount.get("detailCount");
								if ("배송중".equals(orderState)) {
									countShipping += detailCountValue;
								}
							}
							out.print(countShipping);
							%>
							</span></a>
					</div>
					<div class="status-item">
						<a href="../OrderService"><span class="status-label">배송완료</span></a>
						<a href="../OrderService"><span class="status-value">
						<%	int countCompleted = 0;
							for (HashMap<String, Object> detailCount : orderDetailCounts) {
								String orderState = (String) detailCount.get("orderState");
								long detailCountValue = (long) detailCount.get("detailCount");
								if ("배송완료".equals(orderState)) {
									countCompleted += detailCountValue;
								}
							}
							out.print(countCompleted);
							%>
							</span></a>
					</div>
					<%
					} else {
					out.print("주문 내역이 없습니다.");
					}
					} else {
					out.print("주문 내역이 없습니다.");
					}
					%>
					
				</div>
				</section>
				
				<!-- ----------------------------------------------------------------------------------------------------------- -->
				
				<div class="container">
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
						</div>
					</form>
				

			<% if(user.getUser_type().equals("f")){ %>  		<!-- 아직 방사진 올린 기록 없을 때 -->
			<section class="analysis-result" id="user-type-f" style="display:none;">
				<h2>분석 결과</h2>
				<div class="result-details">
					<div class="result-box">
						<div class="corner"></div>
						<img alt="파일을 찾을 수 없습니다" src="../user_room_img/<%=user.getUser_room_url() %>" class="img-responsive">
						<p>색 : <%=user.getUser_room_color() %></p>
						<p>톤 : <%=user.getUser_room_tone() %></p>
					</div>
				</div>
			</section>
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
			</section>
			<%} %>

			
			</div>
			<!-- ----------------------------------------------------------------------------------------------------------- -->
			
			<div class="container">
			<section class="inquiries">
				<h2>문의내용</h2>
				
				<% if (boardDetails != null && !boardDetails.isEmpty()) {
                   	  for (HashMap<String, Object> boardDetail : boardDetails) { %>
				
				<div class="inquiry">
					<p class="date">   <!-- 문의 날짜 -->
						<%     
								Timestamp timestamp = (Timestamp) boardDetail.get("created_at");
	                            if (timestamp != null) {
	                                LocalDate createdAt = timestamp.toLocalDateTime().toLocalDate();
	                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	                                String boardDate = createdAt.format(formatter);
	                                out.print(boardDate);
	                            } else {
	                                out.print("날짜 없음");
	                            }
                     	  %>
                     	  </p>
					<h3><%= boardDetail.get("b_category") %></h3>
					<h4>[문의 제목]</h4>  <!-- 문의 제목 -->
					<span><%= boardDetail.get("b_title") %></span>
					<h4>[문의 내용]</h4>  <!-- 문의 내용 -->
					<p>
					<% String fileName = (String) boardDetail.get("b_file");
										System.out.println(fileName);
									   if (fileName != null) {
										   String filePath = "../board/" + fileName;%>
                     	            <img src="<%= filePath %>" alt="첨부 이미지" style="max-width: 100%; height: auto;">
                        			<% } else {
                               				out.print("첨부 파일 없음"); } %>
                     </p>
					<span><%= boardDetail.get("b_content") %></span>

					<div class="inquiry1">   <!-- 관리자의 답변  -->
						<p>답변</p>
						<% if ("f".equals(boardDetail.get("b_status"))) { %>
								<p>답변이 아직 달리지 않았습니다.</p>
							<% } else { %>
	                            <p>제목 : <%= boardDetail.get("rep_title") %></p>
					            <p>내용 : <%= boardDetail.get("rep_content") %></p>
	                            <p>첨부파일 : <img alt="이미지가 없습니다." 
	                            			src="../reply/<%= boardDetail.get("rep_file") != null ? boardDetail.get("rep_file") : "" %>"
	                            			width="200" height="150"></p> 
	                            <p>작성날짜 : 
									        <% 
									            Timestamp timestamp2 = (Timestamp) boardDetail.get("replied_at");
									            if (timestamp2 != null) {
									                LocalDate repliedAt = timestamp2.toLocalDateTime().toLocalDate();
									                DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy/MM/dd");
									                String boardDate = repliedAt.format(formatter2);
									                out.print(boardDate);
									            } else {
									                out.print("날짜 없음");
									            }
									        %>
									    </p>
									<% } %>
					</div>
				</div>
				
				<% }} else { %>
                <p>문의 내용이 없습니다.</p>
            <% } %>
			</section>
			</div>
		</main>
	</div>
	
	<!-- ----------------------------------------------------------------------------------------------------------- -->
	
</body>
</html>
