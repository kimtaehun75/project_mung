package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.ReportVO;

public interface ReportMapper {
	public void insertReport(ReportVO vo);
	
	public List<ReportVO> reportList(Criteria cri);
	
	public int reportListCount(Criteria cri);
	
	public ReportVO getReport(@Param("bno") int bno);
}	
