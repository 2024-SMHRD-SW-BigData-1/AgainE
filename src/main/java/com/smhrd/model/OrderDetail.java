package com.smhrd.model;

public class OrderDetail {

	// 주문 상세 DTO
	
	// 주상 식별자 
    private long od_idx;

    // 주문 식별자 
    private long order_idx;

    // 아이템 식별자 
    private long item_idx;

    // 주문 수량 
    private long order_cnt;
    
    // 아이템 총 가격(아이템 1개 가격 * 주문 수량)
    private long total_item;

	public OrderDetail(long order_idx, long item_idx, long order_cnt, long total_item) {

		this.order_idx = order_idx;
		this.item_idx = item_idx;
		this.order_cnt = order_cnt;
		this.total_item = total_item;
	}

	public OrderDetail() {

	}

	public long getOd_idx() {
		return od_idx;
	}

	public void setOd_idx(long od_idx) {
		this.od_idx = od_idx;
	}

	public long getOrder_idx() {
		return order_idx;
	}

	public void setOrder_idx(long order_idx) {
		this.order_idx = order_idx;
	}

	public long getItem_idx() {
		return item_idx;
	}

	public void setItem_idx(long item_idx) {
		this.item_idx = item_idx;
	}

	public long getOrder_cnt() {
		return order_cnt;
	}

	public void setOrder_cnt(long order_cnt) {
		this.order_cnt = order_cnt;
	}

	public long getTotal_item() {
		return total_item;
	}

	public void setTotal_item(long total_item) {
		this.total_item = total_item;
	}

	
	
	
	
}
