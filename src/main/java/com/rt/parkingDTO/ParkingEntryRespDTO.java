package com.rt.parkingDTO;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

import com.rt.allEnum.ParkingStatus;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ParkingEntryRespDTO {
	
    private int parkingId;
    private String vehicleNumber;
    private String vehicleType;
    private String ownerName;
    private String contactNumber;
    private String slotId;
    private LocalDate inDate;
    private LocalTime inTime; 
    private LocalDate outDate;
    private LocalTime outTime; 
    private ParkingStatus status;
    private String formattedEntryTime;
    private String formattedExitTime;
    
    private BigDecimal hourlyFee;
    private BigDecimal dailyFee;
	
}
