package com.rt.slotServiceInterface;

import java.util.List;
import java.util.Map;

import com.rt.slotDTO.CreateSlotRequestDTO;
import com.rt.slotDTO.CreateSlotResponseDTO;

public interface SlotServiceInterface {
	
	public List<CreateSlotResponseDTO> createMultipleSlots(CreateSlotRequestDTO request );

	public Map<String, Object> fetchVehicleSlots(int page,int size,String vType);

	public Map<String, Object> slotListFilterByStatus(int page, int size,String vType ,String statusFilter);
	


}
