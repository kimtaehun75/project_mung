package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.BoardVO;
import kr.icia.domain.Criteria;

public interface FreeMapper {
	public int boardCount(Criteria cri);
	
	public List<BoardVO> boardList(Criteria cri);
	
	public void insertBoard(BoardVO vo);
	
	public int updateView(@Param("bno") int bno);
	
	public int update(BoardVO vo);
	
	public int delete(@Param("bno") int bno);
	
	public BoardVO getBoard(@Param("bno") int bno);
	
	// 11-11
		public List<BoardVO> freeList(Criteria cri);
		
		public int freeCount(Criteria cri);
}
