package kr.icia.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.OrderInfoVO;
import kr.icia.domain.OrderSaleVO;
import kr.icia.mapper.OrderMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class OrderServiceImpl implements OrderService {
	
	@Setter(onMethod_=@Autowired)
	private OrderMapper mapper;
	
	public void insertOrderSale(OrderSaleVO vo) {
		
		mapper.insertOrderSale(vo);
	}

	@Override
	public void insertOrderSaleCoupon(OrderSaleVO vo) {
		
		mapper.insertOrderSaleCoupon(vo);
	}

	@Override
	public void insertOrderList(String userid) {
		
		List<OrderInfoVO> vo = mapper.orderList(userid);
		int orderno = mapper.searchOrderno(userid);
		
		vo.forEach(order->{
			order.setOrderno(orderno);
			mapper.insertOrderList(order);
		});
	}

	@Override
	public List<OrderInfoVO> orderList(String userid) {
		log.info("OrderList....");
		return mapper.orderList(userid);
	}

	@Override
	public int searchOrderno(String userid) {
		log.info("Orderno Search...");
		
		return mapper.searchOrderno(userid);
	}

	@Override
	public List<Integer> getOrderno(String userid) {
		log.info("getOrderno..");
		
		return mapper.getOrderno(userid);
	}

	@Override
	public OrderSaleVO callOrderList(int orderno) {
		log.info("callOrderList...");
		
		return mapper.callOrderList(orderno);
	}

	@Override
	public List<OrderInfoVO> callProduct(int orderno) {
		log.info("callProduct");
		return mapper.callProduct(orderno);
	}
	
	
	@Override
	public OrderSaleVO callOrderListNoCp(int orderno) {
		
		return mapper.callOrderListNoCp(orderno);
	}
	
	@Override
	public List<OrderSaleVO> getOrderList(String userid) {
		
		List<OrderSaleVO> list = new ArrayList<>();
		
		List<Integer> orderno = mapper.getOrderno(userid);
		
		orderno.forEach(number->{
			OrderSaleVO vo = new OrderSaleVO();
			vo = mapper.callOrderList(number);
			if(vo == null) {
				vo = mapper.callOrderListNoCp(number);
			}
			log.info("vo : "+vo);
			vo.setOrderList(mapper.callProduct(number));
			list.add(vo);
		});
		
		return list;
	}

	

	
}
