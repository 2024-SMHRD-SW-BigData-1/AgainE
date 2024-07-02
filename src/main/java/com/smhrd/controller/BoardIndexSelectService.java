package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.Board;
import com.smhrd.model.BoardDAO;


public class BoardIndexSelectService extends HttpServlet {
	private static final long serialVersionUID = 1L;

		protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			Long b_idx = Long.parseLong(request.getParameter("b_idx"));
		
			BoardDAO dao = new BoardDAO();
			Board board = dao.boardIndexSelect(b_idx);
			
			ObjectMapper mapper = new ObjectMapper();
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
			
			if(board != null) {
				System.out.println("인덱스로 문의글 불러오기 성공");
				response.getWriter().write(mapper.writeValueAsString(board));
			}else {
				System.out.println("인덱스로 문의글 불러오기 실패");
				response.getWriter().write("{\"error\": \"문의글 인덱스로 선택 실패.\"}");
			}
			
			
			
		}

}
