package kr.icia.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;
@Controller
@Log4j
public class LoginController {
	
	@RequestMapping(value="/userlogin" ,method = {RequestMethod.GET,RequestMethod.POST})
	public void login() {
		
	}
	
	@PostMapping("/userlogout")
	public void logoutPost() {
		log.info("post logout");
	}
}
