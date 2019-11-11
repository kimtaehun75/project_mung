package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.OrderInfoVO;
import kr.icia.domain.OrderSaleVO;

public interface OrderMapper {
	public void insertOrderSale(OrderSaleVO vo);
	
	public void insertOrderSaleCoupon(OrderSaleVO vo);
	
	public void insertOrderList(OrderInfoVO vo);
	
	public List<OrderInfoVO> orderList(String userid);
	
	public int searchOrderno(String userid);
	
	public List<OrderSaleVO> getOrderList(String userid);
	
	public List<Integer> getOrderno(String userid); 
	
	public OrderSaleVO callOrderList(int orderno);
	
	public OrderSaleVO callOrderListNoCp(int orderno);
	
	public List<OrderInfoVO> callProduct(int orderno);
}
