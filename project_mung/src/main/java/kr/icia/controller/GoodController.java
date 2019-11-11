package kr.icia.controller;

import java.security.Principal;

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

import kr.icia.domain.GoodVO;
import kr.icia.service.GoodService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/good/*")
public class GoodController {
	
	private GoodService service;
	
	@GetMapping(value = "/checkGoodCount/{saleno}", produces= { 
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE
		})
	@ResponseBody
	public ResponseEntity<String> checkGoodCount(Principal prin,
			@PathVariable("saleno") int saleno) {
			String userid = prin.getName();
			
			GoodVO vo = new GoodVO();
			
			vo.setSaleno(saleno);
			vo.setUserid(userid);
			
			String count = service.checkGood(vo);
			
			log.info(count);
			
		return new ResponseEntity<>(count,HttpStatus.OK);
	}
	
	@PreAuthorize("principal.username == #vo.userid")
	@DeleteMapping(value="/",
			produces= {
					MediaType.TEXT_PLAIN_VALUE
			})
	@ResponseBody
	public ResponseEntity<String> removeGood(
			@RequestBody GoodVO vo
			){
		log.info("delete : "+vo.getSaleno());
		
		return service.deleteGood(vo) == 1?new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>("fail",HttpStatus.OK);
	}
	
	@PostMapping(value="/insert",
			produces= { 
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
				})
	@ResponseBody
	public ResponseEntity<String> insertGood(Principal prin,@RequestBody GoodVO vo,Model model){
		log.info("CartVO : "+vo);
		
		log.info("userid : "+vo.getUserid());
		
		return service.insertGood(vo) == 1?new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>("fail",HttpStatus.OK);
	}
}
