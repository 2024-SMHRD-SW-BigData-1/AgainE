package com.smhrd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.smhrd.model.Item;
import com.smhrd.model.ItemDAO;
import com.smhrd.model.User;


public class ItemRecommendTwoOptionService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String category = request.getParameter("category");
		String recommend = request.getParameter("recommend");
		String type1 = "tone-on-tone";
		String type2 = "tone-in-tone";
		
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("login_user");
		String user_room_color = user.getUser_room_color();
		String user_room_tone = user.getUser_room_tone();
		
		System.out.println("투옵션 추천"+category);
		System.out.println("투옵션 추천"+recommend);
		System.out.println("투옵션 추천"+user_room_color);
		System.out.println("투옵션 추천"+user_room_tone);
		
		
		
		
		
		
		if(recommend.equals(type1)) { 													// 톤온톤
			ItemDAO dao = new ItemDAO();
			Map<String, String> options = new HashMap<>();
	        options.put("category", category);
	        options.put("color", user_room_color );
	        List<Item> items =  dao.selectToneOnToneCategoryItem(options);
	        
	        if(items != null) {
				System.out.println("투옵션추천 서비스 실행 성공1");
				JSONObject jsonResponse = new JSONObject();
		        jsonResponse.put("items", items);
		        response.setContentType("application/json"); 
		        response.setCharacterEncoding("UTF-8");
		        response.getWriter().write(jsonResponse.toString()); 
		        
			}else {
				System.out.println("투옵션추천 서비스 실패 111");
				JSONObject jsonResponse = new JSONObject();
			    jsonResponse.put("error", "해당 카테고리에 대한 아이템이 없습니다.");
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(jsonResponse.toString());
			}
			
		}else if(recommend.equals(type2)){				//톤인톤
			ItemDAO dao = new ItemDAO();
			Map<String, String> options = new HashMap<>();
			options.put("category", category);
	        options.put("tone", user_room_tone );
	        List<Item> items =  dao.selectToneInToneCategoryItem(options);
	        
	        if(items != null) {
				System.out.println("투옵션추천 서비스 실행 성공2");
				JSONObject jsonResponse = new JSONObject();
		        jsonResponse.put("items", items);
		        response.setContentType("application/json"); 
		        response.setCharacterEncoding("UTF-8");
		        response.getWriter().write(jsonResponse.toString()); 	
		        
			}else {
				System.out.println("투옵션추천 서비스 실패 222");
				JSONObject jsonResponse = new JSONObject();
			    jsonResponse.put("error", "해당 카테고리에 대한 아이템이 없습니다.");
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(jsonResponse.toString());
			}
	        
		}
		
	
	}

}
