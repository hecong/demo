package com.hishop.common;

public enum GoodsStatus {

	/**
	 * 售卖中
	 */
	SELLING(0),
	
	/**
	 *  下架
	 */
	REMOVE(1),
	
	/**
	 * 仓库中
	 */
	WAREHOUSE(2);
	
	
	private int code;
	GoodsStatus(int code) { this.code = code; }
}
