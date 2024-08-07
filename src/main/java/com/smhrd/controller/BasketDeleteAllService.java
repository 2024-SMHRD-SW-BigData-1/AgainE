package com.smhrd.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.BasketDAO;
import com.smhrd.model.User;


public class BasketDeleteAllService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/*
		 * String[] basketIdxListStr = request.getParameterValues("basket_idx_list");
		 * 
		 * int[] basketIdxList = null;
		 * 
		 * if (basketIdxListStr != null) { basketIdxList =
		 * Arrays.stream(basketIdxListStr) .mapToInt(Integer::parseInt) .toArray(); }
		 */
	
		
		/*
		 * for (int basketIdx : basketIdxList) {
		 * System.out.println("Deleting item with ID: " + basketIdx); }
		 */
	
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("login_user");
		
		BasketDAO dao = new BasketDAO();
		int cnt = dao.afterPayBasketDelete(user.getUser_id());
		
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
