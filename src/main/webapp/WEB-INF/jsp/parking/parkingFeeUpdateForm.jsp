<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Parking Fee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <%@ include file="../module/header.jsp" %>
    <style>
        .main-container {
	        width: 60%;
	        padding: 20px;
	        margin-top: 8% 0 0 24%;
        }
        .card-header i {
            font-size: 1.3rem;
        }
        .form-label {
            font-weight: 600;
        }
        .form-control, .form-select {
            font-size: 0.95rem;
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

<div class="container-fluid main-container">

 	<c:if test="${not empty msgStatus}">
         <div id="parking-msg" class="alert alert-success text-center">${msgStatus}</div>
    </c:if>
    <div class="row justify-content-center">
        <div class="col-12 col-md-10 col-lg-8">
            <div class="card shadow-lg border-0">
                <div class="card-header  bg-primary text-white text-center">
                    <h4 class="mb-0">Update Parking Fee</h4>
                </div>

                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/parking/update-parking-fee" method="post">

                     <!-- Vehicle Type -->
							<div class="form-group mb-4">
							    <input type="hidden" value="${parkingFee.parkingFeeId}" name="parkingFeeId" required><!-- hidden value for ID -->
							
							    <label class="form-label">Vehicle Type</label><br>
							
							    <div class="form-check form-check-inline">
							        <input type="radio" id="twoWheeler" name="vehicleType" value="two Wheeler" class="form-check-input"
							            <c:if test="${parkingFee.vehicleType eq 'two Wheeler'}">
							                checked
							            </c:if>
							            <c:if test="${parkingFee.vehicleType ne 'two Wheeler'}">
							                disabled
							            </c:if>
							            required>
							        <label class="form-check-label" for="twoWheeler">Two Wheeler</label>
							    </div>
							
							    <div class="form-check form-check-inline">
							        <input type="radio" id="fourWheeler" name="vehicleType" value="four Wheeler" class="form-check-input"
							            <c:if test="${parkingFee.vehicleType eq 'four Wheeler'}">
							                checked
							            </c:if>
							            <c:if test="${parkingFee.vehicleType ne 'four Wheeler'}">
							                disabled
							            </c:if>>
							        <label class="form-check-label" for="fourWheeler">Four Wheeler</label>
							    </div>
							</div>

                        <!-- Hourly Fee -->
							<div class="form-group mb-4">
							    <label class="form-label">Hourly Fee (₹)</label>
							    <input 
							        type="number"
							        name="hourlyFee"
							        class="form-control"
							        value="${not empty parkingFee.hourlyFee ? parkingFee.hourlyFee : ''}"
							        placeholder="Enter hourly fee in ₹"
							        min="0"
							        step="0.01"
							        pattern="^\d+(\.\d{1,2})?$"
							        title="Enter a valid amount (up to 2 decimal places)"
							        required
							    >
							</div>

                        <!-- Daily Fee -->
							<div class="form-group mb-4">
							    <label class="form-label">Daily Fee (₹)</label>
							    <input 
							        type="number"
							        name="dailyFee"
							        class="form-control"
							         value="${not empty parkingFee.dailyFee ? parkingFee.dailyFee : ''}"
							        placeholder="Enter daily fee in ₹"
							        min="0"
							        step="0.01"
							        pattern="^\d+(\.\d{1,2})?$"
							        title="Enter a valid amount (up to 2 decimal places)"
							        required
							    >
							</div>


                        <!-- Buttons -->
                        <div class="text-end">
                            <button type="submit" class="btn btn-success me-2">
                                <i class="fas fa-save"></i> Save Fee
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
<<script type="text/javascript">

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
