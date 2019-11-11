package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.Criteria;
import kr.icia.domain.ReplyPageDTO;
import kr.icia.domain.ReplyVO;
import kr.icia.mapper.FreeMapper;
import kr.icia.mapper.ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private FreeMapper Boardmapper;
	
	@Override
	public void register(ReplyVO vo) {
		log.info("register..."+vo);
		
		mapper.insert(vo);
	}
	
	
	@Override
	public int remove(int rno) {
		log.info("remove.."+rno);
		
		return mapper.delete(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify : "+vo);
		return mapper.update(vo);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, int bno) {
		log.info("getList..."+cri+","+bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public int getCount(int bno) {
		log.info("getReplyCount..");
		return mapper.getCount(bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, int bno) {
		log.info("getListPage...");
		return new ReplyPageDTO(mapper.getCount(bno),mapper.getListWithPaging(cri, bno));
	}


	@Override
	public ReplyVO get(int rno) {
		log.info("get.."+rno);
		return mapper.read(rno);
	}
	
}
