package com.smhrd.model;

import java.sql.Timestamp;

public class Reply {

	// 관리자 응답 DTO
	
	// 응답 식별자 
    private Long rep_idx;

    // 원글 식별자 
    private Long b_idx;

    // 응답 제목 
    private String rep_title;

    // 응답 내용 
    private String rep_content;

    // 응답 첨부파일 
    private String rep_file;

    // 응답 날짜 
    private Timestamp replied_at;

    // 관리자 아이디 
    private String admin_id;

	public Reply(Long b_idx, String rep_title, String rep_content, String rep_file, Timestamp replied_at,
			String admin_id) {

		this.b_idx = b_idx;
		this.rep_title = rep_title;
		this.rep_content = rep_content;
		this.rep_file = rep_file;
		this.replied_at = replied_at;
		this.admin_id = admin_id;
	}

	public Reply() {

	}

	public Long getRep_idx() {
		return rep_idx;
	}

	public void setRep_idx(Long rep_idx) {
		this.rep_idx = rep_idx;
	}

	public Long getB_idx() {
		return b_idx;
	}

	public void setB_idx(Long b_idx) {
		this.b_idx = b_idx;
	}

	public String getRep_title() {
		return rep_title;
	}

	public void setRep_title(String rep_title) {
		this.rep_title = rep_title;
	}

	public String getRep_content() {
		return rep_content;
	}

	public void setRep_content(String rep_content) {
		this.rep_content = rep_content;
	}

	public String getRep_file() {
		return rep_file;
	}

	public void setRep_file(String rep_file) {
		this.rep_file = rep_file;
	}

	public Timestamp getReplied_at() {
		return replied_at;
	}

	public void setReplied_at(Timestamp replied_at) {
		this.replied_at = replied_at;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
    
    
	
}
