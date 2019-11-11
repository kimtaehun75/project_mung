package kr.icia.mapper;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.MemberVO;

public interface MailMapper {
	public void createUser(MemberVO vo);
	
	public void createAuthKey(
			@Param("email") String email,
			@Param("authKey") String authKey);
	
	public int userAuth(
			@Param("email") String email,
			@Param("authKey") String authKey);
	
	public void createAuth(
			@Param("userid") String userid);
	
	public void deleteUserAuth(String userid);
}
