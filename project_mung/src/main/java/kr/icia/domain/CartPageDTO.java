package kr.icia.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CartPageDTO {
	
	private int cartCount;
	private List<CartListVO> list;
}
