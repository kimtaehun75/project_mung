package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.ReplyVO;

public interface ReplyMapper {
	
	public ReplyVO read(int rno);
	public void insert(ReplyVO vo);
	public int delete(int rno);
	public int update(ReplyVO vo);
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") int bno
			);
	
	public int getCount(int bno);
	
	public int deleteAll(int bno);
}
