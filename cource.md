# 멍품 프로젝트 소스 리뷰

### 보고자 하는 내용을 Ctrl+f해주세요.




#### 목차


### <일반 회원>


#### 1. 회원관리


1.1 회원가입


1.2 로그인


1.3 회원정보 수정


1.4 ID찾기


1.5 비밀번호 찾기(변경)


1.6 쿠폰조회


1.7 회원 탈퇴


#### 2. 상품관리


2.1 상품 목록


2.2 상품 상세페이지


2.3 장바구니


2.4 관심 상품 등록


2.5 상품 결제


2.6 결제내역 조회


#### 3. 유기견관리


3.1 유기견 등록


3.2 유기견 목록


3.3 유기견 상세페이지


3.4 유기견 분양 신청


#### 4. 부가서비스


4.1 이벤트 목록


4.2 이벤트 상세페이지


4.3 FAQ


4.4 실시간 상담


4.5 받은 쪽지


4.6 쪽지 보내기


4.7 보낸 쪽지


### <관리자>

#### 5. 회원관리


5.1 회원 목록 조회


5.2 회원 정보 변경


#### 6. 상품관리


6.1 상품 목록


6.2 상품 정보 수정


6.3 상품 등록


6.4 상품 삭제


#### 7. 유기견관리


7.1 신청된 유기견 목록


7.2 신청된 유기견 상세 페이지


7.3 신청된 유기견 등록


7.4 유기견 분양 신청 목록


7.5 유기견 분양 신청 상세 페이지


7.6 유기견 분양 승인


#### 8. 부가서비스


8.1 이벤트 목록


8.2 이벤트 상세페이지


8.3 이벤트 등록


8.4 이벤트 수정


8.5 이벤트 삭제


8.6 FAQ 목록


8.6 FAQ 상세 페이지


8.7 FAQ 등록


8.8 FAQ 삭제


#### 9. 쿠폰관리


9.1 쿠폰 등록


9.2 등급별 쿠폰 발급


9.3 지정 회원 쿠폰 발급


##### 1. 회원관리 < 일반 회원 >


1.1 회원가입


###### 1.MemberControlller

"`

@PostMapping("/register")
	public String register(MemberVO vo,RedirectAttributes rttr) throws Exception {
		service.register(vo);
	}


--------------------------------------------------------------------------------------------------------------
1. register.jsp 에서 받아온 회원 정보들을 MemberVO에 저장 후 Service를 호출
--------------------------------------------------------------------------------------------------------------


