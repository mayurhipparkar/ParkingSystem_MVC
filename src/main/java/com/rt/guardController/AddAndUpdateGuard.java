package com.rt.guardController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.rt.guardDTO.AddGuardReqDTO;
import com.rt.guardDTO.FetchGuardDetailsReqDTO;
import com.rt.guardDTO.FetchGuardDetailsRespDTO;
import com.rt.guardServiceInterface.GuardServiceInterface;

import jakarta.servlet.http.HttpSession;

@Controller
public class AddAndUpdateGuard {
	
	@Autowired
	private GuardServiceInterface guardServiceInterface;
	
	//add guard logic start.
	@GetMapping("/add-guard-form")
	public String addGuardForm() {
		return "guard/addGuard";
	}
	
	@PostMapping("/add-guard")
	public String getGuardData(@ModelAttribute AddGuardReqDTO addGuardReqDTO,
	                          RedirectAttributes redirectAttributes) {
		
	    System.out.println("guard details :" + addGuardReqDTO.getFullname() + " " + addGuardReqDTO.getNumber() + " " +
	            addGuardReqDTO.getEmail() + " " + addGuardReqDTO.getAddress() + " " + addGuardReqDTO.getPassword()+" "+ addGuardReqDTO.getStatus());

	    String message = guardServiceInterface.addGuard(addGuardReqDTO);
	   

	    if (message != null) {
	        System.out.println("the guard message :" + message);
	        
	        if ("Email already exists...!".equalsIgnoreCase(message) || 
	            "Only 'Guard' role is allowed!".equalsIgnoreCase(message) || "Contact number already exists...!".equalsIgnoreCase(message)) {
	            redirectAttributes.addFlashAttribute("msgStatus", message);
	            return "redirect:/add-guard-form";
	        }

	        redirectAttributes.addFlashAttribute("status", message);
	        return "redirect:/guard-list/" + addGuardReqDTO.getRole();
	    }

	    redirectAttributes.addFlashAttribute("msgStatus",message);
	    return "redirect:/add-guard-form";
	}
	
	//add guard logic end.
	
	
	//update guard logic start.
	
	@GetMapping("/fetch-guard/{id}/{role}")
	public String guardUpdateFormBasedOnId(@PathVariable int id,@PathVariable String role,HttpSession session,Model model,RedirectAttributes redirectAttributes) {
		System.out.println("Guard fetched data in update :"+id+ " " +role);
				
		FetchGuardDetailsReqDTO fetchGuardDetailsReqDTO=new FetchGuardDetailsReqDTO(id,role);
		
		FetchGuardDetailsRespDTO fetchGuardDetailsRespDTO=guardServiceInterface.fetchGuardDataById(fetchGuardDetailsReqDTO);
		System.out.println("Guard fetched data set in dto :"+fetchGuardDetailsReqDTO.getId()+ " " +fetchGuardDetailsReqDTO.getRole());
		if(fetchGuardDetailsRespDTO!=null) {
			model.addAttribute("guardData", fetchGuardDetailsRespDTO);
			return "guard/updateGuard";
		}
		 redirectAttributes.addFlashAttribute("status","Something Wrong");
	        return "redirect:/guard-list/" + role;
		
	}
	
	@PostMapping("/update-guard")
	public String updateGuardbasedOnId(@ModelAttribute FetchGuardDetailsRespDTO fetchGuardDetailsRespDTO,
			RedirectAttributes redirectAttributes) {
		
		 String message = guardServiceInterface.updateGuard(fetchGuardDetailsRespDTO);
		   
		    if (message != null) {
		        System.out.println("the guard message :" + message);
		        
		        if ("Email already exists...!".equalsIgnoreCase(message) || 
		            "Only 'Guard' role is allowed!".equalsIgnoreCase(message) || "Contact number already exists...!".equalsIgnoreCase(message)) {
		            redirectAttributes.addFlashAttribute("msgStatus", message);
		            return "redirect:/fetch-guard/"+fetchGuardDetailsRespDTO.getId()+"/"+fetchGuardDetailsRespDTO.getRole();
		        }
		        
		        redirectAttributes.addFlashAttribute("status", message);
		        return "redirect:/guard-list/" + fetchGuardDetailsRespDTO.getRole();
		    }

		    redirectAttributes.addFlashAttribute("msgStatus",message);
		    return "redirect:/fetch-guard/"+fetchGuardDetailsRespDTO.getId()+"/"+fetchGuardDetailsRespDTO.getRole();
		
	}
	
	
	
	//update guard logic end.

}
