<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.ItemDAO"%>
<%@page import="com.smhrd.model.Item"%>
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
System.out.println("여여ㅑ여");
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
@
keyframes float { 0%, 100% {transform: translateY(0);} 50%{transform:translateY(-15px);}}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>

<body>
      <div id="fh5co-main">
      <div class="fh5co-narrow-content">
         <!-- a 태그 안에 로그인전 , 후  다르게 페이지가 이동 되어야함 index or index_main -->
         <h2 class="fh5co-heading animate-box"
            data-animate-effect="fadeInLeft">
            <a style="text-decoration: none; color: #000000;"
               href="admin.jsp">ColorSpace</a>
         </h2>

         <div class="log">
            <i class="fa fa-love"></i><a href="../AdminItemListService">제품수정/추가</a> <a>|</a> <i
               class="fa fa-love"><a href="../AdminOrderService">주문내역</a></i> <a>|</a> <i
               class="fa fa-love"></i><a href="admin_board.jsp">문의내역</a> <a>|</a> <i
               class="fa fa-love"></i><a href="../logout">로그아웃</a>
         </div>
      </div>
      <div class="line" style="margin-top: 0;"></div>


 <div class="t_con">
        
                <form action="../AdminItemInsertService" method="post" enctype="multipart/form-data">
                <table>
                    <thead>
                        <tr >
                            <th></th>
                            <th>추가</th>
             
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>카테고리</td>
                            <td>

                                <select id="inquiryType" class="custom-select" name="item_category" required>
                                	<option value="" disabled selected>카테고리 선택</option>
                                    <option value="침대">침대</option>
                                    <option value="쇼파">쇼파</option>
                                    <option value="서랍">서랍</option>
                                    <option value="옷장">옷장</option>
                                    <option value="의자">의자</option>
                                    <option value="식탁">식탁</option>
                                    <option value="책상">책상</option>
                                    <option value="책장">책장</option>
                                </select>

                            </td>
                        </tr>
                        <tr>
                            <td>제품명</td>
                            <td>
                                <input type="text"  name="item_name" required>
                            </td>
                        </tr>
                        <tr>
                           
                            <td>이미지</td>
                            <td>
                                <input type="file" name="item_url" class="f" required>
                               
                            </td>
                           
                        </tr>
                        <tr>
                            <td>톤</td>
                            <td>
                            <select id="inquiryType" class="custom-select" name="item_tone" required>
                            		<option value="" disabled selected>톤 선택</option>
                                    <option value="비비드">비비드</option>
                                    <option value="스트롱">스트롱</option>
                                    <option value="딥">딥</option>
                                    <option value="라이트">라이트</option>
                                    <option value="소프트">소프트</option>
                                    <option value="페일">페일</option>
                                    <option value="다크">다크</option>
                                    <option value="덜">덜</option>
                                </select>
                                </td>
                          
                        </tr>
                        <tr>
                            <td>컬러</td>
                            <td>
                            <select id="inquiryType" class="custom-select" name="item_color" required>
                            		<option value="" disabled selected>색 선택</option>
                                    <option value="레드">레드</option>
                                    <option value="오렌지">오렌지</option>
                                    <option value="옐로우">옐로우</option>
                                    <option value="그린">그린</option>
                                    <option value="라이트블루">라이트블루</option>
                                    <option value="네이비">네이비</option>
                                    <option value="퍼플">퍼플</option>
                                    <option value="핑크">핑크</option>
                                    <option value="베이지">베이지</option>
                                    <option value="브라운">브라운</option>
                                    <option value="그레이">그레이</option>
                                    <option value="화이트">화이트</option>
                                    <option value="블랙">블랙</option>
                                </select>
                            </td>
                           
                        </tr>
                        <tr>
                           
                            <td>설명</td>
                            <td>
                                <input  class="ex" name="item_info" type="text" placeholder="간단설명 , 사이즈 작성">
                            </td>
                           
                        </tr>
                        <tr>
                           
                            <td>가격</td>
                            <td>
                                <input type="text" name="item_price" placeholder="숫자로만 작성" required>
                            </td>
                           
                        </tr>

                    </tbody>
                </table>
                <div class="sw-btn-container">
                    <button type="submit" class="sw-btn">추가 하기</button>
                </div>
                </form>
            </div>
            </div>
            </body>
            </html>
            