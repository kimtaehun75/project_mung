package kr.icia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.GoodVO;
import kr.icia.mapper.GoodMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class GoodServiceImpl implements GoodService {

	@Setter(onMethod_=@Autowired)
	private GoodMapper mapper;
	
	@Override
	public String checkGood(GoodVO vo) {
		log.info("checkGood..");
		
		return mapper.checkGood(vo);
	}

	@Override
	public int insertGood(GoodVO vo) {
		log.info("insertGood..");
		
		return mapper.insertGood(vo);
	}

	@Override
	public int deleteGood(GoodVO vo) {
		log.info("deleteGood");
		
		return mapper.deleteGood(vo);
	}

	@Override
	public void deleteUser(String userid) {
		mapper.deleteUser(userid);
		
	}
	
}
