package kr.icia.controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.icia.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class CheckController {
	
	private MemberService service;
	
	@GetMapping(value="/idCheck",
			produces= { 
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
				})
	@ResponseBody
	public int idCheck(@Param("userid") String userid) {
		log.info(service.userIdCheck(userid));
		return service.userIdCheck(userid);
	}
}
