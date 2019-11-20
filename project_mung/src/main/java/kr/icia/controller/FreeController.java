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

import kr.icia.domain.BoardVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.PageDTO;
import kr.icia.service.FreeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/freeboard/*")
@AllArgsConstructor
public class FreeController {
	private FreeService service;
		
	@GetMapping("/freeboard")
	public void freeboard(Criteria cri, Model model) {
		log.info("freeboard");
		log.info("list : "+service.boardList(cri));
		log.info("pageMaker : "+new PageDTO(cri, service.boardCount(cri)));
		
		cri.setAmount(10);
		
		model.addAttribute("free", service.boardList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.boardCount(cri)));
	}
	
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void freeboardReg(Criteria cri, Model model) {
		log.info("freeboardReg");

	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public void modify(@Param("bno") int bno,@ModelAttribute("cri") Criteria cri, Model model) {
		log.info("modify");
		
		log.info("content : "+service.getBoard(bno));
		
		model.addAttribute("board",service.getBoard(bno));
	}
	
	@PreAuthorize("principal.username == #vo.userid")
	@PostMapping("/modify")
	public String update(BoardVO vo,
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		
		log.info("bno : "+vo.getBno());
		log.info("vo : "+vo);
		
		if(service.update(vo)) {
			rttr.addFlashAttribute("result","수정이 완료되었습니다.");
		}
		
		return "redirect:/freeboard/freeboard"+cri.getListLink();
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(BoardVO vo,Principal prin) {
		
		String userid = prin.getName();
		
		vo.setUserid(userid);
		
		service.insertBoard(vo);
		
		return "redirect:/freeboard/freeboard";
	}
	
	@GetMapping("/info")
	public void getInfo(@Param("bno") int bno,@ModelAttribute("cri") Criteria cri,Model model) {
		log.info("bno : "+bno);
		
		if(service.updateView(bno))
			model.addAttribute("board",service.getBoard(bno));
		
		
	}
	
	@PreAuthorize("principal.username == #vo.userid")
	@PostMapping("/remove")
	public String remove(BoardVO vo,
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr
			) {
		
		if(service.delete(vo.getBno())){
			rttr.addFlashAttribute("result","게시물 삭제가 완료되었습니다.");
		}
		
		return "redirect:/freeboard/freeboard"+cri.getListLink();
	}
}
