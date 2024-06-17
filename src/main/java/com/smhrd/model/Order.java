package com.smhrd.model;

import java.time.LocalDateTime;

public class Order {

	// 주문 DTO
	
	
	// 주문 식별자 
    private Long order_idx;

    // 총 주문금액 
    private Integer total_amount;

    // 결제 대상금액 
    private Integer pay_amount;

    // 결재 수단 
    private String pay_method;

    // 결재 금액 
    private Integer paid_amount;

    // 주문자 아이디 
    private String user_id;

    // 주문 일자 
    private LocalDateTime ordered_at;

    // 주문 상태 
    private String order_state;

	public Order(Integer total_amount, Integer pay_amount, String pay_method,
			Integer paid_amount, String user_id, LocalDateTime ordered_at, String order_state) {

		
		this.total_amount = total_amount;
		this.pay_amount = pay_amount;
		this.pay_method = pay_method;
		this.paid_amount = paid_amount;
		this.user_id = user_id;
		this.ordered_at = ordered_at;
		this.order_state = order_state;
	}

	public Order() {

	}

	public Long getOrder_idx() {
		return order_idx;
	}

	public void setOrder_idx(Long order_idx) {
		this.order_idx = order_idx;
	}

	public Integer getTotal_amount() {
		return total_amount;
	}

	public void setTotal_amount(Integer total_amount) {
		this.total_amount = total_amount;
	}


	public Integer getPay_amount() {
		return pay_amount;
	}

	public void setPay_amount(Integer pay_amount) {
		this.pay_amount = pay_amount;
	}

	public String getPay_method() {
		return pay_method;
	}

	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}

	public Integer getPaid_amount() {
		return paid_amount;
	}

	public void setPaid_amount(Integer paid_amount) {
		this.paid_amount = paid_amount;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public LocalDateTime getOrdered_at() {
		return ordered_at;
	}

	public void setOrdered_at(LocalDateTime ordered_at) {
		this.ordered_at = ordered_at;
	}

	public String getOrder_state() {
		return order_state;
	}

	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}

	
	
    
    
}
