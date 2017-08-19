<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<style>
.custab {
	border: 1px solid #ccc;
	padding: 5px;
	margin: 2% 0;
	box-shadow: 3px 3px 2px #ccc;
	transition: 0.5s;
}

@import url(http://fonts.googleapis.com/css?family=Righteous);
</style>


<security:authorize access="hasRole('ADMIN')">

	<div class="row">
		<jstl:if
			test="${numBookingThisMonth > 0 || numBookingPreviousMonth > 0 || numBookingMakeTwoMonth >0}">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">
						<div>
							<spring:message code="dashboard.numBookingThisMonth"
								var="thisMonth" />
							<spring:message code="dashboard.numBookingPreviousMonth"
								var="previousMonth" />
							<spring:message code="dashboard.numBookingMakeTwoMonth"
								var="makeTwoMonth" />


							<div class="text-center">
								<h3>
									<spring:message code="dashboard.bookingsIn3Months" />
								</h3>
								<canvas id="pie" width="800" height="500"></canvas>
							</div>
						</div>


					</div>
				</div>
			</div>
		</jstl:if>

		<jstl:if
			test="${numBookingThisYear > 0 || numBookingPreviousYear > 0 || numBookingMakeTwoYear >0}">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<div>
							<spring:message code="dashboard.numBookingThisYear"
								var="thisYear" />
							<spring:message code="dashboard.numBookingPreviousYear"
								var="previousYear" />
							<spring:message code="dashboard.numBookingMakeTwoYear"
								var="makeTwoYear" />


							<div class="text-center">
								<h3>
									<spring:message code="dashboard.bookingsIn3Years" />
								</h3>
								<canvas id="pie2" width="800" height="500"></canvas>
							</div>
						</div>
					</div>
				</div>
			</div>
		</jstl:if>

		<jstl:if
			test="${avgPriceOfEventThisYear > 0 || avgPriceOfEventPreviousYear > 0 || avgPriceOfEventMake2Year >0}">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<div>
							<spring:message code="dashboard.avgPriceOfEventThisYear"
								var="thisYear" />
							<spring:message code="dashboard.avgPriceOfEventPreviousYear"
								var="previousYear" />
							<spring:message code="dashboard.avgPriceOfEventMake2Year"
								var="makeTwoYear" />
							<div class="text-center">
								<h3>
									<spring:message code="dashboard.avgPriceOfEventIn3Years" />
								</h3>
								<canvas id="pie3" width="800" height="500"></canvas>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>

		<jstl:if
			test="${eventReportedThisMonth > 0 || eventReportedPreviousMonth > 0 || eventReportedMake2Month >0}">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<div>
							<spring:message code="dashboard.eventReportedThisMonth"
								var="thisMonth" />
							<spring:message code="dashboard.eventReportedPreviousMonth"
								var="previousMonth" />
							<spring:message code="dashboard.eventReportedMake2Month"
								var="makeTwoMonth" />


							<div class="text-center">
								<h3>
									<spring:message code="dashboard.eventReportedIn3Month" />
								</h3>
								<canvas id="pie4" width="800" height="500"></canvas>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>

		<jstl:if test="${routeWithMoreEvents.size() != 0 }">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">
						<h3 class="text-center">
							<spring:message code="dashboard.routeWithMoreEvents" />
						</h3>
						<div class="container">
							<div class="row col-md-12 ">
								<table class="table table-striped custab">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message
													code="dashboard.name" /></th>
											<th class="text-center"><spring:message
													code="dashboard.city" /></th>
											<th class="text-center"><spring:message
													code="dashboard.tourfriend" /></th>
											<th class="text-center"><spring:message
													code="dashboard.events" /></th>
										</tr>
									</thead>
									<jstl:forEach items="${routeWithMoreEvents}" var="r">
										<tr>
											<%!int count0 = 1;%>
											<td class="text-center"><%=count0%></td>
											<td class="text-center">${r.name}</td>
											<td class="text-center">${r.city}</td>
											<td class="text-center">${r.tourFriendCreator.firstName}
												${r.tourFriendCreator.lastName}</td>
											<td class="text-center">${r.events.size()}</td>
											<%
												count0++;
											%>
										</tr>
									</jstl:forEach>
									<%
										count0 = 1;
									%>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</jstl:if>

		<jstl:if test="${routeWithLessEvents.size() != 0 }">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<h3 class="text-center">
							<spring:message code="dashboard.routeWithLessEvents" />
						</h3>
						<div class="container">
							<div class="row col-md-12 ">
								<table class="table table-striped custab">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message
													code="dashboard.name" /></th>
											<th class="text-center"><spring:message
													code="dashboard.city" /></th>
											<th class="text-center"><spring:message
													code="dashboard.tourfriend" /></th>
											<th class="text-center"><spring:message
													code="dashboard.events" /></th>
										</tr>
									</thead>
									<jstl:forEach items="${routeWithLessEvents}" var="r">
										<tr>
											<%!int count = 1;%>
											<td class="text-center"><%=count%></td>
											<td class="text-center">${r.name}</td>
											<td class="text-center">${r.city}</td>
											<td class="text-center">${r.tourFriendCreator.firstName}
												${r.tourFriendCreator.lastName}</td>
											<td class="text-center">${r.events.size()}</td>
											<%
												count++;
											%>
										</tr>
									</jstl:forEach>
									<%
										count = 1;
									%>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>


		<jstl:if test="${routesHighestRated.size() != 0 }">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<h3 class="text-center">
							<spring:message code="dashboard.routesHighestRated" />
						</h3>
						<div class="container">
							<div class="row col-md-12 ">
								<table class="table table-striped custab">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message
													code="dashboard.name" /></th>
											<th class="text-center"><spring:message
													code="dashboard.rating" /></th>
										</tr>
									</thead>
									<jstl:forEach items="${routesHighestRated}" var="r">
										<tr>
											<%!int count1 = 1;%>
											<td class="text-center"><%=count1%></td>
											<td class="text-center">${r.get(0)}</td>
											<td class="text-center">${r.get(1)}</td>
											<%
												count1++;
											%>
										</tr>
									</jstl:forEach>
									<%
										count1 = 1;
									%>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>



		<jstl:if test="${routesLowestRated.size() != 0 }">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<h3 class="text-center">
							<spring:message code="dashboard.routesLowestRated" />
						</h3>
						<div class="container">
							<div class="row col-md-12 ">
								<table class="table table-striped custab">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message
													code="dashboard.name" /></th>
											<th class="text-center"><spring:message
													code="dashboard.rating" /></th>
										</tr>
									</thead>
									<jstl:forEach items="${routesLowestRated}" var="r">
										<tr>
											<%!int count2 = 1;%>
											<td class="text-center"><%=count2%></td>
											<td class="text-center">${r.get(0)}</td>
											<td class="text-center">${r.get(1)}</td>
											<%
												count2++;
											%>
										</tr>
									</jstl:forEach>
									<%
										count2 = 1;
									%>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>


		<jstl:if test="${routeThisMonth.size() != 0 }">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<h3 class="text-center">
							<spring:message code="dashboard.routeThisMonth" />
						</h3>
						<div class="container">
							<div class="row col-md-12 ">
								<table class="table table-striped custab">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message
													code="dashboard.name" /></th>
											<th class="text-center"><spring:message
													code="dashboard.events" /></th>
										</tr>
									</thead>
									<jstl:forEach items="${routeThisMonth}" var="r">
										<tr>
											<%!int count3 = 1;%>
											<td class="text-center"><%=count3%></td>
											<td class="text-center">${r.get(0)}</td>
											<td class="text-center">${r.get(1)}</td>
											<%
												count3++;
											%>
										</tr>
									</jstl:forEach>
									<%
										count3 = 1;
									%>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>

		<jstl:if test="${tourfriendsHighestRated.size() != 0 }">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<h3 class="text-center">
							<spring:message code="dashboard.tourfriendsHighestRated" />
						</h3>
						<div class="container">
							<div class="row col-md-12 ">
								<table class="table table-striped custab">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message
													code="dashboard.name" /></th>
											<th class="text-center"><spring:message
													code="dashboard.rating" /></th>
										</tr>
									</thead>
									<jstl:forEach items="${tourfriendsHighestRated}" var="r">
										<tr>
											<%!int count4 = 1;%>
											<td class="text-center"><%=count4%></td>
											<td class="text-center">${r.get(0)}</td>
											<td class="text-center">${r.get(1)}</td>
											<%
												count4++;
											%>
										</tr>
									</jstl:forEach>
									<%
										count4 = 1;
									%>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>

		<jstl:if test="${tourfriendsLowestRated.size() != 0 }">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<h3 class="text-center">
							<spring:message code="dashboard.tourfriendsLowestRated" />
						</h3>
						<div class="container">
							<div class="row col-md-12 ">
								<table class="table table-striped custab">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message
													code="dashboard.name" /></th>
											<th class="text-center"><spring:message
													code="dashboard.rating" /></th>
										</tr>
									</thead>
									<jstl:forEach items="${tourfriendsLowestRated}" var="r">
										<tr>
											<%!int count5 = 1;%>
											<td class="text-center"><%=count5%></td>
											<td class="text-center">${r.get(0)}</td>
											<td class="text-center">${r.get(1)}</td>
											<%
												count5++;
											%>
										</tr>
									</jstl:forEach>
									<%
										count5 = 1;
									%>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>

		<jstl:if test="${cityMoreBookings.size() != 0 }">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<h3 class="text-center">
							<spring:message code="dashboard.cityMoreBookings" />
						</h3>
						<div class="container">
							<div class="row col-md-12 ">
								<table class="table table-striped custab">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message
													code="dashboard.name" /></th>
											<th class="text-center"><spring:message
													code="dashboard.bookings" /></th>
										</tr>
									</thead>
									<jstl:forEach items="${cityMoreBookings}" var="r">
										<tr>
											<%!int count6 = 1;%>
											<td class="text-center"><%=count6%></td>
											<td class="text-center">${r.get(0)}</td>
											<td class="text-center">${r.get(1)}</td>
											<%
												count6++;
											%>
										</tr>
									</jstl:forEach>
									<%
										count6 = 1;
									%>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>


		<jstl:if test="${cityLessBookings.size() != 0 }">
			<div class="col-sm-8 col-md-offset-2">
				<div class="card">
					<div class="card-block">

						<h3 class="text-center">
							<spring:message code="dashboard.cityLessBookings" />
						</h3>
						<div class="container">
							<div class="row col-md-12 ">
								<table class="table table-striped custab">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message
													code="dashboard.name" /></th>
											<th class="text-center"><spring:message
													code="dashboard.bookings" /></th>
										</tr>
									</thead>
									<jstl:forEach items="${cityLessBookings}" var="r">
										<tr>
											<%!int count7 = 1;%>
											<td class="text-center"><%=count7%></td>
											<td class="text-center">${r.get(0)}</td>
											<td class="text-center">${r.get(1)}</td>
											<%
												count7++;
											%>
										</tr>
									</jstl:forEach>
									<%
										count7 = 1;
									%>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</jstl:if>

	</div>


</security:authorize>

<script>
		var drawPieChart = function(data, colors) {
			var canvas = document.getElementById('pie');
			var ctx = canvas.getContext('2d');
			var x = canvas.width / 2;
			y = canvas.height / 2;
			var color, startAngle, endAngle, total = getTotal(data);

			for (var i = 0; i < data.length; i++) {
				color = colors[i];
				startAngle = calculateStart(data, i, total);
				endAngle = calculateEnd(data, i, total);

				ctx.beginPath();
				ctx.fillStyle = color;
				ctx.moveTo(x, y);
				ctx.arc(x, y, y - 100, startAngle, endAngle);
				ctx.fill();
				ctx.rect(canvas.width - 200, y - i * 30, 12, 12);
				ctx.fill();
				ctx.font = "13px sans-serif";
				ctx.fillText(data[i].label + " - " + data[i].value + " ("
						+ calculatePercent(data[i].value, total) + "%)",
						canvas.width - 200 + 20, y - i * 30 + 10);
			}
		};

		var calculatePercent = function(value, total) {

			return (value / total * 100).toFixed(2);
		};

		var getTotal = function(data) {
			var sum = 0;
			for (var i = 0; i < data.length; i++) {
				sum += data[i].value;
			}

			return sum;
		};

		var calculateStart = function(data, index, total) {
			if (index === 0) {
				return 0;
			}

			return calculateEnd(data, index - 1, total);
		};

		var calculateEndAngle = function(data, index, total) {
			var angle = data[index].value / total * 360;
			var inc = (index === 0) ? 0 : calculateEndAngle(data, index - 1,
					total);

			return (angle + inc);
		};

		var calculateEnd = function(data, index, total){
			return degreeToRadians(calculateEndAngle(data, index, total));
		};

		var degreeToRadians = function(angle) {
			return angle * Math.PI / 180
		}

		var data = [ {
			label : '${thisMonth}',
			value : ${numBookingThisMonth}
		}, {
			label : '${previousMonth}',
			value : ${numBookingPreviousMonth}
		}, {
			label : '${makeTwoMonth}',
			value : ${numBookingMakeTwoMonth}
		} ];
		var colors = [ '#39CCCC', '#3D9970', '#001F3F', '#85144B' ];

		drawPieChart(data, colors);
		
		var drawPieChart = function(data, colors) {
			var canvas = document.getElementById('pie2');
			var ctx = canvas.getContext('2d');
			var x = canvas.width / 2;
			y = canvas.height / 2;
			var color, startAngle, endAngle, total = getTotal(data);

			for (var i = 0; i < data.length; i++) {
				color = colors[i];
				startAngle = calculateStart(data, i, total);
				endAngle = calculateEnd(data, i, total);

				ctx.beginPath();
				ctx.fillStyle = color;
				ctx.moveTo(x, y);
				ctx.arc(x, y, y - 100, startAngle, endAngle);
				ctx.fill();
				ctx.rect(canvas.width - 200, y - i * 30, 12, 12);
				ctx.fill();
				ctx.font = "13px sans-serif";
				ctx.fillText(data[i].label + " - " + data[i].value + " ("
						+ calculatePercent(data[i].value, total) + "%)",
						canvas.width - 200 + 20, y - i * 30 + 10);
			}
		};

		var calculatePercent = function(value, total) {

			return (value / total * 100).toFixed(2);
		};

		var getTotal = function(data) {
			var sum = 0;
			for (var i = 0; i < data.length; i++) {
				sum += data[i].value;
			}

			return sum;
		};

		var calculateStart = function(data, index, total) {
			if (index === 0) {
				return 0;
			}

			return calculateEnd(data, index - 1, total);
		};

		var calculateEndAngle = function(data, index, total) {
			var angle = data[index].value / total * 360;
			var inc = (index === 0) ? 0 : calculateEndAngle(data, index - 1,
					total);

			return (angle + inc);
		};

		var calculateEnd = function(data, index, total){
			return degreeToRadians(calculateEndAngle(data, index, total));
		};

		var degreeToRadians = function(angle) {
			return angle * Math.PI / 180
		};

		var data = [ {
			label : '${thisYear}',
			value : ${numBookingThisYear}
		}, {
			label : '${previousYear}',
			value : ${numBookingPreviousYear}
		}, {
			label : '${makeTwoYear}',
			value : ${numBookingMakeTwoYear}
		} ];
		var colors = [ '#39CCCC', '#3D9970', '#001F3F', '#85144B' ];

		drawPieChart(data, colors);
		
		var drawPieChart = function(data, colors) {
			var canvas = document.getElementById('pie3');
			var ctx = canvas.getContext('2d');
			var x = canvas.width / 2;
			y = canvas.height / 2;
			var color, startAngle, endAngle, total = getTotal(data);

			for (var i = 0; i < data.length; i++) {
				color = colors[i];
				startAngle = calculateStart(data, i, total);
				endAngle = calculateEnd(data, i, total);

				ctx.beginPath();
				ctx.fillStyle = color;
				ctx.moveTo(x, y);
				ctx.arc(x, y, y - 100, startAngle, endAngle);
				ctx.fill();
				ctx.rect(canvas.width - 200, y - i * 30, 12, 12);
				ctx.fill();
				ctx.font = "13px sans-serif";
				ctx.fillText(data[i].label + " - " + data[i].value + " ("
						+ calculatePercent(data[i].value, total) + "%)",
						canvas.width - 200 + 20, y - i * 30 + 10);
			}
		};

		var calculatePercent = function(value, total) {

			return (value / total * 100).toFixed(2);
		};

		var getTotal = function(data) {
			var sum = 0;
			for (var i = 0; i < data.length; i++) {
				sum += data[i].value;
			}

			return sum;
		};

		var calculateStart = function(data, index, total) {
			if (index === 0) {
				return 0;
			}

			return calculateEnd(data, index - 1, total);
		};

		var calculateEndAngle = function(data, index, total) {
			var angle = data[index].value / total * 360;
			var inc = (index === 0) ? 0 : calculateEndAngle(data, index - 1,
					total);

			return (angle + inc);
		};

		var calculateEnd = function(data, index, total){
			return degreeToRadians(calculateEndAngle(data, index, total));
		};

		var degreeToRadians = function(angle) {
			return angle * Math.PI / 180
		};

		var data = [ {
			label : '${thisYear}',
			value : ${avgPriceOfEventThisYear}
		}, {
			label : '${previousYear}',
			value : ${avgPriceOfEventPreviousYear}
		}, {
			label : '${makeTwoYear}',
			value : ${avgPriceOfEventMake2Year}
		} ];
		var colors = [ '#39CCCC', '#3D9970', '#001F3F', '#85144B' ];

		drawPieChart(data, colors);
		
		var drawPieChart = function(data, colors) {
			var canvas = document.getElementById('pie4');
			var ctx = canvas.getContext('2d');
			var x = canvas.width / 2;
			y = canvas.height / 2;
			var color, startAngle, endAngle, total = getTotal(data);

			for (var i = 0; i < data.length; i++) {
				color = colors[i];
				startAngle = calculateStart(data, i, total);
				endAngle = calculateEnd(data, i, total);

				ctx.beginPath();
				ctx.fillStyle = color;
				ctx.moveTo(x, y);
				ctx.arc(x, y, y - 100, startAngle, endAngle);
				ctx.fill();
				ctx.rect(canvas.width - 200, y - i * 30, 12, 12);
				ctx.fill();
				ctx.font = "13px sans-serif";
				ctx.fillText(data[i].label + " - " + data[i].value + " ("
						+ calculatePercent(data[i].value, total) + "%)",
						canvas.width - 200 + 20, y - i * 30 + 10);
			}
		};

		var calculatePercent = function(value, total) {

			return (value / total * 100).toFixed(2);
		};

		var getTotal = function(data) {
			var sum = 0;
			for (var i = 0; i < data.length; i++) {
				sum += data[i].value;
			}

			return sum;
		};

		var calculateStart = function(data, index, total) {
			if (index === 0) {
				return 0;
			}

			return calculateEnd(data, index - 1, total);
		};

		var calculateEndAngle = function(data, index, total) {
			var angle = data[index].value / total * 360;
			var inc = (index === 0) ? 0 : calculateEndAngle(data, index - 1,
					total);

			return (angle + inc);
		};

		var calculateEnd = function(data, index, total){
			return degreeToRadians(calculateEndAngle(data, index, total));
		};

		var degreeToRadians = function(angle) {
			return angle * Math.PI / 180
		};

		var data = [ {
			label : '${thisMonth}',
			value : ${eventReportedThisMonth}
		}, {
			label : '${previousMonth}',
			value : ${eventReportedPreviousMonth}
		}, {
			label : '${makeTwoMonth}',
			value : ${eventReportedMake2Month}
		} ];
		var colors = [ '#39CCCC', '#3D9970', '#001F3F', '#85144B' ];

		drawPieChart(data, colors);
	</script>

