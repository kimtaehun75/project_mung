package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.BoardEventVO;
import kr.icia.domain.Criteria;
import kr.icia.mapper.EventMapper;
import kr.icia.mapper.ImageMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class EventServiceImpl implements EventService {

	@Setter(onMethod_=@Autowired)
	private EventMapper mapper; 
	
	@Setter(onMethod_=@Autowired)
	private ImageMapper imgMapper;
	
	@Override
	public void register(BoardEventVO vo) {
		log.info("register : ");
		mapper.register(vo);
		
		if(vo.getAttachImage() == null) {
			return;
		}
		
		imgMapper.insertEvent(vo.getAttachImage());
		
	}

	@Override
	public int getEventCount(Criteria cri) {
		log.info("getSaleCount...");
		return mapper.getEventCount(cri);
	}

	@Override
	public List<BoardEventVO> getEvent(Criteria cri) {
		log.info("getSaleList...");
		return mapper.getEvent(cri);
	}

	@Override
	public BoardEventVO getEventInfo(int bno) {
		log.info("getEventInfo..");
		return mapper.getEventInfo(bno);
	}

	@Override
	public boolean update(BoardEventVO vo) {
		log.info("update");
		return mapper.update(vo) == 1;
	}

	@Override
	public boolean delete(int bno) {
		log.info("delete");
		
		imgMapper.removeEvent(bno);
		
		return mapper.delete(bno) == 1;
	}

} //end class
