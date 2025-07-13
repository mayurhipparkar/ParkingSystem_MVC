<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.min.css" />
<%@ include file="../module/header.jsp" %>
 <<style>
.main-container{
	width:60%;
	margin: 7% 0 0 29.5%;
}
</style>
 
<div class="container main-container">
  <div class="card shadow-lg">
    <div class="card-header bg-primary text-white">
      <h4 class="mb-0">Vehicle Entry Form</h4>
    </div>
    <div class="card-body">
      <form action="add-Vehicle" method="post">
        <div class="row mb-3">
          <div class="col-md-6">
            <label for="vehicleType" class="form-label">Vehicle Type</label>
            <select class="form-select" id="vehicleType" name="vehicleType" required>
              <option value="">Select</option>
              <option value="two wheeler">Two Wheeler</option>
              <option value="four wheeler">Four Wheeler</option>
            </select>
          </div>
          <div class="col-md-6">
            <label for="vehicleNumber" class="form-label">Vehicle Number</label>
            <input type="text" 
			       class="form-control" 
			       name="vehicleNumber" 
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
		       id="ownerName" 
		       name="ownerName" 
		       pattern="[A-Za-z ]{2,50}" 
		       title="Owner name should contain only letters and spaces (2-50 characters)" 
		   required>
          </div>
          <div class="col-md-6">
            <label for="contactNumber" class="form-label">Contact Number</label>
            <input type="tel" 
		       class="form-control" 
		       id="contactNumber" 
		       name="contactNumber" 
		       pattern="[6-9][0-9]{9}" 
		       title="Enter a valid 10-digit mobile number starting with 6, 7, 8, or 9" 
		       maxlength="10" 
		     required>
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label for="entryDate" class="form-label">Entry Date </label>
            <input type="date" class="form-control" id="entryDate" name="entryDate" required>
          </div>
          <div class="col-md-6">
            <label for="entryTime" class="form-label">Entry Time</label>
            <input type="time" class="form-control" id="entryTime" name="entryTime" required>
          </div>
         
        </div>
        <div class="text-end">
          <button type="submit" class="btn btn-success">Submit Entry</button>
          <button type="reset" class="btn btn-secondary" id="resetButton">Reset</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  const dateInput = document.getElementById("entryDate");
  const timeInput = document.getElementById("entryTime");

  function updateDateTime() {
    const now = new Date();

    // Format date: yyyy-MM-dd
   //  Local Date (yyyy-MM-dd)
    const formattedDate = now.getFullYear() + "-" +
      String(now.getMonth() + 1).padStart(2, '0') + "-" +
      String(now.getDate()).padStart(2, '0');
    
    // Format time: HH:mm
    const formattedTime = now.toTimeString().slice(0, 5);

    //  Update only if date actually changed
    if (dateInput.value !== formattedDate) {
      dateInput.value = formattedDate;
      dateInput.min = formattedDate;
      dateInput.max = formattedDate;
    }

    // Always update time
    timeInput.value = formattedTime;
  }

  // On page load
  window.addEventListener("DOMContentLoaded", () => {
    updateDateTime();
    setInterval(updateDateTime, 1000);
    
  });

  //  Reset button (excluding date/time)
  document.getElementById("resetButton").addEventListener("click", () => {
    document.getElementById("vehicleType").value = "";
    document.getElementById("vehicleNumber").value = "";
    document.getElementById("ownerName").value = "";
    document.getElementById("contactNumber").value = "";
    updateDateTime(); // Re-sync date and time on reset
  });

  //  Force uppercase in vehicle number
  document.getElementById("vehicleNumber").addEventListener("input", function () {
    this.value = this.value.toUpperCase();
  });
</script>

<%@ include file="../module/footer.jsp" %>
    <script src="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.bundle.min.js"></script>