package com.smhrd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.OrderDetailDAO;
import com.smhrd.model.User;


public class OrderService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("주문처리현황서비스 실행");

		// 세션에서 사용자 id 가져오기
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("login_user");
		String user_id = user.getUser_id();

		System.out.println("아이디 확인");

		if (user_id != null) {
			OrderDetailDAO detailDao = new OrderDetailDAO();
	        List<HashMap<String, Object>> orderDetailCounts = detailDao.orderDetailCount(user_id);
	        List<HashMap<String, Object>> orderDetails = detailDao.orderDetail(user_id);
	        System.out.println("주문상세내역개수 : " + orderDetailCounts);
			System.out.println("주문상세내역 : " + orderDetails);

			session.setAttribute("orderDetailCounts", orderDetailCounts);
			session.setAttribute("orderDetails", orderDetails);
			
			response.sendRedirect("html/user_orderlist.jsp");
			
		} else {
			// 로그인되지 않은경우
			System.out.println("로그인no");
			response.sendRedirect("html/login.jsp");
		}
	
	
	
	
	
	}

}
