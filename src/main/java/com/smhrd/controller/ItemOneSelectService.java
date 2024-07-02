package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.Item;
import com.smhrd.model.ItemDAO;


public class ItemOneSelectService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int item_idx = Integer.parseInt(request.getParameter("item_idx"));
	
		// System.out.println("클릭된 가구의 id :" + item_idx);
		
		ItemDAO dao = new ItemDAO();
		Item item = dao.selectOneItem(item_idx);
		
		ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
	
		if(item != null) {
			System.out.println("가구 한개 선택 성공");
            System.out.println("선택된거: " + item.getItem_idx());
            response.getWriter().write(mapper.writeValueAsString(item));
			
		}else {
			System.out.println("가구 한개 선택 실패");
            response.getWriter().write("{\"error\": \"아이템 한 개 선택 실패.\"}");
		}
	
	}

}
