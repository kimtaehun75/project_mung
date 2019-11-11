package kr.icia.controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.icia.domain.Criteria;
import kr.icia.domain.PageDTO;
import kr.icia.service.SaleService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/sale/*")
public class SaleController {
	
	private SaleService service;
	
	
	@GetMapping("/list")
	public void getSaleList(Criteria cri,Model model){
		log.info("saleList");
		log.info("cateno : "+cri.getCateno());
		
		cri.setAmount(12);
		
		model.addAttribute("menu",service.getCate());
		model.addAttribute("list",service.getSale(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,service.getSaleCount(cri)));
	}
	
	@GetMapping("/detail")
	   public void getDetail(@Param("saleno")int saleno ,Model model,Criteria cri) {
	      model.addAttribute("saleno",saleno);
	      log.info("saleno :"+saleno);      
	      log.info("review : " + service.getReview(cri));
	      log.info("reviewCount : " + service.getRevCount(cri));
	      log.info("pageMaker : " + new PageDTO(cri, service.getRevCount(cri)));

	      cri.setAmount(4);
	      int total = service.getRevCount(cri);
	      model.addAttribute("review", service.getReview(cri));
	      model.addAttribute("pageMaker", new PageDTO(cri,total));
	      model.addAttribute("sale",service.getSaleInfo(saleno));
	      
	   }
}
