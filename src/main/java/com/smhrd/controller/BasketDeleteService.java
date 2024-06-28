package com.smhrd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.BasketDAO;


public class BasketDeleteService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	
		Long basket_id = Long.parseLong(request.getParameter("basket_idx"));
	
		BasketDAO dao = new BasketDAO();
		int cnt = dao.basketDelete(basket_id);
	
		ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
		
     // 응답 데이터 생성
        Map<String, Object> responseData = new HashMap<>();
        if(cnt > 0) {
            responseData.put("success", true);
            System.out.println("장바구니 삭제 성공");
        } else {
            responseData.put("success", false);
            System.out.println("장바구니 삭제 실패");
        }

        // JSON 응답 전송
        String jsonResponse = mapper.writeValueAsString(responseData);
        response.getWriter().write(jsonResponse);
	
	
	}

}
