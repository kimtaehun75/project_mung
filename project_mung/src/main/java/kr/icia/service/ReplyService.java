package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.ReplyPageDTO;
import kr.icia.domain.ReplyVO;

public interface ReplyService {
	
	public ReplyVO get(int rno);
	
	public void register(ReplyVO vo);
	
	public int remove(int rno);
	
	public int modify(ReplyVO reply);
	
	public List<ReplyVO> getList(
			@Param("cri") Criteria cri,
			@Param("bno") int bno
			);
	
	public int getCount(@Param("bno") int bno);
	
	public ReplyPageDTO getListPage(
			@Param("cri") Criteria cri,
			@Param("bno") int bno
			);
}
