<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<%@ include file="../module/header.jsp" %>

<style>
    .main-container {
        width: 60%;
        padding: 20px;
        margin-top: 8% 0 0 24%;
    }

    #parking-msg {
        color: black;
        background-color: lightgreen;
        font-weight: bold;
        text-align: center;
        padding: 10px 20px;
        margin-top: 10px;
        border: 2px solid black;
    }

    .fade-out {
        transition: opacity 1s ease-out;
        opacity: 0;
    }

    @media (min-width: 467px) {
        .main-container {
            width: 60%;
            margin:8% 0 0 24%;
        }
    }
</style>

<div class="container-fluid main-container py-4">

    <!-- Flash Message Section -->
    <c:if test="${not empty msgStatus}">
        <div class="row mb-3">
            <div class="col-12 col-md-12 mx-auto">
                <div id="parking-msg" class="alert alert-info text-center">
                    ${msgStatus}
                </div>
            </div>
        </div>
    </c:if>

    <!-- Parking Entry Form -->
    <div class="row justify-content-center">
        <div class="col-12 col-md-10 col-lg-8">
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white text-center">
                    <h4 class="mb-0">Parking Exit Form</h4>
                </div>

                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/parking/exit-vehicle-parking" method="post">

					    <!-- Vehicle Type (readonly) -->
					    <div class="form-group mb-3">
					        <label class="form-label fw-semibold">Vehicle Type</label>
					        <input type="hidden" class="form-control" name="parkingId" value="${data.parkingId}">
					        <input type="text" class="form-control" name="vehicleType" value="${data.vehicleType}" readonly>
					    </div>
					
					    <!-- Vehicle Number (readonly) -->
					    <div class="form-group mb-3">
					        <label class="form-label fw-semibold">Vehicle Number</label>
					         <input type="hidden" class="form-control" name="vehicleId" value="${data.vehicleId}">
					        <input type="text" class="form-control" name="vehicleNumber" value="${data.vehicleNumber}" readonly>
					    </div>
					
					    <!-- Slot ID (readonly) -->
					    <div class="form-group mb-3">
					        <label class="form-label fw-semibold">Slot ID</label>
					        <input type="hidden" class="form-control" name="slotId" value="${data.slotId}">
					        <input type="text" class="form-control" name="slotValue" value="${data.slotValue}" readonly>
					    </div>
					
					    <!-- Entry Date & Time (readonly) -->
					    <div class="row mb-3">
					        <div class="col-md-6">
					            <label class="form-label fw-semibold">Entry Date</label>
					            <input type="date" class="form-control" name="inDate" value="${data.inDate}"readonly>
					        </div>
					        <div class="col-md-6">
					            <label class="form-label fw-semibold">Entry Time</label>
					            <input type="time" class="form-control" name="inTime" value="${data.inTime}" readonly>
					        </div>
					    </div>
					
					    <!-- Exit Date & Time (auto-filled, live clock) -->
					    <div class="row mb-4">
					        <div class="col-md-6">
					            <label class="form-label fw-semibold">Exit Date</label>
					            <input type="date" id="exitDate" name="outDate" class="form-control" value="${data.outDate}" required>
					        </div>
					        <div class="col-md-6">
					            <label class="form-label fw-semibold">Exit Time</label>
					            <input type="time" id="exitTime" name="outTime" class="form-control" value="${data.outTime}" required>
					        </div>
					    </div>
					
					    <div class="text-end">
					        <button type="submit" class="btn btn-success">
					            <i class="fas fa-check-circle"></i> Confirm Exit
					        </button>
					    </div>
					
					</form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script>

const dateInput = document.getElementById("exitDate");
const timeInput = document.getElementById("exitTime");

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
  
//Restrict input to current time only
  function preventInvalidTimeSelection() {
      const now = new Date();
      const currentTime = now.toTimeString().slice(0, 5); // HH:mm

      if (timeInput.value !== currentTime) {
          alert("You can only select the current time.");
          timeInput.value = currentTime;
      }
  }
}


//it is used to hide message after 3s. 
document.addEventListener("DOMContentLoaded", function () {
    const msg = document.getElementById("parking-msg");
    if (msg) {
        setTimeout(() => {
            msg.classList.add("fade-out");
            setTimeout(() => msg.style.display = "none", 1000);
        }, 4000);
    }
    //it is used to update time 
    updateDateTime();
    setInterval(updateDateTime, 1000);
    
    // Attach validator
    timeInput.addEventListener("change", preventInvalidTimeSelection);
});
</script>

<script src="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.bundle.min.js"></script>
<%@ include file="../module/footer.jsp" %>
