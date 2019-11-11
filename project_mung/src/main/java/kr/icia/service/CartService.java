package kr.icia.service;

import java.util.List;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;

public interface CartService {
	public String getCartCount(String userid);
	
	public int getMainCart(CartVO vo);
	
	public List<CartListVO> getCartList(String userid);
	
	public int removeCart(CartVO vo);
	
	public CartListVO allCartCost(String userid);
	
	public CartListVO allCartCost2(String userid);
	
	public String checkCart(CartVO vo);
	
	public void deleteUser(String userid);
}
