package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.smhrd.model.Item;
import com.smhrd.model.ItemDAO;
import com.smhrd.model.User;


public class ItemRecommendService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("login_user");
		
		String recommend = request.getParameter("recommend"); // 추천방식 저장
		String type1 = "tone-on-tone";
		String type2 = "tone-in-tone";
		
		String user_room_color = user.getUser_room_color();  // 유저 방 color 저장
		System.out.println("추천"+user_room_color);
		String user_room_tone = user.getUser_room_tone();	// 유저 방 tone 저장
		System.out.println("추천"+user_room_tone);
		
		System.out.println("recommend type : " + recommend);
		System.out.println("로그인 된 유저 : " + user.getUser_id());
		
		ItemDAO dao = new ItemDAO();
		if(recommend.equals(type1)) {    // 톤온톤 : 동일한 color
			List<Item> items = dao.selectToneOnToneItem(user_room_color);
			
			if(items != null) {
				System.out.println("추천 서비스 실행 성공1");
				JSONObject jsonResponse = new JSONObject();
		        jsonResponse.put("items", items);
		        response.setContentType("application/json"); // 응답의 Content-Type을 JSON으로 설정
		        response.setCharacterEncoding("UTF-8");
		        response.getWriter().write(jsonResponse.toString()); // JSON 응답을 작성
		        
			}else {
				System.out.println("추천 서비스 실패 111");
				JSONObject jsonResponse = new JSONObject();
			    jsonResponse.put("error", "해당 카테고리에 대한 아이템이 없습니다.");
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(jsonResponse.toString());
			}
			
		}else if(recommend.equals(type2)) {  //톤인톤 : 동일한 tone
			dao.selectToneInToneItem(user_room_tone);
			List<Item> items = dao.selectToneInToneItem(user_room_tone);
			
			if(items != null) {
				System.out.println("추천 서비스 실행 성공2");
				JSONObject jsonResponse = new JSONObject();
		        jsonResponse.put("items", items);
		        response.setContentType("application/json"); // 응답의 Content-Type을 JSON으로 설정
		        response.setCharacterEncoding("UTF-8");
		        response.getWriter().write(jsonResponse.toString()); // JSON 응답을 작성	
		        
			}else {
				System.out.println("추천 서비스 실패 222");
				JSONObject jsonResponse = new JSONObject();
			    jsonResponse.put("error", "해당 카테고리에 대한 아이템이 없습니다.");
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(jsonResponse.toString());
			}
		}
	
		
		
		
		
		
		
		
		
		
	}

}
