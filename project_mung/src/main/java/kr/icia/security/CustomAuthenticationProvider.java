package kr.icia.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.icia.security.domain.CustomUser;
import lombok.extern.log4j.Log4j;
@Log4j
public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	@Autowired
	private CustomUserDetailsService service;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		 String userid= (String) authentication.getPrincipal();
	     String userpw = (String) authentication.getCredentials();
	     
		CustomUser user = (CustomUser) service.loadUserByUsername(userid);
		
		log.info(user);
		
		if(user == null) {
			throw new UsernameNotFoundException(userid);
		}
		
		String enabled = user.getEnabled();
		
		if(!matchPassword(userpw, user.getPassword())) {
			throw new BadCredentialsException(userid);
        }
		
		log.info(enabled);
		
		if(enabled.equals("0")) {
			throw new DisabledException(enabled);
		}else if(enabled.equals("2")) {
			throw new LockedException(enabled);
		}
		
		return new UsernamePasswordAuthenticationToken(userid, userpw, user.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
	
	private boolean matchPassword(String loginPwd, String password) {
        return loginPwd.equals(password);
    }
}
