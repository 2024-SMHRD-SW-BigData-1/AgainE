package com.smhrd.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.Basket;
import com.smhrd.model.BasketDAO;
import com.smhrd.model.User;


public class BasketInsertService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("login_user");
		if(user == null) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
		}
		
		Long item_idx = Long.parseLong(request.getParameter("item_idx"));
		Long cnt = Long.parseLong(request.getParameter("cnt"));
		String user_id = user.getUser_id();
		
		LocalDateTime created_at = LocalDateTime.now();
		created_at = created_at.truncatedTo(ChronoUnit.SECONDS);
		
		// String user_id, Long item_idx, Long cnt, LocalDateTime created_at,
		// String basket_status
		Basket basket = new Basket(user_id, item_idx, cnt, created_at, "장바구니상태");  //
		BasketDAO dao = new BasketDAO();
		int cnt2 = dao.basketInsert(basket);
		
		if(cnt2 > 0) {
			System.out.println("장바구니 추가 성공");
			response.setStatus(HttpServletResponse.SC_OK);
		}else {
			System.out.println("장바구니 추가 실패");
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
		
	
	
	}

}
