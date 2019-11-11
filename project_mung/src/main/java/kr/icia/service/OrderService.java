package kr.icia.service;

import java.util.List;

import kr.icia.domain.OrderInfoVO;
import kr.icia.domain.OrderSaleVO;

public interface OrderService {
	public void insertOrderSale(OrderSaleVO vo);
	
	public void insertOrderSaleCoupon(OrderSaleVO vo);
	
	public void insertOrderList(String userid);
	
	public List<OrderInfoVO> orderList(String userid);
	
	public int searchOrderno(String userid);
	
	public List<OrderSaleVO> getOrderList(String userid);
	
	public List<Integer> getOrderno(String userid); 
	
	public OrderSaleVO callOrderList(int orderno);
	
	public OrderSaleVO callOrderListNoCp(int orderno);
	
	public List<OrderInfoVO> callProduct(int orderno);

}
