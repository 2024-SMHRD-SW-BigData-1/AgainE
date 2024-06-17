package com.smhrd.model;

public class Item {

	// 상품 DTO
	
	// 아이템 식별자
    private Long item_idx;

    // 아이템 이름 
    private String item_name;

    // 아이템 톤 
    private String item_tone;

    // 아이템 칼라 
    private String item_color;

    // 아이템 정보 
    private String item_info;

    // 아이템 카테고리 
    private String item_category;

    // 아이템 평점 
    private Double item_ratings;

    // 아이템 가격 
    private Integer item_price;

    // 아이템 URL 
    private String item_url;

	public Item(String item_name, String item_tone, String item_color, String item_info,
			String item_category, Double item_ratings, Integer item_price, String item_url) {
		
		this.item_name = item_name;
		this.item_tone = item_tone;
		this.item_color = item_color;
		this.item_info = item_info;
		this.item_category = item_category;
		this.item_ratings = item_ratings;
		this.item_price = item_price;
		this.item_url = item_url;
	}

	public Item() {

	}

	public Long getItem_idx() {
		return item_idx;
	}

	public void setItem_idx(Long item_idx) {
		this.item_idx = item_idx;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getItem_tone() {
		return item_tone;
	}

	public void setItem_tone(String item_tone) {
		this.item_tone = item_tone;
	}

	public String getItem_color() {
		return item_color;
	}

	public void setItem_color(String item_color) {
		this.item_color = item_color;
	}

	public String getItem_info() {
		return item_info;
	}

	public void setItem_info(String item_info) {
		this.item_info = item_info;
	}

	public String getItem_category() {
		return item_category;
	}

	public void setItem_category(String item_category) {
		this.item_category = item_category;
	}

	public Double getItem_ratings() {
		return item_ratings;
	}

	public void setItem_ratings(Double item_ratings) {
		this.item_ratings = item_ratings;
	}

	public Integer getItem_price() {
		return item_price;
	}

	public void setItem_price(Integer item_price) {
		this.item_price = item_price;
	}

	public String getItem_url() {
		return item_url;
	}

	public void setItem_url(String item_url) {
		this.item_url = item_url;
	}

	
	
	
	
	
	
}
