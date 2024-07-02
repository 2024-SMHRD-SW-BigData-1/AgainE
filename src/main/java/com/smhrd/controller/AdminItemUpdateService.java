package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.Item;
import com.smhrd.model.ItemDAO;


public class AdminItemUpdateService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		Long item_idx = Long.parseLong(request.getParameter("item_idx"));
		String item_name = request.getParameter("item_name");
		String item_tone = request.getParameter("item_tone");
		String item_color = request.getParameter("item_color");
		String item_info = request.getParameter("item_info");
		String item_category = request.getParameter("item_category");
		Integer item_price = Integer.parseInt(request.getParameter("item_price"));
		String item_url = request.getParameter("item_url");

		System.out.println("item_idx: " + item_idx);
		System.out.println("item_name: " + item_name);
		System.out.println("item_tone: " + item_tone);
		System.out.println("item_color: " + item_color);
		System.out.println("item_info: " + item_info);
		System.out.println("item_category: " + item_category);
		System.out.println("item_price: " + item_price);
		System.out.println("item_url: " + item_url);

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		Item item = new Item(item_name, item_tone, item_color, item_info, item_category, item_price, item_url);
		item.setItem_idx(item_idx);

		ItemDAO dao = new ItemDAO();
		int cnt = dao.updateItem(item);

		if (cnt > 0) {
			showAlert(response, "success", "업데이트 성공", "", "AdminItemListService");
		} else {
			String referer = request.getHeader("Referer");
			showAlert(response, "error", "업데이트 실패", "", referer);
		}
	}

	private void showAlert(HttpServletResponse response, String icon, String title, String text, String redirectUrl)
			throws IOException {
		response.getWriter().println("<html><head>");
		response.getWriter().println("<style>");
		response.getWriter().println("@charset \"UTF-8\";");
		response.getWriter().println("@font-face {");
		response.getWriter().println("  font-family: 'GongGothicMedium';");
		response.getWriter().println(
				"  src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff') format('woff');");
		response.getWriter().println("  font-weight: normal;");
		response.getWriter().println("  font-style: normal;");
		response.getWriter().println("}");
		response.getWriter().println(".swal2-title-custom {");
		response.getWriter().println("  font-family: 'GongGothicMedium', sans-serif;");
		response.getWriter().println("  font-size: 22px;");
		response.getWriter().println("}");
		response.getWriter().println(".swal2-popup-custom {");
		response.getWriter().println("  width: 350px !important;"); // 알림 창 너비 조정
		response.getWriter().println("  heighth: 180px !important;"); // 알림 창 너비 조정
		response.getWriter().println("  padding: 20px !important;"); // 패딩 추가
		response.getWriter().println("  box-sizing: border-box;"); // 내부 요소들의 크기를 고려한 박스 크기 설정
		response.getWriter().println("  text-align: center;"); // 텍스트 가운데 정렬
		response.getWriter().println("}");
		response.getWriter().println(".swal2-confirm-custom {");
		response.getWriter().println("  width: 80px !important;"); // 알림 창 너비 조정
		response.getWriter().println("  heighth: 20px !important;"); // 알림 창 너비 조정
		response.getWriter().println("  background-color: #2778C4 !important;"); // OK 버튼 색상 변경
		response.getWriter().println("  color: white !important;"); // 버튼 텍스트 색상
		response.getWriter().println("  margin: 0 auto;"); // OK 버튼 가운데 정렬
		response.getWriter().println("}");
		response.getWriter().println(".swal2-title {");
		response.getWriter().println("  padding: 10 !important;"); // 패딩 제거
		response.getWriter().println("}");
		response.getWriter().println(".swal2-icon {");
		response.getWriter().println("  margin-top: 20px !important;"); // 윗부분 마진 줄이기
		response.getWriter().println("}");
		response.getWriter().println(".swal2-popup {");
		response.getWriter().println("  padding: 2 !important;"); // 패딩 제거
		response.getWriter().println("}");
		response.getWriter().println(".swal2-actions {");
		response.getWriter().println("  margin-top: 0px !important;"); // 패딩 제거
		response.getWriter().println("  margin-bottom: 15px !important;"); // 패딩 제거
		response.getWriter().println("}");

		response.getWriter().println("</style>");
		response.getWriter().println(
				"<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css\">");
		response.getWriter().println(
				"<script src=\"https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js\"></script>");
		response.getWriter().println("</head><body>");
		response.getWriter().println("<script>");
		response.getWriter().println("window.onload = function() {");
		response.getWriter().println("Swal.fire({");
		response.getWriter().println("  icon: '" + icon + "',");
		response.getWriter().println("  title: '<div class=\"swal2-title-custom\">" + title + "</div>',");
		response.getWriter().println("  customClass: {");
		response.getWriter().println("    popup: 'swal2-popup-custom',"); // 사용자 정의 클래스 적용
		response.getWriter().println("    title: 'swal2-title-custom',"); // 타이틀 클래스 적용
		response.getWriter().println("    confirmButton: 'swal2-confirm-custom'"); // OK 버튼 클래스 적용
		response.getWriter().println("  }");
		response.getWriter().println("}).then(() => {");
		response.getWriter().println("  location.href='" + redirectUrl + "';");
		response.getWriter().println("});");
		response.getWriter().println("};");
		response.getWriter().println("</script>");
		response.getWriter().println("</body></html>");
	
	
	
	
	}

}
