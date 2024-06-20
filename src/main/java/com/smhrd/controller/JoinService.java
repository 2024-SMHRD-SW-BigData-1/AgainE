package com.smhrd.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.User;
import com.smhrd.model.UserDAO;


public class JoinService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String user_email = request.getParameter("user_email");
		String user_name = request.getParameter("user_name");
		String user_phone = request.getParameter("user_phone");
		String user_addr = request.getParameter("user_addr");
		
		LocalDateTime joined_at = LocalDateTime.now();
		joined_at = joined_at.truncatedTo(ChronoUnit.SECONDS);
        
		String user_type = "f";
		if(user_id.equals("admin")) {
			user_type = "a";
		}
	
        System.out.println(joined_at);
        
        
        
		User user = new User(user_id, user_pw, user_name, user_email, user_phone, user_addr, joined_at, user_type);
		
		UserDAO dao = new UserDAO();
		int cnt = dao.joinUser(user);
		
		
		if(cnt>0) {
			System.out.println("회원가입 성공");
			response.sendRedirect("html/index.jsp?join_success=true");
		}else {
			System.out.println("회원가입 실패3");
			response.sendRedirect("html/join.jsp?join_success=false");
		}
	
	
	}

}
