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
<%@taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<script>
	window.onload = function() {
		$("#squarespaceModal").modal()
	};
</script>
<div id="container">
	<form:form action="message/actor/create.do"
		modelAttribute="messageToEdit">
		<div class="card card-container">
			<div class="text-center">
				<h2><spring:message code="message.create" /></h2><br><br>
			</div>

			<jstl:if test="${sendError == true}">
				<div class="alert alert-danger alert-dismissible" role="alert">
					<spring:message code="message.maxMessages.error" />
				</div>
				<br />
			</jstl:if>
			<form:hidden path="id" />
			<form:hidden path="version" />
			<form:hidden path="senderActor" />
			<form:hidden path="recipientActor" />
			<form:hidden path="sentMoment" />
			<form:hidden path="isRead" />
			<form:hidden path="isRecipientCopy" />

			<div class="form-group">
				<acme:textarea code="message.subject" path="subject" cols="43"
					rows="2" required="required" css="form-control" />
			</div>
			<div class="form-group">
				<acme:textarea code="message.body" path="body" cols="43" rows="2"
					required="required" css="form-control"/>
			</div>
			<br />
			<div class="text-center">
				<acme:submit name="save" code="message.save" css="btn btn-primary mano"/>
			</div>
		</div>
	</form:form>
</div>