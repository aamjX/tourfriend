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

<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCnpBhHuVjijtDEVMw-zSGWID4btWRQey4&v=3.exp&sensor=false&libraries=places"></script>

<script>
	function initialize() {

		var input = document.getElementById('meetingPoint');
		var autocomplete = new google.maps.places.Autocomplete(input);
	}

	google.maps.event.addDomListener(window, 'load', initialize);
</script>

<security:authorize access="hasRole('TOURFRIEND')">

	<div class="section-mini-padding">
		<h2>
			<i class="fa fa-server"></i> -
			<spring:message code="event.title" />
		</h2>
	</div>

	<div class="container">

		<jstl:if test="${minMaxError}">
			<div class="alert alert-danger alert-dismissible" role="alert">
				<spring:message code="event.error.minmax" />
			</div>
			<br />
		</jstl:if>

		<div class="row section-content-padding">
			<div class="well bs-component">
				<div class="row">
					<div class="col-md-12">
						<form:form action="event/edit.do" modelAttribute="event"
							method="post">
							<div class="row text-center">
								<div class="col-md-12">
									<p
										style="font-family: font-family : 'Lato', sans-serif; font-size: 25px">
										<spring:message code="event.manage" />
									</p>
									<hr>
								</div>
							</div>

							<form:hidden path="id" />
							<form:hidden path="version" />
							<form:hidden path="isCancelled" />
							<form:hidden path="cancelledMoment" />
							<form:hidden path="commentEvents" />
							<form:hidden path="bookings" />
							<form:hidden path="tourFriend" />
							<jstl:if test="${event.id!=0}">
								<form:hidden path="route" />
							</jstl:if>
							<div class="col-md-2"></div>
							<div class="col-md-8">
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<acme:textbox code="event.name" path="name"
												css="form-control" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-4">
										<div class="form-group">
											<acme:textbox type="number" step="0.1"
												code="event.edit.price" path="price" css="form-control" />
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<acme:textbox type="number" code="event.minPeople"
												path="minPeople" css="form-control" min="1"/>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<acme:textbox type="number" code="event.maxPeople"
												path="maxPeople" css="form-control" min="1"/>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<spring:message code="event.search.meetingPoint"
												var="messageSearchMeetingPoint" />
											<acme:textbox code="event.meetingPoint" path="meetingPoint"
												css="form-control" id="meetingPoint"
												placeholder="${messageSearchMeetingPoint}" />
										</div>
									</div>
								</div>

								<jstl:if test="${event.id==0}">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<acme:select items="${routes}" itemLabel="name"
													code="event.route" path="route" css="form-control" />
											</div>
										</div>
									</div>
								</jstl:if>
								<div class="row">
									<div class="col-md-7">
										<div class="form-group">
											<label for="date"><spring:message
													code="event.search.date" /></label>
											<div class='input-group date' id='datetimepicker2'>
												<acme:textbox onblur="myFunction(this.value)" path="date" type='text' css="form-control"
													name="date" id="date" />
												<span class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
											<div id="error_date" style="visibility: hidden">
												<p style='color: red'><spring:message code="event.date.info" /></p>
											</div>
										</div>

									</div>
									<div class="col-md-5">
										<div class="form-group">
											<acme:textbox type="number" step="0.1"
												code="event.edit.duration" path="duration"
												css="form-control" min="0.5"/>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<acme:textarea code="event.overview" path="overview"
												css="form-control" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<acme:textarea code="event.thingsToNote" path="thingsToNote"
												css="form-control" />
										</div>
									</div>
								</div>
								<div class="row text-center">
									<div class="col-md-12">
										<div class="form-group">
											<button type="submit" name="save" id="buttonSubmit"
												class="btn btn-raised btn-primary">
												<spring:message code="event.save" />
												- <i class="fa fa-check-square-o"></i>
											</button>
											<a href="event/myEvents.do"
												class="btn btn-raised btn btn-default" id="delete-button">
												<i class="fa fa-reply"></i> - <spring:message
													code="event.back" />
											</a>

										</div>
									</div>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>

</security:authorize>

<script>
	function myFunction(Fecha) {
		var today = new Date();
        var str = Fecha;
        var res = str.split("/");
        var day = res[0];
        var month = res[1];
        var yearDayHour = res[2];
        var fechaFormateada = month + "/" + day + "/" + yearDayHour;

		var date = new Date(fechaFormateada);

		if(today < date) {
            document.getElementById("error_date").style.visibility = "hidden";
            document.getElementById("buttonSubmit").disabled = false;
		} else {
            document.getElementById("error_date").style.visibility = "visible";
            document.getElementById("buttonSubmit").disabled = true;
		}
		
	}
</script>
