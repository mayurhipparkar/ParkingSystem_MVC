<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Parking System - Authentication</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.min.css" />
    <style>
        .form-toggle {
            cursor: pointer;
            color: #0d6efd;
            text-decoration: underline;
        }

        #signUpForm {
            display: none;
        }

        #resetPasswordForm {
            display: none;
        }

        #error-msg {
            background-color: lightgreen;
            color: black;
            padding: 5px;
            word-spacing: 1px;
            letter-spacing: 1px;
            font-size: 20px;
            margin: 10px;
            border: 2px solid black;
            display: none;
        }

        .fade-out {
            transition: opacity 1s ease-out;
            opacity: 0;
        }
    </style>
</head>
<body class="bg-light">

    <c:if test="${not empty status}">
        <div id="error-msg" class="alert alert-info text-center">${status}</div>
    </c:if>

<div class="container my-3">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card p-4 shadow">

                <!-- Sign In Form -->
                <div id="signInForm">
                    <h4 class="text-center mb-4">Sign In</h4>
                    <form action="${pageContext.request.contextPath}/loginuser" method="post">
                        <div class="mb-3">
                            <label for="signinUsername" class="form-label">Username or Email</label>
                            <input type="email" class="form-control" id="signinUseremail" name="email" placeholder="Enter your email@ id" required />
                        </div>
                        
                        <div class="mb-3">
					    <label for="newPassword" class="form-label">Password</label>
					    <div class="input-group">
					        <input 
					            type="password" 
					            class="form-control" 
					           	id="signinPassword"
					            name="password" 
					            placeholder="Enter your pass***d"
					            required 
					        />
					        <button class="btn btn-outline-secondary" type="button" id="togglePasswordLogin">
					            Show
					        </button>
					    </div>
					</div>
                        <button type="submit" class="btn btn-primary w-100">Login</button>
                    </form>
                    <c:if test="${showForgotPassword}">
                        <p class="text-center mt-2">
                            <span class="form-toggle text-danger" onclick="showResetForm()">Forgot Password?</span>
                        </p>
                    </c:if>
                    <p class="text-center mt-3">
                        Don't have an account? 
                        <span class="form-toggle" onclick="toggleForms()">Sign Up</span>
                    </p>
                </div>

                <!-- Sign Up Form (hidden by default) -->
                <div id="signUpForm">
                    <h4 class="text-center mb-4">Sign Up</h4>
                    <form action="${pageContext.request.contextPath}/registeruser" method="post">
                        <div class="mb-3">
                            <label for="fullname" class="form-label">Full Name</label>
                            <input type="text"
                                   class="form-control"
                                   id="fullname"
                                   name="fullname"
                                   placeholder="e.g., name"
                                   pattern="[A-Za-z ]{2,50}"
                                   title="Name should contain only letters and spaces (2–50 characters)"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="signupEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="signupEmail" name="email" placeholder="Enter your  email@ id" required />
                        </div>
                        <div class="mb-3">
                            <label for="signupEmail" class="form-label">Number</label>
                            <input type="text" 
                                   class="form-control" 
                                   id="signupNumber" 
                                   name="number" 
                                   pattern="[6-9][0-9]{9}"
                                   title="Enter a valid 10-digit mobile number starting with 6, 7, 8, or 9"
                                   maxlength="10" 
                                   placeholder="Enter your number" required />
                        </div>
                        <div class="mb-3">
                            <label for="signupEmail" class="form-label">Address</label>
                            <input type="text" class="form-control" id="signupAddress" name="address" 
                                   pattern="[A-Za-z ]{2,100}"
                                   title="Address should contain only letters and spaces (2–100 characters)"
                                   placeholder="Enter your address" required />
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password (Auto-generated)</label>
                            <input type="text"
                                   class="form-control"
                                   id="password"
                                   name="password"
                                   readonly
                                   placeholder="Auto-generated from name">
                        </div>
                        <div class="mb-3">
                            <label for="signupRole" class="form-label">Role</label>
                            <select class="form-select" id="signupRole" name="role" required>
                                <option value="">Select Role</option>
                                <option value="Admin">Admin</option>
                                <option value="Guard">Guard</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Register</button>
                    </form>
                    <p class="text-center mt-3">
                        Already have an account? 
                        <span class="form-toggle" onclick="toggleForms()">Sign In</span>
                    </p>
                </div>

                <!-- Reset Password Form -->
                <div id="resetPasswordForm">
                    <h4 class="text-center mb-4">Reset Password</h4>
                    <form action="${pageContext.request.contextPath}/resetpassword" method="post">
                        <div class="mb-3">
                            <label for="resetEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="resetEmail" name="email" placeholder="Enter your registered email" required />
                        </div>
                   <div class="mb-3">
					    <label for="newPassword" class="form-label">New Password</label>
					    <div class="input-group">
					        <input 
					            type="password" 
					            class="form-control" 
					            id="newPassword" 
					            name="newPassword" 
					            placeholder="Enter new password" 
					            required 
					        />
					        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
					            Show
					        </button>
					    </div>
					</div>
                        <button type="submit" class="btn btn-warning w-100">Reset Password</button>
                    </form>
                    <p class="text-center mt-3">
                        Back to <span class="form-toggle" onclick="backToLogin()">Login</span>
                    </p>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/bootstrapFiles/bootstrap.bundle.min.js"></script>

<script>
const name = document.getElementById("fullname");
name.addEventListener("input", function () {
    let words = this.value.split(" ");
    let capitalizedWords = words.map(word => {
        if (word.length > 0) {
            return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
        }
        return "";
    });
    this.value = capitalizedWords.join(" ");
});

const nameInput = document.getElementById("fullname");
const passwordInput = document.getElementById("password");

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

function toggleForms() {
    const signInForm = document.getElementById('signInForm');
    const signUpForm = document.getElementById('signUpForm');
    const resetPasswordForm = document.getElementById('resetPasswordForm');
    resetPasswordForm.style.display = 'none';

    if (signInForm.style.display === 'none') {
        signInForm.style.display = 'block';
        signUpForm.style.display = 'none';
    } else {
        signInForm.style.display = 'none';
        signUpForm.style.display = 'block';
    }
}

function showResetForm() {
    document.getElementById('signInForm').style.display = 'none';
    document.getElementById('signUpForm').style.display = 'none';
    document.getElementById('resetPasswordForm').style.display = 'block';
}

function backToLogin() {
    document.getElementById('resetPasswordForm').style.display = 'none';
    document.getElementById('signInForm').style.display = 'block';
}

window.onload = function () {
    const errorMsg = document.getElementById("error-msg");
    if (errorMsg && errorMsg.innerText.trim() !== "") {
        errorMsg.style.display = "block";
        setTimeout(function () {
            errorMsg.classList.add("fade-out");
            setTimeout(() => errorMsg.style.display = "none", 1000);
        }, 3000);
    }
};

/* it is used to show and hide password in reset password */
document.getElementById('togglePassword').addEventListener('click', function () {
    const passwordField = document.getElementById('newPassword');
    const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordField.setAttribute('type', type);
    this.textContent = type === 'password' ? 'Show' : 'Hide';
});


/* it is used to show and hide password in login */
document.getElementById('togglePasswordLogin').addEventListener('click', function () {
    const passwordField = document.getElementById('signinPassword');
    const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordField.setAttribute('type', type);
    this.textContent = type === 'password' ? 'Show' : 'Hide';
});
</script>
</body>
</html>
