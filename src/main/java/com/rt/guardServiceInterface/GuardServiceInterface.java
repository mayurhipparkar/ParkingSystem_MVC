package com.rt.guardServiceInterface;

import java.util.List;
import java.util.Map;

import com.rt.guardDTO.AddGuardReqDTO;
import com.rt.guardDTO.AllGuardRespDTO;
import com.rt.guardDTO.FetchGuardDetailsReqDTO;
import com.rt.guardDTO.FetchGuardDetailsRespDTO;

public interface GuardServiceInterface {

	public String addGuard(AddGuardReqDTO addGuardReqDTO);

	public Map<String, Object> getAllGuardRecord(int page, int size, String role,String sessionUserRole);

	public FetchGuardDetailsRespDTO fetchGuardDataById(FetchGuardDetailsReqDTO fetchGuardDetailsReqDTO);

	//it is used to update existing guard record.
	public String updateGuard(FetchGuardDetailsRespDTO fetchGuardDetailsRespDTO);

	public Map<String, Object> getAllGuardRecordUsingStatusFilter(int page, int size, String role, String statusFilter,
			String sessionUserRole);

	public List<AllGuardRespDTO> fetchGuardsBySearch(String search, String role);
	
}
