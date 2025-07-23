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
                    <h4 class="mb-0">Parking Entry Form</h4>
                </div>

                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/parking/assign-slot" method="post">

                        <!-- Vehicle Type -->
                        <div class="form-group mb-4">
                            <label class="form-label fw-bold">Vehicle Type</label>
                            <div class="form-check form-check-inline ms-2">
                                <input type="radio" id="twoWheeler" name="vehicleType" value="two Wheeler" class="form-check-input"
                                       onclick="updateFormOnVehicleTypeChange(this.value)" required>
                                <label class="form-check-label" for="twoWheeler">Two Wheeler</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="radio" id="fourWheeler" name="vehicleType" value="four Wheeler" class="form-check-input"
                                       onclick="updateFormOnVehicleTypeChange(this.value)">
                                <label class="form-check-label" for="fourWheeler">Four Wheeler</label>
                            </div>
                        </div>

                        <!-- Two-Wheeler Section -->
                        <div id="twoWheelerSection" style="display:none;">
                            <div class="form-group mb-3">
                                <label class="form-label fw-semibold">Select Two-Wheeler Vehicle</label>
                                <div class="input-group">
                                    <select id="twoWheelerVehicleSelect"class="form-select">
                                        <option value="">-- Only today's records --</option>
                                        <c:forEach var="v" items="${twoWheelerList}">
                                            <option value="${v.id}">${v.vehicleNumber}</option>
                                        </c:forEach>
                                    </select>
                                   <span class="input-group-text bg-light text-dark" role="button"
								          onclick="window.location.href='${pageContext.request.contextPath}/vehicle/add-vehicle-Form?fromParkingForm=true&type=two'">
								        <i class="fas fa-plus"></i>
								   </span>
                                </div>
                            </div>

                            <div class="form-group mb-4">
                                <label class="form-label fw-semibold">Available Two-Wheeler Slots</label>
                                <select id="twoWheelerSlotSelect" class="form-select">
                                    <option value="">-- Select Slot --</option>
                                    <c:forEach var="slot" items="${twoWheelerSlotList}">
                                        <option value="${slot.id}">Slot ${slot.slotId} (${slot.status})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!-- Four-Wheeler Section -->
                        <div id="fourWheelerSection" style="display:none;">
                            <div class="form-group mb-3">
                                <label class="form-label fw-semibold">Select Four-Wheeler Vehicle</label>
                                <div class="input-group">
                                    <select id="fourWheelerVehicleSelect" class="form-select">
                                        <option value="">-- Only today's records --</option>
                                        <c:forEach var="v" items="${fourWheelerList}">
                                            <option value="${v.id}">${v.vehicleNumber}</option>
                                        </c:forEach>
                                    </select>
                                    <span class="input-group-text bg-light text-dark" role="button"
								          onclick="window.location.href='${pageContext.request.contextPath}/vehicle/add-vehicle-Form?fromParkingForm=true&type=four'">
								        <i class="fas fa-plus"></i>
								   </span>
                                </div>
                            </div>

							<!-- Hidden input to store selected vehicleId -->
							        <input type="hidden" id="vehicleId" name="vehicleId" required>
							        
                            <div class="form-group mb-4">
                                <label class="form-label fw-semibold">Available Four-Wheeler Slots</label>
                                <select id="fourWheelerSlotSelect" class="form-select">
                                    <option value="">-- Select Slot --</option>
                                    <c:forEach var="slot" items="${fourWheelerSlotList}">
                                        <option value="${slot.id}">Slot ${slot.slotId} (${slot.status})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
						<!-- Hidden input to store selected slotId -->
						<input type="hidden" id="slotId" name="slotId" required>
						
                        <!-- Entry Date & Time -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label fw-semibold">Incoming Date</label>
                                    <input type="date" id="entryDate" name="inDate" class="form-control" readonly required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label fw-semibold">Incoming Time</label>
                                    <input type="time" id="entryTime" name="inTime" class="form-control" readonly required>
                                </div>
                            </div>
                        </div>

                        <!-- Submit Buttons -->
                        <div class="text-end">
                            <button type="submit" class="btn btn-success me-2">
                                <i class="fas fa-check-circle"></i> Submit Entry
                            </button>
                            <button type="reset" class="btn btn-secondary">
                                <i class="fas fa-undo-alt"></i> Reset
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
const contextPath = "<%= request.getContextPath() %>";

