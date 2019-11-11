package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.AdoptVO;
import kr.icia.domain.BoardVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.DogsVO;
import kr.icia.domain.MemberVO;

public interface AdoptService {

	public List<DogsVO> getDogsList(Criteria cri);

	public void register(DogsVO vo);

	public DogsVO getDogs(int dogno);

	public boolean update(DogsVO vo);

	public List<DogsVO> getDogsUserList(Criteria cri);
	
	public DogsVO getDogProfile(int dogno);
	
	public MemberVO getMember(String userid);

	public void adoptRequest(AdoptVO vo);

	public List<AdoptVO> getRequestList(Criteria cri);

	public AdoptVO getRequestUser(int bno);

	public boolean adopt(AdoptVO vo);
	
	public void insertAfter(BoardVO vo);
	
	public List<BoardVO> afterList(Criteria cri);

	public int afterCount(Criteria cri);
	
	public boolean updateView(@Param("bno") int bno);

	public BoardVO getAfter(@Param("bno") int bno);


} //end class
