package com.smhrd.model;

import java.sql.Timestamp;

public class Board {

	// 게시판 DTO
	
	
		// 글 식별자 
	    private Long b_idx;

	    // 글 제목 
	    private String b_title;

	    // 글 내용 
	    private String b_content;

	    // 글 첨부파일 
	    private String b_file;

	    // 글 작성일자 
	    private Timestamp created_at;

	    // 글 작성자 
	    private String user_id;

	    // 글 상태 
	    private String b_status;
	    
	    // 글 유형
	    private String b_category;

	    
	    
		public Board(String b_title, String b_content, String b_file, Timestamp created_at, String user_id,
				String b_status, String b_category) {

			this.b_title = b_title;
			this.b_content = b_content;
			this.b_file = b_file;
			this.created_at = created_at;
			this.user_id = user_id;
			this.b_status = b_status;
			this.b_category = b_category;
		}

		public Board() {

		}

		public Long getB_idx() {
			return b_idx;
		}

		public void setB_idx(Long b_idx) {
			this.b_idx = b_idx;
		}

		public String getB_title() {
			return b_title;
		}

		public void setB_title(String b_title) {
			this.b_title = b_title;
		}

		public String getB_content() {
			return b_content;
		}

		public void setB_content(String b_content) {
			this.b_content = b_content;
		}

		public String getB_file() {
			return b_file;
		}

		public void setB_file(String b_file) {
			this.b_file = b_file;
		}

		public Timestamp getCreated_at() {
			return created_at;
		}

		public void setCreated_at(Timestamp created_at) {
			this.created_at = created_at;
		}

		public String getUser_id() {
			return user_id;
		}

		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}

		public String getB_status() {
			return b_status;
		}

		public void setB_status(String b_status) {
			this.b_status = b_status;
		}

		public String getB_category() {
			return b_category;
		}

		public void setB_category(String b_category) {
			this.b_category = b_category;
		}
	
	
	
    
}
