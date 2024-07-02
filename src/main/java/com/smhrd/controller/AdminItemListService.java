package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.Item;
import com.smhrd.model.ItemDAO;


public class AdminItemListService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("관리자제품목록수정서비스실행");
        request.setCharacterEncoding("UTF-8");

        ItemDAO dao = new ItemDAO();
        List<Item> items = dao.selectAllItem();
        System.out.println("아이템정보: " + items);

        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("items", items);

        response.sendRedirect("html/admin_itemlist.jsp");
	
	
	}

}
