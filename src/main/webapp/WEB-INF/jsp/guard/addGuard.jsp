<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.min.css" />
<%@ include file="../module/header.jsp" %>

<style>
    .main-container {
        width: 60%;
        margin: 7% 0 0 29.5%;
    }

    #guard-msg {
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
</style>

<div class="row main-container">
    <div class=" col-sm-9 container ">
        <div class="card shadow-lg">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Add Guard Form</h4>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/add-guard" method="post">

                    <!-- Name & Email -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="fullname" class="form-label">Guard Name</label>
                            <input type="text"
                                   class="form-control"
                                   id="fullname"
                                   name="fullname"
                                   placeholder="e.g., name"
                                   pattern="[A-Za-z ]{2,50}"
                                   title="Name should contain only letters and spaces (2–50 characters)"
                                   required>
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email</label>
                            <input type="email"
                                   class="form-control"
                                   id="email"
                                   name="email"
                                   placeholder="e.g., guard@example.com"
                                   required>
                        </div>
                    </div>

                    <!-- Contact Number & Password -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="number" class="form-label">Contact Number</label>
                            <input type="tel"
                                   class="form-control"
                                   id="number"
                                   name="number"
                                   pattern="[6-9][0-9]{9}"
                                   title="Enter a valid 10-digit mobile number starting with 6, 7, 8, or 9"
                                   maxlength="10"
                                   required>
                        </div>
                        <div class="col-md-6">
                            <label for="password" class="form-label">Password (Auto-generated)</label>
                            <input type="text"
                                   class="form-control"
                                   id="password"
                                   name="password"
                                   readonly
                                   placeholder="Auto-generated from name">
                        </div>
                    </div>

                    <!-- Address -->
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <textarea class="form-control"
                                  id="address"
                                  name="address"
                                  rows="1"
                                  maxlength="255"
                                  required></textarea>
                    </div>

                    <!-- Status -->
                    <div class="mb-3">
                        <label for="status" class="form-label">Status</label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="Active" selected>Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>

                    <!-- Buttons -->
                    <div class="text-end">
                        <button type="submit" class="btn btn-success">Register Guard</button>
                        <button type="reset" class="btn btn-secondary" id="resetButton">Reset</button>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <div class="col-sm-3">
        <c:if test="${not empty msgStatus}">
            <div id="guard-msg" class="alert alert-info text-center w-100">${msgStatus}</div>
        </c:if>
    </div>
</div>

<%@ include file="../module/footer.jsp" %>
<script src="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.bundle.min.js"></script>

<script>
    const nameInput = document.getElementById("fullname");
    const passwordInput = document.getElementById("password");

    // Auto-generate password based on first name
    nameInput.addEventListener("input", function () {
        const name = nameInput.value.trim();
        if (name.length > 0) {
            const firstName = name.split(" ")[0];
            const generatedPassword = firstName.charAt(0).toUpperCase() + firstName.slice(1) + "@123";
            passwordInput.value = generatedPassword;
        } else {
            passwordInput.value = "";
        }
    });

    // Reset behavior
    document.getElementById("resetButton").addEventListener("click", () => {
        passwordInput.value = "";
    });

    // Hide error message after delay
    document.addEventListener("DOMContentLoaded", function () {
        const errorMsg = document.getElementById("guard-msg");
        if (errorMsg) {
            setTimeout(function () {
                errorMsg.classList.add("fade-out");
                setTimeout(() => errorMsg.style.display = "none", 1000);
            }, 3000);
        }
    });
</script>
