package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.BoardRvVO;
import kr.icia.domain.CateVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.SaleVO;

public interface SaleService {
	public List<CateVO> getCate();
	
	public int getSaleCount(Criteria cri);
	
	public void register(SaleVO vo);
	
	public List<SaleVO> getSale(Criteria cri);
	
	public List<SaleVO> getSaleList(Criteria cri);
	
	public int getCount(Criteria cri);
	
	public SaleVO getSaleInfo(@Param("saleno") int saleno);
	
	public SaleVO getAdminSaleInfo(@Param("saleno") String saleno);
	
	public boolean updateSale(SaleVO vo);
	
	public boolean removeSale(SaleVO vo);

	public int getRevCount(Criteria cri);
	
	public int getRevCountUser(Criteria cri);
	
	public List<BoardRvVO> getReview(Criteria cri);
	
	public List<BoardRvVO> getReviewUser(Criteria cri);

	public void reviewReg(BoardRvVO vo);
}
