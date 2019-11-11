package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.BoardFaqVO;
import kr.icia.domain.Criteria;
import kr.icia.mapper.FaqMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FaqServiceImpl implements FaqService {
	// 11-06 작업분
	@Setter(onMethod_=@Autowired)
	private FaqMapper mapper;
	
	@Override
	public void register(BoardFaqVO vo) {
		log.info("faqregister : ");
		
		mapper.register(vo);
	}

	@Override
	public List<BoardFaqVO> faqList(Criteria cri) {
		log.info("getFaqList..");
		return mapper.faqList(cri);
	}

	@Override
	public int faqCount(Criteria cri) {
		log.info("getFaqCount");
		return mapper.faqCount(cri);
	}

	@Override
	public BoardFaqVO getFaq(int bno) {
		log.info("getFaq");
		return mapper.getFaq(bno);
	}

	@Override
	public boolean delete(int bno) {
		
		return mapper.delete(bno) == 1;
	}

}