2.MailService
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
		
		sendMail.addInline("메일사진1",new FileDataSource("D:\\sts3\\sts3\\sts-bundle\\work\\mung.zip_expanded\\project_mung\\src\\main\\webapp\\resources\\images\\메일사진1.png")); // 보낼 이미지 파일의 저장 경로
		sendMail.addInline("메일사진2", new FileDataSource("D:\\sts3\\sts3\\sts-bundle\\work\\mung.zip_expanded\\project_mung\\src\\main\\webapp\\resources\\images\\메일사진2.gif")); // 보낼 이미지 파일의 이름과 저장 경로
		
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
--------------------------------------------------------------------------------------------------------------
1. MemberController에서 받아온 VO에서 비밀번호를 암호화하여 Console에 출력하고 암호화 된 비밀번호를 VO에 다시 저장
2. Mapper의 createUser를 호출하고 파라메터로 VO를 넘김
3. Mapper의 createAuth를 호출하고 파라메터로 userId를 넘김
4. TempKey().getKey를 호출하여 파라메터로 50(난수의 길이,false(소문자 변환 여부)를 넘김 -> p4 ~ p5
5. Mapper의 createAuthKey를 호출하고 파라메터로 email,authKey를 넘김
6. MailHandler를 호출하고 파라메터로 mailSender를 넘김,mailSender는 javaMailSender로 내부 인터페이스 객체임
7. 메일로 보낼 이미지,보낼 제목,내용,보낸이,받는이 등을 입력받아 MailHandler를 통해 보냄
--------------------------------------------------------------------------------------------------------------




3.MailMapper
<insert id="createUser">
  	insert into member(userno,userid,userpw,username,addr_1,addr_2,addr_3,email,phone,birth)  	values(member_seq.nextval,#{userid},#{userpw},#{userName},#{addr_1},#{addr_2},#{addr_3},#{email},#{phone},#{birth})
  </insert>

<insert id="createAuthKey">
	insert into email_auth(email,authkey) values(#{email},#{authKey})
</insert>
<insert id="createAuth">
	insert into member_auth(userid,auth) values(#{userid},'ROLE_MEMBER')
</insert>
--------------------------------------------------------------------------------------------------------------
1. createUser에서 VO에 저장된 값을 데이터베이스에 저장함
2. createAuthKey에서 넘겨받은 email,authKey를 저장함
3. createAuth에서 넘겨받은 userId와 ROLE_MEMBER라는 권한을 저장함
--------------------------------------------------------------------------------------------------------------
4.MemberControlller
@PostMapping("/register")
	public String register(MemberVO vo,RedirectAttributes rttr) throws Exception {
return "redirect:/userlogin";
}
--------------------------------------------------------------------------------------------------------------
1. 처리가 다 끝나면 userlogin 페이지로 redirect 시킴
5.TempKey
public class TempKey { // 인증키 생성 클래스
	private boolean lowerCheck; // 소문자 변환을 위한 변수
	private int size; // 만들 임의의 값의 최대 길이

	public String getKey(int size, boolean lowerCheck) {
		this.size = size;
		this.lowerCheck = lowerCheck;
		return init();
	}
	private String init() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;
		do {
			num = ran.nextInt(75) + 48;
			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}
		} while (sb.length() < size);
		if (lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}

}
--------------------------------------------------------------------------------------------------------------
1. 난수를 받는 ran을 선언 후 nextInt로 0부터 75의 값을 받아 +48을 더해줌 그리고 그값을 num에 할당
2. num에 할당된 숫자를 char형식으로 StringBuffer,sb 에 할당함
3. 조건문에 적힌 첫 번째 조건(num >= 48 && num <= 57)은 숫자를 지정하는 부분이고
두 번째,세 번째는 영문 소문자,영문 대문자를 지정한다. 그래서 숫자,영문 소문자,영문 대문자만으로 구성된 인증키를 만듬
--------------------------------------------------------------------------------------------------------------
6.MailHandler
public class MailHandler { // 메일보내기 유틸 클래스
	private JavaMailSender mailSender;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;

	public MailHandler(JavaMailSender mailSender) throws MessagingException {
		this.mailSender = mailSender;
		message = this.mailSender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	}

	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}

	public void setText(String htmlContent) throws MessagingException {
		messageHelper.setText(htmlContent, true);
	}

	public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
		messageHelper.setFrom(email, name);
	}

	public void setTo(String email) throws MessagingException {
		messageHelper.setTo(email);
	}

	public void addInline(String contentId, DataSource dataSource) throws MessagingException {
		messageHelper.addInline(contentId, dataSource);
	}

	public void send() {
		mailSender.send(message);
	}

--------------------------------------------------------------------------------------------------------------
1. 메일을 보내는데 필요한 유틸들을 쉽고 간단하기 쓰기 위해 한 곳에 모아 작업을 함
2. mailSender는 메일을 보내기 위해 필요한 기능이고 해당 기능은 send로 대체함
3. message는 JavaMailSender.createMimeMessage()의 변수로 보낼 메시지를 담는 용도로 씀
4. messageHelper는 보낼 메시지와 파일 첨부여부, 언어 코드를 설정해주기 위해 사용함
5. 각 메서드 setSubject는 제목,setText는 내용,setFrom는 보낸이,setTo는 받는이,addInline은 보낼 파일,send는 보내는 기능을 담당함.
--------------------------------------------------------------------------------------------------------------
7.MemberController
@GetMapping("/member/auth")
	public String authEmail(String email,String authKey,String userName,Model model) {
		
		service.userAuth(email,authKey);
		model.addAttribute("email",email);
		model.addAttribute("userName",userName);
		
		return "/member/auth";	
	}
--------------------------------------------------------------------------------------------------------------
1. get방식으로 받아온 email,authKey를 Service에 보내줌
--------------------------------------------------------------------------------------------------------------




8.MailService
@Override
	public boolean userAuth(String email, String authKey) {
		return mapper.userAuth(email,authKey) == 1;
	}
--------------------------------------------------------------------------------------------------------------
1. Controller에서 받아온 email,authKey를 mapper에 전달
2. 결과 값을 리턴
--------------------------------------------------------------------------------------------------------------
9.MailMapper
<update id="userAuth">
		<![CDATA[
		update member set enabled = 1,updatedate = sysdate where 
		(select count(*) from email_auth 
		where email = #{email} and authkey = #{authKey}) > 0 
		and email = #{email}
		]]>
	</update>
--------------------------------------------------------------------------------------------------------------
1. Controller에서부터 받아온 email,authKey를 서브 쿼리에서 비교하여 동일한 값이 있을 경우 1을 출력하고,없을 경우 조건식에 위배되어 수정이 되지않음
2. 동일한 email,authKey가 있을 경우 1을 출력하고, member 테이블에서 동일한 이메일을 가진 회원의 계정을 활성화 상태(enabled=1)로 만들고 updatedate를 쿼리가 실행한 날짜로 수정을 시켜줌
--------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------
1. 이메일로 보낸 하이퍼링크에 생성한 인증키를 url로 함께 보내 Get방식으로 인증키를 다시 받아 회원의 인증 상태를 변경시켜줌
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
1. 이메일 인증이 되지않은 계정이라면 위의 이미지처럼 로그인이 되지않음
1.2 로그인
1.CustomAuthenticationProvider
@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String userid= (String) authentication.getPrincipal();
	   	String userpw = (String) authentication.getCredentials();
	     
		CustomUser user = (CustomUser) service.loadUserByUsername(userid);
--------------------------------------------------------------------------------------------------------------
1. userlogin페이지에서 입력한 userId와 userpw를 변수에 할당하고 UserDetailService의 파라메터로 userId를 넘겨 호출함
--------------------------------------------------------------------------------------------------------------
2.CustomUserDetailService
@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO vo = mapper.read(username);
--------------------------------------------------------------------------------------------------------------
1. Provider에서 가져온 userId를 Mapper의 파라메터 값으로 넘기고 호출함
--------------------------------------------------------------------------------------------------------------



3.MemberMapper
<select id="read" resultMap="memberMap">
	select mem.userno,mem.userid,userpw,username,addr_1,addr_2,addr_3,email,phone,to_char(birth,'yyyyMMdd') as birth,joindate,updatedate,report,grade,adopt,enabled,auth,uuid,imagepath,filename 
	from 
	member mem,member_auth auth,member_img img
        where auth.userid(+) = mem.userid
        and img.userno(+) = mem.userno
        and mem.userid = #{userid}
	</select>
--------------------------------------------------------------------------------------------------------------
1. Service로 부터 받아온 userid 를 DB 에서 일치하는 회원의 정보들을 가져오는데, member_img에 저장한 회원의 프로필 사진이 있다면 출력을 같이 하고 없으면 null 값을 출력하기위해 outer join을 사용하였음
2. 그리고 그 결과를 memberVO에 저장함
--------------------------------------------------------------------------------------------------------------
4.CustomUserDetailService
MemberVO vo = mapper.read(username);
if(vo == null) {
	throw new BadCredentialsException(username);
	}
	String enabled= vo.getEnabled();
	return vo==null?null:new CustomUser(vo)
	}

--------------------------------------------------------------------------------------------------------------
1. Mapper에서 저장한 MemberVO를 변수 vo 에 할당하고 null 값이면 예외 처리를 함
2. vo가 널이 아니면 vo가 파라메터로 담긴 CustomUser를 리턴해줌
--------------------------------------------------------------------------------------------------------------
5.CustomAuthenticationProvider
CustomUser user = (CustomUser) service.loadUserByUsername(userid);
		log.info(user);

		if(user == null) {
			throw new UsernameNotFoundException(userid);
		}
		if(!matchPassword(userpw, user.getPassword())) {
			throw new BadCredentialsException(userid);
        }
private boolean matchPassword(String loginPwd, String password) {
        return loginPwd.equals(password);   

--------------------------------------------------------------------------------------------------------------
1. Service에서 가져온 CustomUser 타입의 결과를 user에 할당을 하고 null이 아닌지 확인하고 null이라면 예외처리를 함
2. 함호화된 회원의 비밀번호를 검사하여 틀리다면 예외처리를 함
--------------------------------------------------------------------------------------------------------------


6.CustomAuthenticationProvider
String enabled = user.getEnabled();

if(enabled.equals("0")) {
			throw new DisabledException(enabled);
		}else if(enabled.equals("2")) {
			throw new LockedException(enabled);
		}
return new UsernamePasswordAuthenticationToken(userid, userpw, user.getAuthorities());
	}
--------------------------------------------------------------------------------------------------------------
1. vo의 Enabled를 비교하여 0이라면 계정이 이메일 인증을 거치지 않은 상태이므로 로그인이 되지않고,2인 상태라면 정지처분을 받은 계정이므로 로그인이 되지않는 예외 처리를 함
2. 아이디,비밀번호,계정 활성화 상태를 파라메터로 UsernamePasswordAuthenticationToken를 호출 하고 그 값을 리턴 처리 해줌(userId는 principal,userpw는 credentials로 저장)
--------------------------------------------------------------------------------------------------------------
7.LoginFailureHandler
if(exception instanceof BadCredentialsException) {
			errorMsg = MessageUtils.getMessage("error.BadCredentials");
		} else if(exception instanceof InternalAuthenticationServiceException) {
			errorMsg = MessageUtils.getMessage("error.BadCredentials");
		} else if(exception instanceof DisabledException) {
			errorMsg = MessageUtils.getMessage("error.Disaled");
		} else if(exception instanceof CredentialsExpiredException) {
			errorMsg = MessageUtils.getMessage("error.CredentialsExpired");
		} else if(exception instanceof LockedException) {
			errorMsg = MessageUtils.getMessage("error.Locked");
		}
--------------------------------------------------------------------------------------------------------------
1. security-context에서 LoginFailureHandler에서 예외 처리를 하도록 설정함
2. 위에서부터 비밀번호가 틀릴 경우, 존재 하지 않는 아이디일 경우,계정이 비활성화인 상태인 경우, 비밀번호 유효 기간이 만료된 경우,잠긴 계정일 경우 예외 처리를 함
--------------------------------------------------------------------------------------------------------------


















1.3 회원정보 수정
1.MyPageController
@PreAuthorize("isAuthenticated()")
@GetMapping("/getInfo")
	public String getMyPage(Principal prin,RedirectAttributes rttr) {
		String userid = prin.getName();
		rttr.addFlashAttribute("member",service.getUser(userid));
--------------------------------------------------------------------------------------------------------------
1. 회원의 정보를 prin의 변수에 담아 파라메터로 넘겨받음(웹페이지로 부터)
2. 넘겨받은 정보중 회원의 아이디를 userId에 저장
3. service의 getUser매서드에 파라메터를 userId로 주고 호출함 결과를 member 라는 이름의 속성에 저장
--------------------------------------------------------------------------------------------------------------
2.MemberServiceImpl
@Override
	public MemberVO getUser(String userid) {
		return mapper.read(userid);
	}
--------------------------------------------------------------------------------------------------------------
1. cotroller에서 넘겨받은 회원 아이디를 mapper의 read 매서드의 파라메터로 넘겨줌
2. 그리고 그 결과를 리턴
--------------------------------------------------------------------------------------------------------------


3.MemberMapper
<select id="read" resultMap="memberMap">
		select 
	mem.userno,mem.userid,userpw,username,addr_1,addr_2,addr_3,email,phone,to_char(birth,'yyyyMMdd') as birth,joindate,updatedate,report,grade,adopt,enabled,auth,uuid,imagepath,filename 
		from 
		member mem,member_auth auth,member_img img
        where auth.userid(+) = mem.userid
        and img.userno(+) = mem.userno
        and mem.userid = #{userid}
	</select>
--------------------------------------------------------------------------------------------------------------
1. 회원 가입 절차에서도 썼던 쿼리로 Service로 부터 받아온 userid 를 DB 에서 일치하는 회원의 정보들을 가져오는데, member_img에 저장한 회원의 프로필 사진이 있다면 출력을 같이 하고 없으면 null 값을 출력하기위해 outer join을 사용하였음
2. 그리고 그 결과를 memberVO 에 할당
--------------------------------------------------------------------------------------------------------------
4.MyPageController
public String getMyPage(Principal prin,RedirectAttributes rttr) {
rttr.addFlashAttribute("member",service.getUser(userid));
		
		return "redirect:/mypage/info";
}
--------------------------------------------------------------------------------------------------------------
1. mapper와 service에서부터 받아온 값을 member라는 속성값에 저장하고 info페이지(회원정보)로 redirect 시킴
1.4 ID찾기
1.MemberController
public String findUserId(@Param("userName") String userName,
			@Param("email") String email,
			RedirectAttributes rttr) {
rttr.addFlashAttribute("id",memService.userGetId(userName, email));
}
--------------------------------------------------------------------------------------------------------------
1. ID 찾기 페이지에서 받은 회원의 이름과 이메일을 Service의 파라메터로 넘겨 주고 호출함
--------------------------------------------------------------------------------------------------------------
2.MemberService
public List<String> userGetId(String userName,String email) {
		return mapper.userGetId(userName, email);
	}
--------------------------------------------------------------------------------------------------------------
1. mapper의 userGetId를 controller에서 넘겨받은 userName과 email을 다시 넘겨 주며 호출 함
--------------------------------------------------------------------------------------------------------------
3.MemberMapper
<select id="userGetId" resultType="String">
	 	select userid from member 
	 	where username = #{userName} and 
	 	email = #{email}
	 </select>


--------------------------------------------------------------------------------------------------------------
1. Service에서 넘겨받은 email과 userName를 조회하여 동일한 회원의 Id를 String 타입으로 돌려받음
--------------------------------------------------------------------------------------------------------------
4.MemberController
public String findUserId(@Param("userName") String userName,
			@Param("email") String email,
			RedirectAttributes rttr) {
rttr.addFlashAttribute("id",memService.userGetId(userName, email));

		return "redirect:/member/checkid";
}
--------------------------------------------------------------------------------------------------------------
1. Mapper에서 받은 Id를 속성 이름이 id 인 속성 값으로 넣어 주고 checkid 로 redirect 시키고
2. 해당 페이지에서 입력한 정보(이메일, 유저이름)와 일치하는 회원의 아이디를 출력해줌
--------------------------------------------------------------------------------------------------------------







1.5 비밀번호 찾기(변경)
1.MemberController
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
--------------------------------------------------------------------------------------------------------------
1. 비밀번호 찾기 페이지에서 입력한 userid, userName,email을 Service로 넘겨 결과를 받아옴
2. 결과가 true 로 일치한다면 로그인 페이지로 redirect시키며 이메일로 변경된 비밀번호가 전송되었다는 alert 창을 출력함
3. 결과가 false 로 다르다면  다시 비밀번호 찾기 페이지로 redirect시키며 정보가 다르다는 alert창을 출력함
--------------------------------------------------------------------------------------------------------------


2.MemberService
public boolean changeUserPw(String userid, String userName, String email) throws Exception {
		String userpw = new TempKey().getKey(8, false);
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
--------------------------------------------------------------------------------------------------------------
1. TempKey를 통해 임의의 값 8자리를 가져와서 userpw라는 변수에 할당
2. MailHandler(회원가입 부분에 서술한 커스텀한 MailHandler)를 통해 메일 기능을 사용하기 위해 sendMail에 할당해줌(레퍼런스)
3. 제목,내용,받는이,보낸이를 작성하여 보내는데 필드에 선언한 BCryptPasswordEncoder를 이용하여 비밀번호를 암호화하여 mapper에 아이디,이름,이메일,비밀번호를 호출하고 결과를 0과 1로 받음
--------------------------------------------------------------------------------------------------------------


3.MemberMapper
<update id="changePw">
	 	update member set userpw = #{userpw} 
	 	where userid = #{userid} and 
	 	userName = #{userName} and 
	 	email = #{email}
	 </update>
--------------------------------------------------------------------------------------------------------------
1. 받아온 아이디,이름,이메일이 일치하는 회원의 비밀번호를 암호화된 새로운 비밀번호로 수정을 해줌
2. 수정이 되었다면 1, 되지 않았다면 0을 리턴해줌
--------------------------------------------------------------------------------------------------------------
4.MemberService

return mapper.changePw(userid, userName, email, userpw) == 1;

--------------------------------------------------------------------------------------------------------------
1. Mapper에서 나온 결과 값이 1이라면 true로 리턴 0이라면 false로 리턴
--------------------------------------------------------------------------------------------------------------






5.MemberController
if(memService.changeUserPw(userid, userName, email)) {
			 rttr.addFlashAttribute("result","이메일로 변경된 비밀번호가 전송됩니다.");
		 }else {
			 rttr.addFlashAttribute("result","정보가 올바르지 않습니다.");
			 return "redirect:/member/findpw";
		 }
		return "redirect:/userlogin";
--------------------------------------------------------------------------------------------------------------
1. Service에서 가져온 값을 비교하여 조건문 수행
--------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------
1. 회원의 아이디,이름,이메일까지 일치할 경우 입력한 이메일로 임의의 8자리 문자/숫자를 보냄
------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
1. 이메일로 온 비밀번호를 입력하여 로그인이 가능함
--------------------------------------------------------------------------------------------------------------














1.6 쿠폰조회
1.MyPageController
public void coupon(Criteria cri,Model model,Principal prin) {
		
		String userid = prin.getName();
		cri.setType("I");
		cri.setKeyword(userid);
		model.addAttribute("coupon",Cservice.haveUserCoupon(userid));
	}
--------------------------------------------------------------------------------------------------------------
1. userid 에 현재 로그인 정보를 담고있는 principal을 파라메터로 받아 getName를 통해 회원 아이디를 가져와 할당함
2. 검색을 위해 Criteria의 setType으로 I를 담고setKeyword로 userid를 담음
3. 회원의 아이디를 파라메터로 담은 service의 haveUserCoupon 매서드 호출
--------------------------------------------------------------------------------------------------------------
2.CouponService
@Override
	public List<CouponVO> haveUserCoupon(String userid) {
		log.info("haveUserCoupon");
		return mapper.haveUserCoupon(userid);
	}
--------------------------------------------------------------------------------------------------------------
1. controller에서 받아온 cri 를 파라메터로 Mapper의 haveCounpon을 호출
--------------------------------------------------------------------------------------------------------------3.CouponMapper
<select id="haveUserCoupon" resultType="kr.icia.domain.CouponVO">
		<![CDATA[
			select 
			m.cpnum,cpname,cpcontent,value,type,cpupdate,cpenddate,userid 
			from 
			coupon c,coupon_member m 
			where 
c.cpnum = m.cpnum 
and 
			cpenddate > sysdate 
			and
			userid = #{userid}
		]]>
	</select>
--------------------------------------------------------------------------------------------------------------
1. 넘겨받은 회원 아이디를 비교하여 쿠폰을 가져오는데 쿠폰 만료일(cpenddate)을 지난 쿠폰은 가져올수 없고 회원이 가지고 있지않은 쿠폰이라면 출력하지 않음
2. 결과를 CouponVO 에 반환하여 쿠폰 조회 페이지에 출력해줌
--------------------------------------------------------------------------------------------------------------



1.7 회원 탈퇴
1.MyPageController - 회원 탈퇴 시작과 끝
private BCryptPasswordEncoder pwencoder;
public String memberoutPost(HttpSession session,Principal prin,
	@Param("userpw") String userpw,
	RedirectAttributes rttr) {
String userid = prin.getName();
		CustomUser user = (CustomUser) UserService.loadUserByUsername(userid);
if(pwencoder.matches(userpw, user.getPassword())) {
			Cservice.deleteUser(userid);
			Sservice.deleteUser(userid);
			Gservice.deleteUser(userid);
			Mservice.deleteUserAuth(userid);
			service.deleteUser(userid);
}
SecurityContextHolder.clearContext();
If(session != null)
session.invalidate();
rttr.addFlashAttribute("result","회원탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.");
return "redirect:/";





--------------------------------------------------------------------------------------------------------------
1. 회원이 회원을 탈퇴하기 위해 비밀번호를 입력하게 되면 현재 로그인 되어있는 계정의 id를 userId 변수에 저장하여 UserService를 통해 회원의 정보들을 가져와 user 에 저장
2. 회원이 입력한 비밀번호와 계정의 비밀번호가 동일하다면 각 서비스에서 Mapper를 호출하여 해당 계정의 DB들을 삭제하는데,
3. 위에서부터 쿠폰,장바구니,관심상품,쪽지,회원 순으로 삭제를 함
4. ClearContext().는 로그인중인 계정의 정보를 지움
5. 그리고 session.invalidate()로 세션에 남아있을수도 있는 회원정보 등을 무효화 처리
6. 해당 작업까지 끝냈다면 회원 탈퇴가 완료되었다는 alert 창을 출력함
7. 회원 탈퇴가 되었을 경우 메인 페이지로 redirect 시킴
--------------------------------------------------------------------------------------------------------------
else {
			log.info("일치하지 않음");
			rttr.addFlashAttribute("result","비밀번호가 일치하지 않습니다.");
			return "redirect:/mypage/memberout";
}


--------------------------------------------------------------------------------------------------------------
1. 회원탈퇴 페이지에서 입력한 비밀번호가 회원의 비밀번호와 맞지 않을 경우 비밀번호가 틀렸다는 alert 창을 출력하고 다시 회원 탈퇴 페이지로 redirect 시킴
--------------------------------------------------------------------------------------------------------------


2. 상품관리

2.1 상품 목록
1.SaleController - 상품 목록 시작	
@GetMapping("/list")
	public void getSaleList(Criteria cri,Model model){
		model.addAttribute("menu",service.getCate());
}
--------------------------------------------------------------------------------------------------------------
1. service의 getCate를 호출
--------------------------------------------------------------------------------------------------------------
2.SaleService - Mapper에 카테고리 정보 요청
@Override
	public List<CateVO> getCate() {
		return mapper.getCate();
	}
--------------------------------------------------------------------------------------------------------------
1. Mapper의 getCate를 호출
--------------------------------------------------------------------------------------------------------------




3.SaleMapper - DB에 카테고리 정보 요청
<select id="getCate" resultType="kr.icia.domain.CateVO">
		select * from sale_cate
	</select>
--------------------------------------------------------------------------------------------------------------
1. DB에 있는 카테고리 정보를 가져와서 cateVO 에 반환
--------------------------------------------------------------------------------------------------------------
4.SalaController - 페이징 처리 및 상품 정보 요청
public void getSaleList(Criteria cri,Model model){
	model.addAttribute("list",service.getSale(cri));
}
--------------------------------------------------------------------------------------------------------------
1. 카테고리 정보를 담은 cri 를 파라메터로 getSale 를 호출
--------------------------------------------------------------------------------------------------------------
5.SaleService - 상품 정보 
public List<SaleVO> getSale(Criteria cri) {
		if(cri.getCateno() == 0) {
			return mapper.getSale(cri);
		}
		return mapper.getSaleList(cri);
	}
--------------------------------------------------------------------------------------------------------------
1. cri의 카테고리 번호가 0 일 경우 mapper의 getSale를 호출
2. 아니라면 getSaleList(cri) 로 선택한 카테고리 번호의 상품들을 요청하기 위해 호출
6.SaleMapper(Cateno=0)
<select id="getSale" resultMap="saleMap">
		<![CDATA[
			select saleno,salename, cost,content,amount,good,updatedate,uuid,
			cateno,imagepath,filename,catename 
			from 
			(select /*+index_desc(sale slaeno)*/
			rownum rn, s.saleno,salename,s.cateno,
			to_char(cost,'999,999')||'원' cost,	content,amount,
			(select count(*) from sale_good where saleno = s.saleno) as good,
			s.updatedate,uuid,imagepath,filename,c.catename
			from sale s,sale_img i,sale_cate c
			where 
			s.cateno = c.cateno and  i.saleno = s.saleno and 
		]]>
		<include refid="criteria"/>
		<![CDATA[
			rownum <= #{pageNum} * #{amount})
			where (rn > (#{pageNum}-1) * #{amount})
		]]>
--------------------------------------------------------------------------------------------------------------
1. 모든 상품의 정보를 담아 SaleVO 에 반환
--------------------------------------------------------------------------------------------------------------

7.SaleMapper(Cateno!=0)
<![CDATA[
			select saleno,salename, cost,content,amount,good,updatedate,uuid,
			cateno,imagepath,filename,catename 
			from 
			(select /*+index_desc(sale slaeno)*/
			rownum rn, s.saleno,salename,s.cateno,
			to_char(cost,'999,999')||'원' cost,	content,amount,
			(select count(*) from sale_good where saleno = s.saleno) as good,
			s.updatedate,uuid,imagepath,filename,c.catename
			from sale s,sale_img i,sale_cate c
			where 
			s.cateno = c.cateno and  i.saleno = s.saleno and 
		]]>
		<include refid="criteria"/>
		<![CDATA[
			rownum <= #{pageNum} * #{amount})
			where (rn > (#{pageNum}-1) * #{amount})
and cateno = #{cateno}
		]]>
--------------------------------------------------------------------------------------------------------------
1. 위 코드와 거의 동일 하나 카테고리를 비교하는 조건문(볼드체)를 추가 하였음
--------------------------------------------------------------------------------------------------------------

8.SaleController
public void getSaleList(Criteria cri,Model model){

		cri.setAmount(12);

model.addAttribute("pageMaker",new PageDTO(cri,service.getCount(cri)));
}
--------------------------------------------------------------------------------------------------------------
1. cri 페이징 처리를 위해 setAmount 매서드의 파라메터로 12를 주고 호출,amoun는 한 페이지에 출력할 최대 개수임
2. 페이징 처리를 위해 cri를 파라메터로 담고 getCount를 호출하여 결과를 pageDTO의 파라메터에 담아 페이징 처리를 함 
--------------------------------------------------------------------------------------------------------------
9.SaleService
@Override
	@Override
	   public int getCount(Criteria cri) {
	      if(cri.getCateno() == 0) {
	         return mapper.getCountNoneCate(cri);
	      }
	      return mapper.getCount(cri);	
--------------------------------------------------------------------------------------------------------------
1. 카테고리 번호가 0 이라면 getCountNoneCate 매퍼를 호출하고
2. 카테고리 번호가 0 이 아니라면 getCount 매퍼를 호출함
--------------------------------------------------------------------------------------------------------------
10.SaleMapper
<select id="getCount" resultType="int">
      select count(*) from sale where
      <include refid="criteria"/>
       <![CDATA[
          saleno > 0 and 
          cateno = #{cateno}
       ]]>
   </select>  <select id="getCountNoneCate" resultType="int">
      select count(*) from sale where
      <include refid="criteria"/>
       <![CDATA[
          saleno > 0 
       ]]>
   </select>
--------------------------------------------------------------------------------------------------------------
1. 카테고리 번호가 0 이라면 모든 상품을 가져오는 getCountNoneCate의 쿼리를 수행
2. 카테고리 번호가 0 이 아니라면 선택한 카테고리 번호에 해당하는 상품만 가져오는 getCount의 쿼리를 수행
--------------------------------------------------------------------------------------------------------------





11. 상품 목록 페이지
 <c:forEach items="${list}" var="sale" varStatus="i">
         <c:set var="checkList" value="${checkList+1 }"/>
<c:if test="${checkList == null}">
         <span style="margin:auto;">등록된 상품이 없습니다.</span>
--------------------------------------------------------------------------------------------------------------
1. 해당 카테고리나 전체 상품중 상품이 없다면 등록된 상품이 없다는 글을 출력해줌
--------------------------------------------------------------------------------------------------------------















2.2 상품 상세페이지
1.SaleController
@GetMapping("/detail")
	   public void getDetail(@Param("saleno")int saleno ,Model model,Criteria cri) {
	      model.addAttribute("saleno",saleno);
	      model.addAttribute("sale",service.getSaleInfo(saleno));
	   }
--------------------------------------------------------------------------------------------------------------
1. 상품 목록에서 선택한 상품의 번호를 가져와서 Service로 넘김
--------------------------------------------------------------------------------------------------------------
2.SaleService
@Override
	public SaleVO getSaleInfo(int saleno) {
		log.info("getSaleInfo..");
		return mapper.getSaleInfo(saleno);
	}
--------------------------------------------------------------------------------------------------------------
1. Controller에서 받아온 saleno를 mapper에 넘김
--------------------------------------------------------------------------------------------------------------



3.SaleMapper
<select id="getSaleInfo" resultMap="saleMap">
		select s.saleno,salename, to_char(cost,'999,999')||'원' cost,content,amount,
			(select count(*) from sale_good where saleno = #{saleno}) as good,
			s.updatedate,uuid,imagepath,filename,c.catename,s.cateno 
			from 
			sale s,sale_img i,sale_cate c
			where s.cateno = c.cateno and 
			i.saleno = s.saleno and
			s.saleno = #{saleno}
	</select>
--------------------------------------------------------------------------------------------------------------
1. 선택한 상품의 번호와 일치하는 상품의 정보를 가져와서 출력해줌
--------------------------------------------------------------------------------------------------------------








2.3 장바구니
1.Cart.js
function insertMainCart(cart,callback,error){
		$.ajax({
			url:'/cart/insertMainCart',
			data:JSON.stringify(cart),
			dataType : 'text',
			contentType:'application/json; charset=utf-8',
			type:'POST',
			success: function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr,status,er){
				if(error){
					error(er);
--------------------------------------------------------------------------------------------------------------
1. 상품 목록페이지,상품 상세페이지에서 장바구니 담기 버튼을 누르면 해당 매서드 호출
2. ajax 로 페이지 이동없이 상품의 번호(변수 cart에 담겨있음)를 넘김
< cart 에는 userid(회원 아이디) , saleno(상품 번호) , amount ( 개수 ) 가 있음> 
3. Controller에서 보내준 상태(status)를 비교하여 에러 메시지를 출력할지 완료 메시지를 출력할지 조건식을 거침
4. 그리고 조건에 맞는 메시지를 출력함
2.CartControlle
@PostMapping(value="/insertMainCart",
			produces= { 
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
				})
	@ResponseBody
	public ResponseEntity<String> insertMainCart(Principal prin,@RequestBody CartVO vo,Model model){
	return Cservice.getMainCart(vo) == 1?new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>("fail",HttpStatus.OK);
	}
--------------------------------------------------------------------------------------------------------------
1. 반환하는 값의 형식을 xml,json형식을 반환하고 언어 코드를 UTF8로 반환
2. 장바구니에 담을 상품의 번호를 VO에 담아 Service를 호출
--------------------------------------------------------------------------------------------------------------
3.CartService
@Override
	public int getMainCart(CartVO vo) {
		return mapper.insertMainCart(vo);
	}
--------------------------------------------------------------------------------------------------------------
1. 상품의 번호(saleno)를 담은 vo를 파라메터로 담아 mapper의 inserMainCart를 호출 후 반환
--------------------------------------------------------------------------------------------------------------

4.CartMapper
<insert id="insertMainCart">
 	    insert into sale_cart 
	    select #{userid},#{saleno},#{amount} from dual 
	    where not exists 
	    (select 0 from sale_cart 
	    where userid = #{userid} and 
	    saleno = #{saleno})
 	</insert>
--------------------------------------------------------------------------------------------------------------
1. Service에서 받아온 vo 에서 상품 번호와 회원 아이디를 장바구니 목록을 추가함
--------------------------------------------------------------------------------------------------------------
5.CartController
public ResponseEntity<String> insertMainCart(
Principal prin,@RequestBody CartVO vo,Model model){
	return Cservice.getMainCart(vo) == 1	
?new ResponseEntity<>("success",HttpStatus.OK):
new ResponseEntity<>("fail",HttpStatus.OK);
	}
--------------------------------------------------------------------------------------------------------------
1. 장바구니에 등록이 된다면 1 이 반환되어 success를 등록에 문제가 생겨 안되었다면 0을 반환하여 fail을 반환
--------------------------------------------------------------------------------------------------------------


6.Cart.js
function insertMainCart(cart,callback,error){
	success: function(result,status,xhr){
				if(callback){
					callback(result);
				}
	error: function(xhr,status,er){
				if(error){
					error(er);
				}
7.제품 페이지
 if(result === 'success'){
	 alert('장바구니에 추가하였습니다');
	cartService.cartCount(function(count){
	$("#cartIcon").html('<span class="icon-shopping_cart"></span>'+"["+count+"]");
	}else{
	alert('이미 추가된 상품입니다.');
cartService.cartCount(function(count){
 	$("#cartIcon").html('<span class="icon-shopping_cart"></span>'+"["+count+"]");
		    			 });
--------------------------------------------------------------------------------------------------------------
1. result에 success 가 들어오면 장바구니에 추가되었다는 alert창을 출력해주고 success가 아니라면 이미 추가되었다는 alert창을 출력
2. 헤더 부분의 장바구니에 담긴 상품 개 수를 나타내주기 위해 cartCount를 호출함(callback)
8.Cart.js
function cartCount(callback,error){
		$.getJSON("/cart/getCartCount",
		function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error(er);
--------------------------------------------------------------------------------------------------------------
1. getCartCount를 매핑하여 Controller의 getCartCount를 호출함
--------------------------------------------------------------------------------------------------------------
9.CartController
	@ResponseBody
	public ResponseEntity<String> getCartCount(Principal prin) {
			String userid = prin.getName();
			String cart = Cservice.getCartCount(userid);
		return new ResponseEntity<>(cart,HttpStatus.OK);
	}
--------------------------------------------------------------------------------------------------------------
1. 회원의 정보를 담은 Principal에서 getName로 회원의 id 만 userid 변수에 할당
2. Service의 getCartCount 매서드의 파라메터 값으로 userid 를 넘기며 호출
3. Service에서 반환되어진 값을 cart 변수에 담아 반환해주면서 상태 값도 같이 반환
10.CartService
@Override
	public String getCartCount(String userid) {
		return mapper.getCartCount(userid);
	} // 매퍼 호출후 결과 반환
11.CartMapper
<select id="getCartCount" resultType="String">
 		select count(*) from sale_cart where userid = #{userid}
 	</select>
--------------------------------------------------------------------------------------------------------------
1. 회원 아이디를 조회하여 해당 회원의 장바구니 목록의 개수를 String 으로 반환
--------------------------------------------------------------------------------------------------------------
12.Header
cartService.cartCount(function(count){
 	$("#cartIcon").html('<span class="icon-shopping_cart"></span>'+"["+count+"]");
		    		 });
--------------------------------------------------------------------------------------------------------------
1. Mapper에서 반환받은 장바구니 개수를 count로 받아 장바구니 아이콘 옆에 출력
--------------------------------------------------------------------------------------------------------------







--------------------------------------------------------------------------------------------------------------
1. 상품 목록 페이지에서 장바구니 담기가 가능
2. 상품 상세 페이지에서도 장바구니 담기가 가능
--------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------
1. 장바구니에 담긴 상품의 수 만큼 헤더의 장바구니 아이콘에 카운트되어 있음
--------------------------------------------------------------------------------------------------------------










2.4 관심 상품 등록
1.good.js
function checkGood(param,callback,error){
		var saleno = param.saleno;
		$.getJSON("/good/checkGoodCount/"+saleno,
				function(count){
					if(callback){
						callback(count);
					}
		}).fail(function(xhr,status,err){
			if(error){
				error(er);
			}
--------------------------------------------------------------------------------------------------------------
1. 상품 목록에서 관심 상품 등록버튼을 누르게 되면 먼저 checkGood에서 현재 관심 상품으로 등록한 상품인지 등록이 되지 않은 제품인지 확인을 하게됨
2. json으로 uri에 상품 번호(saleno)를 get 방식을 controller 에 전달
--------------------------------------------------------------------------------------------------------------






2.GoodController
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
		return new ResponseEntity<>(count,HttpStatus.OK);
	}
--------------------------------------------------------------------------------------------------------------
1. 현재 로그인 중인 회원의 정보중,회원의 아이디를 userid에 할당
2. vo에 회원의 아이디와 상품 목록페이지에서 넘겨 받은 상품 번호를 할당
3. Service에 vo를 파라메터 값으로 넘겨 호출
4. 반환된 값을 count 에 할당 하고 ResponseEntity로 count와 페이지 상태를 반환 
--------------------------------------------------------------------------------------------------------------


3.GoodService
@Override
	public String checkGood(GoodVO vo) {
		return mapper.checkGood(vo);
	}
--------------------------------------------------------------------------------------------------------------
1. Controller 에서 넘겨 받은 vo 를 매퍼로 넘겨줌
--------------------------------------------------------------------------------------------------------------
4.GoodMapper
<select id="checkGood" resultType="String">
 	select count(*) from sale_good where 
 	userid = #{userid} and saleno = #{saleno}
 	</select>
--------------------------------------------------------------------------------------------------------------
1. 전체 관심 상품 목록 테이블에서 넘겨 받은 회원의 아이디와 넘겨 받은 상품 번호 또한 일치하는 관심 상품의 개 수를 조회 하여 반환
--------------------------------------------------------------------------------------------------------------







5.제품 페이지
function(result){
               if(result == '1'){
                                        goodService.removeGood(saleno,userid,function(result){
               alert('좋아요를 취소했습니다.');
               goodBtn.css('color','white');
               });
}else{
                     goodService.insertGood(good,function(result){
                     if(result === 'success'){
                                               alert('좋아요를 눌르셨습니다.');
                                               goodBtn.css('color','red');
                                            }else{
                                        goodService.insertGood(good,function(result){
                                            if(result === 'success'){
                                               console.log(result);
                                               alert('좋아요를 눌르셨습니다.');
                                               goodBtn.css('color','red');
                                            }
                                        });
--------------------------------------------------------------------------------------------------------------
1. Mapper에서 돌려 받은 값이 1 이라면 removeGood을 호출
2. Mapper에서 관심 상품을 삭제하는 쿼리를 수행하고 버튼색을 바꿈
3. Mapper에서 돌려 받은 값이 1 이 아니라면 insertGood을 호출하여 관심 상품을 추가 한 뒤 버튼의 색을 바꾸어 줌
6.GoodMapper
<delete id="deleteGood">
 		delete from sale_good 
 		where userid = #{userid} and saleno = #{saleno} 
 	</delete>
--------------------------------------------------------------------------------------------------------------
1. vo에 담아 보낸 회원 아이디(userid)와 상품 번호(saleno)로 일치하는 회원의 관심 상품을 삭제
--------------------------------------------------------------------------------------------------------------
7.GoodMapper
<insert id="insertGood">
 		insert into sale_good 
	    select #{saleno},#{userid} from dual 
	    where not exists 
	    (select 0 from sale_good
	    where userid = #{userid} and 
	    saleno = #{saleno})
 	</insert>
--------------------------------------------------------------------------------------------------------------
1. vo에 담아 보낸 회원 아이디(userid)와 상품 번호(saleno)로 일치하는 회원의 관심 상품을 등록
--------------------------------------------------------------------------------------------------------------




2.5 상품 결제
1.HomeController
@PostMapping("/order")
	public String orderPost(OrderSaleVO vo) {
		if(vo.getCpnum() != 0) {
			service.insertOrderSaleCoupon(vo);
			service.insertOrderList(vo.getUserid());
		}else {
			service.insertOrderSale(vo);
			service.insertOrderList(vo.getUserid());
		}
--------------------------------------------------------------------------------------------------------------
1. 상품 결제 페이지에서 쿠폰 번호를 받아오는데 쿠폰이 없다면 0으로 넘어옴
2. 조건문을 통해 적용시킬 쿠폰이 있다면 쿠폰 번호도 같이 DB에 저장시키는 매서드를 호출
3. 적용시킬 쿠폰이 없다면 쿠폰 번호없이 DB에 저장을 시키는 매서드를 호출
--------------------------------------------------------------------------------------------------------------
2.OrderService
@Override
	public void insertOrderSaleCoupon(OrderSaleVO vo) {
		mapper.insertOrderSaleCoupon(vo);
	}
@Override
public void insertOrderSale(OrderSaleVO vo) {
		mapper.insertOrderSale(vo);
3.OrderMapper
<insert id="insertOrderSaleCoupon">
insert into order_sale(orderno,userid,username,addr_1,addr_2,addr_3,email,phone,cpnum) 
	values(
info_seq.nextval,#{userid},#{userName},
#{addr_1},#{addr_2},#{addr_3},#{email},#{phone},#{cpnum})
 	</insert>
<insert id="insertOrderSale">
 		insert into
order_sale(orderno,userid,username,addr_1,addr_2,addr_3,email,phone) 
values(
info_seq.nextval,#{userid},#{userName},
#{addr_1},#{addr_2},#{addr_3},#{email},#{phone})
 	</insert>
--------------------------------------------------------------------------------------------------------------
1. 쿠폰이 있다면 위의 매서드와 쿼리를 호출
2. 쿠폰이 없다면 아래의 매서드를 쿼리를 호출
--------------------------------------------------------------------------------------------------------------






4.OrderService
@Override
	   public void insertOrderList(String userid) {
	      List<OrderInfoVO> vo = mapper.orderList(userid);
	      int orderno = mapper.searchOrderno(userid);
	      vo.forEach(order->{
	         order.setOrderno(orderno);
	         SaleVO sale = new SaleVO();
	         sale.setSaleno(order.getSaleno());
	         sale.setAmount(order.getAmount());
	         if(sMapper.updateAmount(sale) == 1) {
	         mapper.insertOrderList(order);
	         }
--------------------------------------------------------------------------------------------------------------
1. orderList로 회원의 아이디를 넘겨 장바구니에 담은 상품의 상품 번호와 가격, 개수를 vo 에 반환
2. searchOrderno로 회원의 아이디를 넘겨 방금 추가한 주문 번호를 가져와 orderno 에 할당
3. orderno를 주문 정보vo에 담고 주문 정보vo에 담긴 상품 번호와 상품 개수를 saleVO에 할당
4. SaleMapper의 updateAmount 쿼리를 수행
5. 정상적으로 수행이 되었다면 insertOrderList의 쿼리를 수행
--------------------------------------------------------------------------------------------------------------




5.SaleMapper
<update id="updateAmount">
      update sale set amount = amount-#{amount} where saleno = #{saleno} and amount > 0 and amount >= #{amount}
   </update>
--------------------------------------------------------------------------------------------------------------
1. 해당 쿼리에서는 상품의 최대 개수이상, 혹은 0이하로 주문이 들어올 경우 주문 완료가 되지않게 해주는 쿼리임
--------------------------------------------------------------------------------------------------------------
6.OrderMapper
<insert id="insertOrderList">
 		insert into order_info(orderno,saleno,amount) 
 		values(#{orderno},#{saleno},#{amount})
 	</insert>
--------------------------------------------------------------------------------------------------------------
1. 해당 쿼리에서는 주문 내역을 저장하는 쿼리임
--------------------------------------------------------------------------------------------------------------
7.HomeController
public String orderPost(OrderSaleVO vo) {
		Cmapper.deleteUser(vo.getUserid());
		}
--------------------------------------------------------------------------------------------------------------
1. 회원 아이디를 Mapper에 넘겨 장바구니 내역을 삭제
--------------------------------------------------------------------------------------------------------------
8.CartMapper
<delete id="deleteUser">
 		delete from sale_cart where userid = #{userid}
 	</delete>
--------------------------------------------------------------------------------------------------------------
1. 받아온 회원 아이디로 회원 아이디로 저장되어있는 장바구니 내역을 삭제
--------------------------------------------------------------------------------------------------------------
9.HomeController
CouponVO coupon = new CouponVO();
		
		coupon.setCpnum(vo.getCpnum());
		coupon.setUserid(vo.getUserid());
		
		Sservice.deleteCoupon(coupon);
		
		return "redirect:/complete";
}
--------------------------------------------------------------------------------------------------------------
1. 쿠폰 번호와 회원 아이디를 deleteCounpon매서드로 보냄
--------------------------------------------------------------------------------------------------------------




10.CouponService
@Override
	public boolean deleteCoupon(CouponVO vo) {
		return mapper.deleteCoupon(vo) > 0;
	}
--------------------------------------------------------------------------------------------------------------
1. 삭제 처리를 위한 매퍼 호출 수행이 되지않는 다면 0이 넘어와 false 수행된다면 true 반환
--------------------------------------------------------------------------------------------------------------
11.CouponMapper
<delete id="deleteCoupon">
		delete from coupon_member where cpnum = #{cpnum} and userid = #{userid}
	</delete>
--------------------------------------------------------------------------------------------------------------
1. 회원 아이디와 쿠폰 번호를 조회해 일치하는 정보를 삭제 쿠폰이 없다면 0이 넘어오기떄문에
결과를 0 으로 반환하여 Serivce에서 false를 반환하게 되고 삭제 처리가 되었다면 1이 넘어가서 true를 반환하게 됨
2. 해당 동작까지 끝나게 된다면 Controller의 return "redirect:/complete"; 가 반환되어 결제 완료창으로 이동하게 됨
--------------------------------------------------------------------------------------------------------------





2.6 결제내역 조회
1.MyPageController
@PreAuthorize("isAuthenticated()")
	@GetMapping("/order")
	public void order(Criteria cri,Model model,Principal prin) {
		String userid = prin.getName();
		model.addAttribute("list",Oservice.getOrderList(userid));
	}
--------------------------------------------------------------------------------------------------------------
1. 현재 로그인 되어있는 회원의 아이디를 userid 할당
2. 회원 아이디(userid)를 넘겨주며 getOrderList를 호출 (Oservice == orderService)
--------------------------------------------------------------------------------------------------------------
2.OrderService
	public List<Integer> getOrderno(String userid) {
		return mapper.getOrderno(userid);
	}
3.OrderMapper
<select id="getOrderno" resultType="int">
 		select orderno from order_sale where userid = #{userid} order by orderno
 	</select>
--------------------------------------------------------------------------------------------------------------
1. 넘겨 받은 userid 를 조회하여 일치하는 내역을 출력하여 그 값을 반환
2. 반환된 값을 Controller의 list 에 담아 페이지에 출력해줌
3. 유기견 관리

3.1 유기견 등록
1.AdoptController
	public String adoptUpload(DogsVO vo, RedirectAttributes rttr) {
		aService.register(vo);
		rttr.addFlashAttribute("result","
등록이 완료되었습니다. 관리자가 승인 시 목록에 표시되어집니다.");
		return "redirect:/adopt/adoptList";
	}
--------------------------------------------------------------------------------------------------------------
1. 페이지에서 받은 유기견의 정보를 vo 에 담아 adoptService의 register로 넘기며 호출
--------------------------------------------------------------------------------------------------------------
2.AdoptService
	public void register(DogsVO vo) {
		mapper.register(vo);
		if(vo.getAttachImage() == null) {
			return;
		}
		imgMapper.insertDogs(vo.getAttachImage());
}
--------------------------------------------------------------------------------------------------------------
1. mapper에 vo 를 넘기고 쿼리를 수행 이미지 여부에따라 추가 매서드 호출을 함
3.AdoptMapper
<insert id="register" >
		insert into dogs(dogno, userid, dogname, kind, age, pre, gender, detail )
		values (dogs_seq.nextval, #{userid}, #{dogName}, #{kind}, #{age}, #{pre}, #{gender}, #{detail} )
	</insert>
4.ImageMapper
<insert id="insertDogs">
		<selectKey keyProperty="dogno" order="BEFORE" resultType="int">
			select count(*) as dogno from dogs
		</selectKey>
		insert into dogs_img(uuid,imagepath,filename,dogno) 
		values(#{uuid},#{imagePath},#{fileName},#{dogno})
	</insert>
--------------------------------------------------------------------------------------------------------------
1. 이미지가 없다면 AdoptMapper의 쿼리만 수행
2. 이미지가 있다면 ImageMapper도 수행
3. 이후 Controller 에서 유기견 등록이 완료되었다는 alert 창을 출력
4. 유기견 목록 페이지로 redirect 시킴
--------------------------------------------------------------------------------------------------------------




3.1 유기견 목록
1.AdoptController
@GetMapping("/adopt/adoptList")
	public void adoptAdoptDog(Criteria cri,Model model) {
		model.addAttribute("list", aService.getDogsUserList(cri));
	}
2.AdoptService
	public List<DogsVO> getDogsUserList(Criteria cri) {
		return mapper.getDogsUserList(cri);
	}
3.AdoptMapper
<select id="getDogsUserList" resultMap="dogsMap">
		select 
		d.dogno, d.userid, dogname, kind, age, pre, 
		decode(gender, '1', '수컷', '2', '암컷') gender,detail, updatedate, 
adopt,uuid,imagePath,filename
		from dogs d, dogs_img i
		where d.dogno = i.dogno and adopt = 1 and
		d.dogno > 0 order by d.dogno desc
	</select>
--------------------------------------------------------------------------------------------------------------
1. 다른 기능들 중 목록을 나타내는 기능의 동작 원리가 비슷함
2. 조건문으로는 유기견이 분양상태가 아니여야한다는 조건이있음
3.3 유기견 상세페이지
1.AdoptController
	public void adoptDogProfile(DogsVO vo,Criteria cri, Model model) {
		int dogno = vo.getDogno();
		model.addAttribute("dogs" , aService.getDogProfile(dogno));
	}
--------------------------------------------------------------------------------------------------------------
1. 페이지에서 get방식으로 넘겨받은 유기견 고유 번호를 dogno라는 변수에 할당
2. service의 getDogProfile의 파라메터값으로 유기견 번호(dogno)를 담아 호출
--------------------------------------------------------------------------------------------------------------
2.AdoptService
	public DogsVO getDogProfile(int dogno) {
		return mapper.getDogProfile(dogno);
	}
3.AdoptMapper
<select id="getDogProfile" resultMap="dogsMap">
	select d.dogno,dogname, kind, age, pre, 
	decode(gender, '1', '수컷', '2', '암컷') gender,
detail,uuid,imagePath,filename 
	from dogs d,dogs_img I where d.dogno = i.dogno and d.dogno = #{dogno}
</select>
--------------------------------------------------------------------------------------------------------------
1. 유기견의 고유번호에 맞는 유기견의 정보들을 VO형식으로 반환
3.4 유기견 분양 신청
1.AdoptController
@PreAuthorize("isAuthenticated()")
	@GetMapping("/adopt/adoptProcess")
	public void adoptAdoptProcess(Principal prin, Criteria cri, Model model,DogsVO vo) {
		String userid = prin.getName();
		int dogno = vo.getDogno();
		model.addAttribute("member", aService.getMember(userid));
		model.addAttribute("dogs", aService.getDogProfile(dogno));
	}
--------------------------------------------------------------------------------------------------------------
1. 유기견 상세 페이지에서 분양 신청 버튼을 누르면 분양에 필요한 정보를 작성하는 페이지로 이동하게 되면서 현재 로그인 되어있는 회원의 아이디를 userid에 할당
2. 선택한 유기견의 고유 번호를 dogno 에 할당
3. getMember 매서드에서는 회원 정보를 받아오는 쿼리를 수행해 가져오고
4. getDogProfile 매서드에서는 유기견의 정보를 가져오는 쿼리를 수행하여 페이지에 출력함
--------------------------------------------------------------------------------------------------------------
2.AdoptController
	@PostMapping("/adopt/adoptRequest")
	public String adoptAdoptRequest(AdoptVO vo, Model model,RedirectAttributes rttr) {
		aService.adoptRequest(vo);
		rttr.addFlashAttribute("result","입양 신청되었습니다. 관리자가 확인 후 연락드리겠습니다.");
		return "redirect:/adopt/adoptList";
--------------------------------------------------------------------------------------------------------------
1. 분양 신청 페이지에서 작성한 정보들을 vo에 담아 Service를 호출
--------------------------------------------------------------------------------------------------------------
3.AdoptService
public void adoptRequest(AdoptVO vo) {
		mapper.getRequest(vo);
	}
4.AdoptMapper
<insert id="getRequest">
		insert into dogs_adopt(
bno, dogno, userid, userName, phone, addr_1, addr_2, addr_3, reason)
values (dogno_adopt_seq.nextval, #{dogno}, #{userid}, #{userName}, #{phone}, #{addr_1}, #{addr_2}, #{addr_3}, #{reason})
	</insert>
--------------------------------------------------------------------------------------------------------------
1. 회원이 작성한 정보들을 DB에 저장
--------------------------------------------------------------------------------------------------------------
5.AdoptController
public String adoptAdoptRequest(AdoptVO vo, Model model,RedirectAttributes rttr) {
rttr.addFlashAttribute("result","
입양 신청되었습니다. 관리자가 확인 후 연락드리겠습니다.");
		return "redirect:/adopt/adoptList";
--------------------------------------------------------------------------------------------------------------
1. DB에 저장이 되었다면 adoptList로 redirect 시키며 alert창을 출력함
4. 부가서비스

4.1 이벤트 목록
1.EventController
@GetMapping("/event")
	public void event(Criteria cri,Model model) {
		cri.setAmount(5);
		model.addAttribute("list",service.getEvent(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,service.getEventCount(cri)));
	}
--------------------------------------------------------------------------------------------------------------
1. 한 페이지에 출력할 최대 게시물 개수를 5개로 지정(setAmount)
2. service의 getEvent로 cri를 파라메터 값을 넘겨 이벤트 정보를 가져옴
3. service의 getEventCount로 cri를 파라메터 값을 넘겨 이벤트 개수를 가져와 페이징 처리
--------------------------------------------------------------------------------------------------------------
2.EventService
	public List<BoardEventVO> getEvent(Criteria cri) {
		return mapper.getEvent(cri);
	}
	public int getEventCount(Criteria cri) {
		return mapper.getEventCount(cri);

--------------------------------------------------------------------------------------------------------------
1. 두 매서드 모두 매퍼의 쿼리를 수행하도록 하는 매서드
3.EventMapper
<select id="getEvent" resultMap="eventMap">
		select 
		bno,userid,title,sub,content,updatedate,enddate,good,uuid,imagepath,filename
		from (select 
		rownum rn,b.bno,b.userid,title,sub,content,updatedate,
enddate,good,uuid,imagepath,filename 
		from board_ev b,board_ev_img i
		where b.bno = i.bno and
		<include refid="criteria"/>
	 	<![CDATA[
	 		rownum <= #{pageNum} * #{amount})
	 		where (rn > (#{pageNum}-1) * #{amount})
	 	]]>
	<select id="getEventCount" resultType="int">
		select count(*) from board_ev where
	 	<include refid="criteria"/>
	 	<![CDATA[
	 		bno > 0
	 	]]>
--------------------------------------------------------------------------------------------------------------
1. 위의 쿼리로 이벤트 정보를 가져오고 eventVO에 반환
2. 아래의 쿼리로 이벤트의 개수를 가져와 페이징 처리를 함
3. 이벤트의 정보와 이벤트의 개수를 해당 페이지에 출력
--------------------------------------------------------------------------------------------------------------
4.2 이벤트 상세페이지
1.EventController
@GetMapping("/detail")
	public void eventDetail(@Param("bno") int bno,
@ModelAttribute("cri") Criteria cri,Model model) {
		model.addAttribute("event",service.getEventInfo(bno));
	}
--------------------------------------------------------------------------------------------------------------
1. get 방식으로 bno 번호를 받아와 service의 getEventInfo 메서드의 파라메터 값으로 넘김
--------------------------------------------------------------------------------------------------------------
2.EventService
@Override
	public BoardEventVO getEventInfo(int bno) {
		return mapper.getEventInfo(bno);
	}
3.EventMapper
<select id="getEventInfo" resultMap="eventMap">
		select bno,userid,	title,sub,	content,updatedate,enddate,good
		from board_ev 
		where bno = #{bno}
	</select>
--------------------------------------------------------------------------------------------------------------
1. Controller와 Serivce를 거쳐 넘어온 bno 값을 비교하여 일치하는 이벤트 게시글 번호에 맞는 게시물의 제목,내용 등을 BoerdEventVO에 반환하여 해당 페이지에 출력
4.3 FAQ
1.ServiceController
@GetMapping("/faq")
	public void faq(Criteria cri, Model model) {
		cri.setAmount(10);
		model.addAttribute("faq", fService.faqList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, fService.faqCount(cri)));
	}
--------------------------------------------------------------------------------------------------------------
1. 한 페이지에 출력할 게시물 수를 10개로 할당( setAmount )
2. faqList 매서드로 faq 정보를 출력
3. faqCount로 페이징 처리
--------------------------------------------------------------------------------------------------------------
2.FaqService
	public List<BoardFaqVO> faqList(Criteria cri) {
		return mapper.faqList(cri);
	}
	public int faqCount(Criteria cri) {
		return mapper.faqCount(cri);
	}
--------------------------------------------------------------------------------------------------------------
1. 위의 매서드는 FAQ 정보들을 가져어고
2. 아래 매서드는 페이징에 필요한 총 게시물 수를 가져옴
--------------------------------------------------------------------------------------------------------------
3.FaqMapper
<select id="faqList" resultType="kr.icia.domain.BoardFaqVO">
		select bno,title,content
		from (select rownum rn,bno,title,content
		from board_faq
		where
		<include refid="faqCriteria" />
		<![CDATA[
			rownum <= #{pageNum} * #{amount})
	 		where (rn > (#{pageNum}-1) * #{amount}) 
	 		order by bno desc
		]]>
	</select>
<select id="faqCount" resultType="int">
		select count(bno) from board_faq where
		<include refid="faqCriteria" />
		<![CDATA[
			bno > 0
		]]>
	</select>
--------------------------------------------------------------------------------------------------------------
1. 위의 쿼리는 FAQ 정보들을 가져오는 쿼리
2. 아래의 쿼리는 전체 FAQ 개수를 가져오는 쿼리
3. Cotroller로 정보들을 넘겨 페이지에 출력을 해줌
--------------------------------------------------------------------------------------------------------------
4.4 실시간 상담
1. 실시간 상담 - API
   <script type="text/javascript">
      tocplusTop = 1150;  tocplusLeft = 5;
      tocplusMinimizedImage = 'http://kr03.tocplus007.com/img/minimized_ko.gif';
      tocplusHAlign = 'right';  tocplusWidth = 200;
      tocplusHeight = 240;
      tocplusUserName = '집사님';
      tocplusFrameColor = '#FFA500';
      tocplusFloatingWindow = true;
      var tocplusHost = (("https:" == document.location.protocol) ? "https://"
            : "http://");
      document.write(unescape("%"
                  + "3Cscript src='"
                  + tocplusHost
                  +"kr03.tocplus007.com/chatLoader.do?userId=chldlsgn00' type='text/javascript'"
                  + "%" + "3E" + "%" + "3C/script" + "%" + "3E"));
   </script>
--------------------------------------------------------------------------------------------------------------
1. TocPlus API를 적용
--------------------------------------------------------------------------------------------------------------


4.5 받은 쪽지
1.MyPageController
@PreAuthorize("isAuthenticated()")
	@GetMapping("/getRecvMail")
	public String getRecvMail(Principal principal,RedirectAttributes rttr) {
		String userid = principal.getName();
		rttr.addFlashAttribute("recv",Nservice.getRecvList(userid));
		return "redirect:/mypage/recvmail";
	}
--------------------------------------------------------------------------------------------------------------
1. principal 로 현재 로그인 중인 회원의 아이디를 userid에 할당
2. 그 값을 getRecvList의 파라메터 값으로 넘겨 호출
3. 받은 메일 페이지로 redirect 시키며 getRecvList에서 받은 값을 넘김
--------------------------------------------------------------------------------------------------------------
2.NoteService
@Override
	public List<NoteVO> getRecvList(String userid) {
		return mapper.getRecvList(userid);
	}
--------------------------------------------------------------------------------------------------------------
1. Controller 에서 넘겨받은 userid 를 mapper로 넘겨주며 호출, 결과 값을 반환
--------------------------------------------------------------------------------------------------------------

3.NoteMapper
<select id="getRecvList" resultType="kr.icia.domain.NoteVO">
	 		select noteno,  sentid, recvid, title, content, sentdate, 
	 		readdate, recvread,sentdel,recvdel
	 		from 
	 		(select /*+index_desc(note noteno)*/
	 		rownum rn, noteno, sentid,recvid,title, content, sentdate, readdate, 
	 		decode(recvread,0,'읽지않음',1,'읽음') as recvread,
			decode(sentdel,0,'전송완료',1,'삭제') as sentdel,
			decode(recvdel,0,'전송완료',1,'삭제') as recvdel
			from note 
	 		where 	
	 		recvid = #{userid})
	 </select>
--------------------------------------------------------------------------------------------------------------
1. 받은 쪽지 DB에서 service로 부터 넘겨받은 userid 에 일치하는 쪽지를 가져옴
2. 해당 쪽지들을 출력해줌
--------------------------------------------------------------------------------------------------------------






4.받은 쪽지함
<c:if test="${recv.recvread == '읽음' }">
<a style="color: gray;">제목>
<c:if test="${recv.recvread == '읽지않음' }">
<a>제목</a>
--------------------------------------------------------------------------------------------------------------
1. 받은 쪽지함 페이지에서 읽은 쪽지의 제목의 글씨색을 회색으로 바꾸어줌
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
1. 위의 쪽지는 읽지않은 쪽지
2. 아래의 쪽지는 읽은 쪽지
--------------------------------------------------------------------------------------------------------------

5.NoteConroller
@ResponseBody
	public ResponseEntity<String> getRecvCount(Principal prin) {
			String userid = prin.getName();
			String mail = Nservice.getRecvCount(userid);
		return new ResponseEntity<>(mail,HttpStatus.OK);
	}
--------------------------------------------------------------------------------------------------------------
1. Principal로 현재 로그인 중인 회원의 아이디를 가져와 userid에 할당
2. 회원의 아이디(userid)를 getRecvCount 매서드의 파라메터 값으로 넘기고 호출
--------------------------------------------------------------------------------------------------------------
6.NoteService
@Override
	public String getRecvCount(String userid) {
		return mapper.getRecvCount(userid);
	}
7.NoteMapper
<select id="getRecvCount" resultType="String">
 		select count(*) from note where recvid = #{userid} and recvread = 0
 	</select>
--------------------------------------------------------------------------------------------------------------
1. Controller와 Service를 거쳐 받은 회원 아이디를 조회하여 해당하는 쪽지들을 가져옴
2. 동시에 받은 쪽지의 읽기 여부가 읽지 않은 상태(recvread=0) 이여야 함
--------------------------------------------------------------------------------------------------------------
8.Header
mailService.mailCount(function(count) {
                        $("#mailIcon").html(
                              '<span class="icon-mail"></span>' + "["
                                    + count + "]");
                     });
--------------------------------------------------------------------------------------------------------------
1. Mapper로 부터 가져온 읽지 않은 메일의 수를 표시해줌
--------------------------------------------------------------------------------------------------------------












4.6 쪽지 보내기
1.NoteController
@PostMapping("/writemail")
	   public String writemail(NoteVO vo,RedirectAttributes rttr,Principal prin) {
	      String userid = prin.getName();
	      vo.setSentid(userid);
	      Nservice.writemail(vo);
	      return "redirect:/mypage/getSentMail";
	   }
--------------------------------------------------------------------------------------------------------------
1. 현재 로그인한 회원의 아이디를 Principal로 가져와 userid 에 할당 
2. vo에 userid를 담고 writemail 매서드의 파라메터로 vo를 담아 호출
--------------------------------------------------------------------------------------------------------------
2.NoteService
@Override
	public void writemail(NoteVO vo) {
		mapper.writemail(vo);		
	}
3.NoteService
<insert id="writemail">
		insert into note(noteno,sentid,recvid,title,content) 
		values(note_seq.nextval,#{sentid},#{recvid},#{title},
		#{content})
4.7 보낸 쪽지
1.MyPageController
@PreAuthorize("isAuthenticated()")
	@GetMapping("/getSentMail")
	public String getSentMail(Principal principal,RedirectAttributes rttr) {
		String userid = principal.getName();
		rttr.addFlashAttribute("sent",Nservice.getSentList(userid));
		return "redirect:/mypage/sentmail";
	}
--------------------------------------------------------------------------------------------------------------
1. 현재 로그인한 회원의 아이디를 Principal로 가져와 userid 에 할당
2. getSentList 매서드의 파라메터로 userid 를 넘겨 호출
--------------------------------------------------------------------------------------------------------------
2.NoteService
@Override
	public List<NoteVO> getSentList(String userid) {<select id="getSentList" resultType="kr.icia.domain.NoteVO">
	return mapper.getSentList(userid);
	}
--------------------------------------------------------------------------------------------------------------
1. Controller에서 넘겨 받은 userid를 Mapper에 넘김
--------------------------------------------------------------------------------------------------------------


3.NoteMapper
	<select id="getSentList" resultType="kr.icia.domain.NoteVO">
	select noteno, sentid, recvid, title, content, sentdate, readdate, 
	recvread,sentdel,recvdel
	from 
	(select /*+index_desc(note noteno)*/
	rownum rn, noteno, sentid,recvid,title, content, sentdate, readdate, 
	decode(recvread,0,'읽지않음',1,'읽음') as recvread,
	decode(sentdel,0,'전송완료',1,'삭제') as sentdel,
	decode(recvdel,0,'전송완료',1,'삭제') as recvdel
	from note 
	where 	
sentid = #{userid})
	</select>
--------------------------------------------------------------------------------------------------------------
1. 보낸 쪽지를 조회하는 쿼리로 Service로 부터 넘겨 받은 userid 를 비교하여 일치하는 회원의
보낸 쪽지 정보를 가져와 출력, 빠른 검색을 위해 index를 사용
2. 결과를 NoteVO형태로 반환
3. Controller에서 선언한 대로 sentmail로 redirect 시키며 해당 쿼리의 결과를 출력 해줌
--------------------------------------------------------------------------------------------------------------





5. 회원 관리 < 관리자 >

5.1 회원 목록 조회
1.AdminController
@GetMapping("/member/member")
	public void connectAdmin(Criteria cri,Model model) {
		model.addAttribute("list",service.getList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,service.getMemberCount(cri)));
	}
--------------------------------------------------------------------------------------------------------------
1. criteria 에 할당된 기본값(20)에 따라 한 페이지에 20명의 회원 정보만 출력 되도록 하기 위해 PageDTO에 cri 와 getMemberCount 매서드의 결과 값을 파라메터 값으로 줌
2. 회원의 정보들을 가져오기 위해 cri를 파라메터로 넘겨 getList를 호출
--------------------------------------------------------------------------------------------------------------
2.MemberService
@Override
	public int getMemberCount(Criteria cri) {
		return mapper.getMemberCount(cri);
	}
--------------------------------------------------------------------------------------------------------------
1. 넘겨 받은 cri 를 다시 Mapper의 파라메터로 다시 넘겨  호출
--------------------------------------------------------------------------------------------------------------


3.MemberMapper
<select id="getMemberCount" resultType="int">
	 	select count(userno) from member m,grade g where m.grade = g.grade and  
	 	<include refid="criteria"/>
	 	<![CDATA[
	 		userno > 0
	 	]]>
	 </select>
--------------------------------------------------------------------------------------------------------------
1. 회원의 수를 가져오는 쿼리임
--------------------------------------------------------------------------------------------------------------
4.MemberService
@Override
	public List<MemberVO> getList(Criteria cri) {
		return mapper.getMemberWithPaging(cri);
	}
5.MemberMapper
<select id="getMember" resultMap="memberMap">
	 	select userno, m.grade,tear, username, userid, addr_1,addr_2, addr_3,  phone, 
	 	email,to_char(birth,'yyyyMMdd') as birth, joindate, 
	 	decode(enabled,0,'이메일 인증 대기',1,'정상',2,'정지') as enabled,
	 	report, decode(adopt,0,'무','유') as adopt 
	 	from member m, grade gwhere m.grade = g.grade and 
	 	userid = #{userid}
6.회원 목록 페이지
<c:if test="${member.report > 4}">
<a href="./getMember?userid=${member.userid}" class="" style="color:red;">${member.userid}</a>
</c:if>
<c:if test="${member.report < 5}">
<a href="./getMember?userid=${member.userid}" class="">${member.userid}</a></c:if>
--------------------------------------------------------------------------------------------------------------
1. 목록을 출력할 페이지에서 만약 신고 횟수가 5회 이상 누적되었다면 빨간색으로 표시
--------------------------------------------------------------------------------------------------------------








1.2 회원 정보 변경
1.AdminController
@PostMapping("/member/modify")
	public String modify(MemberVO vo,RedirectAttributes rttr) {
		if(service.adminUpdateUser(vo)) {
			rttr.addFlashAttribute("result","회원정보 수정이 완료되었습니다.");
		}else {
			rttr.addFlashAttribute("result","수정이 실패하였습니다.");
		}
		return "redirect:/admin/member/member";
	}
--------------------------------------------------------------------------------------------------------------
1. 회원 정보 변경 페이지에서 변경한 값을 vo에 담아 adminUpdateUser의 파라메터로 넘겨 호출
--------------------------------------------------------------------------------------------------------------
2.MemberService
@Override
	public boolean adminUpdateUser(MemberVO vo) {
		return mapper.adminUpdateUser(vo) == 1;
	}
3.MemberMapper
<update id="adminUpdateUser">
	 	update member set enabled = #{enabled},report = #{report},adopt = #{adopt},
	 	grade = #{grade.grade},updatedate = sysdate  
	 	where userno = #{userno}

--------------------------------------------------------------------------------------------------------------
1. 회원의 계정 정보 중 등급,분양 유무, 계정 상태만 수정이 가능함
--------------------------------------------------------------------------------------------------------------



6. 상품 관리

6.1 상품 목록
1.AdminController
@GetMapping("/product/list")
	public void productList(Criteria cri,Model model) {
		cri.setAmount(12);
		model.addAttribute("menu",sService.getCate());
		model.addAttribute("list",sService.getSale(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,sService.getCount(cri)));
	}
--------------------------------------------------------------------------------------------------------------
1. 한 페이지에 출력할 최대 게시물 수를 12개로 정하기 위해 setAmoun(12) 호출
2. 카테고리 목록을 받기 위해 getCate를 호출
3. 상품 목록을 받기위해 카테고리 번호가 있는 cri 와 함께 getSale를 호출 
4. 페이징 처리를 위해 cri를 getCount 매서드에서 반환한 과 함께 PageDTO의 파라메터로 넘김
--------------------------------------------------------------------------------------------------------------
2.SaleService - 관리자 상품 목록 - 2
@Override
	public List<CateVO> getCate() {
		return mapper.getCate();
	}

3.SaleMapper - 관리자 상품 목록 - 3 
<select id="getCate" resultType="kr.icia.domain.CateVO">
		select * from sale_cate
	</select>

4.SaleService - 관리자 상품 목록 - 4
@Override
	public List<SaleVO> getSale(Criteria cri) {
		if(cri.getCateno() == 0) {
			return mapper.getSale(cri);
		}
	return mapper.getSaleList(cri);
	}
--------------------------------------------------------------------------------------------------------------
1. getCate 매서드로 가져와 cri에 담은 정보중 카테고리 번호를 조회 하여 0 일 경우 전체 목록을 출력하는 매서드를 호출
2. cri에 담긴 카테고리 번호가 0이 아니라면 해당 카테고리 번호와 일치하는 상품의 정보들을 출력하는 매서드를 호출
3. 두 경우 경우 모두 상품의 정보들을 반환함( 형식은 SaleVO )
4. 이후 페이지에 출력
--------------------------------------------------------------------------------------------------------------




6.2 상품 정보 수정
1.AdoptController
@PostMapping("/product/saleInfo")
	public String modify(SaleVO vo,RedirectAttributes rttr) {
		if (sService.updateSale(vo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/admin/product/list";
	}
--------------------------------------------------------------------------------------------------------------
1. 페이지에서 입력한 상품의 정보를 담은 vo를 updateSale 매서드의 파라메터  값으로 넘김
2. 결과 값이 true 라면 success 라는 alert창을 출력하고 상품 목록 페이지로 redirect 시킴
3. 결과 값이 false 라면 아무 창도 출력하지 않고 상품 목록 페이지로 redirect 시킴
--------------------------------------------------------------------------------------------------------------
2.AdoptService
@Override
public boolean updateSale(SaleVO vo) {
	boolean check = false;
	if(vo.getAttachImage() == null) {
		if(mapper.updateSale(vo) == 1) {
			check = true;
			return check;
		}

--------------------------------------------------------------------------------------------------------------
1. vo에 상품의 이미지가 없다면 상품 정보를 수정하는 updateSale 쿼리를 수행하여 되었으면 check를 true를 할당하여 반환
--------------------------------------------------------------------------------------------------------------
}else if(vo.getAttachImage() != null){
			vo.getAttachImage().setSaleno(vo.getSaleno());
			if(imgMapper.updateSale(vo.getAttachImage()) == 1) {
				if(mapper.updateSale(vo) == 1) {
					check = true;
				}
--------------------------------------------------------------------------------------------------------------
1. 이미지가 있다면 상품 이미지 vo 에 상품 번호를 할당
2. vo의 getAttachImage를 파라메터로 담아 이미지 Mapper의 매서드, updateSale 호출
3. 반환 값이 1 이라면 updateSale 매서드를 호출하여 상품 정보를 저장 시킴
--------------------------------------------------------------------------------------------------------------
3.ImageMapper
<update id="updateSale">
		update sale_img set uuid = #{uuid},imagepath = #{imagePath},
		filename = #{fileName} 
		where saleno = #{saleno}
	</update>
--------------------------------------------------------------------------------------------------------------
1. 해당 쿼리를 수행하여 상품 이미지로 저장
2. 상품을 출력할 때 saleno로 조회 하여 일치하는 이미지가 있다면 그 이미지를 출력하고
3. 없다면 출력하지않는 처리를 함
4.SaleMapper
<update id="updateSale">
		update sale set salename = #{saleName},cost = #{cost},content = #{content},
updatedate = sysdate,amount = #{amount},cateno = #{cate.cateno}  
		where 
		saleno = #{saleno} 
	</update>
--------------------------------------------------------------------------------------------------------------
1. Service에서 넘어온 vo에 담긴 정보들을 update 해줌
--------------------------------------------------------------------------------------------------------------















6.3 상품 등록
1.AdoptController
@PostMapping("/product/saleUpload")
	public String productUpload(SaleVO vo,RedirectAttributes rttr) {
		sService.register(vo);
		return "redirect:/admin/product/list";
	}
--------------------------------------------------------------------------------------------------------------
1. 상품 등록 페이지에서 입력한 정보들을 담은 vo를 Service의 register 로 넘기며 호출
--------------------------------------------------------------------------------------------------------------
2.SaleService
@Override
	public void register(SaleVO vo) {
		mapper.register(vo);
		if(vo.getAttachImage() == null) {
			return;
		}
		imgMapper.insert(vo.getAttachImage());
	}
--------------------------------------------------------------------------------------------------------------
1. Mapper의 register 매서드를 호출하고 업로드한 상품의 이미지가 없다면 동작을 그만두고 반환
2. 이미지가 있다면 if문을 지나쳐 imgMapper의 insert매서드를 호출하여 이미지를 저장함
--------------------------------------------------------------------------------------------------------------

3.SaleMapper
<insert id="register">
		insert into sale(saleno,salename,cost,content,amount,cateno) 
		values(sale_seq.nextval,#{saleName},#{cost},#{content},#{amount},#{cate.cateno})
	</insert>
4.ImageMapper
<insert id="insert">
		<selectKey keyProperty="saleno" order="BEFORE" resultType="int">
			select max(saleno) as saleno from sale
		</selectKey>
		insert into sale_img(uuid,imagepath,filename,saleno) 
		values(#{uuid},#{imagePath},#{fileName},#{saleno})
	</insert>
--------------------------------------------------------------------------------------------------------------
1. 이미지가 없다면 위의 쿼리만 수행
2. 이미지가 있다면 아래의 쿼리를 수행하게 되는데
3. selectkey로 insert 쿼리를 수행하기전(BEFORE) 상품 번호의 최대값을 가져와 그 값을 insert 해줌
4. 이렇게 insert하는 이유는 모든 상품에 이미지를 넣은 것이라고 설계를 했기 때문
--------------------------------------------------------------------------------------------------------------





6.4 상품 삭제
1.AdminController
@PostMapping("/product/remove")
	public String productRemove(SaleVO vo,RedirectAttributes rttr) {
		if(sService.removeSale(vo)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/admin/product/list";
	}
2.SaleController
@Transactional
	@Override
	public boolean removeSale(SaleVO vo) {
		Cmapper.removeCart(vo.getSaleno());
		Gmapper.removeGood(vo.getSaleno());
		imgMapper.removeSaleImage(vo.getSaleno());
		return mapper.deleteSale(vo.getSaleno()) == 1;
	}
--------------------------------------------------------------------------------------------------------------
1. 해당 상품에 대한 정보가 담긴 모든 테이블의 정보들을 지우기 위해 장바구니,관심상품,이미지,상품정보를 지우는 Mapper의 매서드들을 호출
--------------------------------------------------------------------------------------------------------------


3.CartMapper
<delete id="removeCart">
 		delete from sale_cart 
 		where saleno= #{saleno}
 	</delete>
4.GoodMapper
<delete id="deleteGood">
 		delete from sale_good 
 		where userid = #{userid} and saleno = #{saleno} 
 	</delete>
5.ImageMapper
<delete id="removeSaleImage">
		delete from sale_img 
		where saleno = #{saleno}
	</delete>
6.SaleMapper
<delete id="deleteSale">
		delete from sale where 
		saleno = #{saleno}
	</delete>
--------------------------------------------------------------------------------------------------------------
1. 위에서부터 장바구니, 관심상품, 이미지, 상품 정보 순으로 쿼리를 수행하여 상품 정보를 지움
--------------------------------------------------------------------------------------------------------------
7. 유기견관리

7.1 신청된 유기견 목록
1.AdminController
@GetMapping("/dogReg/dogReg")
	public void dogRegDogReg(Criteria cri, Model model) {
		model.addAttribute("list", aService.getDogsList(cri));
	}
2.AdoptService
@Override
	public List<DogsVO> getDogsList(Criteria cri) {
		return mapper.getDogsList(cri);
	}
3.AdoptMapper
<select id="getDogsList" resultMap="dogsMap">
	   select  d.dogno,d.userid,dogname, kind,age,pre, 
	   decode(gender, '1', '수컷', '2', '암컷') gender,detail,updatedate, 
	   decode(adopt, '0', '등록 대기', '1', '분양 등록중', '2' , '분양 완료') adopt ,
	   uuid,imagePath,filename from dogs d,dogs_img i
	   where d.dogno = i.dogno and d.dogno > 0 order by d.dogno desc
--------------------------------------------------------------------------------------------------------------
1. 유기견 등록을 신청한 목록을 가져와 출력해주는 과정
2. 유기견 등록 신청부터 분양 완료되었을 경우에도 출력해주고 목록에 출력이 됨
7.2 신청된 유기견 상세 페이지
1.AdminController
@GetMapping("/dogReg/dRegister")
	public void dogRegdRegister(int dogno, Criteria cri,Model model) {
		model.addAttribute("dogs", aService.getDogs(dogno));
	}
2.AdoptService
	public DogsVO getDogs(int dogno) {
		return mapper.getDogs(dogno);
	}
3.AdoptMapper
<select id="getDogs" resultType="kr.icia.domain.DogsVO">
	   select dogno, dogname,userid,kind,age,pre,detail, 
	   decode(gender, '1', '수컷', '2', '암컷') gender,
	   decode(adopt, '0', '등록 대기', '1', '분양 등록중', '2' , '분양 완료') adopt 
	   from dogs  where dogno = #{dogno}
	</select>
--------------------------------------------------------------------------------------------------------------
1. 신청된 유기견 등록 신청 목록에서 사진을 클릭하면 해당 유기견의 고유 번호(dogno)를 get방식으로 넘겨 DB에서 조회
2. 조회된 정보들을 DogsVO에 담아 유기견 등록 신청 상세 페이지에 출력
--------------------------------------------------------------------------------------------------------------

7.3 신청된 유기견 등록
1.AdminController
@PostMapping("/dogReg/dogUpdate")
	public String dogUpdate(DogsVO vo, RedirectAttributes rttr) {
		if(aService.update(vo)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/admin/dogReg/dogReg";
	}
2.AdoptService
public boolean update(DogsVO vo) {
		return mapper.update(vo) == 1;
	}
3.AdoptMapper
<update id="update">
		update dogs set 
		apprdate = sysdate,
		adopt = 1 where dogno = ${dogno}
--------------------------------------------------------------------------------------------------------------
1. 상세 페이지에서 등록 버튼을 누르게 되면 유기견 등록을 신청한 유저가 입력한 정보들을
DB에 업데이트되어 분양 상태 번호(adopt)를 분양 신청 상태(adopt=1)로 만들고 분양 신청일(apprdate)을 관리자가 등록한 날로 수정(update)됨
2. 등록이 되었다면 success 라는 내용의 alert창을 출력하고 유기견 등록 신청한 목록으로 돌아가고 등록이 되지 않았다면 alert창을 출력하지 않고 유기견 등록 신청한 목록으로 돌아감
7.4 유기견 분양 신청 목록
1.AdminController
@GetMapping("/dogAdopt/dogAdopt")
	public void dogAdoptDogAdopt(Criteria cri,Model model) {
		model.addAttribute("list", aService.getRequestList(cri));
	}
2.AdoptService
@Override
	public List<AdoptVO> getRequestList(Criteria cri) {
		return mapper.getRequestList(cri);
	}
3.AdoptMapper
<select id="getRequestList" resultMap="adoptMap">
		select bno,a.dogno,a.userid, dogname,phone,addr_1, addr_2, addr_3,
		uuid,imagePath,filename
		from dogs_adopt a, dogs_img i,dogs d
		where a.dogno = i.dogno and a.adopt = 0 and
		bno > 0 
		order by bno desc
	</select>
--------------------------------------------------------------------------------------------------------------
1. 유기견 등록 신청한 유기견 목록을 출력
2. 유기견 등록 신청한 상태(adopt=0)여야 목록에 출력이 됨
7.5 유기견 분양 신청 상세 페이지
1.AdminController
@GetMapping("/dogAdopt/adoptAdmit")
public void dogAdoptAdoptAdmit(int dogno,int bno, Model model) {
	      model.addAttribute("adopt", aService.getRequestUser(bno));
	   }
2.AdoptService
@Override
	public AdoptVO getRequestUser(int bno) {
		return mapper.getRequestUser(bno);
	}
3.AdoptMapper
<select id="getRequestUser" resultType="kr.icia.domain.AdoptVO">
		   select d.dogno,a.bno,a.userid,a.userName,phone,
		   addr_1,addr_2, addr_3,reason
		   from dogs d,dogs_adopt a
		   where d.dogno = a.dogno and bno = #{bno}
		   order by bno desc
--------------------------------------------------------------------------------------------------------------
1. 유기견 분양 신청 목록 페이지에서 이미지를 클릭할 경우 해당 글의 고유 번호(bno)와 유기견의 고유 번호(dogno)를 get방식으로 넘김
2. 페이지에서 받은 bno를 Service를 거쳐 Mapper의 쿼리문으로 전달하여 분양 신청 테이블(dog_adopt) 테이블에 저장된 bno와 비교하여 일치하는 게시물 번호의 유기견 고유 번호를 비교하여 일치하는 유기견의 정보와 분양 신청한 회원의 정보를 함께 출력
7.6 유기견 분양 승인
1.AdminController
@PostMapping("/dogAdopt/adoptCompl")
	public String dogAdoptAdoptCompl(AdoptVO vo, RedirectAttributes rttr) {
		if(aService.adopt(vo)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/admin/dogAdopt/dogAdopt";
	}
--------------------------------------------------------------------------------------------------------------
1. Service의 adopt를 호출하여 true로 반환이 되면 result라는 이름의 속성에 success라는 문자열을 담아 alert창으로 출력하고 유기견 분양 신청 목록으로 redirect 시키고 분양 승인이 되지않아 false를 반환할 경우 alert창을 출력하지않고 유기견 분양 신청 목록으로 redirect 시킴
--------------------------------------------------------------------------------------------------------------
2.AdoptService
@Override
	public boolean adopt(AdoptVO vo) {
		boolean check = false;
		if(Mmapper.updateAdopt(vo.getUserid()) == 1 && mapper.adopt(vo) == 1 && mapper.adoptUser(vo) == 1)
			check = true;
		return check;
--------------------------------------------------------------------------------------------------------------
1. MemberMapper에서 회원의 분양 상태를 수정
2. adoptMapper에서 유기견의 분양 상태를 수정
3.AdoptMapper
<update id="adopt">
	update dogs set adopt = 2,selldate = sysdate 
	where dogno = #{dogno}
	</update>
	<update id="adoptUser">
	update dogs_adopt set adopt = 1 
	where dogno = #{dogno}
	</update>
--------------------------------------------------------------------------------------------------------------
1. dogs는 유기견의 상세 정보
2. dogs_adopt는 유기견 분양 상세 정보
--------------------------------------------------------------------------------------------------------------












8. 부가 서비스
8.1 이벤트 목록
1.AdminController
@GetMapping("/event/event")
	public void eventEvent(Criteria cri, Model model) {
		cri.setAmount(4);
		model.addAttribute("list",eService.getEvent(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,eService.getEventCount(cri)));
	}
--------------------------------------------------------------------------------------------------------------
1. 페이징 처리를 위해 Criteria의 amount 값을 4로 할당해 줌
2. 이벤트 목록을 출력하기 위해 cri 를 파라메터 값으로 getEvent를 호출
3. 페이징 처리를 위해 getEventCount를 호출
--------------------------------------------------------------------------------------------------------------
2.EventService
@Override
	public List<BoardEventVO> getEvent(Criteria cri) {
		return mapper.getEvent(cri);
	}
--------------------------------------------------------------------------------------------------------------
1. Controller에서 넘겨 받은 cri를 Mapper의 getEvent의 파라메터 값으로 넘기며 호출
--------------------------------------------------------------------------------------------------------------

3.EventMapper
<select id="getEvent" resultMap="eventMap">
		select bno,userid,title,sub,content,updatedate,enddate,
		good,uuid,imagepath,filename
		from (select 
			rownum rn,b.bno,b.userid,title,sub,content,updatedate,enddate,
			good,uuid,imagepath,filename 
			from board_ev b,board_ev_img i
			where b.bno = i.bno and
		<include refid="criteria"/>
	 	<![CDATA[
	 		rownum <= #{pageNum} * #{amount})
	 		where (rn > (#{pageNum}-1) * #{amount})
	 	]]>
	</select>
--------------------------------------------------------------------------------------------------------------
1. board_ev 테이블에 있는 이벤트 정보를 BoardEventVO에 저장
2. 썸네일 이미지를 출력하기 위해 board_ev_img 테이블의 고유 번호(uuid), 이미지 경로(imagepath), 파일 이름(filename)도 가져옴 
--------------------------------------------------------------------------------------------------------------



4.EventService
@Override
	public int getEventCount(Criteria cri) {
		return mapper.getEventCount(cri);
	}
5.EventMapper
<select id="getEventCount" resultType="int">
		select count(*) from board_ev where
	 	<include refid="criteria"/>
	 	<![CDATA[
	 		bno > 0
	 	]]>
	</select>
--------------------------------------------------------------------------------------------------------------
1. 페이징 처리를 위해 이벤트 게시판의 게시물의 전체 개수를 가져옴
--------------------------------------------------------------------------------------------------------------








8.2 이벤트 상세페이지
1.EventController
@GetMapping("/detail")
	public void eventDetail(int bno,@ModelAttribute("cri") Criteria cri,Model model) {
		model.addAttribute("event",service.getEventInfo(bno));
	}
2.EventService
@Override
	public BoardEventVO getEventInfo(int bno) {
		return mapper.getEventInfo(bno);
	}
3.EventMapper
<select id="getEventInfo" resultMap="eventMap">
		select bno,userid,title,sub,content,updatedate,enddate,good
		from board_ev 
		where bno = #{bno}
	</select>
--------------------------------------------------------------------------------------------------------------
1. 이벤트 목록에서 이벤트 이미지를 클릭하면 이벤트 상세 페이지 출력
2. 쿼리문에서는 이미지를 추출해내는 부분이 없지만 MyBatis의 collection 태그의 기능으로 bno에 걸려있는 외래키를 통해 이벤트 게시판 이미지 테이블(board_ev_img)에서 동일한 bno 의 이미지를 정보들을 가져와 출력
--------------------------------------------------------------------------------------------------------------

8.3 이벤트 등록
1.AdminController
@PostMapping("/event/eventUpload")
	public String eventUpload(BoardEventVO vo, RedirectAttributes rttr) {
		eService.register(vo);
		return "redirect:/admin/event/event";
	}
2.EventService
@Override
	public void register(BoardEventVO vo) {
		mapper.register(vo);
		if(vo.getAttachImage() == null) {
			return;
		}
		imgMapper.insertEvent(vo.getAttachImage());
	}
--------------------------------------------------------------------------------------------------------------
1. Mapper의 register 매서드를 호출하여 쿼리를 수행하여 DB에 이벤트의 정보를 저장함 
2. 이벤트 등록 페이지에서 추가한 이미지가 없다면 동작을 멈춤
3. 추가한 이미지가 있다면 insertEvent매서드를 호출
--------------------------------------------------------------------------------------------------------------



3.EventMapper
<insert id="register">
		insert into board_ev(bno, userid, title, sub, content, enddate)
		values(board_ev_seq.nextval, #{userid}, #{title}, #{sub}, #{content} ,#{endDate})
	</insert>
4.ImageMapper
<insert id="insertEvent">
		<selectKey keyProperty="bno" order="BEFORE" resultType="int">
			select count(*) as bno from board_ev
		</selectKey>
		insert into board_ev_img(uuid,imagepath,filename,bno) 
		values(#{uuid},#{imagePath},#{fileName},#{bno})
	</insert>
--------------------------------------------------------------------------------------------------------------
1. 이미지가 없다면 위의 쿼리만 수행
2. 이미지가 있다면 두 쿼리 모두 수행
3. 위의 쿼리는 이벤트 등록 페이지에서 입력한 정보를 DB에 저장하는 쿼리
4. 아래의 쿼리도 이벤트 등록 페이지에서 업로드한 이미지를 가져와 지정한 위치에 저장하고 해당 이미지에 대한 정보를 DB에 저장을 하는데 selectkey를 통해 이벤트 게시판의 총 게시물 수를 가져와 그 수를 bno로 지정해주며 해당 번호로 저장함
( 모든 이벤트는 이미지가 있다는 가정하에 설계되었음 )
--------------------------------------------------------------------------------------------------------------



8.4 이벤트 수정
1.EventController
@PreAuthorize("principal.username == #vo.userid")
	@PostMapping("/modify")
	public String update(BoardEventVO vo,Criteria cri,RedirectAttributes rttr) {
		if(service.update(vo)) {
			rttr.addFlashAttribute("result","수정이 완료되었습니다.");
		}
		return "redirect:/event/event"+cri.getListLink();
	}
2.EventService
@Override
	public boolean update(BoardEventVO vo) {
		return mapper.update(vo) == 1;
3.EventMapper
<update id="update">
update board_ev set title=#{title},content=#{content},enddate=#{endDate} where bno = #{bno}
</update>
--------------------------------------------------------------------------------------------------------------
1. 이벤트 수정 페이지에서 수정한 정보들을 Controller 와 Service를 거쳐 Mapper의 전달해 쿼리를 수행하고 update된 수를 반환 ( 고유 번호(bno)가 있기 때문에 1과0만 반환)
2. 수행이 되었다면 Service에서 boolean타입으로 반환받아 Controller의 조건문을 거침
3. true라면 수정이 완료되었다는 alert창을 출력하고 이벤트 목록 페이지로 redirect 시킴
4. false라면 alert창을 출력하지 않고 이벤트 목록 페이지로 redirect 시킴
8.5 이벤트 삭제
1.EventController
@PreAuthorize("principal.username == #vo.userid")
	@PostMapping("/remove")
	public String eventRemove(BoardEventVO vo,Criteria cri,RedirectAttributes rttr) {
		if(service.delete(vo.getBno())){
			rttr.addFlashAttribute("result","게시물 삭제가 완료되었습니다.");
		}
		return "redirect:/event/event"+cri.getListLink();
	}
2.EventService
@Override
	public boolean delete(int bno) {
		imgMapper.removeEvent(bno);
		return mapper.delete(bno) == 1;
	}
--------------------------------------------------------------------------------------------------------------
1. imgMapper의 removeEvent를 호출하여 등록한 이미지의 정보를 삭제
2. 이벤트의 정보를 삭제하는 delete를 호출
3. 정상적으로 삭제가 된다면 1을 반환하여 true로 반환
4. 정상적으로 삭제가 되지않았다면 0 을 반환하여 false를 반환
--------------------------------------------------------------------------------------------------------------


3.ImageMapper
	<delete id="removeEvent">
		delete from board_ev_img
		where bno = #{bno}
	</delete>
4.EventMapper
<delete id="delete">
		delete from board_ev where bno = #{bno}
	</delete>
--------------------------------------------------------------------------------------------------------------
1. 두 쿼리문 모두 수행하며 페이지에서 받아온 bno에 해당하는 정보만 삭제
--------------------------------------------------------------------------------------------------------------












8.6 FAQ 목록
1.AdminController
@GetMapping("/faq/faq")
	public void faq(Criteria cri, Model model) {
		cri.setAmount(10);
		model.addAttribute("faq", fService.faqList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, fService.faqCount(cri)));
	}
2.FaqService
@Override
	public List<BoardFaqVO> faqList(Criteria cri) {
		return mapper.faqList(cri);
	}
3.FaqMapper
<select id="faqList" resultType="kr.icia.domain.BoardFaqVO">
	Select bno,title,content
	from (select rownum rn,bno,title,content
		from board_faq where
		<include refid="faqCriteria" />	
		<![CDATA[
			rownum <= #{pageNum} * #{amount})
	 		where (rn > (#{pageNum}-1) * #{amount}) 
	 		order by bno desc
8.7 FAQ 상세 페이지
1.AdminController
@GetMapping("/faq/faqInfo")
	public void getInfo(int bno, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("faq", fService.getFaq(bno));
	}
2.FaqService
@Override
	public BoardFaqVO getFaq(int bno) {
		return mapper.getFaq(bno);
	}
3.FaqMapper
<select id="getFaq" resultType="kr.icia.domain.BoardFaqVO">
		select bno,title,content
		from board_faq
		where bno =#{bno}
	</select>
--------------------------------------------------------------------------------------------------------------
1. FAQ 목록 페이지에서 받은 게시물 번호(bno)를 가져와 일치하는 글의 제목(title)과 내용(content)를 가져와 화면에 출력해줌
--------------------------------------------------------------------------------------------------------------


8.8 FAQ 등록
1.AdminController
@PostMapping("/faq/insertFaq")
	   public String faq(BoardFaqVO vo, RedirectAttributes rttr) {
	      fService.register(vo);
	      rttr.addFlashAttribute("result","글 추가가 완료되었습니다.");
	      return "redirect:/admin/faq/faq";
	  }
2.FaqService
@Override
	public void register(BoardFaqVO vo) {
		mapper.register(vo);
	}
3.FaqMapper
<insert id="register">
		insert into board_faq(bno, title, content)
		values(board_faq_seq.nextval, #{title}, #{content})
	</insert>
--------------------------------------------------------------------------------------------------------------
1. FAQ 등록 페이지에서 입력한 정보들을 Controller와 Service를 거쳐 Mapper를 통해 DB에 저장
2. DB에 저장후 글이 추가되었다는 alert창을 출력해주며 FAQ 목록 페이지로 redirec 시킴
--------------------------------------------------------------------------------------------------------------

8.9 FAQ 삭제
1.AdminController
@PostMapping("/faq/remove")
	public String remove(BoardFaqVO vo,RedirectAttributes rttr) {
		if(fService.delete(vo.getBno())){
			rttr.addFlashAttribute("result","게시물 삭제가 완료되었습니다.");
		}
		return "redirect:/admin/faq/faq";
2.FaqService
@Override
	public boolean delete(int bno) {
		return mapper.delete(bno) == 1;
	}
3.FaqMapper
<delete id="delete">
		delete from board_faq where bno = #{bno}
	</delete>
--------------------------------------------------------------------------------------------------------------
1. FAQ 상세 페이지에서 삭제버튼을 누르면 confirm창을 출력해 삭제 여부를 다시 한번 입력받도록 하고 다시 한번 삭제를 하면 해당 게시물 번호를 post 형식으로 Controller로 보냄
2. Controller에서 Service를 거쳐 Mapper에 게시물 번호(bno)값을 넘겨 게시물 번호와 일치하는 정보를 삭제
3. 정상적으로 삭제가 되었다면 Service에서 true를 반환하여 삭제가 완료되었다는 alert창을 출력
4. FAQ 목록으로 redirect 시킴
9. 쿠폰관리

9.1 쿠폰 등록
1.AdminController
@PostMapping("/coupon/registerCoupon")
	public String couponRegister(CouponVO vo,RedirectAttributes rttr) {
		cService.insertCoupon(vo);
		return "redirect:/admin/coupon/coupon";
	}
2.CouponService
@Override
	public void insertCoupon(CouponVO vo) {
		mapper.insertCoupon(vo);
	}
3.CouponMapper
<insert id="insertCoupon">
		insert into coupon(cpnum,cpname,cpcontent,value,type) 
		values(coupon_seq.nextval,#{cpName},#{cpContent},#{value},#{type})
	</insert>




9.2 등급별 쿠폰 발급
1.AdminController
@PostMapping("/coupon/registerGrade")
	public String couponRegisterGrade(CouponVO vo,RedirectAttributes rttr) {
		cService.inserGradeCoupon(vo);
		return "redirect:/admin/coupon/list";
	}
2.CouponService
@Override
	public void inserGradeCoupon(CouponVO vo) {
		List<String> userid = mMapper.getGradeId((vo.getGrade().getTear()));
		userid.forEach(id->{
			vo.setUserid(id);
			mapper.insertGradeCoupon(vo);
		});
	}
--------------------------------------------------------------------------------------------------------------
1. vo에서 입력받은 등급을 가져와 Mapper의 getGradeId로 넘겨주며 호출함
2. Mapper에서 반환 받은 값을 List형식의 userid로 할당
3. forEach로 받아온 회원 아이디를 vo에 할당 ,Mapper의 쿼리를 수행
--------------------------------------------------------------------------------------------------------------



3.MemberMapper
<select id="getGradeId" resultType="String">
	 	select 
m.userid from member m,grade g where m.grade = g.grade and tear = #{tear}
	 </select>
--------------------------------------------------------------------------------------------------------------
1. 페이지에서 입력한 등급의 회원 아이디를 반환
--------------------------------------------------------------------------------------------------------------
4.CouponMapper
<insert id="insertGradeCoupon">
		insert into coupon_member(userid,cpnum,cpenddate) 
		values(#{userid},#{cpnum},#{cpEndDate})
	</insert>
--------------------------------------------------------------------------------------------------------------
1. MemberMapper에서 넘겨 받은 회원 아이디에게 쿠폰을 부여(forEach 반복)
--------------------------------------------------------------------------------------------------------------






9.3 지정 회원 쿠폰 발급
1.AdminController
@PostMapping("/coupon/registerUser")
	public String couponRegisterUser(CouponVO vo,RedirectAttributes rttr) {
		cService.insertUser(vo);
		return "redirect:/admin/coupon/list?type=I&keyword="+vo.getUserid();
	}
--------------------------------------------------------------------------------------------------------------
1. 페이지에서 입력받은 정보를 vo에 담아 insertUser에 넘기며 호출
2. insertUser 호출 후 쿠폰 발급 리스트로 이동하는데 회원의 아이디를 검색하여 해당 회원의 쿠폰 목록만을 보여주는 페이지를 출력
--------------------------------------------------------------------------------------------------------------
2.CouponService
@Override
	public void insertUser(CouponVO vo) {
		if(mMapper.userIdCheck(vo.getUserid()) == 1)
			mapper.insertGradeCoupon(vo);
	}
--------------------------------------------------------------------------------------------------------------
1. 회원의 아이디와 일치하는 회원이 있다면 매퍼의 쿼리를 수행
2. 해당 쿼리는 등급별 쿠폰 발급에서 수행했던 같은 쿼리임
--------------------------------------------------------------------------------------------------------------
