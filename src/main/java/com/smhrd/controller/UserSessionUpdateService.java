package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.smhrd.model.User;


public class UserSessionUpdateService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        
        User user = mapper.readValue(request.getInputStream(), User.class);
        
        System.out.println(user.getUser_room_color());
		
        if(user != null) {
        	
        	HttpSession session = request.getSession();
        	session.setAttribute("login_user", user);
        	System.out.println("로그인 유저 세션 업데이트 성공");
        }
	
	
	}

}
