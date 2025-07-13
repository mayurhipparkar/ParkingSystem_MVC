package com.rt.vehicleEntryServiceInterface;

import com.rt.vehicleEntryDTO.add.AddVehicleReqDto;
import com.rt.vehicleEntryDTO.add.AddVehicleRespDto;
import com.rt.vehicleEntryDTO.select.RespFetchVehicleInfo;

public interface VehicleEntryInterface {
	
	AddVehicleRespDto addVehicleInfo(AddVehicleReqDto addVehicleReqDto);
	
	RespFetchVehicleInfo fetchVehicleData(int id,int sessionUserId,String sessionUserRole);

}
