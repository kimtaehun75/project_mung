package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SaleVO {
	private int saleno;
	private String saleName;
	private String cost;
	private String content;
	private int amount;
	private int good;
	private Date updateDate;
	private CateVO cate;
	private SaleImageVO attachImage;
}
