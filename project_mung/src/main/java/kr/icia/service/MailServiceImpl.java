package kr.icia.service;

import javax.activation.FileDataSource;
import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.icia.domain.MemberVO;
import kr.icia.mail.MailHandler;
import kr.icia.mail.TempKey;
import kr.icia.mapper.MailMapper;
import lombok.Setter;
@Service
public class MailServiceImpl implements MailService {
	
	@Setter(onMethod_=@Autowired)
	public MailMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BCryptPasswordEncoder pwencoder;
	
	@Inject
	private JavaMailSender mailSender;
	
	@Override
	public boolean userAuth(String email, String authKey) {
		return mapper.userAuth(email,authKey) == 1;
	}

	@Override
	public void register(MemberVO vo) throws Exception {
		String userpw = pwencoder.encode(vo.getUserpw());
		System.out.println(userpw);
		vo.setUserpw(userpw);
		mapper.createUser(vo);
		String userid = vo.getUserid();
		System.out.println("userid : "+vo.getUserid());
		mapper.createAuth(userid);
		System.out.println("email :"+vo.getEmail());
		String authkey = new TempKey().getKey(50, false);
		System.out.println(authkey);
		String email = vo.getEmail();
		mapper.createAuthKey(email,authkey);
		
		MailHandler sendMail = new MailHandler(mailSender);
		
		sendMail.addInline("메일사진1",new FileDataSource("D:\\sts3\\sts3\\sts-bundle\\work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\project_mung\\resources\\images\\메일사진1.png"));
		sendMail.addInline("메일사진2", new FileDataSource("D:\\sts3\\sts3\\sts-bundle\\work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\project_mung\\resources\\images\\메일사진2.gif"));
		
		sendMail.setSubject("멍품천국 인증"); // 메일제목
		sendMail.setText( // 메일내용
				new StringBuffer()
				.append("<div style='position: relative;'>")
				.append("<img src=\"cid:메일사진1\" width='800' height='568'>")
				.append("<div style='position: absolute;'>")
				.append("<a href='http://localhost:8090/member/auth?email=")
				.append(vo.getEmail())
				.append("&authKey=")
				.append(authkey)
				.append("&userName=")
				.append(vo.getUserName())
				.append("' target='_blank'>")
				.append("이메일 인증하기")
				.append("</div>")
				.append("</a>")
				.append("</div>")
				.toString());
		sendMail.setFrom("thunkim96@gmail.com","관리자"); // 보낸이
		sendMail.setTo(vo.getEmail()); // 받는이
		sendMail.send();
	}

	@Override
	public void deleteUserAuth(String userid) {
		mapper.deleteUserAuth(userid);
		
	}

}
