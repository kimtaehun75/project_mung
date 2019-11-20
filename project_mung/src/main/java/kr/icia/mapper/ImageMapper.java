package kr.icia.mapper;

import kr.icia.domain.BoardImageVO;
import kr.icia.domain.DogsImageVO;
import kr.icia.domain.MemberImageVO;
import kr.icia.domain.SaleImageVO;

public interface ImageMapper {
	public String checkBoardImg(int bno);
	
	public void insert(SaleImageVO vo);
	public void delete(String uuid);
	public void deleteUser(int userno);
	public void removeUser(String userid);
	public void insertEvent(BoardImageVO vo);
	public void insertMember(MemberImageVO vo);
	public int updateMember(MemberImageVO vo);
	public int updateSale(SaleImageVO vo);
	public void insertDogs(DogsImageVO vo);
	
	public int checkUserno(String userid);
	
	public void removeSaleImage(int saleno);
	public void removeEvent(int bno);
	public void removeBoard(int bno);
	public void insertReview(BoardImageVO vo);
	public void insertAfter(BoardImageVO vo);
}
