<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.rt.allEnum.ParkingStatus" %>
<html>
<head>
    <title>Parking Entry List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        table.table tbody, table.table tr, table.table td {
            padding: 4px 8px;
            
         }
        .label{
        font-size: 1.2rem;
        }
        
         #msg{
        	color:black;
        	background-color:lightgreen;
        	font-weight:bold;
        	text-align:center;
        	padding:10px 20px;
        	margin-top:5px;
        	border: 2px solid black; 	
        	
        }
        
        .fade-out {
		    transition: opacity 1s ease-out;
		    opacity: 0;
		 }
    </style>
</head>
<body data-context-path="${pageContext.request.contextPath}" data-role="${role}">

   
	
<!-- 	table start -->
<div class="container mt-5">

<!-- Message -->
<c:if test="${not empty msgStatus}">
    <div id="msg" class="alert alert-info text-center">${msgStatus}</div>
</c:if>

<!-- Total Records -->
<div class="col-md-12 d-flex align-items-center mb-3">
    <label class="form-label mb-0 me-2">Total Records:</label>
    <strong>${totalItems}</strong>
</div>

<!-- Main Action and Filter Row -->
<div class="row g-5">

    <!-- Left Section: Action Buttons -->
    <div class="col-sm-6 col-md-6">
        <div class="row g-2">
            <!-- Home Button -->
            <div class="col-md-4 mb-3">
                <a href="${pageContext.request.contextPath}/from-guard"
                   class="btn btn-outline-warning w-100">🏠 Home</a>
            </div>

            <!-- Add Button -->
            <div class="col-md-4 mb-3">
                <a href="${pageContext.request.contextPath}/parking/parking-entry-form"
                   class="btn btn-outline-warning w-100">
                    <i class="fas fa-plus text-success"></i> Add
                </a>
            </div>

            <!-- All Button -->
            <div class="col-md-4 mb-3">
                <a href="${pageContext.request.contextPath}/parking/all-parking-list"
                   class="btn btn-outline-warning w-100">All</a>
            </div>
        </div>
    </div>

    <!-- Right Section: Search and Filter -->
    <div class="col-sm-6 col-md-6">
        <div class="row g-2">
            <!-- Search by vehicle Number -->
            <div class="col-md-6 mb-3">
                <input type="text"
                       name="search"
                       id="searchvehicle"
                       class="form-control border border-2 border-warning bg-transparent text-dark"
                       placeholder="Search Vehicle Number"
                       value="${search}">
            </div>

            <!-- Status Filter Dropdown -->
            <div class="col-md-6 mb-3">
                <select name="statusFilter"
                        id="statusFilter"	
                        class="form-select border border-2 border-warning bg-transparent text-dark">
                    <option value="">-- Select Status --</option>
                    <option value="ACTIVE" ${statusFilter == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                    <option value="EXITED" ${statusFilter == 'EXITED' ? 'selected' : ''}>EXITED</option>
                </select>
            </div>
        </div>
    </div>

</div>

    <!-- Card Table -->
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Parked Vehicle List</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                <tr>
                    <th>Sr NO.</th>
                    <th>Vehicle Number</th>
                    <th>Vehicle Type</th>
                    <th>Owner Name</th>
                    <th>InDate</th>
                    <th>InTime</th>
                    <th>Slot</th>
                    <th>OutDate</th>
                    <th>OutTime</th>
                    <th>Status</th>
                    <th>Action</th>
                    <th>Report</th> 
                </tr>
                </thead>
               <tbody id="parking-table-body">
                <c:forEach var="park" items="${data}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${park.vehicleNumber}</td>
                        <td>${park.vehicleType}</td>
                        <td>${park.ownerName}</td>
                        <td>${park.inDate}</td>
                        <td>${park.formattedEntryTime}</td>
                        <td>${park.slotId}</td>
                         <td style="text-align: center;">
							  <c:choose>
							    <c:when test="${empty park.outDate}">
							      --
							    </c:when>
							    <c:otherwise>
							      ${park.outDate}
							    </c:otherwise>
							  </c:choose>
							</td> 
                       <td style="text-align: center;">
							  <c:choose>
							    <c:when test="${empty park.formattedExitTime}">
							      --
							    </c:when>
							    <c:otherwise>
							      ${park.formattedExitTime}
							    </c:otherwise>
							  </c:choose>
							</td>
                        <td>
                        <c:choose>
							  <c:when test="${park.status == ParkingStatus.ACTIVE}">
							    <span style="background-color: yellow; padding: 2px 6px; border-radius: 4px;">${park.status}</span>
							  </c:when>
							  <c:when test="${park.status == ParkingStatus. EXITED}">
							    <span style="background-color: lightgreen; padding: 2px 6px; border-radius: 4px;">${park.status}</span>
							  </c:when>
							  <c:otherwise>
							    ${park.status}
							  </c:otherwise>
							</c:choose>
                        <td>
							 <c:choose>
							    <c:when test="${park.status == ParkingStatus.ACTIVE}">
							        <a href="${pageContext.request.contextPath}/parking/fetch-parking?parkingId=${park.parkingId}" title="Edit ${park.status}">
							            <i class="fas fa-pen-to-square fa-2x text-primary ms-2" style="cursor: pointer;"></i>
							        </a>
							    </c:when>
							    <c:when test="${park.status == ParkingStatus.EXITED}">
							        <span title="Vehicle already exited">
							            <i class="fas fa-pen-to-square fa-2x text-secondary ms-2" style="opacity: 0.4; cursor: not-allowed;"></i>
							        </span>
							    </c:when>
							</c:choose>
                        </td>
                        
                        <td>
                        <c:choose>
        					<c:when test="${park.status == ParkingStatus.EXITED}">
				            <button 
							    class="btn btn-sm btn-outline-info" 
							    data-hourly="${park.hourlyFee}" 
							    data-daily="${park.dailyFee}" 
							    data-vehicle="${park.vehicleType}"
							    data-vehicle-number="${park.vehicleNumber}"
							    data-owner-name="${park.ownerName}"
							    data-contact-number="${park.contactNumber}"
							    data-entry-date="${park.inDate}" 
							    data-entry-time="${park.formattedEntryTime}" 
							    data-exit-date="${park.outDate}" 
							    data-exit-time="${park.formattedExitTime}" 
							    onclick="openReportModal(this)">
							    <i class="fas fa-file-alt"></i> Report
							  </button>
							   </c:when>
							   <c:otherwise>
						            <button class="btn btn-sm btn-outline-secondary" disabled title="Report available after Exit">
						                <i class="fas fa-file-alt"></i> Report
						            </button>
						        </c:otherwise>
						        </c:choose>
				        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- Pagination -->
            <c:if test="${totalPages > 0}">
                <nav>
                    <ul class="pagination justify-content-center">
                        <c:forEach begin="0" end="${totalPages - 1}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/parking/all-parking-list?page=${i}&size=10">
                                    ${i + 1}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
    </div>
   
   
   <!-- Report Modal -->
<div id="reportModal" class="modal fade" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 600px; margin: auto;">
        <div class="modal-content">
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title">Parking Report</h5>
                <button type="button" class="btn-close" onclick="closeReportModal()"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <!-- Left Section -->
                    <div class="col-6">
                        <p><strong>Vehicle Type:</strong> <span id="reportVehicleType"></span></p>
                        <p><strong>Vehicle Number:</strong> <span id="reportVehicleNumber"></span></p>
                        <p><strong>Owner Name:</strong> <span id="reportOwnerName"></span></p>
                        <p><strong>Contact Number:</strong> <span id="reportContactNumber"></span></p>
                        <p><strong>Hourly Fee:</strong> ₹<span id="reportHourlyFee"></span></p>
                    </div>

                    <!-- Right Section -->
                    <div class="col-6">
                        <p><strong>Entry Date:</strong> <span id="reportInDate"></span></p>
                        <p><strong>Exit Date:</strong> <span id="reportOutDate"></span></p>
                        <p><strong>Entry Time:</strong> <span id="reportInTime"></span></p>
                        <p><strong>Exit Time:</strong> <span id="reportOutTime"></span></p>
                        <p><strong>Daily Fee:</strong> ₹<span id="reportDailyFee"></span></p>
                    </div>
                </div>

                <!-- Center Section for Total Time and Charges -->
                <div class="text-center mt-4 border-top pt-3">
                    <p><strong>Total Hours Parked:</strong> <span id="reportHoursParked"></span> hrs</p>
                    <p><strong>Total Charges:</strong> ₹<span id="reportTotalCharge"></span></p>
                </div>
            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeReportModal()">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- End Report Modal -->
<script type="text/javascript">

const contextPath = document.body.dataset.contextPath;
const role = document.body.dataset.role;

document.getElementById("statusFilter").addEventListener("change", async function () {
    const selectedStatus = this.value;
    const url = contextPath+"/parking/all-parking-list-by-filter?statusFilter=" +selectedStatus;

    try {
        const result = await fetch(url).then(res => res.json());
        const parkingList = result || [];

        console.log("Full parking Response:", result);
        console.log("Parking data:", parkingList);
        
        
        if (parkingList.length === 0) {
            document.getElementById("parking-table-body").innerHTML = `
                <tr>
                    <td colspan="11" class="text-center text-danger fw-bold">
                        No records found for selected status
                    </td>
                </tr>
            `;
            return;
        }

        const html = parkingList.map((park, index) => {
            const formattedOutDate = park.outDate ? park.outDate : "--";
            const formattedExitTime = park.formattedExitTime ? park.formattedExitTime : "--";
            const status = park.status;
            const statusColor = status === 'ACTIVE' ? 'yellow' : (status === 'EXITED' ? 'lightgreen' : 'lightgray');
            const statusLabel = `<span style="background-color: \${statusColor}; padding: 2px 6px; border-radius: 4px;">\${status}</span>`;

            const editAction = status === 'ACTIVE'
                ? `<a href="\${contextPath}/parking/fetch-parking?parkingId=\${park.parkingId}" title="Edit \${status}">
                       <i class="fas fa-pen-to-square fa-2x text-primary ms-2" style="cursor: pointer;"></i>
                   </a>`
                : `<span title="Vehicle already exited">
                       <i class="fas fa-pen-to-square fa-2x text-secondary ms-2" style="opacity: 0.4; cursor: not-allowed;"></i>
                   </span>`;

            return `
                <tr>
                    <td>\${index + 1}</td>
                    <td>\${park.vehicleNumber || '--'}</td>
                    <td>\${park.vehicleType || '--'}</td>
                    <td>\${park.ownerName || '--'}</td>
                    <td>\${park.inDate || '--'}</td>
                    <td>\${park.formattedEntryTime || '--'}</td>
                    <td>\${park.slotId || '--'}</td>
                    <td style="text-align: center;">\${formattedOutDate}</td>
                    <td style="text-align: center;">\${formattedExitTime}</td>
                    <td>\${statusLabel}</td>
                    <td>\${editAction}</td>
                </tr>
            `;
        }).join("");

        document.getElementById("parking-table-body").innerHTML = html;

    } catch (error) {
        console.error("Error fetching guard data:", error);
        document.getElementById("parking-table-body").innerHTML = `
            <tr><td colspan="11" class="text-center text-danger">Error loading data</td></tr>
        `;
    }
});

 // Search by vehicle number.
 document.addEventListener("DOMContentLoaded", function () {

	 document.getElementById("searchvehicle").addEventListener("input", async function () {
		    const search = this.value;
		    const url = contextPath+"/parking/all-parking-list-by-filter-number?search=" +search;

		    try {
		        const result = await fetch(url).then(res => res.json());
		        const parkingList = result || [];

		        console.log("Full parking Response:", result);
		        console.log("Parking data:", parkingList);
		        
		        
		        if (parkingList.length === 0) {
		            document.getElementById("parking-table-body").innerHTML = `
		                <tr>
		                    <td colspan="11" class="text-center text-danger fw-bold">
		                        No records found for selected status
		                    </td>
		                </tr>
		            `;
		            return;
		        }

		        const html = parkingList.map((park, index) => {
		            const formattedOutDate = park.outDate ? park.outDate : "--";
		            const formattedExitTime = park.formattedExitTime ? park.formattedExitTime : "--";
		            const status = park.status;
		            const statusColor = status === 'ACTIVE' ? 'yellow' : (status === 'EXITED' ? 'lightgreen' : 'lightgray');
		            const statusLabel = `<span style="background-color: \${statusColor}; padding: 2px 6px; border-radius: 4px;">\${status}</span>`;

		            const editAction = status === 'ACTIVE'
		                ? `<a href="\${contextPath}/parking/fetch-parking?parkingId=\${park.parkingId}" title="Edit \${status}">
		                       <i class="fas fa-pen-to-square fa-2x text-primary ms-2" style="cursor: pointer;"></i>
		                   </a>`
		                : `<span title="Vehicle already exited">
		                       <i class="fas fa-pen-to-square fa-2x text-secondary ms-2" style="opacity: 0.4; cursor: not-allowed;"></i>
		                   </span>`;

		            return `
		                <tr>
		                    <td>\${index + 1}</td>
		                    <td>\${park.vehicleNumber || '--'}</td>
		                    <td>\${park.vehicleType || '--'}</td>
		                    <td>\${park.ownerName || '--'}</td>
		                    <td>\${park.inDate || '--'}</td>
		                    <td>\${park.formattedEntryTime || '--'}</td>
		                    <td>\${park.slotId || '--'}</td>
		                    <td style="text-align: center;">\${formattedOutDate}</td>
		                    <td style="text-align: center;">\${formattedExitTime}</td>
		                    <td>\${statusLabel}</td>
		                    <td>\${editAction}</td>
		                </tr>
		            `;
		        }).join("");

		        document.getElementById("parking-table-body").innerHTML = html;

		    } catch (error) {
		        console.error("Error fetching guard data:", error);
		        document.getElementById("parking-table-body").innerHTML = `
		            <tr><td colspan="11" class="text-center text-danger">Error loading data</td></tr>
		        `;
		    }
		});

});
 
 /* it is used to convert formatedtime into 24hour */
 function convertTo24Hour(timeStr) {
	    const [time, modifier] = timeStr.split(" ");
	    let [hours, minutes] = time.split(":").map(Number);

	    if (modifier === "PM" && hours !== 12) {
	        hours += 12;
	    } else if (modifier === "AM" && hours === 12) {
	        hours = 0;
	    }

	    // Pad single digits with 0
	    const pad = (n) => n.toString().padStart(2, "0");
	    return `\${pad(hours)}:\${pad(minutes)}`;
	}
 
 /* it is used to open report model */
 function openReportModal(button) {
    var vehicleType = button.getAttribute("data-vehicle");
    var hourlyFee = parseFloat(button.getAttribute("data-hourly"));
    var dailyFee = parseFloat(button.getAttribute("data-daily"));
    var vehicleNumber = button.getAttribute("data-vehicle-number");
    var ownerName = button.getAttribute("data-owner-name");
    var contactNumber = button.getAttribute("data-contact-number");
    var inDate = button.getAttribute("data-entry-date");
    var outDate = button.getAttribute("data-exit-date");
    var inTime = button.getAttribute("data-entry-time");
    var outTime = button.getAttribute("data-exit-time");

    document.getElementById("reportVehicleType").textContent = vehicleType;
    document.getElementById("reportHourlyFee").textContent = hourlyFee;
    document.getElementById("reportDailyFee").textContent = dailyFee;
    document.getElementById("reportVehicleNumber").textContent = vehicleNumber;
    document.getElementById("reportOwnerName").textContent = ownerName;
    document.getElementById("reportContactNumber").textContent = contactNumber;
    document.getElementById("reportInDate").textContent = inDate;
    document.getElementById("reportOutDate").textContent = outDate;
    document.getElementById("reportInTime").textContent = inTime;
    document.getElementById("reportOutTime").textContent = outTime;

    // Convert time to 24-hour format
    function convertTo24Hour(timeStr) {
        var [time, modifier] = timeStr.split(" ");
        var [hours, minutes] = time.split(":").map(Number);

        if (modifier === "PM" && hours !== 12) {
            hours += 12;
        } else if (modifier === "AM" && hours === 12) {
            hours = 0;
        }

        return `\${hours.toString().padStart(2, '0')}:\${minutes.toString().padStart(2, '0')}`;
    }

    var inDateTimeStr = inDate + "T" + convertTo24Hour(inTime);
    var outDateTimeStr = outDate + "T" + convertTo24Hour(outTime);

    var inDateTime = new Date(inDateTimeStr);
    var outDateTime = new Date(outDateTimeStr);

    if (isNaN(inDateTime) || isNaN(outDateTime)) {
        document.getElementById("reportHoursParked").textContent = "Invalid date/time format";
        document.getElementById("reportTotalCharge").textContent = "N/A";
        var reportModal = new bootstrap.Modal(document.getElementById('reportModal'));
        reportModal.show();
        return;
    }

    var timeDiffMs = outDateTime - inDateTime;
    var totalMinutes = Math.ceil(timeDiffMs / (1000 * 60));
    var totalHoursExact = totalMinutes / 60;

    var fullDays = Math.floor(totalHoursExact / 24);
    var remainingHours = totalHoursExact - (fullDays * 24);

    var totalCharge = 0;
    if (fullDays > 0) {
        totalCharge = (fullDays * dailyFee) + (remainingHours > 0 ? Math.ceil(remainingHours) * hourlyFee : 0);
    } else {
        totalCharge = Math.ceil(totalHoursExact) * hourlyFee;
    }

    // Time format display
    var hours = Math.floor(totalHoursExact);
    var minutes = Math.round((totalHoursExact - hours) * 60);
    var timeText = `\${hours} hr\${hours !== 1 ? 's' : ''}\${minutes > 0 ? ` \${minutes} min\${minutes !== 1 ? 's' : ''}` : ''}`;
    if (fullDays > 0) {
        timeText += ` (\${fullDays} day\${fullDays > 1 ? 's' : ''}\${remainingHours > 0 ? ` + \${Math.ceil(remainingHours)} hr\${Math.ceil(remainingHours) > 1 ? 's' : ''}` : ''})`;
    }

    document.getElementById("reportHoursParked").textContent = timeText;
    document.getElementById("reportTotalCharge").textContent = totalCharge.toFixed(2);

    var reportModal = new bootstrap.Modal(document.getElementById('reportModal'));
    reportModal.show();
}

 /* it is used to close report model */
 function closeReportModal() {
	 const modalEl = document.getElementById('reportModal');
	    const modal = bootstrap.Modal.getInstance(modalEl) || new bootstrap.Modal(modalEl);
	    modal.hide();
	  }
 
/*  this is used to hide error message when user already exist */
document.addEventListener("DOMContentLoaded", function () {
	 const errorMsg = document.getElementById("msg");
	    if (errorMsg) {
	        setTimeout(function () {
	            errorMsg.classList.add("fade-out");
	            setTimeout(() => errorMsg.style.display = "none", 1000);
	        }, 3000);
	    }
	});
</script>
</body>
</html>
