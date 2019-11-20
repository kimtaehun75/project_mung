package kr.icia.controller;

import java.security.Principal;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.AdoptVO;
import kr.icia.domain.BoardEventVO;
import kr.icia.domain.BoardFaqVO;
import kr.icia.domain.BoardVO;
import kr.icia.domain.CouponVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.DogsVO;
import kr.icia.domain.MemberVO;
import kr.icia.domain.PageDTO;
import kr.icia.domain.SaleVO;
import kr.icia.service.AdoptService;
import kr.icia.service.CouponService;
import kr.icia.service.EventService;
import kr.icia.service.FaqService;
import kr.icia.service.FreeService;
import kr.icia.service.MemberService;
import kr.icia.service.ReportService;
import kr.icia.service.SaleService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {
	
	private MemberService service;
	
	private SaleService sService;
	
	private EventService eService;
	
	private CouponService cService;
	
	private AdoptService aService;
	
	private ReportService rService;
	
	private FaqService fService;
	
	private FreeService frService;
	
	@GetMapping("/member/member")
	public void connectAdmin(Criteria cri,Model model) {
		log.info("list : "+service.getList(cri));
		log.info("pageMaker : "+new PageDTO(cri,service.getMemberCount(cri)));
		
		model.addAttribute("list",service.getList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,service.getMemberCount(cri)));
	}//end MemberList
	
	@GetMapping("/member/getMember")
	public String modifyUser(@Param("userid") String userid,
			RedirectAttributes rttr) {
		log.info("userid : "+userid);
		
		rttr.addFlashAttribute("member",service.getMember(userid));
		rttr.addFlashAttribute("list",service.getGradeList());
	
		return "redirect:/admin/member/modify";
	}
	
	@GetMapping("/member/modify")
	public void modifyPage() {
		
	}
	
	@PostMapping("/member/modify")
	public String modify(MemberVO vo,RedirectAttributes rttr) {
		
		if(service.adminUpdateUser(vo)) {
			rttr.addFlashAttribute("result","회원정보 수정이 완료되었습니다.");
		}else {
			rttr.addFlashAttribute("result","수정이 실패하였습니다.");
		}
		
		return "redirect:/admin/member/member";
	}
	
	@GetMapping("/product/list")
	public void productList(Criteria cri,
			Model model) {
		log.info("productList");
		log.info("pageMaker : "+new PageDTO(cri,sService.getCount(cri)));
		
		model.addAttribute("menu",sService.getCate());
		model.addAttribute("list",sService.getSale(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,sService.getCount(cri)));
	}
	
	@GetMapping("/product/saleinfo")
	public void getDetail(@Param("saleno") String saleno,Model model) {
			
		log.info("saleno :"+saleno);
		
		model.addAttribute("cate",sService.getCate());
		model.addAttribute("saleInfo",sService.getAdminSaleInfo(saleno));
			
	}
		
	@PostMapping("/product/saleInfo")
	public String modify(SaleVO vo,RedirectAttributes rttr) {

		log.info("modify: " + vo);

		if (sService.updateSale(vo)) {
			rttr.addFlashAttribute("result", "success");
		}
		// 수정이 성공하면 success 메세지가 포함되어 이동.
		// 실패해도 메세지 빼고 이동.

		return "redirect:/admin/product/list";
	}
	
	@GetMapping("/product/register")
	public void productGetRegister(Criteria cri,Model model) {
		log.info("productRegister");
		
		model.addAttribute("list",sService.getCate());
		model.addAttribute("count",sService.getSaleCount(cri));
		
	}

	@PostMapping("/product/saleUpload")
	public String productUpload(SaleVO vo,RedirectAttributes rttr) {
		log.info("productUpload");
		log.info("attachImage : "+vo.getAttachImage());
		sService.register(vo);
		
		return "redirect:/admin/product/list";
	}
	
	@PostMapping("/product/remove")
	public String productRemove(SaleVO vo,RedirectAttributes rttr) {
		log.info("productRemove");
		log.info("attachImage : "+vo.getAttachImage());
		
		if(sService.removeSale(vo)) {
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/admin/product/list";
	}
	
	@GetMapping("/event/event")
	public void eventEvent(Criteria cri, Model model) {
		log.info("list : "+eService.getEvent(cri));
		log.info("eventCount : "+eService.getEventCount(cri));
		log.info("pageMaker : "+new PageDTO(cri,eService.getEventCount(cri)));
		
		cri.setAmount(4);
		
		model.addAttribute("list",eService.getEvent(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,eService.getEventCount(cri)));
	}
	
	@GetMapping("/event/addEvent")
	public void eventAddEvent(Criteria cri, Model model, Principal prin) {
		
		String userid = prin.getName();
		
		model.addAttribute("userid",userid);

	}
	
	@PostMapping("/event/eventUpload")
	public String eventUpload(BoardEventVO vo, RedirectAttributes rttr) {
		log.info("eventUpload");
		log.info("vo : "+vo);
		log.info("attachImage : " + vo.getAttachImage());
	
		eService.register(vo);

		return "redirect:/admin/event/event";
	}
	
	@GetMapping("/coupon/coupon")
	public void couponCoupon(Criteria cri, Model model) {
		log.info("couponList");
		log.info("list : "+cService.getCouponList(cri));
		
		model.addAttribute("list",cService.getCouponList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,cService.getCouponCount(cri)));
		
	}
	
	@GetMapping("/coupon/list")
	public void couponList(Criteria cri,Model model) {
		log.info("haveCouponList");
		log.info("list : "+cService.haveCouponList(cri));
		
		model.addAttribute("list",cService.haveCouponList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,cService.haveCouponCount(cri)));
	}
	
	@GetMapping("/coupon/addCoupon")
	public void addCoupon() {
		log.info("addCoupon");
	}
	
	@GetMapping("/coupon/addGrade")
	public void addGrade(Model model) {
		log.info("addGrade");
		
		model.addAttribute("grade",service.getGradeList());
		model.addAttribute("list",cService.getCoupon());
	}
	
	@GetMapping("/coupon/addUser")
	public void addUser(Model model) {
		log.info("addUser");
		
		model.addAttribute("list",cService.getCoupon());
	}
	
	@PostMapping("/coupon/registerCoupon")
	public String couponRegister(CouponVO vo,RedirectAttributes rttr) {
		log.info("couponRegister");
		log.info("vo : "+vo);
		
		cService.insertCoupon(vo);

		return "redirect:/admin/coupon/coupon";
	}
	
	@PostMapping("/coupon/registerGrade")
	public String couponRegisterGrade(CouponVO vo,RedirectAttributes rttr) {
		log.info("registerGrade");
		log.info("vo : "+vo);
		
		cService.inserGradeCoupon(vo);

		return "redirect:/admin/coupon/list";
	}
	
	@PostMapping("/coupon/registerUser")
	public String couponRegisterUser(CouponVO vo,RedirectAttributes rttr) {
		log.info("registerUser");
		log.info("vo : "+vo);
		
		cService.insertUser(vo);

		return "redirect:/admin/coupon/list?type=I&keyword="+vo.getUserid();
	}
	

	@GetMapping("/dogReg/dogReg")
	public void dogRegDogReg(Criteria cri, Model model) {
		log.info("doglist : ");
		
		model.addAttribute("list", aService.getDogsList(cri));
	}
	
	@GetMapping("/dogReg/dRegister")
	public void dogRegdRegister(@RequestParam("dogno") int dogno, Criteria cri,Model model) {
		log.info("dogdRegister : ");

		model.addAttribute("dogs", aService.getDogs(dogno));
	}
	
	@PostMapping("/dogReg/dogUpdate")
	public String dogUpdate(DogsVO vo, RedirectAttributes rttr) {
		log.info("dogUpdate : "+vo);
		if(aService.update(vo)) {
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/admin/dogReg/dogReg";
	}
	
	@GetMapping("/dogAdopt/dogAdopt")
	public void dogAdoptDogAdopt(Criteria cri,Model model) {
		log.info("adoptList : ");
		
		model.addAttribute("list", aService.getRequestList(cri));
	}
	
	@GetMapping("/dogAdopt/adoptAdmit")
	   public void dogAdoptAdoptAdmit(@RequestParam("dogno") int dogno, @RequestParam("bno") int bno, Model model) {
	      log.info("adoptAdmit bno : "+bno);
	      log.info("adoptAdmit  dogno : "+dogno);
	      
	      model.addAttribute("adopt", aService.getRequestUser(bno));
	   }
	
	@PostMapping("/dogAdopt/adoptCompl")
	public String dogAdoptAdoptCompl(AdoptVO vo, RedirectAttributes rttr) {
		log.info("adoptCompl : " + vo);
		
		if(aService.adopt(vo)) {
			log.info("success");
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/admin/dogAdopt/dogAdopt";
	}
	
	@GetMapping("/report/report")
	public void reportList(Criteria cri,Model model) {
		
		
		model.addAttribute("list",rService.reportList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,rService.reportListCount(cri)));
	}
	
	@GetMapping("/report/detail")
	public void reportDetail(@Param("bno") int bno,Model model) {
		
		model.addAttribute("list",rService.getReport(bno));
	}
	

	@GetMapping("/faq/faq")
	public void faq(Criteria cri, Model model) {
		log.info("faqList");
		log.info("List : " + fService.faqList(cri));
		log.info("pageMaker : " + new PageDTO(cri, fService.faqCount(cri)));

		cri.setAmount(10);

		model.addAttribute("faq", fService.faqList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, fService.faqCount(cri)));
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/faq/addFaq")
	public void addFaq() {

	}

	@GetMapping("/faq/faqInfo")
	public void getInfo(@Param("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("bno : " + bno);

		model.addAttribute("faq", fService.getFaq(bno));

	}
	
	@PostMapping("/faq/remove")
	public String remove(BoardFaqVO vo,RedirectAttributes rttr) {
		
		if(fService.delete(vo.getBno())){
			rttr.addFlashAttribute("result","게시물 삭제가 완료되었습니다.");
		}
		
		return "redirect:/admin/faq/faq";
	}
	
	@PostMapping("/faq/insertFaq")
	   public String faq(BoardFaqVO vo, RedirectAttributes rttr) {
	      log.info("insertFaq : ");
	      log.info("vo : " + vo);

	      fService.register(vo);
	      
	      
	      rttr.addFlashAttribute("result","글 추가가 완료되었습니다.");
	      

	      return "redirect:/admin/faq/faq";
	  }
	

	@GetMapping("/free/free")
	public void free(Criteria cri, Model model) {
		log.info("freeList : ");
		log.info("List : " + frService.freeList(cri));
		log.info("pageMaker : " + new PageDTO(cri, frService.freeCount(cri)));

		cri.setAmount(10);

		model.addAttribute("free", frService.freeList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, frService.freeCount(cri)));
	}
	
	@GetMapping("/free/freeInfo")
	public void getfreeInfo(@Param("bno") int bno,@ModelAttribute("cri") Criteria cri,Model model) {
		log.info("bno : "+bno);
		
		model.addAttribute("free",frService.getBoard(bno));
	}

	@PostMapping("/free/remove")
	public String remove(BoardVO vo,@ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		
		if(frService.delete(vo.getBno())){
			rttr.addFlashAttribute("result","게시물 삭제가 완료되었습니다.");
		}
		
		return "redirect:/admin/free/free"+cri.getListLink();
	}
	
	@GetMapping("/free/modify")
	public void modify(@Param("bno") int bno,@ModelAttribute("cri") Criteria cri, Model model) {
		log.info("modify");
		
		log.info("content : "+frService.getBoard(bno));
		
		model.addAttribute("free",frService.getBoard(bno));
	}
	
	@PostMapping("/free/freeModify")
	public String update(BoardVO vo,
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		
		log.info("bno : "+vo.getBno());
		log.info("vo : "+vo);
		
		if(frService.update(vo)) {
			rttr.addFlashAttribute("result","수정이 완료되었습니다.");
		}
		
		return "redirect:/admin/free/free"+cri.getListLink();
	}
}
