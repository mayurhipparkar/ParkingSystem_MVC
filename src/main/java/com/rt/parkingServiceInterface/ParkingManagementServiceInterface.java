package com.rt.parkingServiceInterface;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.rt.parkingDTO.ParkingEntryReqDTO;
import com.rt.parkingDTO.ParkingEntryRespDTO;
import com.rt.parkingDTO.ParkingFeeReqDTO;
import com.rt.parkingDTO.ParkingFeeRespDTO;
import com.rt.parkingDTO.ParkingFetchRespDTO;

public interface ParkingManagementServiceInterface {

	String assignSlotToVehicle(ParkingEntryReqDTO parkingEntryReqDTO);

	ResponseEntity<Map<String, Object>> fetchVehicleAndSlotDataBasedOnVehicleTypeAndUserId(String vType,
			int sessionUserId);

	Map<String, Object> getparkingListByRole(int page, int size, int sessionUserId,String sessionUserRole);

	ParkingFetchRespDTO fetchSingleParkingById(int parkingId);

	String exitParkedVehicleById(ParkingFetchRespDTO parkingFetchRespDTO);

	String setParkingFee(ParkingFeeReqDTO parkingFeeReqDTO);

	List<ParkingFeeRespDTO> parkingFeeList(String userRole);

	ParkingFeeRespDTO fetchParkingFeeById(int feeId);

	String updateParkingFee(ParkingFeeRespDTO parkingFeeRespDTO);

	List<ParkingEntryRespDTO> getparkingListByStatusFilter(String statusFilter, int sessionUserId, String sessionUserRole);

	List<ParkingEntryRespDTO> getparkingListByVehicleNumber(String search, int sessionUserId, String sessionUserRole);

}
