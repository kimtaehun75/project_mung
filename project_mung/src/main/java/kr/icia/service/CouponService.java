package kr.icia.service;

import java.util.List;

import kr.icia.domain.CouponVO;
import kr.icia.domain.Criteria;

public interface CouponService {
	public List<CouponVO> getCouponList(Criteria cri);
	
	public List<CouponVO> getCoupon();
	
	public List<CouponVO> haveCouponList(Criteria cri);
	
	public int getCouponCount(Criteria cri);
	
	public int haveCouponCount(Criteria cri);
	
	public void insertCoupon(CouponVO vo);
	
	public void inserGradeCoupon(CouponVO vo);
	
	public void insertUser(CouponVO vo);
	
	public List<CouponVO> haveUserCoupon(String userid);
	
	public CouponVO getCouponValue(String userid,int cpnum);
	
	public void deleteUser(String userid);
	
	public boolean deleteCoupon(CouponVO vo);
}
