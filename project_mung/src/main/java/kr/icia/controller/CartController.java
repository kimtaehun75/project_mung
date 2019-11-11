package kr.icia.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;
import kr.icia.domain.CouponVO;
import kr.icia.domain.Criteria;
import kr.icia.service.CartService;
import kr.icia.service.CouponService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/cart/*")
public class CartController {
	
	private CartService Cservice;
	
	private CouponService Sservice;
	
	@GetMapping(value="/getSaleCost/{userid}/{cpnum}",
			produces= { 
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
				})
	@ResponseBody
	public ResponseEntity<CouponVO> getSaleCost(
			@PathVariable("userid") String userid,
			@PathVariable("cpnum") int cpnum){
		
		log.info("getCartCost..");
		log.info("userid : "+userid);
		log.info("cpnum : "+cpnum);
		log.info("value : "+Sservice.getCouponValue(userid,cpnum));
		
		if(Sservice.getCouponValue(userid,cpnum) == null) {
			CouponVO coupon = new CouponVO();
			coupon.setDisCost("￦0");
			if(Cservice.allCartCost(userid).getCost() == null) {
				coupon.setSaleCost("￦0");
			}else {
				coupon.setSaleCost(Cservice.allCartCost(userid).getCost());
			}
			return new ResponseEntity<>(coupon,HttpStatus.OK);
		}
		if(Sservice.getCouponValue(userid,cpnum).getSaleCost() == null) {
			CouponVO coupon = new CouponVO();
			coupon.setDisCost("￦0");
			coupon.setSaleCost("￦0");
			return new ResponseEntity<>(coupon,HttpStatus.OK); 
		}
		
		return new ResponseEntity<>(Sservice.getCouponValue(userid,cpnum),HttpStatus.OK);
	}
	
	@GetMapping(value="/getCouponList/{userid}",produces= { 
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE
		})
	@ResponseBody
	public ResponseEntity<List<CouponVO>> getCouponList(
			@PathVariable("userid") String userid){
		
		log.info("userid : "+userid);
		log.info("coupon : "+Sservice.haveUserCoupon(userid));
		
		return new ResponseEntity<>(Sservice.haveUserCoupon(userid),HttpStatus.OK);
	}
	
	@GetMapping(value = "/getCartCount", produces= { 
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE
		})
	@ResponseBody
	public ResponseEntity<String> getCartCount(Principal prin) {
			String userid = prin.getName();
			
			String cart = Cservice.getCartCount(userid);
			log.info("cart : "+cart);
			
		return new ResponseEntity<>(cart,HttpStatus.OK);
	}
	
	@GetMapping(value = "/checkCartCount/{saleno}", produces= { 
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE
		})
	@ResponseBody
	public ResponseEntity<String> checkCartCount(Principal prin,
			@PathVariable("saleno") int saleno) {
			String userid = prin.getName();
			
			CartVO vo = new CartVO();
			
			vo.setSaleno(saleno);
			vo.setUserid(userid);
			
			String count = Cservice.checkCart(vo);
			
		return new ResponseEntity<>(count,HttpStatus.OK);
	}
	
	@PostMapping(value="/insertMainCart",
			produces= { 
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
				})
	@ResponseBody
	public ResponseEntity<String> insertMainCart(Principal prin,@RequestBody CartVO vo,Model model){
		log.info("CartVO : "+vo);
		
		log.info("userid : "+vo.getUserid());
		
		return Cservice.getMainCart(vo) == 1?new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>("fail",HttpStatus.OK);
	}
	
	@GetMapping(value="/getCartList/{userid}",
			produces= { 
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
				})
	@ResponseBody
	public ResponseEntity<List<CartListVO>> getCartList(
			@PathVariable("userid") String userid){
		
		log.info("getCartList..");
		
		return new ResponseEntity<>(Cservice.getCartList(userid),HttpStatus.OK);
	}
	
	@GetMapping(value="/getCartCost/{userid}",
			produces= { 
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
				})
	@ResponseBody
	public ResponseEntity<CartListVO> getCartCost(
			@PathVariable("userid") String userid){
		
		log.info("getCartCost..");
		
		log.info("userid : "+userid);
		
		log.info("cost : "+Cservice.allCartCost(userid));
		
		if(Cservice.allCartCost(userid) == null) {
			CartListVO vo = new CartListVO();
			vo.setCost("￦0");
			System.out.println("cost : "+vo.getCost());
			return new ResponseEntity<>(vo,HttpStatus.OK); 
		}
		
		return new ResponseEntity<>(Cservice.allCartCost(userid),HttpStatus.OK);
	}
	
	@PreAuthorize("principal.username == #vo.userid")
	@DeleteMapping(value="/",
			produces= {
					MediaType.TEXT_PLAIN_VALUE
			})
	@ResponseBody
	public ResponseEntity<String> removeCart(
			@RequestBody CartVO vo
			){
		log.info("delete : "+vo.getSaleno());
		
		return Cservice.removeCart(vo) == 1?new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>("fail",HttpStatus.OK);
	}
}	
