<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Parking Fee List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        table.table tbody, table.table tr, table.table td {
            padding: 4px 8px;
        }
        .label {
            font-size: 1.2rem;
        }
        #msg {
            color: black;
            background-color: lightgreen;
            font-weight: bold;
            text-align: center;
            padding: 10px 20px;
            margin-top: 5px;
            border: 2px solid black;
        }
        .fade-out {
            transition: opacity 1s ease-out;
            opacity: 0;
        }
    </style>
</head>
<body data-context-path="${pageContext.request.contextPath}">

<div class="container mt-5">
    <!-- Message -->
    <c:if test="${not empty msgStatus}">
        <div id="msg" class="alert alert-info text-center">${msgStatus}</div>
    </c:if>

<div class="col-sm-6 col-md-6">
        <div class="row g-2">
            <!-- Home Button -->
            <div class="col-md-4 mb-3">
                <a href="${pageContext.request.contextPath}/from-guard"
                   class="btn btn-outline-warning w-100">🏠 Home</a>
            </div>

            <!-- Add Button -->
            <div class="col-md-4 mb-3">
                <a href="${pageContext.request.contextPath}/parking/parking-fees-form"
                   class="btn btn-outline-warning w-100">
                    <i class="fas fa-plus text-success"></i> Add
                </a>
            </div>
        </div>
    </div>


    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Parking Fee List</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                <tr>
                    <th>Sr No.</th>
                    <th>Vehicle Type</th>
                    <th>Hourly Fee (₹)</th>
                    <th>Daily Fee (₹)</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="fee" items="${parkingFeeList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${fee.vehicleType}</td>
                        <td>${fee.hourlyFee}</td>
                        <td>${fee.dailyFee}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/parking/fetch-parking-fee/${fee.parkingFeeId}" title="Edit ${fee.vehicleType} Fee">
                                <i class="fas fa-pen-to-square fa-2x text-primary ms-2"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
// Fade out message
setTimeout(function () {
    const msg = document.getElementById("msg");
    if (msg) {
        msg.classList.add("fade-out");
        setTimeout(() => msg.style.display = "none", 1000);
    }
}, 3000);
</script>

</body>
</html>
