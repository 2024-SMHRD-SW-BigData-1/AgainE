package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.smhrd.model.Item;
import com.smhrd.model.ItemDAO;


public class ItemColorSelectService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String color = request.getParameter("color");
	
		System.out.println("컬러"+color);
		
		ItemDAO dao =  new ItemDAO();
		List<Item> items =  dao.selectColorItem(color);
		
		if(items != null) {
			System.out.println("컬러 조회 성공");
			System.out.println("컬러ㄴ"+items.get(0).getItem_color());
			JSONObject jsonResponse = new JSONObject();
	        jsonResponse.put("items", items);
	        response.setContentType("application/json"); // 응답의 Content-Type을 JSON으로 설정
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(jsonResponse.toString()); // JSON 응답을 작성
		}else {
			System.out.println("컬러 조회 실패 333");
			JSONObject jsonResponse = new JSONObject();
		    jsonResponse.put("error", "해당 카테고리에 대한 아이템이 없습니다.");
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(jsonResponse.toString());
		}
	
		
	}

}
