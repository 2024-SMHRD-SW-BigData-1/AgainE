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



public class AdminOrderDetailService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int orderIdx = Integer.parseInt(request.getParameter("order_idx"));

		OrderDetailDAO dao = new OrderDetailDAO();
		List<HashMap<String, Object>> orderDetails = dao.adminOrderDetails(orderIdx);

		HttpSession session = request.getSession();
		session.setAttribute("orderDetails", orderDetails);

		// 세션에 데이터가 제대로 저장되었는지 디버깅
		if (orderDetails == null) {
			System.out.println("제품상세내역 없음");
		} else {
			System.out.println("제품상세내역사이즈: " + orderDetails.size());
		}

		// 세션에 설정된 값을 출력하여 확인
		System.out.println("Update Result in AODService: " + session.getAttribute("updateResult"));

		response.sendRedirect("html/admin_order_detail.jsp");
	
	
	
	
	
	
	
	
	
	
	}

}
