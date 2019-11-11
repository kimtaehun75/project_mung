package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.BoardVO;
import kr.icia.domain.Criteria;
import kr.icia.mapper.FreeMapper;
import kr.icia.mapper.ImageMapper;
import kr.icia.mapper.ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class FreeServiceImpl implements FreeService {
	
	@Setter(onMethod_=@Autowired)
	private FreeMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper Rmapper;
	
	@Setter(onMethod_=@Autowired)
	private ImageMapper imgMapper;
	
	@Override
	public int boardCount(Criteria cri) {
		log.info("getFreeCount");
		return mapper.boardCount(cri);
	}

	@Override
	public List<BoardVO> boardList(Criteria cri) {
		log.info("getBoardList..");
		return mapper.boardList(cri);
	}

	@Override
	public void insertBoard(BoardVO vo) {
		log.info("insertBoard");
		
		mapper.insertBoard(vo);
	}

	@Override
	public BoardVO getBoard(int bno) {
		log.info("getBoard");
		return mapper.getBoard(bno);
	}

	@Override
	public boolean updateView(int bno) {
		boolean check = false;
		
		if(mapper.updateView(bno) == 1)
			check = true;
		
		return check;
	}

	@Override
	public boolean delete(int bno) {
		
		Rmapper.deleteAll(bno);
		
		if(imgMapper.checkBoardImg(bno) != null) {
			imgMapper.removeBoard(bno);
		}
		
		return mapper.delete(bno) == 1;
	}

	@Override
	public boolean update(BoardVO vo) {
		
		return mapper.update(vo) == 1;
	}
	
	// 11-11
		@Override
		public List<BoardVO> freeList(Criteria cri) {
			log.info("getFreeList..");
			return mapper.freeList(cri);
		}
		// 11-11
		@Override
		public int freeCount(Criteria cri) {
			log.info("getFreeCount : ");
			return mapper.freeCount(cri);
		}
}
