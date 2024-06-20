package com.smhrd.model;

import java.time.LocalDateTime;

public class User {

	// 회원 DTO
	
	
	// 회원 아이디 
    private String user_id;

    // 회원 비밀번호 
    private String user_pw;

    // 회원 이름 
    private String user_name;

    // 회원 이메일 
    private String user_email;

    // 회원 전화번호 
    private String user_phone;

    // 회원 주소 
    private String user_addr;

    // 회원 방톤 
    private String user_room_tone;

    // 회원 방색상 
    private String user_room_color;
    
    // 회원 방사진주소
    private String user_room_url;

    // 회원 가입일자 
    private LocalDateTime joined_at;

    // 회원 유형 
    private String user_type;

    
    
    // 회원 가입 시에 필요한 정보만 담은 생성자
	public User(String user_id, String user_pw, String user_name, String user_email, String user_phone,
			String user_addr, LocalDateTime joined_at, String user_type) {
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_phone = user_phone;
		this.user_addr = user_addr;
		this.joined_at = joined_at;
		this.user_type = user_type;
	}

	public User() {
	
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_addr() {
		return user_addr;
	}

	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}

	public String getUser_room_tone() {
		return user_room_tone;
	}

	public void setUser_room_tone(String user_room_tone) {
		this.user_room_tone = user_room_tone;
	}

	public String getUser_room_color() {
		return user_room_color;
	}

	public void setUser_room_color(String user_room_color) {
		this.user_room_color = user_room_color;
	}
	

	public String getUser_room_url() {
		return user_room_url;
	}

	public void setUser_room_url(String user_room_url) {
		this.user_room_url = user_room_url;
	}

	public LocalDateTime getJoined_at() {
		return joined_at;
	}

	public void setJoined_at(LocalDateTime joined_at) {
		this.joined_at = joined_at;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	
	
    
	
    
	
}
