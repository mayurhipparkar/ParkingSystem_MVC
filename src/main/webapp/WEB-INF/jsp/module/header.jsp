<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!doctype html>
<html lang="en">
<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!--favicon-->
	<link rel="icon" href="${pageContext.request.contextPath}/resources/assets/images/favicon-32x32.png" type="image/png"/>
	<!--plugins-->
	<link href="${pageContext.request.contextPath}/resources/assets/plugins/vectormap/jquery-jvectormap-2.0.2.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/assets/plugins/simplebar/css/simplebar.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/assets/plugins/metismenu/css/metisMenu.min.css" rel="stylesheet"/>
	<!-- loader-->
	<link href="${pageContext.request.contextPath}/resources/assets/css/pace.min.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/resources/assets/js/pace.min.js"></script>
	<!-- Bootstrap CSS -->
	<link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-extended.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&amp;display=swap" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/assets/css/app.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/assets/css/icons.css" rel="stylesheet">
	<!-- Theme Style CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/dark-theme.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/semi-dark.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/header-colors.css"/>
	<title>Vehicle Parking System</title>
	<style>
		.bx-checkbox-square{
			margin-left:15px;
		}
		
	</style>
</head>

<body>
	<!--wrapper-->
	<div class="wrapper">
		<!--sidebar wrapper -->
		<div class="sidebar-wrapper" data-simplebar="true">
			<div class="sidebar-header">
				<div>
					<img src="${pageContext.request.contextPath}/resources/assets/images/products/parking_logo3.png" class="logo-icon" alt="logo icon">
				</div>
				<div>
					<h4 class="logo-text">Parking<sup>system</sup></h4>
				</div>
			 </div>
			<!--navigation-->
			<ul class="metismenu" id="menu">
				<li>
					<a href="${pageContext.request.contextPath}/home">
						<div class="parent-icon"><span>🏠</span>
						</div>
						<div class="menu-title">Home</div>
					</a>
				</li>
				
				<c:if test="${sessionScope.userRole == 'Admin' || sessionScope.userRole == 'Guard'}">
				    <li>
				        <a href="javascript:;" class="has-arrow">
				            <div class="parent-icon"><span>📝</span></div>
				            <div class="menu-title">Vehicle Entry</div>
				        </a>
				        <ul>
				            <li><a href="${pageContext.request.contextPath}/vehicle/add-vehicle-Form"><i class='bx bx-radio-circle'></i>Add Vehicle</a></li>
				            <li><a href="${pageContext.request.contextPath}/list/twoWheeler-list/two wheeler"><i class='bx bx-radio-circle'></i>Two Wheeler List</a></li>
				            <li><a href="${pageContext.request.contextPath}/list/fourWheeler-list/four wheeler"><i class='bx bx-radio-circle'></i>Four Wheeler List</a></li>
				        </ul>
				    </li>
				</c:if>

				<c:if test="${sessionScope.userRole == 'Admin'}">
				    <li>
				        <a href="javascript:;" class="has-arrow">
				            <div class="parent-icon"><span>👮</span></div>
				            <div class="menu-title">Guard</div>
				        </a>
				        <ul>
				            <li><a href="${pageContext.request.contextPath}/add-guard-form"><i class='bx bx-radio-circle'></i>Add Guard</a></li>
				            <li><a href="${pageContext.request.contextPath}/guard-list/Guard"><i class='bx bx-radio-circle'></i>View Guard List</a></li>
				        </ul>
				    </li>
				</c:if>
			
				<c:if test="${sessionScope.userRole == 'Admin'}">
				    <!-- Two Wheeler Slot -->
				    <li>
				        <a href="javascript:;" class="has-arrow">
				            <div class="parent-icon"><span>🏍️</span></div>
				            <div class="menu-title">Two Wheeler Slot</div>
				        </a>
				        <ul>
				            <li><a href="ecommerce-products.html"><i class='bx bx-radio-circle'></i>Create Slot</a></li>
				            <li><a href="ecommerce-products-details.html"><i class='bx bx-radio-circle'></i>Remove Slot</a></li>
				            <li><a href="ecommerce-add-new-products.html"><i class='bx bx-radio-circle'></i>Update Slot</a></li>
				            <li><a href="ecommerce-orders.html"><i class='bx bx-radio-circle'></i>View Slot List</a></li>
				        </ul>
				    </li>
				
				    <!-- Four Wheeler Slot -->
				    <li>
				        <a href="javascript:;" class="has-arrow">
				            <div class="parent-icon"><span>🚗</span></div>
				            <div class="menu-title">Four Wheeler Slot</div>
				        </a>
				        <ul>
				            <li><a href="ecommerce-products.html"><i class='bx bx-radio-circle'></i>Create Slot</a></li>
				            <li><a href="ecommerce-products-details.html"><i class='bx bx-radio-circle'></i>Remove Slot</a></li>
				            <li><a href="ecommerce-add-new-products.html"><i class='bx bx-radio-circle'></i>Update Slot</a></li>
				            <li><a href="ecommerce-orders.html"><i class='bx bx-radio-circle'></i>View Slot List</a></li>
				        </ul>
				    </li>
				
				</c:if>

				
				<c:if test="${sessionScope.userRole == 'Admin' || sessionScope.userRole == 'Guard'}">
				    <li>
				        <a href="javascript:;" class="has-arrow">
				            <div class="parent-icon"><span>🅿️</span></div>
				            <div class="menu-title">Manage Parking</div>
				        </a>
				        <ul>
				            <!-- Two Wheeler Slot Submenu -->
				            <li>
				                <a href="javascript:;" class="has-arrow has-sub-arrow">
				                    <i class='bx bx-checkbox-square'></i>Two Wheeler Slot
				                </a>
				                <ul>
				                    <li><a href="ecommerce-products.html"><i class='bx bx-radio-circle'></i>Assign Slot</a></li>
				                    <li><a href="ecommerce-products-details.html"><i class='bx bx-radio-circle'></i>Delete slot</a></li>
				                    <li><a href="ecommerce-add-new-products.html"><i class='bx bx-radio-circle'></i>View Engaged slot</a></li>
				                    <li><a href="ecommerce-orders.html"><i class='bx bx-radio-circle'></i>View Remaining slot</a></li>
				                </ul>
				            </li>
				
				            <!-- Four Wheeler Slot Submenu -->
				            <li>
				                <a href="javascript:;" class="has-arrow has-sub-arrow">
				                    <i class='bx bx-checkbox-square'></i>Four Wheeler Slot
				                </a>
				                <ul>
				                    <li><a href="ecommerce-products.html"><i class='bx bx-radio-circle'></i>Assign Slot</a></li>
				                    <li><a href="ecommerce-products-details.html"><i class='bx bx-radio-circle'></i>Delete slot</a></li>
				                    <li><a href="ecommerce-add-new-products.html"><i class='bx bx-radio-circle'></i>View Engaged slot</a></li>
				                    <li><a href="ecommerce-orders.html"><i class='bx bx-radio-circle'></i>View Remaining slot</a></li>
				                </ul>
				            </li>
				        </ul>
				    </li>
				</c:if>

				
				<li>
					<a href="https://themeforest.net/user/codervent" target="_blank">
						<div class="parent-icon"><i class="bx bx-support"></i>
						</div>
						<div class="menu-title">Support</div>
					</a>
				</li>
			</ul>
			<!--end navigation-->
		</div>
		<!--end sidebar wrapper -->
		<!--start header -->
		<header>
			<div class="topbar d-flex align-items-center">
				<nav class="navbar navbar-expand gap-3">
					<div class="mobile-toggle-menu"><i class='bx bx-menu'></i>
					</div>
					  <div class="top-menu ms-auto">
						<ul class="navbar-nav align-items-center gap-1">
							<li class="nav-item dark-mode d-none d-sm-flex">
								<a class="nav-link dark-mode-icon" href="javascript:;"><i class='bx bx-moon'></i>
								</a>
							</li>
							<li class="nav-item dropdown dropdown-app">
								<div class="dropdown-menu dropdown-menu-end p-0">
									<div class="app-container p-2 my-2">
									  <div class="row gx-0 gy-2 row-cols-3 justify-content-center p-2">
									  </div><!--end row-->
									</div>
								</div>
							</li>

							<li class="nav-item dropdown dropdown-large">
								<a class="nav-link dropdown-toggle dropdown-toggle-nocaret position-relative" href="#" data-bs-toggle="dropdown"><span class="alert-count">7</span>
									<i class='bx bx-bell'></i>
								</a>
								<div class="dropdown-menu dropdown-menu-end header-notifications-list">
									<a href="javascript:;">
										<div class="msg-header">
											<p class="msg-header-title">Notifications</p>
											
										</div>
									</a>	
								</div>
							</li>
							<li class="nav-item dropdown dropdown-large">
								
								<div class="dropdown-menu dropdown-menu-end">
									<a href="javascript:;">	
									</a>
									<div class="header-message-list">
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="user-box dropdown px-3">
						<a class="d-flex align-items-center nav-link dropdown-toggle gap-3 dropdown-toggle-nocaret" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							<img src="${pageContext.request.contextPath}/assets/images/avatars/avatar-2.png" class="user-img" alt="user avatar">
							<div class="user-info">
								<p class="user-name mb-0">Pauline Seitz</p>
								<p class="designattion mb-0">Web Designer</p>
							</div>
						</a>
						<ul class="dropdown-menu dropdown-menu-end">
							<li><a class="dropdown-item d-flex align-items-center" href="javascript:;"><i class="bx bx-user fs-5"></i><span>Profile</span></a>
							</li>
							<li><a class="dropdown-item d-flex align-items-center" href="javascript:;"><i class="bx bx-cog fs-5"></i><span>Settings</span></a>
							</li>
							<li><a class="dropdown-item d-flex align-items-center" href="javascript:;"><i class="bx bx-home-circle fs-5"></i><span>Dashboard</span></a>
							</li>
							<li><a class="dropdown-item d-flex align-items-center" href="javascript:;"><i class="bx bx-dollar-circle fs-5"></i><span>Earnings</span></a>
							</li>
							<li><a class="dropdown-item d-flex align-items-center" href="javascript:;"><i class="bx bx-download fs-5"></i><span>Downloads</span></a>
							</li>
							<li>
								<div class="dropdown-divider mb-0"></div>
							</li>
							<li><a class="dropdown-item d-flex align-items-center" href="javascript:;"><i class="bx bx-log-out-circle"></i><span>Logout</span></a>
							</li>
						</ul>
					</div>
				</nav>
			</div>
		</header>
		<!--end header -->