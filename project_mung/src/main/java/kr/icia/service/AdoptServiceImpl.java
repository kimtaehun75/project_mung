 package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.AdoptVO;
import kr.icia.domain.BoardVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.DogsVO;
import kr.icia.domain.MemberVO;
import kr.icia.mapper.AdoptMapper;
import kr.icia.mapper.ImageMapper;
import kr.icia.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdoptServiceImpl implements AdoptService {

	@Setter(onMethod_=@Autowired)
	private AdoptMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private ImageMapper imgMapper;
	
	@Setter(onMethod_=@Autowired)
	private MemberMapper Mmapper;
	
	@Override
	public List<DogsVO> getDogsList(Criteria cri) {
		log.info("getDogsList...");
		return mapper.getDogsList(cri);
	}

	@Override
	public void register(DogsVO vo) {
		log.info("dogRegister : ");
		mapper.register(vo);
		
		if(vo.getAttachImage() == null) {
			return;
		}
		
		imgMapper.insertDogs(vo.getAttachImage());
	}

	@Override
	public DogsVO getDogs(int dogno) {
		log.info("get....." + dogno);

		return mapper.getDogs(dogno);
	}

	@Override
	public boolean update(DogsVO vo) {
		log.info("update : " );
	
		return mapper.update(vo) == 1;
	}

	@Override
	public List<DogsVO> getDogsUserList(Criteria cri) {
		log.info("getDogsUserList : ");
		
		return mapper.getDogsUserList(cri);
	}
	

	@Override
	public DogsVO getDogProfile(int dogno) {
		log.info("getDogProfile : " + dogno);
		
		return mapper.getDogProfile(dogno);
	}

	@Override
	public MemberVO getMember(String userid) {
		log.info("getMemberAdopt : ");
		
		return mapper.getMember(userid);
	}

	@Override
	public void adoptRequest(AdoptVO vo) {
		log.info("getAdoptRequest");

		mapper.getRequest(vo);
	}

	@Override
	public List<AdoptVO> getRequestList(Criteria cri) {
		log.info("getRequestList : ");
		
		return mapper.getRequestList(cri);
	}

	@Override
	public AdoptVO getRequestUser(int bno) {
		log.info("get....." + bno);

		return mapper.getRequestUser(bno);
	}

	@Override
	public boolean adopt(AdoptVO vo) {
		log.info("adopt : " );
		
		boolean check = false;
		
		if(Mmapper.updateAdopt(vo.getUserid()) == 1 && mapper.adopt(vo) == 1 && mapper.adoptUser(vo) == 1)
			check = true;
		
		return check;
		
	}
	
	@Override
	public void insertAfter(BoardVO vo) {
			log.info("dogRegister : ");
			mapper.insertAfter(vo);
			
			if(vo.getAttachImage() == null) {
				return;
			}
			
			imgMapper.insertAfter(vo.getAttachImage());
		}

	@Override
	public List<BoardVO> afterList(Criteria cri) {
		log.info("getAfterList..");
		return mapper.afterList(cri);
	}

	@Override
	public int afterCount(Criteria cri) {
		log.info("getAfterCount");
		return mapper.afterCount(cri);
	}

	@Override
	public boolean updateView(int bno) {
		boolean check = false;
		
		if(mapper.updateView(bno) == 1)
			check = true;
		
		return check;
	}

	@Override
	public BoardVO getAfter(int bno) {
		log.info("getAfter");
		
		return mapper.getAfter(bno);
	}
} //end class
