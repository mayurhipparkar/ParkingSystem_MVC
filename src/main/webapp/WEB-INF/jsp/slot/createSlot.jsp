<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.min.css" />
<%@ include file="../module/header.jsp" %>

<style>
    .main-container {
        width: 60%;
        margin: 10% 0 0 24.5%;
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


<div class="row main-container">

<c:if test="${not empty status}">
    <div id="msg" class="alert alert-info text-center">${status}</div>
</c:if>
    <div class="col-sm-9 container">
        <div class="card shadow-lg">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Create Parking Slots</h4>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/create-multiple-slots" method="post">

                    <!-- Vehicle Type & Slot Count -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="vehicleType" class="form-label">Vehicle Type</label>
                            <select class="form-select" name="vehicleType" id="vehicleType" required>
                                <option value="">-- Select Vehicle Type --</option>
                                <option value="two wheeler">Two Wheeler</option>
                                <option value="four wheeler">Four Wheeler</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="slotCount" class="form-label">Number of Slots</label>
                            <input type="number"
                                   class="form-control"
                                   id="slotCount"
                                   name="slotCount"
                                   min="1"
                                   max="30"
                                   required>
                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="text-end">
                        <button type="submit" class="btn btn-success">Generate Slots</button>
                        <button type="reset" class="btn btn-secondary">Reset</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../module/footer.jsp" %>
<script src="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.bundle.min.js"></script>

<script>
    // Fade-out alert after 3 seconds
    document.addEventListener("DOMContentLoaded", function () {
        const msg = document.getElementById("msg");
        if (msg) {
            setTimeout(function () {
                msg.classList.add("fade-out");
                setTimeout(() => msg.style.display = "none", 1000);
            }, 3000);
        }
    });
</script>
