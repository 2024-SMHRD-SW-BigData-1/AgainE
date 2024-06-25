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


public class ItemAllSelectService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ItemDAO dao =  new ItemDAO();
		List<Item> items =  dao.selectAllItem();
		
		if(items != null) {
			JSONObject jsonResponse = new JSONObject();
	        jsonResponse.put("items", items);
	        response.setContentType("application/json"); // 응답의 Content-Type을 JSON으로 설정
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(jsonResponse.toString()); // JSON 응답을 작성
		}else {
			System.out.println("가구 전체 조회 실패 333");
			JSONObject jsonResponse = new JSONObject();
		    jsonResponse.put("error", "가구 전체 조회 실패요");
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(jsonResponse.toString());
		}
	}

}
