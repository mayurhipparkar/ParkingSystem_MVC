package com.rt.vehicleEntryServiceImplimentation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.rt.vehicleEntryDTO.add.AddVehicleReqDto;
import com.rt.vehicleEntryDTO.add.AddVehicleRespDto;
import com.rt.vehicleEntryDTO.select.RespFetchVehicleInfo;
import com.rt.vehicleEntryServiceInterface.VehicleEntryInterface;

@Service
public class VehicleEntryServiceImp implements VehicleEntryInterface{
	@Autowired
	private RestTemplate restTemplate;

	@Override
	public AddVehicleRespDto addVehicleInfo(AddVehicleReqDto addVehicleReqDto) {
		String url="http://localhost:8181/entry/addVehicle";	
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    
		  HttpEntity<AddVehicleReqDto> request=new HttpEntity<>(addVehicleReqDto,headers);
		  
		    AddVehicleRespDto addVehicleRespDto=restTemplate.postForObject(url, request, AddVehicleRespDto.class);
			return addVehicleRespDto;
	}
	
	@Override
	public RespFetchVehicleInfo fetchVehicleData(int id,int sessionUserId,String sessionUserRole) {
		String url="http://localhost:8181/entry/fetchVehicleInfo?id=" + id+"&userId="+sessionUserId+"&userRole="+sessionUserRole;
		RespFetchVehicleInfo respUpdate=restTemplate.getForObject(url,RespFetchVehicleInfo.class);
		return respUpdate;
	}
}
