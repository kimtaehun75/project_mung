package kr.icia.service;


import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.icia.domain.Criteria;
import kr.icia.domain.GradeVO;
import kr.icia.domain.MemberVO;
import kr.icia.mail.MailHandler;
import kr.icia.mail.TempKey;
import kr.icia.mapper.ImageMapper;
import kr.icia.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private ImageMapper imgMapper;
	
	@Setter(onMethod_=@Autowired)
	private BCryptPasswordEncoder pwencoder;
	
	@Inject
	private JavaMailSender mailSender;
	
	@Override
	public List<String> userGetId(String userName,String email) {
		log.info("find user : "+userName);
		
		return mapper.userGetId(userName, email);
	}

	@Override
	public boolean changeUserPw(String userid, String userName, String email) throws Exception {
		String userpw = new TempKey().getKey(8, false);
		System.out.println(userpw);
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("비밀번호 변경 안내"); // 메일제목
		sendMail.setText( // 메일내용
				new StringBuffer().append("<h1>변경된 비밀번호</h1>")
				.append(userpw)
				.toString());
		sendMail.setFrom("thunkim96@gmail.com","관리자"); // 보낸이
		sendMail.setTo(email); // 받는이
		sendMail.send();
		userpw = pwencoder.encode(userpw);
		
		return mapper.changePw(userid, userName, email, userpw) == 1;
	}

	@Override
	public int userIdCheck(String userid) {
		log.info("userIdCheck");
		
		return mapper.userIdCheck(userid);
	}

	@Override
	public boolean updateUser(MemberVO vo) {
		log.info("update");
		
		boolean check = false;
		
		if(vo.getAttachImage() == null) {
			imgMapper.deleteUser(vo.getUserno());
			return mapper.updateUser(vo) == 1;
		}
		
		imgMapper.insertMember(vo.getAttachImage());
		
		
		if(imgMapper.updateMember(vo.getAttachImage()) == 1 && mapper.updateUser(vo) == 1) {
			check = true;
		}
		return check;
		
	}
	
	@Override
	public boolean adminUpdateUser(MemberVO vo) {
		log.info("adminUpdate");
		return mapper.adminUpdateUser(vo) == 1;
	}
	
	@Override
	public List<MemberVO> getList(Criteria cri) {
		log.info("getList....");
		return mapper.getMemberWithPaging(cri);
	}

	@Override
	public int getMemberCount(Criteria cri) {
		log.info("getMemberCount..");
		return mapper.getMemberCount(cri);
	}

	@Override
	public MemberVO getUser(String userid) {
		log.info("getUser...");
		return mapper.read(userid);
	}

	@Override
	public MemberVO getMember(String userid) {
		log.info("getMember...");
		return mapper.getMember(userid);
	}

	@Override
	public List<GradeVO> getGradeList() {
		log.info("getGradeList..");
		return mapper.getGradeList();
	}

	@Override
	public List<String> getGradeId(String tear) {
		log.info("getGradeId..");
		return mapper.getGradeId(tear);
	}

	@Override
	public void deleteUser(String userid) {
		mapper.deleteUser(userid);
		
	}

	@Override
	public int changeNewPw(MemberVO vo) {
		
		return mapper.changeNewPw(vo);
	}

	
}
