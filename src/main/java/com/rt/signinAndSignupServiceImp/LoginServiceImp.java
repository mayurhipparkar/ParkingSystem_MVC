package com.rt.signinAndSignupServiceImp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.rt.signinAndSignupServiceInterface.LoginServiceInterface;
import com.rt.signupAndSignInDTO.RequestLoginDTO;
import com.rt.signupAndSignInDTO.ResponseLoginDTO;
@Service
public class LoginServiceImp implements LoginServiceInterface {
	@Autowired 
	private RestTemplate restTemplate;

	//here RestTemplate used to connect the two different project and transfer the data to rest Api.
	@Override
	public ResponseLoginDTO loginUser(RequestLoginDTO reqLoginDto) {
		String url="http://localhost:8181/users/login";
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    
	    HttpEntity<RequestLoginDTO> request = new HttpEntity<>(reqLoginDto, headers);
	    ResponseLoginDTO respLoginDto=restTemplate.postForObject(url, request, ResponseLoginDTO.class);
		
		return respLoginDto; 
	}

}
