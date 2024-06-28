package com.smhrd.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.Basket;
import com.smhrd.model.BasketDAO;
import com.smhrd.model.User;


public class BasketSelectService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		HttpSession session =  request.getSession();
		User user = (User)session.getAttribute("login_user");
	
		if(user == null) {
			response.sendRedirect("html/login.jsp");
			return;
		}else {
		
		String user_id = user.getUser_id();
		System.out.println("장바구니 페이지 들어온 id : " + user_id);
		BasketDAO dao = new BasketDAO();
		List<Basket> baskets = dao.basketSelectAll(user_id);
		
		
		ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
		
		if(baskets == null) {			
			baskets = new ArrayList<>(); // 빈 리스트로 초기화
		}

		System.out.println("전체 장바구니 가져오기 성공");
        response.getWriter().write(mapper.writeValueAsString(baskets));
		
		
		}
	
	}

}
