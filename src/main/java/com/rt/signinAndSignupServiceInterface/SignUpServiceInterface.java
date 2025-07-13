package com.rt.signinAndSignupServiceInterface;

import org.springframework.stereotype.Service;

import com.rt.signupAndSignInDTO.RequestSignUpDTO;


@Service
public interface SignUpServiceInterface {

	
	 String registerUser(RequestSignUpDTO reqDto);

}
