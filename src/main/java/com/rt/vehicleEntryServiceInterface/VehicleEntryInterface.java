package com.rt.vehicleEntryServiceInterface;

import com.rt.vehicleEntryDTO.AddVehicleReqDto;
import com.rt.vehicleEntryDTO.AddVehicleRespDto;
import com.rt.vehicleEntryDTO.RespFetchVehicleInfo;

public interface VehicleEntryInterface {
	
	AddVehicleRespDto addVehicleInfo(AddVehicleReqDto addVehicleReqDto);
	
	RespFetchVehicleInfo fetchVehicleData(int id,int sessionUserId,String sessionUserRole);

}
