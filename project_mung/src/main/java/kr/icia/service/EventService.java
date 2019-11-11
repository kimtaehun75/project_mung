package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.BoardEventVO;
import kr.icia.domain.Criteria;

public interface EventService {

	public void register(BoardEventVO vo);
	
	public int getEventCount(Criteria cri);
	
	public List<BoardEventVO> getEvent(Criteria cri);
	
	public BoardEventVO getEventInfo(@Param("bno") int bno);
	
	public boolean update(BoardEventVO vo);
	
	public boolean delete(@Param("bno") int bno);
	
} //end class
