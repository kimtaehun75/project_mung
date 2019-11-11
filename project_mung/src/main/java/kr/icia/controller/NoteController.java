package kr.icia.controller;

import java.security.Principal;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.NoteVO;
import kr.icia.service.NoteService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/mail/*")
public class NoteController {
	
	private NoteService Nservice;
	
	@GetMapping(value = "/getMailCount",produces= { 
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE
		})
	@ResponseBody
	public ResponseEntity<String> getRecvCount(Principal prin) {
			String userid = prin.getName();
			
			String mail = Nservice.getRecvCount(userid);
			log.info("mail : "+mail);
			
		return new ResponseEntity<>(mail,HttpStatus.OK);
	}
	
	@PostMapping("/writemail")
	   public String writemail(NoteVO vo,RedirectAttributes rttr,Principal prin) {
	      String userid = prin.getName();
	      
	      log.info("userid :"+userid);
	      log.info("writemail");
	      
	      vo.setSentid(userid);
	      
	      Nservice.writemail(vo);
	      
	      return "redirect:/mypage/getSentMail";
	   }
}
