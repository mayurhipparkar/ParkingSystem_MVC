package com.rt.vehicleEntryServiceInterface;

import java.time.LocalDate;
import java.util.Map;


public interface EnteredVehicleListInterface {
	
	Map<String, Object> getVehicleListByType( String vehicleType,int page, int size,String search,LocalDate entryDate,int sessionUserId,String sessionUserRole);

}
