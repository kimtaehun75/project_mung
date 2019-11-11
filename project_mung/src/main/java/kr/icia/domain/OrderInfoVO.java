package kr.icia.domain;

import lombok.Data;

@Data
public class OrderInfoVO {
	private int orderno;
	private int saleno;
	private String saleName;
	private String cost;
	private int amount;
	private int costSum;
	
	private SaleImageVO attachImage;
}
