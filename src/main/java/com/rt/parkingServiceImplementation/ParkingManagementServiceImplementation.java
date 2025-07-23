package com.rt.parkingServiceImplementation;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.rt.allEnum.ParkingStatus;
import com.rt.guardDTO.AllGuardRespDTO;
import com.rt.parkingDTO.ParkingEntryReqDTO;
import com.rt.parkingDTO.ParkingEntryRespDTO;
import com.rt.parkingDTO.ParkingFeeReqDTO;
import com.rt.parkingDTO.ParkingFeeRespDTO;
import com.rt.parkingDTO.ParkingFetchRespDTO;
import com.rt.parkingServiceInterface.ParkingManagementServiceInterface;

@Service
public class ParkingManagementServiceImplementation implements ParkingManagementServiceInterface {
	
    @Autowired
    private RestTemplate restTemplate;
    
//it is used to fetch vehicle and slot info for parking.
    @Override
    public ResponseEntity<Map<String, Object>> fetchVehicleAndSlotDataBasedOnVehicleTypeAndUserId(String vType,int sessionUserId) {
        String url = "http://localhost:8181/api/vehicle-and-slot-data?vType=" + vType +"&userId=" +sessionUserId;

        try {
            // Fetching response from external API
            ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);

            // Extracting response body and returning it
            Map<String, Object> responseBody = response.getBody();

            return ResponseEntity.status(response.getStatusCode()).body(responseBody);

        } catch (Exception e) {
            System.out.println(">>> Error while calling vehicle-and-slot-data API: " + e.getMessage());

            return ResponseEntity.internalServerError().body(
                Map.of("error", "Failed to fetch vehicle and slot data", "details", e.getMessage())
            );
        }
    }

    //it is used to assign parking slot to vehicle.
	@Override
	public String assignSlotToVehicle(ParkingEntryReqDTO parkingEntryReqDTO) {
		 String url = "http://localhost:8181/api/assign-slot";
		 HttpHeaders headers = new HttpHeaders();
		    headers.setContentType(MediaType.APPLICATION_JSON);
		    
			  HttpEntity<ParkingEntryReqDTO> request=new HttpEntity<>(parkingEntryReqDTO,headers);
			  try {
			        String message = restTemplate.postForObject(url, request, String.class);
			        return message;
			    } catch (HttpClientErrorException e) {
			        
			        String errorMessage = e.getResponseBodyAsString();
			        throw new RuntimeException("Failed to add parking: " + errorMessage);
			    } catch (RestClientException e) {
			        // For other errors like connection issues
			        throw new RuntimeException("Service unavailable or failed: " + e.getMessage());
			    }
	}

	//it is used to fetch parking detail based on userId.
	@Override
	public Map<String, Object> getparkingListByRole(int page, int size, int sessionUserId, String sessionUserRole) {
	    String url = "http://localhost:8181/api/all-parking-list?page=" + page + "&size=" + size
	               + "&userId=" + sessionUserId + "&userRole=" + sessionUserRole;

	    Map<String, Object> result = new HashMap<>();

	    try {
	        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);

	        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
	            result = response.getBody();
	            ObjectMapper mapper = new ObjectMapper();
	            mapper.registerModule(new JavaTimeModule());

	            List<ParkingEntryRespDTO> vehicleList = ((List<?>) result.get("data")).stream()
	                    .map(item -> mapper.convertValue(item, ParkingEntryRespDTO.class))
	                    .toList();

	            if (vehicleList != null) {
	                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm a");

	                for (ParkingEntryRespDTO dto : vehicleList) {
	                    if (dto.getInTime() != null) {
	                        dto.setFormattedEntryTime(dto.getInTime().format(formatter));
	                    }
	                    if (dto.getOutTime() != null) {
	                        dto.setFormattedExitTime(dto.getOutTime().format(formatter));
	                    }
	                }

	                result.put("data", vehicleList);
	            }
	        } else {
	            result.put("error", true);
	            result.put("message", "Failed to fetch parking list. Status: " + response.getStatusCode());
	        }
	    } catch (HttpClientErrorException | HttpServerErrorException ex) {
	        result.put("error", true);
	        result.put("message", "API Error: " + ex.getStatusCode() + " - " + ex.getResponseBodyAsString());
	    } catch (ResourceAccessException ex) {
	        result.put("error", true);
	        result.put("message", "Could not connect to the parking service. " + ex.getMessage());
	    } catch (Exception ex) {
	        result.put("error", true);
	        result.put("message", "Unexpected error occurred: " + ex.getMessage());
	    }

	    return result;
	}
	
