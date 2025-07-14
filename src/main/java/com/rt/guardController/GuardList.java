package com.rt.guardController;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rt.guardDTO.AllGuardRespDTO;
import com.rt.guardServiceInterface.GuardServiceInterface;

import jakarta.servlet.http.HttpSession;

@Controller
public class GuardList {
	
	@Autowired
	private GuardServiceInterface guardServiceInterface;
	
	//it is used in list to redirect to home.
		@GetMapping("/from-guard")
		public String homePage() {
			
			return "redirect:/home";
		}  

	//it is used to fetch all guard record with pagination.
	@GetMapping("/guard-list/{role}")
	public String guardList(@PathVariable String role,
			@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            Model model,HttpSession session) {
		
		String sessionUserRole=(String)session.getAttribute("userRole");
		Map<String, Object> response =guardServiceInterface.getAllGuardRecord(page,size,role,sessionUserRole);
		ObjectMapper mapper = new ObjectMapper();
		
		// Convert the raw list of LinkedHashMap to DTO list
		List<AllGuardRespDTO> guardList = ((List<?>) response.get("data")).stream()
		.map(item -> mapper.convertValue(item, AllGuardRespDTO.class))
		.toList();
		
		model.addAttribute("guardList", guardList);
		model.addAttribute("currentPage", response.get("currentPage"));
		model.addAttribute("totalPages", response.get("totalPages"));
		model.addAttribute("totalItems", response.get("totalItems"));    
		model.addAttribute("role",role);     
		
		return"guard/guardList";
	}
	
	//it is used to filter guard record based on there status (Active or Inactive) and it return json data..
	@ResponseBody
	@GetMapping("/guard-list-filter/{role}")
	public Map<String, Object> guardListByStatusFilter(@PathVariable String role,
			@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(required = false) String statusFilter,
            Model model,HttpSession session) {
		
		String sessionUserRole=(String)session.getAttribute("userRole");
		return guardServiceInterface.getAllGuardRecordUsingStatusFilter(page,size,role,statusFilter,sessionUserRole);
	}
	
	
	// it is used to filter guard record based on their searched name and it return json data.
	@ResponseBody
	 @GetMapping("/guard-list-search/{role}")
	    public List<AllGuardRespDTO> showGuardList(@PathVariable String role,
	                                @RequestParam(required = false) String search,
	                                Model model) {
		
		System.out.println("search and role :"+search+ " "+role);
	       return guardServiceInterface.fetchGuardsBySearch(search, role);
	    }

}
