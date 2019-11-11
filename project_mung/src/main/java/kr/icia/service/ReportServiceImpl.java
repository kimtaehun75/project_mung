package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.Criteria;
import kr.icia.domain.ReportVO;
import kr.icia.mapper.ReportMapper;
import lombok.Setter;

@Service
public class ReportServiceImpl implements ReportService {
	
	@Setter(onMethod_=@Autowired)
	private ReportMapper mapper;
	
	@Override
	public void insertReport(ReportVO vo) {
		mapper.insertReport(vo);
	}

	@Override
	public List<ReportVO> reportList(Criteria cri) {
		
		return mapper.reportList(cri);
	}

	@Override
	public int reportListCount(Criteria cri) {
		
		return mapper.reportListCount(cri);
	}

	@Override
	public ReportVO getReport(int bno) {
		
		return mapper.getReport(bno);
	}
	
	
}
