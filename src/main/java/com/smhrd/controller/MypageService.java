package com.smhrd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.OrderDetailDAO;
import com.smhrd.model.User;


public class MypageService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		System.out.println("마이페이지서비스실행");
		
		// 세션에서 사용자 id 가져오기
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("login_user");
		String user_id = user.getUser_id();
		
		System.out.println("세션에 저장된 아이디: " + user_id);

		if (user_id != null) {
			OrderDetailDAO detialDAO = new OrderDetailDAO();
			BoardDAO boardDAO = new BoardDAO();
			List<HashMap<String, Object>> orderDetailCounts = detialDAO.orderDetailCount(user_id);
			List<HashMap<String, Object>> orderDetails = detialDAO.orderDetail(user_id);
			List<HashMap<String, Object>> boardDetails = boardDAO.boardDetail(user_id);
			
			System.out.println("갯수알려줌 : " + orderDetailCounts);
			System.out.println("내역알려줌 : " + orderDetails);
			System.out.println("문의알려줌 : " + boardDetails);
			
			session.setAttribute("orderDetailCounts", orderDetailCounts);
			session.setAttribute("orderDetails", orderDetails);
			session.setAttribute("boardDetails", boardDetails);
			
			response.sendRedirect("html/mypage.jsp");
		} else {
			// 로그인되지 않은 경우 로그인 페이지로 리다이렉트
			System.out.println("로그인안됨");
			response.sendRedirect("html/login.jsp");
		}
	
	
	
	
	}

}
