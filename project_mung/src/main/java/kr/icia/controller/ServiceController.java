package kr.icia.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.BoardFaqVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.PageDTO;
import kr.icia.service.FaqService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/service/*")
public class ServiceController {
	
	private FaqService fService;
	
	@GetMapping("/faq")
	public void faq(Criteria cri, Model model) {
		log.info("faqList");
		log.info("List : "+fService.faqList(cri));
		log.info("pageMaker : "+new PageDTO(cri, fService.faqCount(cri)));
		
		cri.setAmount(10);
		
		model.addAttribute("faq", fService.faqList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, fService.faqCount(cri)));
	}
	
} //end class