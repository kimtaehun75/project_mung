package kr.icia.security;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.icia.domain.OrderSaleVO;
import kr.icia.mapper.CouponMapper;
import kr.icia.mapper.MemberMapper;
import kr.icia.mapper.OrderMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"
	})
@Log4j
public class MemberTests {
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_=@Autowired)
	private DataSource ds;
	
	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private CouponMapper cMapper;
	
	@Setter(onMethod_=@Autowired)
	private OrderMapper Omapper;
	
	/*@Test
	public void testInsertMember() {
		String sql = "insert into member(userno,userid,userpw,username,addr_1,addr_2,addr_3,phone,email,birth,enabled) values(member_seq.nextval,?,?,?,'주소1','주소2','주소3','01046526481','kimtaehun75@naver.com','19960829',1)";
		
		for(int i=0;i<100;i++) {
			Connection con=null;
			PreparedStatement pstmt = null;
			
			try {
				con=ds.getConnection();
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(2,pwencoder.encode("pw"+i));
				
				if(i<80) {
					pstmt.setString(1,"user"+i);
					pstmt.setString(3,"일반사용자"+i);
				}else if(i<90){
					pstmt.setString(1,"manager"+i);
					pstmt.setString(3,"운영자"+i);
				}else {
					pstmt.setString(1,"admin"+i);
					pstmt.setString(3,"관리자"+i);
				}
				pstmt.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					}catch(Exception e) {
						e.printStackTrace();
					}
					if(con != null) {
						try {
							con.close();
						}catch(Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
	}/*
	/*
	@Test
	public void readTest() {
		String userid = "user1";
		
		MemberVO vo = mapper.read(userid);
		
		log.info(vo);
	}
	*/
	/*@Test
	public void insertTest() {
			String sql = "insert into member_auth(userid,auth) values(?,?)";
		
			for(int i=0;i<100;i++) {
			Connection con=null;
			PreparedStatement pstmt = null;
			
			try {
				con=ds.getConnection();
				pstmt=con.prepareStatement(sql);
				
				if(i<80) {
					pstmt.setString(1,"user"+i);
					pstmt.setString(2,"ROLE_USER");
				}else if(i<90){
					pstmt.setString(1,"manager"+i);
					pstmt.setString(2,"ROLE_MANAGER");
				}else {
					pstmt.setString(1,"admin"+i);
					pstmt.setString(2,"ROLE_ADMIN");
				}
				pstmt.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					}catch(Exception e) {
						e.printStackTrace();
					}
					if(con != null) {
						try {
							con.close();
						}catch(Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
	}*/
	/*@Test
	public void getUser() {
		String userid = "admin";
		
		UsersDetails user = mapper.getUser(userid);
		
		log.info(user);
	}*/
	
	/*@Test
	public void getHaveCouponList() {
		
		Criteria cri = new Criteria();
		
		log.info(cMapper.haveCouponList(cri));
	}*/
	
	@Test
	public void callOrderList() {
		
		String userid = "admin";
		
			List<OrderSaleVO> list = new ArrayList<>();
		
		List<Integer> orderno = Omapper.getOrderno(userid);
		
		orderno.forEach(number->{
			OrderSaleVO vo = new OrderSaleVO();
			vo = Omapper.callOrderList(number);
			log.info("vo : "+vo);
			vo.setOrderList(Omapper.callProduct(number));
			log.info("vo product : "+vo);
			list.add(vo);
		});
		
		log.info(list);
	}
}
