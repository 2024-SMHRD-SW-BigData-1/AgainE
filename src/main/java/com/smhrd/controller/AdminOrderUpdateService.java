package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.OrderDAO;


public class AdminOrderUpdateService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		int orderIdx = Integer.parseInt(request.getParameter("order_idx"));
		String orderState = request.getParameter("order_state");

		OrderDAO dao = new OrderDAO();
		int result = dao.updateOrderState(orderIdx, orderState);

		HttpSession session = request.getSession();
		if (result > 0) {
			System.out.println("주문 상태 업데이트 성공");
			session.setAttribute("updateResult", "success");
		} else {
			System.out.println("주문 상태 업데이트 실패");
			session.setAttribute("updateResult", "failure");
		}

		// 세션에 설정된 값을 출력하여 확인
		System.out.println("Update Result Set in Session: " + session.getAttribute("updateResult"));

		response.sendRedirect("AODService?order_idx=" + orderIdx);
	
	
	
	
	
	
	}

}
