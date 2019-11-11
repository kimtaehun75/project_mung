package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.BoardVO;
import kr.icia.domain.Criteria;

public interface FreeService {
	public int boardCount(Criteria cri);
	
	public List<BoardVO> boardList(Criteria cri);
	
	public void insertBoard(BoardVO vo);
	
	public boolean updateView(@Param("bno") int bno);
	
	public BoardVO getBoard(@Param("bno") int bno);
	
	public boolean delete(@Param("bno") int bno);
	
	public boolean update(BoardVO vo);
	
	// 11-11
		public List<BoardVO> freeList(Criteria cri);
		// 11-11
		public int freeCount(Criteria cri);
}
