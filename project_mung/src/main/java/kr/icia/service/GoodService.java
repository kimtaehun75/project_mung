package kr.icia.service;

import kr.icia.domain.GoodVO;

public interface GoodService {
	public String checkGood(GoodVO vo);
	
	public int insertGood(GoodVO vo);
	
	public int deleteGood(GoodVO vo);
	
	public void deleteUser(String userid);
}
