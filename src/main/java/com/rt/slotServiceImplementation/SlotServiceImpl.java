package com.rt.slotServiceImplementation;

import java.util.Arrays;
import java.util.Collections;
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
import org.springframework.web.client.RestTemplate;

import com.rt.slotDTO.CreateSlotRequestDTO;
import com.rt.slotDTO.CreateSlotResponseDTO;
import com.rt.slotServiceInterface.SlotServiceInterface;

@Service
public class SlotServiceImpl implements SlotServiceInterface{
	@Autowired
	private RestTemplate restTemplate;
	// it is used to create slot according to type.
	@Override
	public List<CreateSlotResponseDTO> createMultipleSlots(CreateSlotRequestDTO requestDTO) {
	    String URL = "http://localhost:8181/api/create-multiple-slots";
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);

	    HttpEntity<CreateSlotRequestDTO> request = new HttpEntity<>(requestDTO, headers);

	    try {
	        ResponseEntity<CreateSlotResponseDTO[]> response = restTemplate.postForEntity(
	            URL,
	            request,
	            CreateSlotResponseDTO[].class
	        );

	        return Arrays.asList(response.getBody());

	    } catch (HttpClientErrorException | HttpServerErrorException ex) {
	        // Get the message sent from the API (like "Slot limit reached...")
	        String errorMessage = ex.getResponseBodyAsString();

	        // Optionally, log it
	        System.err.println("API Error: " + errorMessage);

	        // Rethrow as a runtime exception or custom exception
	        throw new RuntimeException(errorMessage);
	    }
	}


	//it is used to fetch all slots according to type.
	@Override
	public Map<String, Object> fetchVehicleSlots(int page,int size,String vType) {
		String URL="http://localhost:8181/api/slots?vType="+ vType + "&page=" + page + "&size=" + size;
		
		 ResponseEntity<Map> response = restTemplate.postForEntity(
	                URL,
	                null,
	                Map.class
	        );
		
		 Map<String, Object> result = response.getBody();
		    return result;
	}

//it is used to filter slot based on Parked or Unparked status.
	@Override
	public Map<String, Object> slotListFilterByStatus(int page, int size,String vType ,String statusFilter) {
		String URL="http://localhost:8181/api/slots?vType=" + vType + "&status="+ statusFilter;	
		
		 ResponseEntity<Map> response = restTemplate.postForEntity(URL,null,Map.class);
		 Map<String, Object> result = response.getBody();
   
		return result;
	}
	
	
	
}
