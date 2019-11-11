package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.BoardFaqVO;
import kr.icia.domain.Criteria;

public interface FaqMapper {

	public int register(BoardFaqVO vo);

	public List<BoardFaqVO> faqList(Criteria cri);

	public int faqCount(Criteria cri);

	public BoardFaqVO getFaq(@Param("bno") int bno);

	public int delete(@Param("bno") int bno);

} //end class