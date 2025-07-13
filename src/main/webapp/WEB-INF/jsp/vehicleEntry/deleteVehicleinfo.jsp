<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.min.css" />
<%@ include file="../module/header.jsp" %>
 <style>
.main-container{
	width:60%;
	margin: 7% 0 0 29.5%;
}
</style>
 
 <div class="main-container">
 <div class="my-2">
<label for="vehicleId">Enter ID:</label>
<input type="text" class="my-2"id="vehicleId" placeholder="Enter ID for fetch record">
<button class="btn btn-success " onclick="fetchVehicle()">Fetch Vehicle</button>
</div>
<div class="container">
  <div class="card shadow-lg">
    <div class="card-header bg-primary text-white">
      <h4 class="mb-0">Vehicle Delete Form</h4>
    </div>
    <div class="card-body">
      <form action="${pageContext.request.contextPath}/update-delete/delete-vehicle" method="post">
        <div class="row mb-3">
          <div class="col-md-6">
          <!-- hidden id -->
           <input type="hidden" class="form-control" name="id" value="${vehicleData.id}" readonly/>

			<!-- Vehicle Type Dropdown with pre-selected value -->
			<label for="vehicleType" class="form-label">Vehicle Type</label>
			<select class="form-select" name="vehicleType" disabled>
			  <option value="">Select</option>
			  <option value="two wheeler" ${vehicleData.vehicle_type == 'two wheeler' ? 'selected' : ''}>Two Wheeler</option>
			  <option value="four wheeler" ${vehicleData.vehicle_type == 'four wheeler' ? 'selected' : ''}>Four Wheeler</option>
			</select>
			<!-- hidden field for access vehicleType cause select is 
			disabled and that not be submitted and visible -->
			<input type="hidden" name="vehicleType" value="${vehicleData.vehicle_type}">
		  </div>
          <div class="col-md-6">
            <label for="vehicleNumber" class="form-label">Vehicle Number</label>
            <input type="text" class="form-control" name="vehicleNumber" value="${vehicleData.vehicle_number}" placeholder="e.g., MH12AB1234" readonly>
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label for="ownerName" class="form-label">Owner Name</label>
            <input type="text" class="form-control"   value="${vehicleData.owner_name}" name="ownerName" placeholder="e.g., Sam" readonly>
          </div>
          <div class="col-md-6">
            <label for="contactNumber" class="form-label">Contact Number</label>
            <input type="tel" class="form-control" value="${vehicleData.contact_number}" maxlength="10" name="contactNumber" placeholder="e.g., 1223334445"readonly>
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label for="entryDate" class="form-label">Entry Date </label>
            <input type="date" class="form-control"  value="${vehicleData.entry_date}" name="entryDate" readonly>
          </div>
          <div class="col-md-6">
            <label for="entryTime" class="form-label">Entry Time</label>
            <input type="time" class="form-control"  value="${vehicleData.entry_time}" name="entryTime" readonly>
          </div>
         
        </div>
        <div class="text-end">
          <button type="submit" class="btn btn-success">Delete Entry</button>
        </div>
      </form>
    </div>
  </div>
</div>
</div>

<%@ include file="../module/footer.jsp" %>
    <script src="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.bundle.min.js"></script>