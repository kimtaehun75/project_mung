package kr.icia.domain;

import lombok.Data;

@Data
public class CartListVO {
	private int saleno;
	private String saleName;
	private String cost;
	private int amount;
	private String allCost;
	private SaleImageVO attachImage;
}
