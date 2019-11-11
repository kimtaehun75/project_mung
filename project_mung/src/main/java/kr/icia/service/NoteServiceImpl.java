package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.NoteVO;
import kr.icia.mapper.NoteMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class NoteServiceImpl implements NoteService {

	@Setter(onMethod_=@Autowired)
	private NoteMapper mapper;
	
	@Override
	public String getRecvCount(String userid) {
		log.info("getRecvCount..");
		return mapper.getRecvCount(userid);
	}
	
	@Override
	public List<NoteVO> getSentList(String userid) {
		log.info("getSentList....");
		return mapper.getSentList(userid);
	}

	@Override
	public List<NoteVO> getRecvList(String userid) {
		log.info("getRecvList....");
		return mapper.getRecvList(userid);
	}

	@Override
	public NoteVO getSent(int noteno) {
		log.info("getSent...");
		return mapper.getSent(noteno);
	}
	
	@Override
	public NoteVO getRecv(int noteno) {
		log.info("getRecv...");
		return mapper.getRecv(noteno);
	}

	@Override
	public void writemail(NoteVO vo) {
		log.info("writemail");
		
		mapper.writemail(vo);		
	}

	@Override
	public boolean updateRecvCount(int noteno) {
		log.info("updateRecvCount..");
		
		return mapper.updateRecvCount(noteno) == 1;
	}
}
