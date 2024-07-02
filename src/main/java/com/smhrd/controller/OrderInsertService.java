package com.smhrd.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.Order;
import com.smhrd.model.OrderDAO;
import com.smhrd.model.User;


public class OrderInsertService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		// session 불러오기
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("login_user");
		String user_id = user.getUser_id();
		
		// 결제 타입
		String option = request.getParameter("option");
		String pay_method = null;
		String cardType = request.getParameter("cardType");
		if(option.equals("1")) {
			pay_method = "무통장입금";
		}else if(option.equals("2")) {
			pay_method = "카드" + cardType;
		}
		
		
        // 주문 총액
		System.out.println("payTotalPrice"+request.getParameter("payTotalPrice"));
        Integer payTotalPrice = Integer.parseInt(request.getParameter("payTotalPrice"));
        
        // 주문 상태 디폴트값
        String order_state = "배송준비중";
        
        LocalDateTime ordered_at = LocalDateTime.now();
        ordered_at = ordered_at.truncatedTo(ChronoUnit.SECONDS);

        // 각 파라미터를 처리
//        System.out.println("결제 수단: " + option);
//        System.out.println("카드 타입: " + cardType);
//        System.out.println("총 결제 금액: " + payTotalPrice);
	
        Order order = new Order(payTotalPrice, pay_method, user_id, ordered_at, order_state);
        OrderDAO dao = new OrderDAO();
        Order resultOrder = new Order();
        resultOrder = dao.insertOrder(order);
        
        ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
	
        
        if(resultOrder != null) {
        	System.out.println("order테이블에 들어간 데이터의 order_idx : " + resultOrder.getOrder_idx());
        	Long order_idx = resultOrder.getOrder_idx();
        	response.getWriter().write(mapper.writeValueAsString(order_idx));
        }else {
        	System.out.println("resultOrder 불러오기 실패");
        	 response.getWriter().write("{\"error\": \"resultOrder 가져오기 실패.\"}");
        }
	
	
	}

}
