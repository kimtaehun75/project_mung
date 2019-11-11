package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.GradeVO;
import kr.icia.domain.MemberVO;

public interface MemberService {
	public List<String> userGetId(
			@Param("userName") String userName,
			@Param("email") String email);
	
	public boolean changeUserPw(
			@Param("userid") String userid,
			@Param("userName") String userName,
			@Param("email") String email
			)  throws Exception; 
		
	public int userIdCheck(String userid); 
	
	public boolean updateUser(MemberVO vo);
	
	public boolean adminUpdateUser(MemberVO vo);
	
	public List<MemberVO> getList(Criteria cri);
	
	public List<GradeVO> getGradeList();
	
	public List<String> getGradeId(String tear);
	
	public int getMemberCount(Criteria cri);
	
	public MemberVO getUser(String userid);
	
	public MemberVO getMember(
			@Param("userid") String userid);
	
	public void deleteUser(String userid);
	
	public int changeNewPw(MemberVO vo);
}
