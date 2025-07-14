package com.rt.guardServiceImpl;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriUtils;

import com.rt.guardDTO.AddGuardReqDTO;
import com.rt.guardDTO.AllGuardRespDTO;
import com.rt.guardDTO.FetchGuardDetailsReqDTO;
import com.rt.guardDTO.FetchGuardDetailsRespDTO;
import com.rt.guardServiceInterface.GuardServiceInterface;

@Service
public class GuardServiceImplimentation implements GuardServiceInterface{
@Autowired
private RestTemplate restTemplate;

//this is used to add guard in DB.
	@Override
	public String addGuard(AddGuardReqDTO addGuardReqDTO) {
		
		addGuardReqDTO.setRole("Guard");//default role.
		
		String url="http://localhost:8181/guard/add";
		HttpHeaders header=new HttpHeaders();
		header.setContentType(MediaType.APPLICATION_JSON);
		
		HttpEntity<AddGuardReqDTO> request=new HttpEntity<AddGuardReqDTO>(addGuardReqDTO,header);
		
		return restTemplate.postForObject(url, request, String.class);
	
	}
	
// this is for fetch all guard record only for admin with pagination.
	@Override
	public Map<String, Object> getAllGuardRecord(int page, int size, String role,String sessionUserRole) {
		String URL="http://localhost:8181/guard/list?role="+role + "&page=" + page + "&size=" + size + "&userRole=" + sessionUserRole;		
		
		 ResponseEntity<Map> response = restTemplate.getForEntity(URL, Map.class);
         Map<String, Object> result = response.getBody();
     
		return result;
	}

	//this is used to fetch specific guard record for update.
	@Override
	public FetchGuardDetailsRespDTO fetchGuardDataById(FetchGuardDetailsReqDTO fetchGuardDetailsReqDTO) {
		String url="http://localhost:8181/guard/fetch";
		HttpHeaders header=new HttpHeaders();
		header.setContentType(MediaType.APPLICATION_JSON);
		
		HttpEntity<FetchGuardDetailsReqDTO> request=new HttpEntity<FetchGuardDetailsReqDTO>(fetchGuardDetailsReqDTO,header);
		
		return restTemplate.postForObject(url, request, FetchGuardDetailsRespDTO.class);
	}

	//this is used to update existing guard record by admin only.
	@Override
	public String updateGuard(FetchGuardDetailsRespDTO fetchGuardDetailsRespDTO) {
		String url="http://localhost:8181/guard/add";
		HttpHeaders header=new HttpHeaders();
		header.setContentType(MediaType.APPLICATION_JSON);
		
		HttpEntity<FetchGuardDetailsRespDTO> request=new HttpEntity<FetchGuardDetailsRespDTO>(fetchGuardDetailsRespDTO,header);
		
		return restTemplate.postForObject(url, request, String.class);
		
	}

	//this is used to fetch guard record based on status. 
	@Override
	public Map<String, Object> getAllGuardRecordUsingStatusFilter(int page, int size, String role, String statusFilter,
			String sessionUserRole) {
		String URL="http://localhost:8181/guard/list?role="+role + "&page=" + page + "&size=" + size + "&userRole=" + sessionUserRole + "&statusFilter=" + statusFilter;		
		
		 ResponseEntity<Map> response = restTemplate.getForEntity(URL, Map.class);
        Map<String, Object> result = response.getBody();
    
		return result;
	}

	//this is used to fetch guard record using there name for apply filter in js side. 
	@Override
	public List<AllGuardRespDTO> fetchGuardsBySearch(String search, String role) {
		String url ="http://localhost:8181/guard/search?"+"search=" + UriUtils.encodeQueryParam(search, StandardCharsets.UTF_8)
        + "&role=" + UriUtils.encodeQueryParam(role, StandardCharsets.UTF_8);

		ResponseEntity<AllGuardRespDTO[]> response = restTemplate.getForEntity(url, AllGuardRespDTO[].class);
		
		if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
			return Arrays.asList(response.getBody());
		} else {
			return new ArrayList<>();
		}
		
	}
}
