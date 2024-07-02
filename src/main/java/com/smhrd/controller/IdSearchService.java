package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.UserDAO;


public class IdSearchService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("UTF-8");
	      String user_name = request.getParameter("user_name");
	      String user_email = request.getParameter("user_email");

	      System.out.println(user_name);
	      System.out.println(user_email);

	      UserDAO dao = new UserDAO();
	      String user_id = dao.findUserid(user_name, user_email);
	      // (null, null, user_name, user_email, null, null, null, null?)

	      System.out.println(user_id);

	      if (user_id != null) {
	         System.out.println(user_id);
	         // 아이디를 찾은 경우
	         // request.setAttribute("found_user_id", user_id);
	         Cookie cookie = new Cookie("found_user_id", user_id);
	         Cookie cookie2 = new Cookie("found_user_name", user_name);
	         cookie.setMaxAge(3600); // 쿠키 유효 시간 설정 (초 단위, 여기서는 1시간)
	         cookie2.setMaxAge(3600); // 쿠키 유효 시간 설정 (초 단위, 여기서는 1시간)
	         cookie.setPath("/"); // 쿠키의 유효 경로 설정 (모든 경로에서 유효하도록 설정)
	         cookie2.setPath("/"); // 쿠키의 유효 경로 설정 (모든 경로에서 유효하도록 설정)
	         response.addCookie(cookie); // 클라이언트에게 쿠키를 전송
	         response.addCookie(cookie2); // 클라이언트에게 쿠키를 전송
	         response.sendRedirect("html/search_id.jsp");
	      } else {
	         // 아이디 못 찾은 경우
	         response.sendRedirect("html/search_id.jsp?search_success=false");
	      }

	
	
	}

}
