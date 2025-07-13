package com.rt.vehicleEntryDTO.update;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReqUpdateVehicleInfoDto {
	private int id;
	private String vehicleType;
	private String vehicleNumber;
	private String ownerName;
	private String contactNumber;
	private LocalDate entryDate;
	private LocalTime entryTime;
	private int sessionUserId;
	private String sessionUserRole;
}