async function fetchAndPopulate(type) {
    const url = contextPath + "/parking/vehicle-and-slot-data?vType=" + encodeURIComponent(type);

    try {
        const res = await fetch(url);

        if (!res.ok) {
            throw new Error(`HTTP error! Status: ${res.status}`);
        }

        const data = await res.json();

        const isTwo = type.toLowerCase().includes("two");

        const vehicleSelect = document.getElementById(isTwo ? 'twoWheelerVehicleSelect' : 'fourWheelerVehicleSelect');
        const slotSelect = document.getElementById(isTwo ? 'twoWheelerSlotSelect' : 'fourWheelerSlotSelect');
        const vehicleIdHiddenInput = document.getElementById("vehicleId");  // Set vehicleId and entry date/time from selected vehicle
        const slotIdHiddenInput = document.getElementById("slotId");  // Set slotId and entry date/time from selected vehicle

        // Clear previous data
        vehicleSelect.innerHTML = '';
        slotSelect.innerHTML = '';
        vehicleIdHiddenInput.value = ""; // reset
        slotIdHiddenInput.value = "";
        
        // show vehicle dropdown
        if (data.vehicles && data.vehicles.length > 0) {
            vehicleSelect.innerHTML = '<option value="">-- Select Vehicle --</option>';
            data.vehicles.forEach(v => {
                vehicleSelect.innerHTML += `<option value="\${v.id}" data-date="\${v.entry_date}" data-time="\${v.entry_time}">\${v.vehicle_number}</option>`;
            });
            slotSelect.disabled = false; // Enable slot select
        } else {
            vehicleSelect.innerHTML = '<option value="">-- No Vehicle Entries Found --</option>';
            slotSelect.innerHTML = '<option value="">-- No Available Slots --</option>';
            slotSelect.disabled = true; // Disable slot select if no vehicle
        }

        // show slot dropdown only if slots exist
        if (data.slots && data.slots.length > 0) {
            slotSelect.innerHTML = '<option value="">-- Select Slot --</option>';
            data.slots.forEach(s => {
                slotSelect.innerHTML += `<option value="\${s.id}">\${s.slotId} (\${s.status})</option>`;
            });
        } else {
            // Show only if no slots and vehicles present
            if (data.vehicles && data.vehicles.length > 0) {
                slotSelect.innerHTML = '<option value="">-- No Available Slots --</option>';
            }
        }
       
        
        // Bind change event to populate date and time
        vehicleSelect.addEventListener("change", function () {
            const selectedOption = this.options[this.selectedIndex];
            vehicleIdHiddenInput.value = selectedOption.value || "";
            
            const entryDate = selectedOption.getAttribute("data-date");
            const entryTime = selectedOption.getAttribute("data-time");

            const entryDateInput = document.getElementById("entryDate");
            const entryTimeInput = document.getElementById("entryTime");

            if (entryDate && entryTime) {
                entryDateInput.value = entryDate;
                entryTimeInput.value = entryTime;

                entryDateInput.readOnly = true;
                entryTimeInput.readOnly = true;
            } else {
                entryDateInput.value = "";
                entryTimeInput.value = "";

                entryDateInput.readOnly = false;
                entryTimeInput.readOnly = false;
            }
        });
        
        slotSelect.addEventListener("change", function () {
            slotIdHiddenInput.value = this.value || "";
        });

    } catch (err) {
        console.error("Fetch error:", err);
    }
}

/* it is used to allow only twowheeler or fourwheeler field after clicking on radio button. */
function updateFormOnVehicleTypeChange(type) {
    const isTwo = type.toLowerCase().includes("two");

    document.getElementById("twoWheelerSection").style.display = isTwo ? "block" : "none";
    document.getElementById("fourWheelerSection").style.display = isTwo ? "none" : "block";

    fetchAndPopulate(type);
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
});
</script>

<script src="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.bundle.min.js"></script>
<%@ include file="../module/footer.jsp" %>
