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
<body data-context-path="${pageContext.request.contextPath}" data-role="${role}">

   
	
<!-- 	table start -->
<div class="container mt-5">

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
                <a href="${pageContext.request.contextPath}/add-guard-form"
                   class="btn btn-outline-warning w-100">
                    <i class="fas fa-plus text-success"></i> Add
                </a>
            </div>

            <!-- All Button -->
            <div class="col-md-4 mb-3">
                <a href="${pageContext.request.contextPath}/guard-list/${role}"
                   class="btn btn-outline-warning w-100">All</a>
            </div>
        </div>
    </div>

    <!-- Right Section: Search and Filter -->
    <div class="col-sm-6 col-md-6">
        <div class="row g-2">
            <!-- Search by Guard Name -->
            <div class="col-md-6 mb-3">
                <input type="text"
                       name="search"
                       id="guardSearch"
                       class="form-control border border-2 border-warning bg-transparent text-dark"
                       placeholder="Search guard name"
                       value="${search}">
            </div>

            <!-- Status Filter Dropdown -->
            <div class="col-md-6 mb-3">
                <select name="statusFilter"
                        id="statusFilter"	
                        class="form-select border border-2 border-warning bg-transparent text-dark">
                    <option value="">-- Select Status --</option>
                    <option value="Active" ${statusFilter == 'Active' ? 'selected' : ''}>Active</option>
                    <option value="Inactive" ${statusFilter == 'Inactive' ? 'selected' : ''}>Inactive</option>
                </select>
            </div>
        </div>
    </div>

</div>

    <!-- Card Table -->
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Guard Entry List</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                <tr>
                    <th>Sr NO.</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Number</th>
                    <th>Address</th>
                    <th>Action</th>
                </tr>
                </thead>
               <tbody id="guard-table-body">
                <c:forEach var="guard" items="${guardList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${guard.fullname}</td>
                        <td>${guard.email}</td>
                        <td>${guard.number}</td>
                        <td>${guard.address}</td>
                        <td>
                           <a href="${pageContext.request.contextPath}/fetch-guard/${guard.id}/${role}" title="Edit ${guard.fullname}">
						        <i class="fas fa-user-edit fa-2x text-primary ms-2"></i>
						   </a>
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
                                   href="${pageContext.request.contextPath}/guard-list/${role}?page=${i}&size=8">
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

const contextPath = document.body.dataset.contextPath;//context path 
const role = document.body.dataset.role;// default role

/* fetch guard record based on status "Active or inactive". */
document.getElementById("statusFilter").addEventListener("change", async function () {
    const selectedStatus = this.value;
    const contextPath = document.body.dataset.contextPath;
    const role = document.body.dataset.role;
    const url = contextPath + "/guard-list-filter/" + role + "?statusFilter=" + selectedStatus;

    try {
    	const result = await fetch(url).then(res => res.json());
        console.log("Full Guard Response:", result);
        console.log("Guard data:", result.data);
        console.log("First guard object:", result.data[0]);

        const html = result.data.map((guard, index) => `
        <tr>
            <td>\${index + 1}</td>
            <td>\${guard.fullname || ''}</td>
            <td>\${guard.email || ''}</td>
            <td>\${guard.number|| ''}</td>
            <td>\${guard.address || ''}</td>
            <td>
                <a href="\${contextPath}/fetch-guard/\${guard.id}/\${role}" title="Edit \${guard.fullname}">
                    <i class="fas fa-user-edit fa-2x text-primary ms-2"></i>
                </a>
            </td>
        </tr>
    `).join("");

        document.getElementById("guard-table-body").innerHTML = html;

    } catch (error) {
        console.error("Error fetching guard data:", error);
        document.getElementById("guard-table-body").innerHTML = `
            <tr><td colspan="6" class="text-center text-danger">Error loading data</td></tr>
        `;
    }
});

 // Search by guard name.
 document.addEventListener("DOMContentLoaded", function () {

    document.getElementById("guardSearch").addEventListener("input", async function () {
        const search = this.value;
        console.log(search);
        const tbody = document.getElementById("guard-table-body");
        try {
            const url = contextPath + "/guard-list-search/" + role + "?search=" + encodeURIComponent(search);
            const response = await fetch(url);
            const data = await response.json();
            tbody.innerHTML = "";

            if (!data.length) {
                tbody.innerHTML = "<tr><td colspan='6' class='text-center text-danger'>No guards found</td></tr>";
                return;
            }

            data.map((guard, index) => {
                const row = `
                    <tr>
                        <td>\${index + 1}</td>
                        <td>\${guard.fullname}</td>
                        <td>\${guard.email}</td>
                        <td>\${guard.number}</td>
                        <td>\${guard.address}</td>
                        <td>
		                    <a href="\${contextPath}/fetch-guard/\${guard.id}/\${role}" title="Edit \${guard.fullname}">
		                        <i class="fas fa-user-edit fa-2x text-primary ms-2"></i>
		                    </a>
                        </td>
                    </tr>`;
                tbody.innerHTML += row;
            });

        } catch (error) {
            console.error("Search failed:", error);
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
