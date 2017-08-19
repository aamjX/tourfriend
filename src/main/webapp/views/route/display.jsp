<%@page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
		  uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCnpBhHuVjijtDEVMw-zSGWID4btWRQey4&v=3.exp&sensor=false&libraries=places"></script>

<script>
    function initialize() {

        var input = document.getElementById('city');
        var autocomplete = new google.maps.places.Autocomplete(
            input);
    }

    google.maps.event.addDomListener(window, 'load', initialize);
</script>

<div class="section-mini-padding">
	<h2>
		<i class="fa fa-road" aria-hidden="true"></i> - <spring:message code="routeDetails" />
	</h2>
</div>

<div class="container">
	<div class="row" style="margin-top: 10px;">
		<div class="col-md-8">
			<div class="container">
			<h3>
				${route.name} <small> ${route.city}</small>
			</h3>

			<p>
				<i>${route.description}</i>
			</p>

			<h4><spring:message code="route.categories"/></h4>
			<jstl:forEach var="cat" items='${route.categories}' >
					<jstl:out value="${cat.name}"/>
			</jstl:forEach>


			<h4><spring:message code="route.pois"/></h4>

			<jstl:forEach var="poi" items='${route.pois}' >
				<p><b><jstl:out value="${poi.name}"/></b>
					<small><jstl:out value="${poi.place}"/></small></p>
			</jstl:forEach>
			</div>
		</div><!--/. col-md -->

		<div class="col-md-4 text-center">
			<!-- item -->
			<div class="panel-pricing">
				<div class="panel-heading">
					<img class="photoBig" src="data:image/jpeg;base64,${route.tourFriendCreator.image}"><br>
					${route.tourFriendCreator.firstName} ${route.tourFriendCreator.lastName}
					<jstl:if test="${route.tourFriendCreator.rating != 'NaN'}">
						<acme:ratingStars stars="${route.tourFriendCreator.rating}"/>
					</jstl:if>
				</div>
			</div>

			<jstl:if
					test="${route.events.isEmpty()}">
				<a style="width:100%;margin-top:5px;" class="mano btn btn-default" id="reply-button"
				   onclick="addurl('route/edit.do?id='+${route.id})"
				   data-toggle="modal" data-target="#editModal"><spring:message
						code="route.edit" /></a>
			</jstl:if>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col-md-12">
			<div id="slider">
				<a href="javascript:void(0)" class="control_next">></a> <a
					href="javascript:void(0)" class="control_prev"><</a>
				<ul>
					<jstl:forEach var="p" items="${route.pois}">
						<jstl:forEach var="i" items="${p.photos}">
							<li><img style="height:300px;" src="data:image/jpeg;base64,${i}" /></li>
						</jstl:forEach>
					</jstl:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="mini-section-mini-padding">
	<h3>
		<i class="fa fa-server" aria-hidden="true"></i> - <spring:message code="route.events" />
	</h3>
</div>

<div class="container">
	<div class="row text-center">
		<jstl:forEach var="event" items='${route.events}' >
			<div class="event-list col-md-8 col-md-offset-2 mano" onclick="window.location='event/detailsOfEvent.do?eventId=${event.id}'">
				<i class="fa fa-calendar" aria-hidden="true"></i> - <jstl:out value="${event.name}"/></small> / <fmt:formatDate value="${event.date}" pattern="dd-MM-yyyy HH:mm:ss"/>
			</div>
		</jstl:forEach>
	</div>
</div>

<div class="container">
	<!-- CreateMessageModal -->
	<div class="modal fade" id="createModal" role="dialog">
		<div id="createModalinject" class="modal-dialog">
			<!--  Se inyecta el model del edit.jsp -->
		</div>
	</div>
	<!-- EditModal -->
	<div class="modal fade" id="editModal" role="dialog">
		<div id="editModalinject" class="modal-dialog">
			<!--  Se inyecta el model del login.jsp -->
			<form:form class="form-signin" action="route/editRoute.do?id=${route.id}"
					   modelAttribute="routeEditForm">
				<div class="card card-container" style="padding: 20px 20px !important;">
					<h3 class="text-center"><spring:message code="route.edit" /></h3>
					<hr>
					<jstl:if test="${showErrorLogin == true && showMessage == true}">
						<div class="alert alert-danger alert-dismissible" role="alert">
							<spring:message code="route.commit.error" />
						</div>
						<br />
					</jstl:if>
					<spring:message code="route.name" var="name" />
					<form:label path="name">
						<spring:message code="route.name" />:
					</form:label>
					<form:input path="name" class="form-control "
								autofocus="autofocus" placeholder="${name}" required="required" />
					<form:errors class="error" path="name" />

					<br />

					<spring:message code="route.description" var="description" />
					<form:label path="description">
						<spring:message code="route.description" />:
					</form:label>
					<form:textarea path="description" rows="7" cols="5" class="form-control "
								   placeholder="${description}" required="required"/>
					<form:errors class="error" path="description" />

					<br />

					<spring:message code="route.city" var="city" />
					<form:label path="city">
						<spring:message code="route.city" />:
					</form:label>
					<form:input path="city" class="form-control "
								placeholder="${city}" id="city" required="required"/>
					<form:errors class="error" path="city" />
					<br />
					<acme:submit name="save" code="route.edit.accept"
								 css="btn btn-default mano" css_id="green-button"/>
				</div>
			</form:form>
		</div>
	</div>
</div>

<script>
    function create(url){
        $( "#createModalinject" ).load(url + " #container");
    }
    function myFunction(id) {

        element = document.getElementById("Id"+id);
        elements = document.getElementsByClassName("photo");
        [].forEach.call(elements, function(el) {
            el.classList.remove("photoActive");
        });
        element.classList.add("photoActive");

    }
    function removeFocus(element){
        setTimeout(function(){ element.classList.remove("photoActive") }, 800);
    }
    function assingBubbles(id) {
        $('#Id'+id).bubbletip($('#tip'+id),{deltaDirection:'down', bindShow:'click'});

    }
</script>
