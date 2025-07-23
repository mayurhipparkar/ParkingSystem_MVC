package com.rt.signUpLoginController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rt.signinAndSignupServiceImp.LoginServiceImp;
import com.rt.signinAndSignupServiceImp.SignUpServiceImp;
import com.rt.signinAndSignupServiceInterface.LoginServiceInterface;
import com.rt.signupAndSignInDTO.RequestLoginDTO;
import com.rt.signupAndSignInDTO.RequestSignUpDTO;
import com.rt.signupAndSignInDTO.ResponseLoginDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginSignUpController {
	
	// SignUp logic Start.
	
	@Autowired
	SignUpServiceImp signUpService; //autowired signup service class.
	
	
	//it handles the registration form and transfer the data to service implemented class.
		@PostMapping("/registeruser")
		public String registerForm(@ModelAttribute RequestSignUpDTO reqDto,Model model,HttpSession session) {
			
			String userMessage=signUpService.registerUser(reqDto);//service method.
			System.out.println(reqDto.getFullname()+" "+reqDto.getEmail());
			System.out.println("check User status for signUp is it True or false :"+userMessage);
		
			if(userMessage!=null) {	
				model.addAttribute("status",userMessage);
				return "signInAndSignUp";
			}
			
			return "signInAndSignUp";
			
		}
		
	// SignUp logic End.
		
	// Login logic Start.
		
		@Autowired
		private LoginServiceInterface loginService; //autowired login service class.
		
		@PostMapping("/loginuser")
		public String loginForm(@ModelAttribute RequestLoginDTO reqLoginDto, Model model, HttpSession session) {
		    ResponseLoginDTO respLoginDto = loginService.loginUser(reqLoginDto);

		    if (respLoginDto != null) {
		        if (!"Active".equalsIgnoreCase(respLoginDto.getStatus())) {
		            model.addAttribute("status", "User is not active...!");
		            return "signInAndSignUp";
		        }

		        //Set user details in session
		        session.setAttribute("userId", String.valueOf(respLoginDto.getId()));
		        session.setAttribute("userName", respLoginDto.getFullname());
		        session.setAttribute("userEmail", respLoginDto.getEmail());
		        session.setAttribute("userRole", respLoginDto.getRole());

		        return "redirect:/home";
		    }

		    model.addAttribute("status", "Invalid email or password...!");
		    model.addAttribute("showForgotPassword", true);
		    return "signInAndSignUp";
		}
		
		
		@PostMapping("/resetpassword")
		public String resetPassword(@RequestParam String email,@RequestParam String newPassword,Model model) {
			String message=loginService.resetPassword(email,newPassword);
			model.addAttribute("status", message);
			return "signInAndSignUp";		
		}

		
	// Login Login end.
}
