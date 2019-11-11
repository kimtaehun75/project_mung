package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.icia.domain.BoardRvVO;
import kr.icia.domain.CateVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.SaleVO;
import kr.icia.mapper.CartMapper;
import kr.icia.mapper.GoodMapper;
import kr.icia.mapper.ImageMapper;
import kr.icia.mapper.SaleMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class SaleServiceImpl implements SaleService {
	
	@Setter(onMethod_=@Autowired)
	private CartMapper Cmapper;
	
	@Setter(onMethod_=@Autowired)
	private GoodMapper Gmapper;
	
	@Setter(onMethod_=@Autowired)
	private SaleMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private ImageMapper imgMapper;
	
	@Override
	public List<CateVO> getCate() {
		log.info("getCategori...");
		return mapper.getCate();
	}

	@Override
	public int getSaleCount(Criteria cri) {
		log.info("getSaleCount...");
		return mapper.getSaleCount(cri);
	}

	@Override
	public void register(SaleVO vo) {
		log.info("register");
		mapper.register(vo);
		
		if(vo.getAttachImage() == null) {
			return;
		}
		
		imgMapper.insert(vo.getAttachImage());
		
	}

	@Override
	public SaleVO getSaleInfo(int saleno) {
		log.info("getSaleInfo..");
		return mapper.getSaleInfo(saleno);
	}

	@Override
	public List<SaleVO> getSaleList(Criteria cri) {
		log.info("getSaleList..");
		return mapper.getSaleList(cri);
	}

	@Override
	public int getCount(Criteria cri) {
		log.info("getCount..");
		return mapper.getCount(cri);
	}

	@Override
	public List<SaleVO> getSale(Criteria cri) {
		log.info("getSale..");
		if(cri.getCateno() == 0) {
			return mapper.getSale(cri);
		}
		
		
		return mapper.getSaleList(cri);
	}

	@Override
	public SaleVO getAdminSaleInfo(String saleno) {
		log.info("getAdminSaleInfo..");
		return mapper.getAdminSaleInfo(saleno);
	}
	
	@Transactional
	@Override
	public boolean updateSale(SaleVO vo) {
		log.info("updateSale..");
		
		boolean check = false;
		
		if(vo.getAttachImage() == null) {
			if(mapper.updateSale(vo) == 1) {
				check = true;
				return check;
			}
		}else if(vo.getAttachImage() != null){
			vo.getAttachImage().setSaleno(vo.getSaleno());
			if(imgMapper.updateSale(vo.getAttachImage()) == 1) {
				if(mapper.updateSale(vo) == 1) {
					check = true;
				}
			}
		}
		
		return check;
	}
	@Transactional
	@Override
	public boolean removeSale(SaleVO vo) {
		log.info("removeSale");
		
		Cmapper.removeCart(vo.getSaleno());
		Gmapper.removeGood(vo.getSaleno());
		imgMapper.removeSaleImage(vo.getSaleno());
		
		return mapper.deleteSale(vo.getSaleno()) == 1;
	}

	@Override
	public int getRevCount(Criteria cri) {
		log.info("getRevCount...");
		return mapper.getRevCount(cri);
	}

	@Override
	public List<BoardRvVO> getReview(Criteria cri) {
		log.info("getReviewList...");
		return mapper.getReview(cri);
	}

	@Override
	public void reviewReg(BoardRvVO vo) {
		log.info("reviewReg : ");
		mapper.reviewReg(vo);
		
		if(vo.getAttachImage() == null) {
			return;
		}
		
		imgMapper.insertReview(vo.getAttachImage());
		
	}

	@Override
	public int getRevCountUser(Criteria cri) {
		
		return mapper.getRevCountUser(cri);
	}

	@Override
	public List<BoardRvVO> getReviewUser(Criteria cri) {
		
		return mapper.getReviewUser(cri);
	}

}
