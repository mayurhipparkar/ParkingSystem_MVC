package com.rt.parkingController;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.rt.parkingDTO.ParkingEntryReqDTO;
import com.rt.parkingDTO.ParkingEntryRespDTO;
import com.rt.parkingDTO.ParkingFeeReqDTO;
import com.rt.parkingDTO.ParkingFeeRespDTO;
import com.rt.parkingDTO.ParkingFetchRespDTO;
import com.rt.parkingServiceInterface.ParkingManagementServiceInterface;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/parking")
public class ParkingManagementController {

    @Autowired
    private ParkingManagementServiceInterface parkingManagementServiceInterface;

    // Load the parking JSP page
    @GetMapping("/parking-entry-form")
    public String parkingForm(@RequestParam(required = false) String vehicleAdded, Model model) {
        if ("true".equals(vehicleAdded)) {
            model.addAttribute("msgStatus", "Vehicle added successfully. Please continue parking entry.");
        }
        return "parking/assignParking";
    }
    
    // Load the parking list JSP page
    @GetMapping("/all-parking-list")
    public String getparkingListByRole(@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            HttpSession session,Model model) {
    	String sessionUserRole =(String)session.getAttribute("userRole");
    	int sessionUserId=Integer.parseInt((String)session.getAttribute("userId"));
    	
    	  Map<String, Object> response = parkingManagementServiceInterface.getparkingListByRole(page, size, sessionUserId, sessionUserRole);
    	 // Check for error
        if (Boolean.TRUE.equals(response.get("error"))) {
            model.addAttribute("msgStatus", response.get("message"));
            model.addAttribute("data", List.of()); // empty list
            model.addAttribute("currentPage", 0);
            model.addAttribute("totalPages", 0);
            model.addAttribute("totalItems", 0);
        } else {
            model.addAttribute("data", response.get("data"));
            model.addAttribute("currentPage", response.get("currentPage"));
            model.addAttribute("totalPages", response.get("totalPages"));
            model.addAttribute("totalItems", response.get("totalItems"));
        }

        return "parking/parkedVehicleList";
    }
    
//it is used to get parking record based on status for js side .
    @ResponseBody
    @GetMapping("/all-parking-list-by-filter")
    public List<ParkingEntryRespDTO> getparkingListByStatusFilter(@RequestParam String statusFilter,HttpSession session) {
    	System.out.println("filter value in parking list is :"+statusFilter);
    	int sessionUserId=Integer.parseInt((String)session.getAttribute("userId"));
    	String sessionUserRole=(String)session.getAttribute("userRole");
    	List<ParkingEntryRespDTO> list=parkingManagementServiceInterface.getparkingListByStatusFilter(statusFilter,sessionUserId,sessionUserRole);
		return list;
    	
    }
    
    
  //it is used to get parking record based on search of vehicle number for js side .
    @ResponseBody
    @GetMapping("/all-parking-list-by-filter-number")
    public List<ParkingEntryRespDTO> getparkingListByVehicleNumber(@RequestParam String search,HttpSession session) {
    	System.out.println("search value in parking list is :"+search);
    	int sessionUserId=Integer.parseInt((String)session.getAttribute("userId"));
    	String sessionUserRole=(String)session.getAttribute("userRole");
    	List<ParkingEntryRespDTO> list=parkingManagementServiceInterface.getparkingListByVehicleNumber(search,sessionUserId,sessionUserRole);
		return list;
    	
    }

    //JSON response for parking form 
    @ResponseBody
    @GetMapping("/vehicle-and-slot-data")
    public ResponseEntity<Map<String, Object>> vehicleAndSlotData(@RequestParam String vType,HttpSession session) {
        System.out.println("Fetching data for type: " + vType);
        int sessionUserId=Integer.parseInt((String)session.getAttribute("userId"));
        ResponseEntity<Map<String, Object>> response = 
                parkingManagementServiceInterface.fetchVehicleAndSlotDataBasedOnVehicleTypeAndUserId(vType,sessionUserId);

        return ResponseEntity.status(response.getStatusCode()).body(response.getBody());
    }
    
