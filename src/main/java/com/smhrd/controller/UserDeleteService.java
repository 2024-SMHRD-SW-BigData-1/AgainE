package com.smhrd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.User;
import com.smhrd.model.UserDAO;


public class UserDeleteService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("login_user");
		
		ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> responseData = new HashMap<>();
        
		if (user != null) {
            UserDAO userDao = new UserDAO();
            try {
            	  // UserDao에서 회원 정보 삭제 메서드 호출
            	int result = userDao.deleteUser(user.getUser_id()); // deleteUser 메서드는 회원 ID를 받아서 삭제하는 메서드
            	if(result>0) {
            		session.invalidate(); // 세션 무효화
            		responseData.put("success", true); // 회원 탈퇴 후 메인 페이지로 이동
            	}else {
                    System.out.println("서비스에서 회원탈퇴 실패1");
                    responseData.put("success", false); // 에러 페이지로 이동
            	}
            } catch (Exception e) {
            	System.out.println("서비스에서 회원탈퇴 실패2");
                e.printStackTrace();
                responseData.put("success", false); // 에러 페이지로 이동
            }
        } else {
            response.sendRedirect("html/login.jsp"); // 로그인되어 있지 않으면 메인 페이지로 이동
        }
		
		String jsonResponse = mapper.writeValueAsString(responseData);
        response.getWriter().write(jsonResponse);
		
	}

}
