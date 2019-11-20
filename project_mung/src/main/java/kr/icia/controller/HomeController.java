package kr.icia.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.icia.domain.CouponVO;
import kr.icia.domain.OrderSaleVO;
import kr.icia.mapper.CartMapper;
import kr.icia.service.CouponService;
import kr.icia.service.MemberService;
import kr.icia.service.OrderService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
public class HomeController {
	
	private CartMapper Cmapper;
	
	private OrderService service;
	
	private CouponService Sservice;
	
	private MemberService mService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
			
		return "home";
	}
	
	@GetMapping("/company")
	public void company() {
		
	}
	
	@GetMapping("/grade")
	public void grade() {
		
	}
	
	@GetMapping("/guide")
	public void guide() {
		
	}
	
	@GetMapping("/order")
	public void orderGet(Principal prin,Model model) {
		
		String userid = prin.getName();
		
		model.addAttribute("userid",userid);
	}
	
	@PostMapping("/order")
	public String orderPost(OrderSaleVO vo) {
		log.info("vo : "+vo);
		
		
		if(vo.getCpnum() != 0) {
			service.insertOrderSaleCoupon(vo);
			service.insertOrderList(vo.getUserid());
		}else {
			service.insertOrderSale(vo);
			service.insertOrderList(vo.getUserid());
		}
		
		Cmapper.deleteUser(vo.getUserid());
		
		CouponVO coupon = new CouponVO();
		
		coupon.setCpnum(vo.getCpnum());
		coupon.setUserid(vo.getUserid());
		
		Sservice.deleteCoupon(coupon);
		
		return "redirect:/complete";
	}
	
	@GetMapping("/complete")
	public void complete(Principal prin,Model model) {
		
		String userid = prin.getName();
		
		model.addAttribute("orderno",service.searchOrderno(userid));
	}
}
