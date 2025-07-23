<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Guard Entry List</title>
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
<body data-context-path="${pageContext.request.contextPath}" data-role="${vehicleType}">

   
	
<!-- 	table start -->
<div class="container mt-3">

<!-- Message -->
<c:if test="${not empty status}">
    <div id="msg" class="alert alert-info text-center">${status}</div>
</c:if>

<!-- Total Records -->
<div class="col-md-12 d-flex align-items-center mb-3">
    <label class="form-label mb-0 me-2">Total Records:</label>
    <strong>${totalItems}</strong>
</div>

<!-- Main Action and Filter Row -->
<div class="row">

    <!-- Left Section: Action Buttons -->
    <div class="col-sm-6 col-md-6">
        <div class="row g-2">
            <!-- Home Button -->
            <div class="col-md-4 mb-3">
                <a href="${pageContext.request.contextPath}/from-guard"
                   class="btn btn-outline-warning w-100">🏠 Home</a>
            </div>

          <c:if test="${sessionScope.userRole == 'Admin'}">
            <div class="col-md-4 mb-3">
                <a href="${pageContext.request.contextPath}/slot-form"
                   class="btn btn-outline-warning w-100">
                    <i class="fas fa-plus text-success"></i> Add
                </a>
            </div>
        </c:if>
        
        <div class="col-md-4 mb-3">
                <select name="statusFilter"
                        id="statusFilter"	
                        class="form-select border border-2 border-warning bg-transparent text-dark">
                    <option value="">-- Select Status --</option>
                    <option value="PARKED" ${statusFilter == 'PARKED' ? 'selected' : ''}>PARKED</option>
                    <option value="UNPARKED" ${statusFilter == ' UNPARKED' ? 'selected' : ''}> UNPARKED</option>
                </select>
            </div>

    </div>

</div>

    <!-- Card Table -->
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Two Wheeler Slot List</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                <tr>
                    <th>Sr NO.</th>
	                <th>Slot ID</th>
	                <th>Vehicle Type</th>
	                <th>Status</th>
                </tr>
                </thead>
               <tbody id="slot-list-table-body">
                <c:forEach var="slot" items="${slotList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${slot.slotId}</td>
                    	<td>${slot.vehicleType}</td>
                        <td>
                        <c:choose>
                            <c:when test="${slot.status == 'UNPARKED'}">
                                <span class="badge bg-success">Available</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Parked</span>
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
                                   href="${pageContext.request.contextPath}/slot-list/${vehicleType}?page=${i}&size=10">
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
  </div> 
<script type="text/javascript">


/* fetch guard record based on status "Active or inactive". */
document.getElementById("statusFilter").addEventListener("change", async function () {
    const selectedStatus = this.value;
    const contextPath = document.body.dataset.contextPath;
    const type = document.body.dataset.role;
    const url = contextPath + "/slot-list-filter/" +encodeURIComponent(type)+ "?statusFilter=" + selectedStatus;

    try {
    	const result = await fetch(url).then(res => res.json());
        console.log("slot list Response:", result);
        console.log("slot list data:", result.data);
        console.log("First slot object:", result.data[0]);

        const html = result.data.map((slot, index) => `
        <tr>
            <td>\${index + 1}</td>
            <td>\${slot.slotId || ''}</td>
            <td>\${slot.vehicleType || ''}</td>
            <td>
            \${slot.status === 'UNPARKED' 
                ? '<span class="badge bg-success">Available</span>' 
                : '<span class="badge bg-danger">Parked</span>'}
        </td>
        </tr>
    `).join("");

        document.getElementById("slot-list-table-body").innerHTML = html;

    } catch (error) {
        console.error("Error fetching slot list data:", error);
        document.getElementById("slot-list-table-body").innerHTML = `
            <tr><td colspan="6" class="text-center text-danger">Error loading data</td></tr>
        `;
    }
});

/*  this is used to hide error message when slots already exist */
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
