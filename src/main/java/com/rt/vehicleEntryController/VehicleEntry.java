package com.rt.vehicleEntryController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rt.vehicleEntryDTO.add.AddVehicleReqDto;
import com.rt.vehicleEntryDTO.add.AddVehicleRespDto;
import com.rt.vehicleEntryDTO.select.RespFetchVehicleInfo;
import com.rt.vehicleEntryServiceInterface.VehicleEntryInterface;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/vehicle")
public class VehicleEntry {
	@Autowired
	private VehicleEntryInterface vehicleEntryInterface;
	
	@GetMapping("add-vehicle-Form")
	public String addVehicleEntryForm() {
		return "vehicleEntry/addVehicle";	
	}
	
	//it is used to add data in database.
	@PostMapping("/add-Vehicle")
	public String addVehicleEntryData(@ModelAttribute AddVehicleReqDto addVehicleReqDto,HttpSession session) {
		int sessionUserId=Integer.parseInt((String) session.getAttribute("userId"));
		String sessionRole=(String) session.getAttribute("userRole");
		 addVehicleReqDto.setUserId(sessionUserId);
		 addVehicleReqDto.setUserRole(sessionRole);
		 System.out.println("session value "+ session.getAttribute("userId"));
		 System.out.println("session role "+ session.getAttribute("userRole"));
		
		AddVehicleRespDto addVehicleRespDto=vehicleEntryInterface.addVehicleInfo(addVehicleReqDto);
		if(addVehicleRespDto!=null) {
			System.out.println("vehicle entry added");
			if(addVehicleRespDto.getVehicleType().equalsIgnoreCase("two wheeler")) {
				
				return "redirect:/list/twoWheeler-list/"+addVehicleRespDto.getVehicleType();
				
			}else if(addVehicleRespDto.getVehicleType().equalsIgnoreCase("four wheeler")){
			
				return "redirect:/list/fourWheeler-list/"+addVehicleRespDto.getVehicleType();
			} 
		
		}
		return "vehicleEntry/addVehicle";
		
	}
	
	//it is used to fetch data using id to update the individual data in update form.
	@GetMapping("/fetch-Vehicle/{id}")
	public String fetchVehicleData(@PathVariable int id,Model model,HttpSession session) {
		int sessionUserId=Integer.parseInt((String)session.getAttribute("userId"));
		String sessionUserRole=(String)session.getAttribute("userRole");
		RespFetchVehicleInfo respFetchVehicleInfo=vehicleEntryInterface.fetchVehicleData(id,sessionUserId,sessionUserRole);
		if(respFetchVehicleInfo!=null) {
			model.addAttribute("vehicleData", respFetchVehicleInfo);
				return "vehicleEntry/updateVehicleInfo";
		}
		 
		return "vehicleEntry/twoWheelerlist";
	}
	
}
