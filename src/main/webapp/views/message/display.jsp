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

<div id="container">
	<div class="col-md-12">
		<div class="card card-container">
			<div class="row">
				<div class="col-md-12">
					<div class="cruz">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">
					<jstl:out value="${displayedMessage.subject}" />
					<hr>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<p>
						<strong><spring:message code="message.sender" />:</strong>
						${displayedMessage.senderActor.userAccount.username}
					</p>
				</div>
				<div class="col-md-12">
					<p>
						<strong><spring:message code="message.recipient" />:</strong>
						${displayedMessage.recipientActor.userAccount.username}
					</p>
				</div>
				<div class="col-md-12">
					<p>
						<strong><spring:message code="message.sentMoment" />:</strong>
						<fmt:formatDate pattern="dd-MM-yyyy HH:mm"
							value="${displayedMessage.sentMoment}" />
					</p>
				</div>
				<div class="col-md-12">

					<strong><spring:message code="message.body" />:</strong>
					<jstl:out value="${displayedMessage.body}" />
				</div>
			</div>
		</div>
	</div>

</div>