//it is used to fetch particular record by id.
	@Override
	public ParkingFetchRespDTO fetchSingleParkingById(int parkingId) {
		String url = "http://localhost:8181/api/fetch-parking?parkingId="+parkingId;
		ParkingFetchRespDTO	response=restTemplate.getForObject(url, ParkingFetchRespDTO.class);
		return response;
	}
	
	//it is used to exit particular vehicle record by parking id.
	@Override
	public String exitParkedVehicleById(ParkingFetchRespDTO parkingFetchRespDTO) {
		
		parkingFetchRespDTO.setStatus(ParkingStatus.EXITED);//set exited status.
		
		String url = "http://localhost:8181/api/exit-vehicle-parking";
		 HttpHeaders headers = new HttpHeaders();
		    headers.setContentType(MediaType.APPLICATION_JSON);
		    
		    HttpEntity<ParkingFetchRespDTO> request=new HttpEntity<>(parkingFetchRespDTO,headers);
		    try { 
		    String message = restTemplate.postForObject(url, request, String.class);
	        return message;
		    } catch (HttpClientErrorException e) {
		        
		        String errorMessage = e.getResponseBodyAsString();
		        throw new RuntimeException("Failed to exit parking: " + errorMessage);
		    } catch (RestClientException e) {
		        // For other errors like connection issues
		        throw new RuntimeException("Service unavailable or failed: " + e.getMessage());
		    }
	}

	//it is used to set parking fee.
	@Override
	public String setParkingFee(ParkingFeeReqDTO parkingFeeReqDTO) {
		String url = "http://localhost:8181/api/save-parking-fee";
		 HttpHeaders headers = new HttpHeaders();
		    headers.setContentType(MediaType.APPLICATION_JSON);
		    
		    HttpEntity<ParkingFeeReqDTO> request=new HttpEntity<>(parkingFeeReqDTO,headers);
		    try { 
		    String message = restTemplate.postForObject(url, request, String.class);
	        return message;
		    } catch (HttpClientErrorException e) {
		        
		        String errorMessage = e.getResponseBodyAsString();
		        throw new RuntimeException("Failed to set parking fee: " + errorMessage);
		    } catch (RestClientException e) {
		        // For other errors like connection issues
		        throw new RuntimeException("Service unavailable or failed: " + e.getMessage());
		    }
	}

	//it is used to fetch all parking fee list.
	@Override
	public List<ParkingFeeRespDTO> parkingFeeList(String userRole) {
		String url = "http://localhost:8181/api/parking-fee-list?userRole=" + userRole;
		ResponseEntity<ParkingFeeRespDTO[]> response=restTemplate.getForEntity(url, ParkingFeeRespDTO[].class);

	    return Arrays.asList(response.getBody()); // Convert array to List
		
	}

	//it is used to fetch particular parking fee record based on id.
	@Override
	public ParkingFeeRespDTO fetchParkingFeeById(int feeId) {
		String url = "http://localhost:8181/api/fetch-parking-fee?parkingFeeId=" + feeId;
		 try { 
		ParkingFeeRespDTO response=restTemplate.getForObject(url, ParkingFeeRespDTO.class);
		return response;
		  } catch (HttpClientErrorException e) {
		        
		        String errorMessage = e.getResponseBodyAsString();
		        throw new RuntimeException("Failed to get parking fee record: " + errorMessage);
		    } catch (RestClientException e) {
		        // For other errors like connection issues
		        throw new RuntimeException("Service unavailable or failed: " + e.getMessage());
		    }
	}

	//it is used to update parking fee values .
	@Override
	public String updateParkingFee(ParkingFeeRespDTO parkingFeeRespDTO) {
		
		String url = "http://localhost:8181/api/update-parking-fee";
		
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    
	    HttpEntity<ParkingFeeRespDTO> request=new HttpEntity<>(parkingFeeRespDTO,headers);
		 try { 
		String response=restTemplate.postForObject(url,request,String.class);
		return response;
		  } catch (HttpClientErrorException e) {
		        
		        String errorMessage = e.getResponseBodyAsString();
		        throw new RuntimeException("Failed to set parking fee record: " + errorMessage);
		    } catch (RestClientException e) {
		        // For other errors like connection issues
		        throw new RuntimeException("Service unavailable or failed: " + e.getMessage());
		    }
	
	}

	//it is used to search by filter based on Status (Active or Exited).
	@Override
	public List<ParkingEntryRespDTO> getparkingListByStatusFilter(String statusFilter, int sessionUserId, String sessionUserRole) {
		String url = "http://localhost:8181/api/all-parking-list-by-filter?status="+statusFilter+"&role="+sessionUserRole+"&id="+sessionUserId;
		ResponseEntity<ParkingEntryRespDTO[]> response = restTemplate.getForEntity(url, ParkingEntryRespDTO[].class);
		
		if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
			return Arrays.asList(response.getBody());
		} else {
			return new ArrayList<>();
		}		
	}
// it is used to filter record based on search of vehicle number.
	@Override
	public List<ParkingEntryRespDTO> getparkingListByVehicleNumber(String search, int sessionUserId,
			String sessionUserRole) {
		String url = "http://localhost:8181/api/all-parking-list-by-filter-number?search="+search+"&role="+sessionUserRole+"&id="+sessionUserId;
		ResponseEntity<ParkingEntryRespDTO[]> response = restTemplate.getForEntity(url, ParkingEntryRespDTO[].class);
		
		if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
			return Arrays.asList(response.getBody());
		} else {
			return new ArrayList<>();
		}	
	}

}
