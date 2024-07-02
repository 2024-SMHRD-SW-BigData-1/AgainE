package com.smhrd.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smhrd.model.Board;
import com.smhrd.model.BoardDAO;
import com.smhrd.model.Reply;
import com.smhrd.model.ReplyDAO;
import com.smhrd.model.User;


public class ReplyInsertService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String saveDir = "reply";
		String encType = "UTF-8";
		int maxSize = 5 * 1024 * 1024;

		ServletContext context = request.getServletContext();
		String realFolder = context.getRealPath(saveDir);

		// 파일 업로드 객체 생성
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		} catch (Exception e) {
			System.out.println("답변 업로드 실패");
			e.printStackTrace();
			response.sendRedirect("html/admin_board_detail.jsp");
			return;
		}

		// 세션에서 user_id 가져오기
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("login_user");
		if (user == null) {
			System.out.println("세션에서 id를 가져오지 못했습니다.");
			response.sendRedirect("html/admin_board_detail.jsp");
			return;
		}

		// 업로드 된 답변 유형, 이름 등 가져오기
		Long b_idx = Long.parseLong(multi.getParameter("b_idx"));
		System.out.println("b_idx"+b_idx);
		
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String photo = multi.getFilesystemName("photo");
		Timestamp replied_at = new Timestamp(System.currentTimeMillis());

		Reply reply =  new Reply(b_idx, title, content, photo, replied_at, user.getUser_id());
		ReplyDAO r_dao =  new ReplyDAO();
		int cnt = r_dao.replyInsert(reply);
		
		ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> responseData = new HashMap<>();

		if (cnt > 0) {
			System.out.println("답변 작성 완료");
			BoardDAO b_dao = new BoardDAO();
			int cnt2 = b_dao.boardStatusUpdate(b_idx);
			if(cnt2>0) {
				System.out.println("문의글 상태 변경 성공");
				responseData.put("success", true);
			}else {
				System.out.println("문의글 상태 변경 실패");
				responseData.put("success", false);
			}
		} else {
			System.out.println("답변 작성 실패!!!");
			responseData.put("success", false);
		}
	
		String jsonResponse = mapper.writeValueAsString(responseData);
	    response.getWriter().write(jsonResponse);
	
	}

}
