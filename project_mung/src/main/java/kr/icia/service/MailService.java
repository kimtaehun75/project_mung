package kr.icia.service;

import kr.icia.domain.MemberVO;

public interface MailService {
	
	public boolean userAuth(String email,String authKey);
	
	public void register(MemberVO vo) throws Exception;
	
	public void deleteUserAuth(String userid);
}
