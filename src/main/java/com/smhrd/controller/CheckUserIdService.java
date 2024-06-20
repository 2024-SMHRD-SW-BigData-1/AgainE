package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;
import com.smhrd.model.UserDAO;


public class CheckUserIdService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String user_id = request.getParameter("user_id"); // 요청에서 아이디 값을 가져옴
		System.out.println("111" + user_id);

        // 여기서 데이터베이스와 연결하고 userid 중복 여부 확인 로직을 추가합니다.
		UserDAO dao = new UserDAO();
        int cnt = dao.checkUserid(user_id);
        boolean isAvailable = false;
        
        System.out.println("cnt :" + cnt);
        
        if(cnt > 0) {
        	System.out.println("아이디 중복 체크 했는데 중복임");
        	isAvailable = false;
        }else {
        	System.out.println("아이디 중복 체크 했는데 중복아님");
        	isAvailable = true;
        }

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("isAvailable", isAvailable);

        response.setContentType("application/json"); // 응답의 Content-Type을 JSON으로 설정
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString()); // JSON 응답을 작성
    }
		
		
//        // JSON 응답 생성
//        Gson gson = new Gson();
//		String jsonArr = gson.toJson(isAvailable);
//		System.out.println(jsonArr);
        
        
        

	
	}


