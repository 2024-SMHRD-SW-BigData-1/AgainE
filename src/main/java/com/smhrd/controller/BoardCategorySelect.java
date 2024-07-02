package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.Board;
import com.smhrd.model.BoardDAO;


public class BoardCategorySelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		String b_category = request.getParameter("b_category");
		
		BoardDAO dao = new BoardDAO();
		List<Board> boards =  dao.boardCategorySelect(b_category);
		
		ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
	
		if(boards != null) {
			System.out.println("문의글 카테고리 선택 성공");
            response.getWriter().write(mapper.writeValueAsString(boards));
			
			
		}else {
			System.out.println("문의글 카테고리 선택했더니 없네");
            response.getWriter().write("{\"error\": \"조회된 문의글이 없습니다.\"}");
			
		}
	}

}
