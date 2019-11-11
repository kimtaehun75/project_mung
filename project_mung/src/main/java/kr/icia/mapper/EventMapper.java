package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.BoardEventVO;
import kr.icia.domain.Criteria;

public interface EventMapper {

	public void register(BoardEventVO vo);

	public int getEventCount(Criteria cri);
	
	public List<BoardEventVO> getEvent(Criteria cri);
	
	public BoardEventVO getEventInfo(@Param("bno") int bno);
	
	public int update(BoardEventVO vo);
	
	public int delete(@Param("bno") int bno);
} //end class
