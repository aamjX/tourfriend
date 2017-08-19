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

<div class="section-mini-padding">
	<h2>
		<i class="fa fa-server"></i> -
		<spring:message code="event.title" />
	</h2>
</div>

<div class="container">
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<jstl:choose>
				<jstl:when test="${itsOk==true}">
					<div class="alert alert-success" style="margin-top: 80px;">
						<spring:message code="event.enterCodeOk" />
					</div>
					<br />
				</jstl:when>
				<jstl:otherwise>
					<div class="alert alert-danger" style="margin-top: 80px;">
						<spring:message code="event.enterCodeNotOk" />
					</div>
					<br />
				</jstl:otherwise>
			</jstl:choose>
		</div>
		<div class="col-md-2"></div>
	</div>

	<div class="row">
		<div class="col-md-12 text-center">
			<a href="event/detailsOfEvent.do?eventId=${eventId}"
				class="btn btn-default"> <spring:message
					code="event.confirmation" />
			</a>
		</div>
	</div>

</div>


