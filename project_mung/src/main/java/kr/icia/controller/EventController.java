package kr.icia.controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.BoardEventVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.PageDTO;
import kr.icia.service.EventService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/event/*")
public class EventController {
	
	private EventService service;
	
	@GetMapping("/event")
	public void event(Criteria cri,Model model) {
		log.info("eventList : "+service.getEvent(cri));
		
		cri.setAmount(5);
		
		model.addAttribute("list",service.getEvent(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,service.getEventCount(cri)));
	}
	
	@GetMapping("/detail")
	public void eventDetail(@Param("bno") int bno,@ModelAttribute("cri") Criteria cri,Model model) {
		log.info("bno : "+bno);
		
		
		model.addAttribute("event",service.getEventInfo(bno));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public void eventModify(@Param("bno") int bno,
			@ModelAttribute("cri") Criteria cri,
			Model model) {
		
		
		model.addAttribute("event",service.getEventInfo(bno));
	}
	
	@PreAuthorize("principal.username == #vo.userid")
	@PostMapping("/modify")
	public String update(BoardEventVO vo,
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		
		log.info("bno : "+vo.getBno());
		log.info("vo : "+vo);
		
		if(service.update(vo)) {
			rttr.addFlashAttribute("result","수정이 완료되었습니다.");
		}
		
		return "redirect:/event/event"+cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #vo.userid")
	@PostMapping("/remove")
	public String eventRemove(BoardEventVO vo,
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		
		if(service.delete(vo.getBno())){
			rttr.addFlashAttribute("result","게시물 삭제가 완료되었습니다.");
		}
		
		return "redirect:/event/event"+cri.getListLink();
	}
}
