package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.User;
import com.smhrd.model.UserDAO;


public class PwUpdateService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		Cookie[] cookies = request.getCookies();
		
		String targetCookiePw = "found_user_pw";  
		String targetCookieId = "target_id";
		String found_user_pw = null;
	    String target_id = null;
		
		// 쿠키가 있는지 확인
		if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals(targetCookiePw)) {
	            	found_user_pw = cookie.getValue();
	          }
	            if (cookie.getName().equals(targetCookieId)) {
	            	target_id = cookie.getValue();
	          }
	       }
	    }
		
	      //String user_id = request.getParameter("user_id");
	      String user_id = target_id;
	      System.out.println(user_id);
	      String user_pw = request.getParameter("new_password");
	      
	      System.out.println(user_pw);
	      
	      User user = new User(user_id, user_pw, null, null, null, null, null, null);   
	      
	      UserDAO dao = new UserDAO();
	      int cnt = dao.updatePw(user);
	      
	      if(cnt > 0) {
	         System.out.println("비번 변경 성공");
	         response.sendRedirect("html/search_pw.jsp?update_success=true");
	      }else {
	         System.out.println("비번 변경 실패");
	         response.sendRedirect("html/search_pw.jsp?update_success=false");
	      }
	      
	     

	
	
	
	
	}

}
