package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.CouponVO;
import kr.icia.domain.Criteria;

public interface CouponMapper {
	public List<CouponVO> getCouponList(Criteria cri);
	
	public List<CouponVO> getCoupon();
	
	public int getCouponCount(Criteria cri);
	
	public int haveCouponCount(Criteria cri);
	
	public List<CouponVO> haveCouponList(Criteria cri);
	
	public void insertCoupon(CouponVO vo);
	
	public void insertGradeCoupon(CouponVO vo);
	
	public List<CouponVO> haveUserCoupon(String userid);
	
	public CouponVO getCouponValue(@Param("userid") String userid,
			@Param("cpnum") int cpnum);
	
	public void deleteUser(String userid);
	
	public int deleteCoupon(CouponVO vo);
}
