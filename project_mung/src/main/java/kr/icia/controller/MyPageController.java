package kr.icia.controller;

import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.BoardRvVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.MemberVO;
import kr.icia.domain.PageDTO;
import kr.icia.domain.PasswordVO;
import kr.icia.security.CustomUserDetailsService;
import kr.icia.security.domain.CustomUser;
import kr.icia.service.CartService;
import kr.icia.service.CouponService;
import kr.icia.service.GoodService;
import kr.icia.service.MailService;
import kr.icia.service.MemberService;
import kr.icia.service.NoteService;
import kr.icia.service.OrderService;
import kr.icia.service.SaleService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mypage/*")
@AllArgsConstructor
public class MyPageController {
	
	private MemberService service;
	private NoteService Nservice;
	private CouponService Cservice;
	private CartService Sservice;
	private GoodService Gservice;
	private MailService Mservice;
	private OrderService Oservice;
	private SaleService sService;
	
	private CustomUserDetailsService UserService;
	private BCryptPasswordEncoder pwencoder;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getInfo")
	public String getMyPage(Principal prin,RedirectAttributes rttr) {
		
		String userid = prin.getName();
		log.info("userid : "+userid);
		rttr.addFlashAttribute("member",service.getUser(userid));
		
		return "redirect:/mypage/info";
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/info")
	public void info() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getPost")
	public String getPost() {
			
		return "redirect:/mypage/post";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/post")
	public void post() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getRefund")
	public String getRefund() {
		
		return "redirect:/mypage/refund";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/refund")
	public void refund() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getCoupon")
	public String getCoupon() {
		
		return "redirect:/mypage/coupon";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/coupon")
	public void coupon(Criteria cri,Model model,Principal prin) {
		
		String userid = prin.getName();
		cri.setType("I");
		cri.setKeyword(userid);
		
		model.addAttribute("coupon",Cservice.haveCouponList(cri));
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getOrder")
	public String getOrder() {
		
		return "redirect:/mypage/order";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/order")
	public void order(Criteria cri,Model model,Principal prin) {
		
		String userid = prin.getName();
		
		log.info("list : "+Oservice.getOrderList(userid));
		
		model.addAttribute("list",Oservice.getOrderList(userid));
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getQuestion")
	public String getQuestion() {
		
		return "redirect:/mypage/question";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/question")
	public void question() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getReview")
	public String getReview() {
		
		return "redirect:/mypage/review";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/review")
	public void review(Criteria cri,Model model,Principal prin) {
		
		String userid = prin.getName();
		
		cri.setUserid(userid);
		
		log.info("reviewList : "+sService.getReviewUser(cri));
		
		model.addAttribute("list",sService.getReviewUser(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,sService.getRevCountUser(cri)));
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getRecvMail")
	public String getRecvMail(Principal principal,RedirectAttributes rttr) {
		
		String userid = principal.getName();
		log.info("userid :"+userid);
		
		rttr.addFlashAttribute("recv",Nservice.getRecvList(userid));
		
		return "redirect:/mypage/recvmail";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/recvmail")
	public void recvMail() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getSentMail")
	public String getSentMail(Principal principal,RedirectAttributes rttr) {
		
		String userid = principal.getName();
		log.info("userid :"+userid);
		
		rttr.addFlashAttribute("sent",Nservice.getSentList(userid));
		
		return "redirect:/mypage/sentmail";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/sentmail")
	public void sentMail() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getCart")
	public String getCart() {
		
		return "redirect:/mypage/cart";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/cart")
	public void cart() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getWriteMail")
	public String getWriteMail() {
		
		return "redirect:/mypage/writemail";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/writemail")
	public void writeMail() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getSentMailInfo")
	public String sentMailInfo(
			@Param("noteno") int noteno,
			RedirectAttributes rttr) {
		
		log.info("noteno : "+noteno);
		
		rttr.addFlashAttribute("sent",Nservice.getSent(noteno));
	
		return "redirect:/mypage/sentMailInfo";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/sentMailInfo")
	public void sentMailInfo() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/getRecvMailInfo")
	public String recvMailInfo(
			@Param("noteno") int noteno,
			RedirectAttributes rttr) {
		
		log.info("noteno : "+noteno);
		
		if(!(Nservice.updateRecvCount(noteno))) {
			
			rttr.addFlashAttribute("result","오류가 발생하였습니다.");
			
			return "redirect:/mypage/getRecvMail";
		}
			
		rttr.addFlashAttribute("recv",Nservice.getRecv(noteno));
		
		return "redirect:/mypage/recvMailInfo";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/recvMailInfo")
	public void recvMailInfo() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/memberout")
	public void memberoutGet() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/memberout")
	public String memberoutPost(HttpSession session,Principal prin,
			@Param("userpw") String userpw,
			RedirectAttributes rttr) {
		
		String userid = prin.getName();
		CustomUser user = (CustomUser) UserService.loadUserByUsername(userid);
		
		log.info("userid : "+userid);
		log.info("userpw : "+userpw);
		log.info("have userpw : "+user.getPassword());
		
		if(pwencoder.matches(userpw, user.getPassword())) {
			Cservice.deleteUser(userid);
			Sservice.deleteUser(userid);
			Gservice.deleteUser(userid);
			Mservice.deleteUserAuth(userid);
			service.deleteUser(userid);
			
			SecurityContextHolder.clearContext();
			
			if(session != null)
			    session.invalidate();
			
			rttr.addFlashAttribute("result","회원탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.");
		}else {
			log.info("일치하지 않음");
			rttr.addFlashAttribute("result","비밀번호가 일치하지 않습니다.");
			return "redirect:/mypage/memberout";
		}
		
		return "redirect:/";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/changepw")
	public void changepw() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/changepw")
	public String changepwPost(HttpSession session,Principal prin,
			PasswordVO vo,
			RedirectAttributes rttr) {
		
		String userid = prin.getName();
		CustomUser user = (CustomUser) UserService.loadUserByUsername(userid);
		
		log.info("vo : "+vo);
		
		if(pwencoder.matches(vo.getOld(),user.getPassword())) {
			String userpw = pwencoder.encode(vo.getUserpw());
			log.info("userpw : "+userpw);
			MemberVO member = new MemberVO();
			member.setUserid(userid);
			member.setUserpw(userpw);
			service.changeNewPw(member);
			
			SecurityContextHolder.clearContext();
			
			if(session != null)
			    session.invalidate();
			
			rttr.addFlashAttribute("result","비밀번호가 변경되었습니다. 재 로그인해주시기 바랍니다.");
		}else {
			log.info("일치하지 않음");
			rttr.addFlashAttribute("result","비밀번호가 일치하지 않습니다.");
			return "redirect:/mypage/changepw";
		}
		
		return "redirect:/";
	}
	
	
	@GetMapping("/reviewReg")
	public void saleReviewReg(@Param("saleno") int saleno,Principal prin, Criteria cri, Model model) {
		log.info("moveReviewReg :  ");
		String userid = prin.getName();
		model.addAttribute("userid", userid);
		model.addAttribute("saleno",saleno);
		
	}
	// 11-08
	@PostMapping("/reviewReg")
	public String reviewReg(Principal prin ,BoardRvVO vo, RedirectAttributes rttr) {
		log.info("reviewReg : ");
		log.info("vo : " + vo);
		log.info("attachImage : " + vo.getAttachImage());
		
		sService.reviewReg(vo);
		
		return "redirect:/mypage/order";
	}
}