    //it is used to allocate slot to vehicle.
    @PostMapping("/assign-slot")
    public String assignSlotToVehicle(@ModelAttribute ParkingEntryReqDTO parkingEntryReqDTO,Model model,HttpSession session,
    		RedirectAttributes redirectAttributes) {
    	int sessionUserId=Integer.parseInt((String)session.getAttribute("userId"));
    	parkingEntryReqDTO.setUserId(sessionUserId);
    	
    	try {
    	String message=parkingManagementServiceInterface.assignSlotToVehicle(parkingEntryReqDTO);
    	redirectAttributes.addFlashAttribute("msgStatus", message);
    	 return"redirect:/parking/all-parking-list";
    	 
    	}catch(RuntimeException e) {
    		// Log the exception and set error message
	        System.out.println("Error while adding vehicle: " + e.getMessage());
	        model.addAttribute("msgStatus", e.getMessage());
    	}
    	
    	 return"parking/assignParking";
    }
    
//it is used to fetch particular parking record based on id.    
    @GetMapping("/fetch-parking")
    public String fetchSingleParkingById(@RequestParam int parkingId,Model model) {
    	System.out.println("parking id :"+parkingId);
    	ParkingFetchRespDTO result=parkingManagementServiceInterface.fetchSingleParkingById(parkingId);
    	model.addAttribute("data", result);
		return "parking/exitParking";
    	
    }
    
    //it is used to exit particular vehicle by parking id.
    @PostMapping("/exit-vehicle-parking")
    public String exitParkedVehicleById(@ModelAttribute ParkingFetchRespDTO parkingFetchRespDTO,Model model,RedirectAttributes redirectAttributes) {
    	System.out.println("parking id :"+parkingFetchRespDTO.getParkingId());
    	try {
    	String message=parkingManagementServiceInterface.exitParkedVehicleById(parkingFetchRespDTO);
    	redirectAttributes.addFlashAttribute("msgStatus", message);
   	 	return"redirect:/parking/all-parking-list";
   	 
   	}catch(RuntimeException e) {
   		// Log the exception and set error message
	        System.out.println("Error while adding vehicle: " + e.getMessage());
	        model.addAttribute("msgStatus", e.getMessage());
   	}
   	
   	 return"parking/exitParking";
   }
    
    //it is used to open parking fees form.
    @GetMapping("/parking-fees-form")
    public String parkingfeesForm() {
    	
		return "parking/parkingFeeForm";
    	
    }
    
    @PostMapping("/save-parking-fee")
    public String setParkingFee(@ModelAttribute ParkingFeeReqDTO parkingFeeReqDTO,Model model,HttpSession session,RedirectAttributes redirectAttributes) {
    	try {
    		int userId=Integer.parseInt((String)session.getAttribute("userId"));
    		parkingFeeReqDTO.setUserId(userId);//set session userId
    	String message=parkingManagementServiceInterface.setParkingFee(parkingFeeReqDTO);
    	redirectAttributes.addFlashAttribute("msgStatus", message);
    	return"redirect:/parking/parking-fee-list";
    	}catch(RuntimeException e) {
       		// Log the exception and set error message
    	        System.out.println("Error while adding vehicle: " + e.getMessage());
    	        model.addAttribute("msgStatus", e.getMessage());
       	}
    	return "parking/parkingFeeForm";
    }
    
    
  //it is used to fetch all record of parking fee.
    @GetMapping("/parking-fee-list")
    public String parkingFeeList(HttpSession session,Model model) {
    	String userRole=(String) session.getAttribute("userRole");
    	 List<ParkingFeeRespDTO> respDto=parkingManagementServiceInterface.parkingFeeList(userRole);
    	 model.addAttribute("parkingFeeList", respDto);
		return "parking/parkingFeeList";
    }
    	
    
    //it is used to fetch particular record of parking fee based on id.
    @GetMapping("/fetch-parking-fee/{feeId}")
    public String fetchParkingFeeById(@PathVariable int feeId,Model model) {
    	try {
    	 ParkingFeeRespDTO respDto=parkingManagementServiceInterface.fetchParkingFeeById(feeId);
    	 model.addAttribute("parkingFee", respDto);
		return "parking/parkingFeeUpdateForm";
    	}catch(RuntimeException e) {
    		 System.out.println("Error while adding vehicle: " + e.getMessage());
 	        model.addAttribute("msgStatus", e.getMessage());
    	}
    	return "parking/parkingFeeList";
    }
    	
    
    //it is used to fetch particular record of parking fee based on id.
    @PostMapping("/update-parking-fee")
    public String updateParkingFee(@ModelAttribute ParkingFeeRespDTO parkingFeeRespDTO,Model model,RedirectAttributes redirectAttributes) {
    	try {
    	 String message=parkingManagementServiceInterface.updateParkingFee(parkingFeeRespDTO);
    	 redirectAttributes.addFlashAttribute("msgStatus", message);
     	return"redirect:/parking/parking-fee-list";
    	}catch(RuntimeException e) {
    		 System.out.println("Error while adding vehicle: " + e.getMessage());
 	        model.addAttribute("msgStatus", e.getMessage());
    	}
    	return "redirect:/parking/fetch-parking-fee/"+parkingFeeRespDTO.getParkingFeeId();
    }
    	
    
    
}
