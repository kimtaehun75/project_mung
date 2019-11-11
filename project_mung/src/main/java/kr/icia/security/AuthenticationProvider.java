package kr.icia.security;

import org.springframework.security.core.Authentication;

public interface AuthenticationProvider extends org.springframework.security.authentication.AuthenticationProvider {
	public Authentication Authenticate();
}
