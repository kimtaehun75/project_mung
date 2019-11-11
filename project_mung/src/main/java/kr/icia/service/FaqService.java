package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.BoardFaqVO;
import kr.icia.domain.Criteria;

public interface FaqService {
	// 11-06 작업
	public void register(BoardFaqVO vo);

	public List<BoardFaqVO> faqList(Criteria cri);

	public int faqCount(Criteria cri);

	public BoardFaqVO getFaq(@Param("bno") int bno);
	
	public boolean delete(@Param("bno") int bno);
}
