package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;
import kr.icia.mapper.CartMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CartServiceImpl implements CartService {

	@Setter(onMethod_=@Autowired)
	private CartMapper mapper;
	
	@Override
	public String getCartCount(String userid) {
		log.info("getCartCount..");
		return mapper.getCartCount(userid);
	}

	@Override
	public int getMainCart(CartVO vo) {
		log.info("getMainCart...");
		log.info("CartVO : "+vo);
		
		return mapper.insertMainCart(vo);
	}

	@Override
	public List<CartListVO> getCartList(String userid) {
		log.info("getCartList..");
		
		return mapper.getCartList(userid);
		
	}

	@Override
	public int removeCart(CartVO vo) {
		log.info("removeCart");
		return mapper.deleteCart(vo);
	}

	@Override
	public CartListVO allCartCost(String userid) {
		log.info("allCartCost");
		return mapper.allCartCost(userid);
	}

	@Override
	public String checkCart(CartVO vo) {
		log.info("checkCart");
		return mapper.checkCart(vo);
	}

	@Override
	public void deleteUser(String userid) {
		mapper.deleteUser(userid);
		
	}

	@Override
	public CartListVO allCartCost2(String userid) {
		
		return mapper.allCartCost2(userid);
	}

}
