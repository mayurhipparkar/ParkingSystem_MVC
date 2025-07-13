package com.rt.vehicleEntryServiceInterface;

import com.rt.vehicleEntryDTO.update.ReqUpdateVehicleInfoDto;

public interface UpdateAndDeleteVehicleInfoInterface {
	
	boolean updateVehicleInfoUsingId(ReqUpdateVehicleInfoDto reqUpdateVehicleInfoDto );
	
//	void deleteVehicleInfoUsingId(int id);

}
