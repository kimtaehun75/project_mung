package kr.icia.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.icia.domain.MemberVO;
import kr.icia.mapper.MemberMapper;
import kr.icia.security.domain.CustomUser;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	@Setter(onMethod_= {@Autowired})
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
			log.warn("load user by userName : "+username);	 
			MemberVO vo = mapper.read(username);
			
			if(vo == null) {
				throw new BadCredentialsException(username);
			}
			
			String enabled= vo.getEnabled();
			
			if(enabled.equals("0")) {
				throw new DisabledException(enabled);
			}else if(enabled.equals("2")) {
				throw new LockedException(enabled);
			}
			
			return vo==null?null:new CustomUser(vo);
	}
	
}
