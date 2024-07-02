package com.smhrd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.OrderDetail;
import com.smhrd.model.OrderDetailDAO;


public class OrderDetailInsertService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		long order_idx = Long.parseLong(request.getParameter("order_idx"));
		long order_cnt = Long.parseLong(request.getParameter("order_cnt"));
		long item_idx = Long.parseLong(request.getParameter("item_idx"));
		long total_item = Long.parseLong(request.getParameter("total_item"));
		
		System.out.println("od 테이블에 넣을 order_idx : " + order_idx);
	
		OrderDetail od = new OrderDetail(order_idx, item_idx, order_cnt, total_item);
	
		OrderDetailDAO dao = new OrderDetailDAO();
		int cnt = dao.insertOrderDetail(od);
		
		ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
		
		// 응답 데이터 생성
        Map<String, Object> responseData = new HashMap<>();
	
		if(cnt>0) {
			System.out.println("주문상세 입력 성공");
			responseData.put("success", true);
		}else {
			System.out.println("주문상세 입력 실패");
			responseData.put("success", false);
		}
		
		// JSON 응답 전송
        String jsonResponse = mapper.writeValueAsString(responseData);
        response.getWriter().write(jsonResponse);
	
	
	}

}
