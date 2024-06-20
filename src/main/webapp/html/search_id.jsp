<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ID찾기</title>
    <link rel="stylesheet" href="/nitro/로그인/로그인.css">
</head>
<style>
.container{
    margin-top: 100px;
}
a{
display: block;
text-align: center;
color: black;

margin-bottom: 50px;
margin-top: 50px;
}
span{
font-size: 30px;

}
h4{
    text-align: right;
}
.user_id{
    font-size: medium;
    margin-left: 30px;
    background-color: rgb(221, 218, 213);
    padding: 5px;
    color: blue;
    font-weight: 600;
}
</style>
<body>

    <!-- 찾기 전  -->
     <!-- 메인페이지  -->
  <h1 class = log_size><a style=" text-decoration: none; color: #000000;" href="#">ColorSpace</a></h1>
  <div class="container">
      <h2>아이디 찾기</h2>
      <div class="form-group">
          <label for="name">이름</label>
          
          <input type="text" id="name" name ="name" placeholder="이름을 입력하세요">
          
          
      <div class="form-group">
          <label for="email">이메일</label>
          <input type="email" id="email" name="email" placeholder="이메일을 입력하세요">
      </div>
     
      <div class="form-group">
          <button type="submit">아이디 찾기</button>
      </div>
    
      </div>
</div>
      <!-- 찾은 후  -->


     
      <div class="container">
        <!-- 메인페이지  -->
          <h1><a style=" text-decoration: none; color: #000000;" href="#">ColorSpace</a></h1>
          <div class="form-group">
              <span>아이디 :</span>
              
              
<!-- 아이디 찾아서 이쪽에 -->
              <span class="user_id"> 찾은 아이디 보여주는 곳 </span>
           
              <br>

              <a href="/nitro/로그인/비밀번호찾기.html"> 비밀번호 찾기 </a>
         
         
          <div class="form-group">
              <button type="submit">로그인 하기 </button>
          </div>
          
          <div>
            <h4>로그인 화면으로 이동합니다.</h4>
            
          </div>
        
          </div>
      </div>
      
      
</body>
</html>