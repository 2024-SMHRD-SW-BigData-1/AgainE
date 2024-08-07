package com.smhrd.controller;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.model.Payment;


public class PaymentCancelService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String PORTONE_API_SECRET = "C6O71nZs3xxVt0gb7NkbsWBWkmU8Cc1XBYufed94qFA2FfXJa77XcZcLAPgLARLf7eKM886bIOvtkMdv";
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String payment_id = request.getParameter("paymentId");
		String reason = "결제 취소 사유";
		reason = request.getParameter("message");
		String requestBody = String.format("{\"reason\":\"%s\"}", reason);

		
		
		// 외부 API 호출
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest httpRequest = HttpRequest.newBuilder()
                .uri(URI.create("https://api.portone.io/payments/" + payment_id + "/cancel" )) //+ "&storeId=" + STORE_ID
                .header("Authorization", "PortOne " + PORTONE_API_SECRET)
                .method("POST", HttpRequest.BodyPublishers.ofString(requestBody))
                .build();
		
        try {
            HttpResponse<String> httpResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());
            
            System.out.println(httpResponse.body());

            if (httpResponse.statusCode() != 200) {
                throw new RuntimeException("Failed to get payment details: " + httpResponse.body());
            }

            String responseBody = httpResponse.body();
            
            // JSON 응답을 Java 객체로 변환
            ObjectMapper objectMapper = new ObjectMapper();
            Payment payment = objectMapper.readValue(responseBody, Payment.class);
            
            
         // 응답 데이터를 JSON으로 작성
            Map<String, String> jsonResponse = new HashMap<>();
            if(payment.getStatus().equals("FAILED")) {
            	jsonResponse.put("status", "error");
                jsonResponse.put("message", "결제 취소 실패");
            }else {
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "결제 취소됨");
            }
            
            
            
            
        } catch (InterruptedException | IOException e) {
        	// 오류 응답을 JSON으로 전송
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("status", "error");
            errorResponse.put("message", "에러 발생: " + e.getMessage());

            ObjectMapper objectMapper = new ObjectMapper();
            response.getWriter().write(objectMapper.writeValueAsString(errorResponse));
            
         // 예외를 던져서 서버 로그에 기록되도록 함
            throw new ServletException("에러 발생", e);
        }
	
	
	}

}
