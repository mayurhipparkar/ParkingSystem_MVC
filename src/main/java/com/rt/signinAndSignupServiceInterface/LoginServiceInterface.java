package com.rt.signinAndSignupServiceInterface;

import org.springframework.stereotype.Service;

import com.rt.signupAndSignInDTO.ParkingDashBoardInfoDTO;
import com.rt.signupAndSignInDTO.RequestLoginDTO;
import com.rt.signupAndSignInDTO.ResponseLoginDTO;


@Service
public interface LoginServiceInterface {

	ResponseLoginDTO loginUser(RequestLoginDTO signUpDto);

	ParkingDashBoardInfoDTO gatherAllRecordDetails();

	String resetPassword(String email, String newPassword);

}
