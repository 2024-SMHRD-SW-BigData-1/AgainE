package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.User;
import com.smhrd.model.UserDAO;


public class UserUpdateService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("3333");
		request.setCharacterEncoding("UTF-8");

		// 세션에서 user_id 가져오기
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("login_user");
		if (user == null) {
			System.out.println("세션에서 id를 가져오지 못했습니다.");
			response.sendRedirect("html/mypage.jsp");
			return;
		}

		String user_pw = request.getParameter("update_pw");
		String user_name = request.getParameter("update_name");
		String user_phone = request.getParameter("update_phone");
		String user_addr = request.getParameter("update_addr");
		String user_email = request.getParameter("update_email");


		// 사용자 객체 생성 및 필드 설정
		user.setUser_id(user.getUser_id());
		user.setUser_pw(user_pw);
		user.setUser_name(user_name);
		user.setUser_email(user_email);
		user.setUser_phone(user_phone);
		user.setUser_addr(user_addr);
		
		System.out.println("3333");
		
		UserDAO dao = new UserDAO();
		int cnt = dao.updateUser(user);

		if (cnt > 0) {
			System.out.println("회원정보 업데이트 성공");
			session.setAttribute("login_user", user);
			response.sendRedirect("html/user_update.jsp?update_success=true");
			
			
		} else {
			System.out.println("방 사진 업데이트 실패");
			response.sendRedirect("html/user_update.jsp?update_success=false");
		}
	
	
	
	
	}

}
