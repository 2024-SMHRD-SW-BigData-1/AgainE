package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.BasketDAO;
import com.smhrd.model.User;


public class AfterPayBasketDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("login_user");
	
		String user_id =  user.getUser_id();
		
		BasketDAO dao = new BasketDAO();
		int cnt = dao.afterPayBasketDelete(user_id);
	
		if(cnt > 0) {
			System.out.println("장바구니 전체 삭제 성공");
			response.sendRedirect("html/index.jsp");
		}else {
			System.out.println("장바구니 전체 삭제 실패");
			response.sendRedirect("html/index.jsp?deleteBasket=false");
		}
			
		
		
	}

}
