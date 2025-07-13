<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.min.css" />
<%@ include file="../module/header.jsp" %>
 <style>
.main-container{
	width:60%;
	 margin: 10% 0 0 29.5%;
}
</style>


<div class="main-container">
<div class="container">
  <div class="card shadow-lg">
    <div class="card-header bg-primary text-white">
      <h4 class="mb-0">Vehicle Update Form</h4>
    </div>
    <div class="card-body">
      <form action="${pageContext.request.contextPath}/update-delete/update-vehicle" method="post">
        <div class="row mb-3">
          <div class="col-md-6">
         <input type="hidden" class="form-control" name="id" value="${vehicleData.id}" id="id"/>

			<!-- Vehicle Type Dropdown with pre-selected value -->
			<label for="vehicleType" class="form-label">Vehicle Type</label>
			<select class="form-select" name="vehicleType" id="vehicleType" required>
			  <option value="">Select</option>
			  <option value="two wheeler" ${vehicleData.vehicle_type == 'two wheeler' ? 'selected' : ''}>Two Wheeler</option>
			  <option value="four wheeler" ${vehicleData.vehicle_type == 'four wheeler' ? 'selected' : ''}>Four Wheeler</option>
			</select>
		  </div>
          <div class="col-md-6">
            <label for="vehicleNumber" class="form-label">Vehicle Number</label>
             <input type="text" 
			       class="form-control" 
			       name="vehicleNumber" 
			       value="${vehicleData.vehicle_number}"
			       id="vehicleNumber" 
			       placeholder="e.g., MH12AB1234" 
			       pattern="[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}" 
			       title="Format must be like MH12AB1234 (2 letters, 2 digits, 2 letters, 4 digits)"
			 required>
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label for="ownerName" class="form-label">Owner Name</label>
            <input type="text" 
		       class="form-control" 
		       value="${vehicleData.owner_name}"
		       id="ownerName" 
		       name="ownerName" 
		       placeholder="e.g.,Mayur" 
		       pattern="[A-Za-z ]{2,50}" 
		       title="Owner name should contain only letters and spaces (2-50 characters)" 
		   required>
          </div>
          <div class="col-md-6">
            <label for="contactNumber" class="form-label">Contact Number</label>
            <input type="tel" 
		       class="form-control" 
		       id="contactNumber" 
		       value="${vehicleData.contact_number}"
		       name="contactNumber" 
		       placeholder="e.g., 91******87" 
		       pattern="[6-9][0-9]{9}" 
		       title="Enter a valid 10-digit mobile number starting with 6, 7, 8, or 9" 
		       maxlength="10" 
		     required>
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label for="entryDate" class="form-label">Entry Date </label>
            <input type="date" class="form-control" id="entryDate" value="${vehicleData.entry_date}" name="entryDate" required readonly>
          </div>
          <div class="col-md-6">
            <label for="entryTime" class="form-label">Entry Time</label>
            <input type="time" class="form-control" id="entryTime" value="${vehicleData.entry_time}" name="entryTime" required readonly>
          </div>
         
        </div>
        <div class="text-end">
          <button type="submit" class="btn btn-success">Update Entry</button>
        </div>
      </form>
    </div>
  </div>
</div>

</div>
<%@ include file="../module/footer.jsp" %>
    <script src="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.bundle.min.js"></script>