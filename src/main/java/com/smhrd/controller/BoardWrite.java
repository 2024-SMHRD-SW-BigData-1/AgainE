package com.smhrd.controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smhrd.model.Board;
import com.smhrd.model.BoardDAO;
import com.smhrd.model.User;


public class BoardWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		
		request.setCharacterEncoding("UTF-8");

		String saveDir = "board";
		String encType = "UTF-8";
		int maxSize = 5 * 1024 * 1024;

		ServletContext context = request.getServletContext();
		String realFolder = context.getRealPath(saveDir);

		// 파일 업로드 객체 생성
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		} catch (Exception e) {
			System.out.println("문의글 업로드 실패");
			e.printStackTrace();
			response.sendRedirect("html/user_board.jsp");
			return;
		}

		// 세션에서 user_id 가져오기
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("login_user");
		if (user == null) {
			System.out.println("세션에서 id를 가져오지 못했습니다.");
			response.sendRedirect("html/user_board.jsp");
			return;
		}

		// 업로드 된 문의글 유형, 이름 등 가져오기
		String kind = multi.getParameter("kind");
		System.out.println(kind);
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String photo = multi.getFilesystemName("photo");
		Timestamp created_at = new Timestamp(System.currentTimeMillis());

		Board board = new Board(title, content, photo, created_at, user.getUser_id(), "f", kind);

		BoardDAO dao = new BoardDAO();
		int cnt = dao.boardInsert(board);

		response.setCharacterEncoding("UTF-8");

		if (cnt > 0) {
			System.out.println("게시판 작성 완료");
			/*
			 * response.setContentType("text/html; charset=UTF-8");
			 * response.getWriter().println("<script>" + "alert('문의글 작성이 완료되었습니다');" +
			 * " window.history.back(); </script>");
			 */
			response.sendRedirect("html/user_board.jsp?board_success=true");
		} else {
			System.out.println("게시글 작성 실패!!!");
			response.sendRedirect("html/user_board.jsp?board_success=false");
		}

	}

}
