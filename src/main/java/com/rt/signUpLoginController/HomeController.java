package com.rt.signUpLoginController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.rt.signinAndSignupServiceImp.LoginServiceImp;
import com.rt.signinAndSignupServiceInterface.LoginServiceInterface;
import com.rt.signupAndSignInDTO.ParkingDashBoardInfoDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	
	@Autowired
	LoginServiceInterface loginServiceInterface;
	
	//Sign-in and sign up form.
	@GetMapping("/")
	public String signInAndSignUpPage() {
		return "signInAndSignUp";
	}  
	
//initial value for dashboard.	
	@GetMapping("/home")
	public String homePage(Model model) {
		ParkingDashBoardInfoDTO dashInfo=loginServiceInterface.gatherAllRecordDetails();
		model.addAttribute("dashRecord", dashInfo);
		return "index";
	}   
	
	//logout the user.
	@GetMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate();
	    return "redirect:/";
	}
	

}
