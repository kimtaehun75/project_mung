package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;

public interface CartMapper {
	public String getCartCount(String userid);
	
	public int insertMainCart(CartVO vo);
	
	public List<CartListVO> getCartList(String userid);
	
	public int deleteCart(CartVO vo);
	
	public CartListVO allCartCost(String userid);
	
	public CartListVO allCartCost2(String userid);
	
	public String checkCart(CartVO vo);
	
	public void removeCart(int saleno);
	
	public void deleteUser(String userid);
	
	
}
