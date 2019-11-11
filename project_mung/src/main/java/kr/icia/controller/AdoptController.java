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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.AdoptVO;
import kr.icia.domain.BoardVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.DogsVO;
import kr.icia.domain.PageDTO;
import kr.icia.service.AdoptService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/adopt/*")
@AllArgsConstructor
public class AdoptController {
	
	private AdoptService aService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/adopt/adoptReg")
	public void adoptAdoptReg(Model model, Principal prin) {
		log.info("adoptReg : ");
		String userid = prin.getName();
		
		
		model.addAttribute("userid",userid);
	}
	
	@GetMapping("/adopt/adoptList")
	public void adoptAdoptDog(Criteria cri,Model model) {
		log.info("doglist : ");
		
		model.addAttribute("list", aService.getDogsUserList(cri));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/adopt/dogsupload")
	public String adoptUpload(DogsVO vo, RedirectAttributes rttr) {
		log.info("adoptUpload");
		log.info("vo : "+vo);
		log.info("attachImage : " + vo.getAttachImage());
		
		aService.register(vo);
		
		rttr.addFlashAttribute("result","등록이 완료되었습니다. 관리자가 승인 시 목록에 표시되어집니다.");
		
		return "redirect:/adopt/adoptList";
	}
	
	
	@GetMapping("/adopt/dogProfile")
	public void adoptDogProfile(DogsVO vo,Criteria cri, Model model) {
		log.info("dogProfile : " +vo.getDogno());
		int dogno = vo.getDogno();
		
		model.addAttribute("dogs" , aService.getDogProfile(dogno));
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/adopt/adoptProcess")
	public void adoptAdoptProcess(Principal prin, Criteria cri, Model model,DogsVO vo) {
		log.info("adoptProcess : ");
		String userid = prin.getName();
		int dogno = vo.getDogno();
		log.info("dogno : " + dogno);
		model.addAttribute("member", aService.getMember(userid));
		
		model.addAttribute("dogs", aService.getDogProfile(dogno));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/adopt/adoptRequest")
	public String adoptAdoptRequest(AdoptVO vo, Model model,RedirectAttributes rttr) {
		log.info("adoptRequest : ");
		 
		aService.adoptRequest(vo);
		 
		rttr.addFlashAttribute("result","입양 신청되었습니다. 관리자가 확인 후 연락드리겠습니다.");
		
		return "redirect:/adopt/adoptList";
	}
	
	@GetMapping("/adopt/adoptAfter")
	public void adoptAfter(Criteria cri, Model model) {
		log.info("afterList");
		log.info("List : "+aService.afterList(cri));
		log.info("pageMaker : "+new PageDTO(cri, aService.afterCount(cri)));
		
		
		cri.setAmount(12);
		
		model.addAttribute("after", aService.afterList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, aService.afterCount(cri)));
	}
	
	// 11-04 후기 등록페이지 연결	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/adopt/adoptAfterReg")
	public void adoptAfterReg(Criteria cri, Model model) {
		
	}
	
	// 11-04 후기 오라클에 등록
		@PreAuthorize("isAuthenticated()")
		@PostMapping("/register")
		public String afterRegister(BoardVO vo,Principal prin) {
			log.info("afterRegister : ");
			
			String userid = prin.getName();
			vo.setUserid(userid);
			
			aService.insertAfter(vo);
			
			return "redirect:/adopt/adoptAfter";
		}
		
		
	// 11-04 후기 상세정보
	@GetMapping("/adoptAfterInfo")
	public void getInfo(@Param("bno") int bno, @ModelAttribute("cri") Criteria cri,Model model) {
		log.info("bno : "+ bno);
		
		if(aService.updateView(bno))
			model.addAttribute("after",aService.getAfter(bno));
		
	}
} // end class
