package com.smhrd.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.OrderDAO;
import com.smhrd.model.User;


public class AdminOrderService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("관리자주문내역페이지서비스실행");

        // 세션에서 사용자 id 가져오기
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("login_user");
        String user_id = user.getUser_id();

        System.out.println("세션에 저장된 아이디: " + user_id);

        if (user_id != null) {
            OrderDAO dao = new OrderDAO();
            List<HashMap<String, Object>> adminOrders = dao.adminOrder(user_id);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            for (HashMap<String, Object> order : adminOrders) {
                LocalDateTime orderedAt = (LocalDateTime) order.get("ordered_at");
                String formattedDate = orderedAt.format(formatter);
                order.put("ordered_at", formattedDate);
            }
            
            System.out.println("전체주문내역 : " + adminOrders);
            session.setAttribute("adminOrders", adminOrders); // 속성 이름을 adminOrders로 설정

            response.sendRedirect("html/admin_orderlist.jsp");
        } else {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            System.out.println("로그인안됨");
            response.sendRedirect("html/login.jsp");
        }
	
	
	}

}
