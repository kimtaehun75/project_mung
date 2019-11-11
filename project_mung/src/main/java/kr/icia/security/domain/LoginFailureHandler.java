package kr.icia.security.domain;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Getter
@Setter
public class LoginFailureHandler implements AuthenticationFailureHandler {
	
	private String loginIdName;
	private String loginPwName;
	private String errorMsgName;
	private String defaultFailureUrl;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String username = request.getParameter(loginIdName);
		String password = request.getParameter(loginPwName);
		String errorMsg = null;		
		
		log.info(username);
		log.info(password);
		
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
		
		request.setAttribute(loginIdName,username);
		request.setAttribute(loginPwName,password);
		request.setAttribute(errorMsgName,errorMsg);
		
		
		
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
	}

}
