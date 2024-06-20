<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
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

</style>
<body>

    <!-- 찾기 전  -->
     <!-- 메인페이지 이동  -->
  <h1 class = log_size><a style=" text-decoration: none; color: #000000;" href="#">ColorSpace</a></h1>
  <div class="container">
      <h2>비밀번호 찾기</h2>
      <div class="form-group">
        <label for="userid" class="id_over" >아이디</label>
             
        <input type="text" id="userid" name="userid" placeholder="아이디를 입력하세요">
          
        <div>
          <label for="phone">전화번호</label>
          <input type="tel" id="phone" name="phone" placeholder="전화번호를 입력하세요">
      </div>
          
      <div class="form-group">
          <label for="email">이메일</label>
          <input type="email" id="email" name="email" placeholder="이메일을 입력하세요">
      </div>
     

      <div class="form-group">
          <button type="submit">비밀번호 찾기</button>
      </div>
    
      </div>
</div>

      <!-- 찾은 후  -->


      <!-- 메인 페이지 이동  -->
      <h1 class = log_size><a style=" text-decoration: none; color: #000000;" href="#">ColorSpace</a></h1>
      <div class="container">
          <h2>새 비밀번호를 설정하세요 </h2>
          <div class="form-group">
            <label for="password">새 비밀번호</label>
            <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요 ">
       
        <div class="form-group">
            <label for="password">비밀번호 확인 </label>
            <input type="password" id="password-check" name="password-check" placeholder="비밀번호를 다시 입력하세요">
        </div>
    
          <div class="form-group">
              <button type="submit">비밀번호 변경하기</button>
          </div>
        
          
        </div>
        <div>
          <h4>로그인 화면으로 이동합니다.</h4>
          
        </div>
    </div>
      
      
</body>
</html>