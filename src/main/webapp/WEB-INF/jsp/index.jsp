<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="module/header.jsp" %>
		
		<!--start page wrapper -->
		<div class="page-wrapper">
			<div class="page-content">
				<div class="row row-cols-1 row-cols-md-2 row-cols-xl-4">
                   <div class="col">
					    <div class="card h-100 radius-10 border-start border-0 border-4 border-info">
					        <div class="card-body d-flex flex-column justify-content-between">
					            <div class="d-flex align-items-center">
					                <div>
					                    <p class="mb-0 text-success">Total Vehicles</p>
					                    <h4 class="my-1 text-info">${dashRecord.totalVehicleCount}</h4>
					                </div>
					            </div>
					        </div>
					    </div>
					</div>
								   <div class="col">
				    <div class="card h-100 radius-10 border-start border-0 border-4 border-info">
				        <div class="card-body d-flex flex-column justify-content-between">
				            <div class="d-flex align-items-center">
				                <div>
				                    <p class="mb-0 text-success">Todays Vehicle</p>
				                    <h4 class="my-1 text-info">${dashRecord.todayEnteredVehicleCount}</h4>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>
				  <div class="col">
					    <div class="card h-100 radius-10 border-start border-0 border-4 border-info">
					        <div class="card-body d-flex flex-column justify-content-between">
					            <div class="d-flex align-items-center">
					                <div>
					                    <p class="mb-0 text-success">Total Parked</p>
					                    <h4 class="my-1 text-info">${dashRecord.totalParkedVehicleCount}</h4>
					                </div>
					            </div>
					        </div>
					    </div>
					</div>
				  <div class="col">
					    <div class="card h-100 radius-10 border-start border-0 border-4 border-info">
					        <div class="card-body d-flex flex-column justify-content-between">
					            <div class="d-flex align-items-center">
					                <div>
					                    <p class="mb-0 text-success">Todays Parked Vehicle</p>
					                    <h4 class="my-1 text-info">${dashRecord.todayParkedVehicleCount}</h4>
					                </div>
					            </div>
					        </div>
					    </div>
					</div>
				</div><!--end row-->
				
				<!-- New Section: Labeled Parking Fee Records -->
			<div class="row mt-4">
			    <div class="col-12">
			        <h5 class="mb-3 text-primary">Parking Fee Details</h5>
			        <div class="card">
			            <div class="card-body">
			                <div class="table-responsive">
			                    <table class="table table-bordered text-center">
			                        <thead class="table-primary">
			                            <tr>
			                                <th>Vehicle Type</th>
			                                <th>Hourly Fee (₹)</th>
			                                <th>Per Day Fee (₹)</th>
			                            </tr>
			                        </thead>
			                        <tbody>
			                            <tr>
			                                <td>Two-Wheeler</td>
			                                <td>${dashRecord.twoWheelerFee.hourlyFee}</td>
			                                <td>${dashRecord.twoWheelerFee.dailyFee}</td>
			                            </tr>
			                            <tr>
			                                <td>Four-Wheeler</td>
			                                <td>${dashRecord.fourWheelerFee.hourlyFee}</td>
			                                <td>${dashRecord.fourWheelerFee.dailyFee}</td>
			                            </tr>
			                        </tbody>
			                    </table>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>

		<!--end page wrapper -->
		<!--start overlay-->
		 <div class="overlay toggle-icon"></div>
		<!--end overlay-->
		<!--Start Back To Top Button-->
		  <a href="javaScript:;" class="back-to-top"><i class='bx bxs-up-arrow-alt'></i></a>
		<!--End Back To Top Button-->
		<%@ include file="module/footer.jsp" %>
		