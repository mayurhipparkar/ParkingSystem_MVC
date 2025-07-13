package com.rt.vehicleEntryServiceInterface;

import java.time.LocalDate;
import java.util.Map;


public interface EnteredVehicleListInterface {
	

	Map<String, Object> getVehicleListByType(int page, int size, String vehicleType,String search,LocalDate entryDate,int sessionUserId,String sessionUserRole);
	

}
