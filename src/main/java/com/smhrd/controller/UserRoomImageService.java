package com.smhrd.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.smhrd.model.User;
import com.smhrd.model.UserDAO;


@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 5, // 파일 크기가 메모리에 저장되기 전에 임계값 (1MB)
	    maxFileSize = 1024 * 1024 * 10,  // 업로드할 수 있는 최대 파일 크기 (10MB)
	    maxRequestSize = 1024 * 1024 * 50 // 요청 전체의 최대 크기 (50MB)
	)
public class UserRoomImageService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String UPLOAD_DIR = "user_room_img"; // 톰캣 서버에서 파일을 저장할 폴더
    private static final String WEBAPP_UPLOAD_DIR = "C:\\Users\\SMHRD\\Desktop\\Web_jsp\\AgainE_Project\\src\\main\\webapp\\user_room_img"; // 이클립스 프로젝트의 파일을 저장할 절대 경로
	
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		System.out.println("플라스크에서 데이터 넘어왔나봄");
	
		
		 // JSON 데이터 처리
        String userData = request.getParameter("login_user");
        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        User user = mapper.readValue(userData, User.class);
		
        
		System.out.println("플라스크에서 넘어온 유저 id : " + user.getUser_id());
		
		
		
		
		
		 // 색상 데이터 받기
	    String user_room_color = request.getParameter("color");
	    if (user_room_color != null) {
	        System.out.println("전송된 색상 값: " + user_room_color);
	    }
	    
	    if(user_room_color.equals("기타")) {
	    	JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "색상 기타");
            response.getWriter().write(jsonResponse.toString());
            return;
	    }
	    
	    // 톤 데이터 받기
	    String user_room_tone = request.getParameter("tone");
	    if (user_room_tone != null) {
	        System.out.println("전송된 색상 값: " + user_room_tone);
	    }
	    if(user_room_tone.equals("기타")) {
	    	JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "톤 기타");
            response.getWriter().write(jsonResponse.toString());
            return;
	    }
        
	    Part filePart = request.getPart("file");
		
		if (filePart != null && filePart.getSize() > 0) {
            // 파일명 가져오기
            String fileName = filePart.getSubmittedFileName();
            System.out.println("파일명:  " + fileName);
            
            //톰캣 서버의 임시 폴더 경로 설정
            String tomcatUploadPath = getServletContext().getRealPath("") + UPLOAD_DIR;
            System.out.println(getServletContext().getRealPath(""));
            File tomcatUploadDir = new File(tomcatUploadPath);
            if (!tomcatUploadDir.exists()) {
                tomcatUploadDir.mkdir();
            }
            String tomcatFilePath = tomcatUploadPath + File.separator + fileName;
            File tomcatFile = new File(tomcatFilePath);
            System.out.println(tomcatFilePath);
            
           
            // 이클립스 프로젝트의 경로 설정
            String webappUploadPath  = WEBAPP_UPLOAD_DIR;  
            File webappFileUploadPath = new File(webappUploadPath);
            if (!webappFileUploadPath.exists()) {
            	webappFileUploadPath.mkdir();
            }
            String webappFilePath = webappUploadPath + File.separator + fileName;
            File webappFile = new File(webappFilePath);
            System.out.println(webappFilePath);
            
            
            // 임시 파일 경로
            String tempFilePath = System.getProperty("java.io.tmpdir") + File.separator + fileName;
            File tempFile = new File(tempFilePath);
          
            // 파일 저장
            try (InputStream input = filePart.getInputStream()) {
            	// 임시 파일에 저장
                Files.copy(input, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            	
                // 임시 파일에서 복사하기
                // 톰캣 서버 임시 폴더에 저장
                Files.copy(tempFile.toPath(), tomcatFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                // 이클립스 프로젝트의 파일에 저장
                Files.copy(tempFile.toPath(), webappFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }catch (IOException e) {
            	JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "파일 저장 중 오류 발생: " + e.getMessage());
                response.getWriter().write(jsonResponse.toString());
                return;
            }
            System.out.println("파일 저장 완료: " + tomcatFilePath + ", " + webappFilePath);
            
            user.setUser_room_url(fileName);
            user.setUser_room_color(user_room_color);
            user.setUser_room_tone(user_room_tone);
            
            
            // db에 저장
            UserDAO dao = new UserDAO();
            int cnt = dao.updateUserRoom(user);

            if(cnt > 0) {
            	System.out.println("사용자 방 이미지 업데이트 성공");
            	user.setUser_type("t");
            	int cnt2 = dao.updateUserType(user);
            	if(cnt2 > 0) {
            		System.out.println("회원 유형 업데이트 성공");
            		
            		// JSON 응답에 세션 데이터를 포함
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("status", "success");
                    jsonResponse.put("message", "회원 유형 업데이트 성공");
                    jsonResponse.put("user", new JSONObject(mapper.writeValueAsString(user)));
                    response.getWriter().write(jsonResponse.toString());
            		
            	}else {
            		JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "회원 유형 업데이트 실패");
                    response.getWriter().write(jsonResponse.toString());
            	}
            }else {
            	JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "사용자 방 이미지 업데이트 실패");
                response.getWriter().write(jsonResponse.toString());
            }
            
            
        }else {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "유효한 파일이 업로드되지 않았습니다.");
            response.getWriter().write(jsonResponse.toString());
	
	}

	}
}
