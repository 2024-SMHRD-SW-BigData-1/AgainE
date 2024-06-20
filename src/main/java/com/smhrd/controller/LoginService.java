package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.User;
import com.smhrd.model.UserDAO;


public class LoginService extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
	
		UserDAO dao = new UserDAO();
		
		
		User user = dao.loginUser(new User(user_id, user_pw, null, null, null, null, null, null));
		
		if(user != null) {
			if(user.getUser_type().equals("f") || user.getUser_type().equals("t"))
			System.out.println("로그인 성공");
			HttpSession session = request.getSession();
			session.setAttribute("login_user", user);
			response.sendRedirect("html/index.jsp");
		}else {
			response.sendRedirect("html/login.jsp?login_success=false");
			System.out.println("로그인 실패2");
		}
		
		
		
	}

}
