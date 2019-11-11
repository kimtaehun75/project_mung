package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.GradeVO;
import kr.icia.domain.MemberVO;

public interface MemberMapper {

	
	public MemberVO read(String userid);
	
	public List<String> userGetId(
			@Param("userName") String userName,
			@Param("email") String email);
	
	public List<String> getGradeId(String tear);
	
	public int changePw(
			@Param("userid") String userid,
			@Param("userName") String userName,
			@Param("email") String email,
			@Param("userpw") String userpw
			);
	
	public int userIdCheck(String userid);
	
	public int updateUser(MemberVO vo);
	
	public int updateAdopt(String userid);
	
	public List<MemberVO> getMemberWithPaging(Criteria cri);
	
	public List<GradeVO> getGradeList();
	
	public int getMemberCount(Criteria cri);
	
	public MemberVO getMember(@Param("userid") String userid);
	
	public int adminUpdateUser(MemberVO vo);
	
	public void deleteUser(String userid);
	
	public int changeNewPw(MemberVO vo);
}
