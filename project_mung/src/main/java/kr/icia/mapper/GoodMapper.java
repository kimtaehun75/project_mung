package kr.icia.mapper;

import kr.icia.domain.GoodVO;

public interface GoodMapper {
	public String checkGood(GoodVO vo);
	
	public int insertGood(GoodVO vo);
	
	public int deleteGood(GoodVO vo);
	
	public void removeGood(int saleno);
	
	public void deleteUser(String userid);
}
