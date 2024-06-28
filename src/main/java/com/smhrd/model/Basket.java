package com.smhrd.model;

import java.time.LocalDateTime;

public class Basket {

	// 장바구니 DTO
	
	
	// 장바구니 식별자 
    private Integer basket_idx;

    // 회원 아이디 
    private String user_id;

    // 아이템 식별자 
    private Long item_idx;

    // 수량 
    private Long cnt;

    // 등록 일자 
    private LocalDateTime created_at;

    // 장바구니 상태 
    private String basket_status;
    
    // 장바구니 총 가격
    private Long total_item;

	public Basket(String user_id, Long item_idx, Long cnt, LocalDateTime created_at,
			String basket_status) {
		
		this.user_id = user_id;
		this.item_idx = item_idx;
		this.cnt = cnt;
		this.created_at = created_at;
		this.basket_status = basket_status;
	}

	public Basket() {

	}

	public Integer getBasket_idx() {
		return basket_idx;
	}

	public void setBasket_idx(Integer basket_idx) {
		this.basket_idx = basket_idx;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Long getItem_idx() {
		return item_idx;
	}

	public void setItem_idx(Long item_idx) {
		this.item_idx = item_idx;
	}

	public Long getCnt() {
		return cnt;
	}

	public void setCnt(Long cnt) {
		this.cnt = cnt;
	}

	public LocalDateTime getCreated_at() {
		return created_at;
	}

	public void setCreated_at(LocalDateTime created_at) {
		this.created_at = created_at;
	}

	public String getBasket_status() {
		return basket_status;
	}

	public void setBasket_status(String basket_status) {
		this.basket_status = basket_status;
	}

	public Long getTotal_item() {
		return total_item;
	}

	public void setTotal_item(Long total_item) {
		this.total_item = total_item;
	}
    
	
    
	
}
