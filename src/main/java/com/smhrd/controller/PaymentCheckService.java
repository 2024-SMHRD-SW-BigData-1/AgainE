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


public class PaymentCheckService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String PORTONE_API_SECRET = "C6O71nZs3xxVt0gb7NkbsWBWkmU8Cc1XBYufed94qFA2FfXJa77XcZcLAPgLARLf7eKM886bIOvtkMdv";
	//private static final String STORE_ID = "store-808e7025-bb21-48fa-b9c2-2bae904812e8";
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String payment_id = request.getParameter("paymentId");
		System.out.println(payment_id);
		
		// 외부 API 호출
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest httpRequest = HttpRequest.newBuilder()
                .uri(URI.create("https://api.portone.io/payments/" + payment_id )) //+ "&storeId=" + STORE_ID
                .header("Authorization", "PortOne " + PORTONE_API_SECRET)
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
            if (payment.getAmount().getTotal() == 100) { //테스트결제니까 그냥 100원인지 아닌지 검증
                switch (payment.getStatus()) {
                  case "VIRTUAL_ACCOUNT_ISSUED": {
                    // 가상 계좌가 발급된 상태입니다.
                    // 계좌 정보를 이용해 원하는 로직을 구성하세요.  -> 가상 계좌번호를 사용자에게 보여줘야될듯? 
                	  // -> 보여주고나서 테스트니까 swal.fire 확인 버튼 누르면 그냥 결제 진행시키기
                	String accountNumber = payment.getMethod().getAccountNumber();
                	String bank = payment.getMethod().getBank();
                	jsonResponse.put("status", "virtual");
                    jsonResponse.put("message",  bank+" "+accountNumber);
                    jsonResponse.put("paymentId", payment_id);
                	  
                    break;
                  }
                  case "PAID": {
                    // 모든 금액을 지불했습니다! 완료 시 원하는 로직을 구성하세요.
                	  jsonResponse.put("status", "success");
                      jsonResponse.put("message", "결제 금액이 일치합니다.");
                      jsonResponse.put("paymentId", payment_id);
                    break;
                  }
                }
              } else {
                // 결제 금액이 불일치하여 위/변조 시도가 의심됩니다.
            	  jsonResponse.put("status", "error");
                  jsonResponse.put("message", "결제 금액이 일치하지 않습니다.");
              }
            
         // JSON 응답 전송
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(objectMapper.writeValueAsString(jsonResponse));
            
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




