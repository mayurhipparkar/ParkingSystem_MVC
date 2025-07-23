package com.rt.slotController;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.rt.slotDTO.CreateSlotRequestDTO;
import com.rt.slotDTO.CreateSlotResponseDTO;
import com.rt.slotServiceInterface.SlotServiceInterface;


@Controller
public class SlotController {
	
	@Autowired
	private SlotServiceInterface slotServiceInterface;
	
	@GetMapping("/slot-form")
	public String createSlotForm() {
		return "slot/createSlot";
		
	}
	
	@PostMapping("/create-multiple-slots")
	public String createMultipleSlots(@ModelAttribute CreateSlotRequestDTO createSlotRequestDTO,RedirectAttributes redirectAttributes) {
	    System.out.println("slot data : " + createSlotRequestDTO.getVehicleType() + " " + createSlotRequestDTO.getSlotCount());
	    List<CreateSlotResponseDTO> savedSlotList;

	    try {
	        savedSlotList = slotServiceInterface.createMultipleSlots(createSlotRequestDTO);
	    } catch (RuntimeException  ex) {
	        // This handles the case when slot limit (30) is already reached
	    	redirectAttributes.addFlashAttribute("status", ex.getMessage());
	        return "redirect:/slot-form";
	    }

	    String vType = "";
	    if (!savedSlotList.isEmpty()) {
	        vType = savedSlotList.get(0).getVehicleType().trim();
	    }

	    if ("two wheeler".equalsIgnoreCase(vType) || "four wheeler".equalsIgnoreCase(vType)) {
	    	redirectAttributes.addFlashAttribute("status", "Slots created Successfully");
	        return "redirect:/slot-list/" + vType + "?page=0&size=10";
	    } else {
	    	redirectAttributes.addFlashAttribute("status", "Unknown vehicle type: " + vType);
	        return "redirect:/slot-form";
	    }
	}

 
	// it is used to fetch all slot list according to type.
	@GetMapping("/slot-list/{vType}")
	public String fourWheelerSlotList(@PathVariable String vType,
			@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
			Model model) {
		System.out.println("vehicle type in slot list :"+vType);
		
		Map<String, Object> savedSlotList=	slotServiceInterface.fetchVehicleSlots(page,size,vType);
		 
		 List<CreateSlotResponseDTO> slotList = (List<CreateSlotResponseDTO>) savedSlotList.get("data");
		    String vehicleType = (String) savedSlotList.get("vehicleType");
		    
		    System.out.println("vehicle type in slot list after api call :"+vehicleType);
		    model.addAttribute("slotList", slotList);
		    model.addAttribute("currentPage", page);
		    model.addAttribute("totalPages", savedSlotList.get("totalPages"));
		    model.addAttribute("totalItems", savedSlotList.get("totalItems"));
		    System.out.println("totol elements in list are :"+savedSlotList.get("totalItems"));
		    model.addAttribute("vehicleType", vehicleType);

		 // Return view based on vehicleType
		    if ("two wheeler".equalsIgnoreCase(vehicleType)) {
		        return "slot/twoWheelerSlotList";
		    } else if ("four wheeler".equalsIgnoreCase(vehicleType)) {
		        return "slot/fourWheelerSlotList";
		    } else {
		        model.addAttribute("msg", "Unknown vehicle type: " + vehicleType);
		        return "slot/errorSlotType";
		    }
	}
	
	
	//it is used to filter guard record based on there status (Active or Inactive) and it return json data..
		@ResponseBody
		@GetMapping("/slot-list-filter/{vType}")
		public Map<String, Object> slotListFilterByStatus(
				@PathVariable String vType,
				 @RequestParam(required = false) String statusFilter,
				@RequestParam(defaultValue = "0") int page,
	            @RequestParam(defaultValue = "10") int size) {
			 
			System.out.println("slot list vehicle type in mvc :"+vType);
			
			return slotServiceInterface.slotListFilterByStatus(page,size,vType,statusFilter);
		}


}
