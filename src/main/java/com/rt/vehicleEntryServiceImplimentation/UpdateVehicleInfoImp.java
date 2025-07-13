package com.rt.vehicleEntryServiceImplimentation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.rt.vehicleEntryDTO.update.ReqUpdateVehicleInfoDto;
import com.rt.vehicleEntryServiceInterface.UpdateAndDeleteVehicleInfoInterface;

@Service
public class UpdateVehicleInfoImp implements UpdateAndDeleteVehicleInfoInterface{
@Autowired
private RestTemplate restTemplate;
	@Override
	public boolean updateVehicleInfoUsingId(ReqUpdateVehicleInfoDto reqUpdateVehicleInfoDto ) {
		String url="http://localhost:8181/update/update-vehicle";
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
		  HttpEntity<ReqUpdateVehicleInfoDto> request=new HttpEntity<>(reqUpdateVehicleInfoDto,headers);
		   boolean updatedInfoStatus=restTemplate.postForObject(url, request, Boolean.class);
		    
			return updatedInfoStatus; 
	}


}
