package kr.icia.controller;

import java.security.Principal;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.MemberVO;
import kr.icia.service.MailService;
import kr.icia.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	
	private MailService service;
	
	private MemberService memService;
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(MemberVO vo,RedirectAttributes rttr) throws Exception {
		
		log.info("user :"+vo);
		service.register(vo);
		
		return "redirect:/userlogin";
	}
	
	@GetMapping("/member/auth")
	public String authEmail(String email,String authKey,String userName,Model model) {
		
		service.userAuth(email,authKey);
		model.addAttribute("email",email);
		model.addAttribute("userName",userName);
		
		return "/member/auth";	
	}
	
	@GetMapping("/member/findid")
	public void findId() {
		log.info("find id");
	}
	
	@GetMapping("/member/findpw")
	public void findpw()  {
		log.info("find userpw");
	}
	
	@GetMapping("/member/checkid")
	public void checkid() {
		log.info("check id");
	}
	@GetMapping("/member/findUserId")
	public String findUserId(@Param("userName") String userName,
			@Param("email") String email,
			RedirectAttributes rttr) {
		log.info("fineUserId");
		System.out.println(userName+","+email);
		
		rttr.addFlashAttribute("id",memService.userGetId(userName, email));
		
		return "redirect:/member/checkid";
	}
	
	@GetMapping("/member/changeUserPw")
	public String changePw(@Param("userid") String userid,
			@Param("userName") String userName,
			@Param("email") String email,
			RedirectAttributes rttr) throws Exception {
		if(memService.changeUserPw(userid, userName, email)) {
			 rttr.addFlashAttribute("result","이메일로 변경된 비밀번호가 전송됩니다.");
		 }else {
			 rttr.addFlashAttribute("result","정보가 올바르지 않습니다.");
			 return "redirect:/member/findpw";
		 }
		
		return "redirect:/userlogin";
	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/member/getUser")
	public String getUser(
			Principal principal,
			RedirectAttributes rttr) {
		
		String userid = principal.getName();
		log.info("userid : "+userid);
		rttr.addFlashAttribute("member",memService.getUser(userid));
		
		return "redirect:/member/user";
	}
	
	@GetMapping(value="/member/getProfile",
			produces= { 
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
				})
	@ResponseBody
	public ResponseEntity<MemberVO> getProfile(Principal prin){
		String userid = prin.getName();
		
		log.info("userid : "+userid);
		log.info("vo : "+memService.getUser(userid));
		
		return new ResponseEntity<>(memService.getUser(userid),HttpStatus.OK);
	}
	
	@GetMapping("/user")
	public void user() {
		
	}
	
	@PostMapping("/modify")
	public String modify(MemberVO vo,RedirectAttributes rttr) {
		
		log.info("vo : "+vo);
		log.info("imageAttach : "+vo.getAttachImage());
		
		if(memService.updateUser(vo)) {
			log.info("what : "+memService.updateUser(vo));
			rttr.addFlashAttribute("result","회원정보 수정이 완료되었습니다.");
		}else {
			log.info("what : "+memService.updateUser(vo));
			rttr.addFlashAttribute("result","수정이 실패하였습니다.");
		}
			
		return "redirect:/";
	}
}
