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
