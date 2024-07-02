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


public class PwSearchService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	      String user_id = request.getParameter("user_id");
	      String user_phone = request.getParameter("user_phone");
	      String user_email = request.getParameter("user_email");

	      System.out.println(user_id);
	      System.out.println(user_phone);
	      System.out.println(user_email);

	      User user = new User(user_id, null, null, user_email, user_phone, null, null, null);
	      
	      UserDAO dao = new UserDAO();
	      User user2 = dao.findUserpw(user);
	   
	      String found_user_pw = user2.getUser_pw();
	      
	      System.out.println(found_user_pw);

	      // HttpSession session = request.getSession();

	      if (found_user_pw != null) {
	         System.out.println(found_user_pw);
	         // 비밀번호를 찾은 경우
	         //session.setAttribute("found_user_pw", found_user_pw);
	         //session.setAttribute("target_id", user_id);
	         
	         Cookie cookie = new Cookie("found_user_pw", found_user_pw);
	         Cookie cookie2 = new Cookie("target_id", user_id);
	         cookie.setMaxAge(3600); // 쿠키 유효 시간 설정 (초 단위, 여기서는 1시간)
	         cookie2.setMaxAge(3600); // 쿠키 유효 시간 설정 (초 단위, 여기서는 1시간)
	         cookie.setPath("/"); // 쿠키의 유효 경로 설정 (모든 경로에서 유효하도록 설정)
	         cookie2.setPath("/"); // 쿠키의 유효 경로 설정 (모든 경로에서 유효하도록 설정)
	         response.addCookie(cookie); // 클라이언트에게 쿠키를 전송
	         response.addCookie(cookie2); // 클라이언트에게 쿠키를 전송
	         response.sendRedirect("html/search_pw.jsp");
	      } else {
	         // 비밀번호 못 찾은 경우
	         response.sendRedirect("html/search_pw.jsp?search_success=false");
	      }

	
	
	
	
	}

}
