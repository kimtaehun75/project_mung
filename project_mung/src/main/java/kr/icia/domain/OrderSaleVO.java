package kr.icia.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderSaleVO {
	private int orderno;
	private String userid;
	private String userName;
	private String addr_1;
	private String addr_2;
	private String addr_3;
	private String email;
	private String phone;
	private Date orderDate;
	private String state;
	private String saleState;
	private int cpnum;
	private String cpName;
	
	private String allCost;
	// 가격
	private String disCost;
	// 할인 가격
	private String finalCost;
	// 최종 가격
	
	private List<OrderInfoVO> orderList;
}
