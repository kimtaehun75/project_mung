package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.CouponVO;
import kr.icia.domain.Criteria;
import kr.icia.mapper.CouponMapper;
import kr.icia.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class CouponServiceImpl implements CouponService {
	
	@Setter(onMethod_=@Autowired)
	private CouponMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private MemberMapper mMapper;

	@Override
	public List<CouponVO> getCouponList(Criteria cri) {
		log.info("getCoponList..");
		return mapper.getCouponList(cri);
	}

	@Override
	public int getCouponCount(Criteria cri) {
		log.info("getCouponCount..");
		return mapper.getCouponCount(cri);
	}

	@Override
	public void insertCoupon(CouponVO vo) {
		log.info("insertCoupon");
		mapper.insertCoupon(vo);
	}

	@Override
	public List<CouponVO> getCoupon() {
		log.info("getCoupon");
		return mapper.getCoupon();
	}

	@Override
	public void inserGradeCoupon(CouponVO vo) {
		log.info("insertGradeCoupon");
		
		List<String> userid = mMapper.getGradeId((vo.getGrade().getTear()));
		
		userid.forEach(id->{
			vo.setUserid(id);
			mapper.insertGradeCoupon(vo);
		});
	}

	@Override
	public List<CouponVO> haveCouponList(Criteria cri) {
		log.info("haveCouponList..");
		return mapper.haveCouponList(cri);
	}

	@Override
	public int haveCouponCount(Criteria cri) {
		log.info("haveCouponCount");
		return mapper.haveCouponCount(cri);
	}

	@Override
	public void insertUser(CouponVO vo) {
		log.info("insertUser..");
		if(mMapper.userIdCheck(vo.getUserid()) == 1)
			mapper.insertGradeCoupon(vo);
	}

	@Override
	public CouponVO getCouponValue(String userid,int cpnum) {
		log.info("getCouponValue");
		return mapper.getCouponValue(userid,cpnum);
	}

	@Override
	public List<CouponVO> haveUserCoupon(String userid) {
		log.info("haveUserCoupon");
		return mapper.haveUserCoupon(userid);
	}

	@Override
	public void deleteUser(String userid) {
		
		mapper.deleteUser(userid);
	}

	@Override
	public boolean deleteCoupon(CouponVO vo) {
		
		return mapper.deleteCoupon(vo) > 0;
	}
	
}
