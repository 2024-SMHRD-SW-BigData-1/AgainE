package com.smhrd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.Basket;
import com.smhrd.model.BasketDAO;


public class BasketCntUpdateService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		Long basket_idx = Long.parseLong(request.getParameter("basket_idx"));
		Long cnt = Long.parseLong(request.getParameter("new_quantity"));
	
		Map<String, Long> basket_values = new HashMap<>();
		basket_values.put("basket_idx", basket_idx);
		basket_values.put("cnt", cnt);
	
		BasketDAO dao = new BasketDAO();
		int cnt2 = dao.basketUpdateCnt(basket_values);
		
		ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
	
		if(cnt2 > 0) {
			System.out.println("장바구니 수량 업데이트 성공");
			Basket basket = dao.basketSelectOne(basket_idx);
			
			if(basket != null) {
				System.out.println("업데이트된 장바구니 가져오기 성공");
		        response.getWriter().write(mapper.writeValueAsString(basket));
		        
			}else {
				System.out.println("업데이트된 장바구니 가져오기 실패");
				response.getWriter().write("{\"error\": \"업데이트된 장바구니 가져오기 실패.\"}");
			}
			
		}else {
			System.out.println("장바구니 수량 업데이트 실패");
			response.getWriter().write("{\"error\": \"장바구니 수량 업데이트 실패.\"}");
		}
	
	
	}

}
