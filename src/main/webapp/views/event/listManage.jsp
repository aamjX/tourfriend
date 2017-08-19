<%@page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
		  uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="year" value="${now}" />
<security:authorize access="hasRole('TOURFRIEND')">

	<div class="section-mini-padding">
		<h2>
			<i class="fa fa-server"></i> -
			<spring:message code="event.title" />
		</h2>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1"></div>
			<jstl:if test="${param['errorMessage']}">
				<acme:mensajeWarning messageText="${param['message']}" />
			</jstl:if>
		</div>

		<div class="row">

			<div class="col-md-10 col-md-offset-1 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1">
				<a href="event/create.do" class="btn btn-default mano" id="reply-button" style="margin-top:10px;width:100%;font-size: 20px;padding-bottom: 40px;padding-top: 10px;"><i class="fa fa-plus-circle"></i> <spring:message code="event.create.new" /></a>
			</div>

			<jstl:if test="${!events.isEmpty()}">
				<jstl:forEach items="${events}" var="e">
					<div class="col-md-10 col-md-offset-1 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1" style="margin-top:10px;border: 5px solid #fff;">
						<div class="carousel-row">
							<div class="myEvent">

								<!-- Date and status -->
								<jstl:if test="${!e.isCancelled && e.date gt now}">
									<div class="col-md-3" style="background-color: #d9edf7; color: #31708f">
										<!-- Indicators -->
										<ol class="carousel-indicators">
										</ol>

										<!-- Wrapper for slides -->
										<div class="carousel-inner text-center">
											<div class="item active">
												<!--  fa fa-times fa fa-refresh-->
												<i class="fa fa-clock-o"
												   style="font-size: 100px"></i><br><p>
												<i class="fa fa-calendar"></i>&nbsp;&nbsp;<fmt:formatDate value="${e.date}" pattern="dd/MM/yyyy" />
												<fmt:formatDate value="${e.date}" pattern="HH:mm" /></p>
												<h4><spring:message code="event.message.waiting"/></h4>
											</div>
										</div>
									</div>
								</jstl:if>

								<jstl:if test="${!e.isCancelled && e.date lt now}">
									<div class="col-md-3" style="background-color: #dff0d8; color: #3c763d">
										<!-- Indicators -->
										<ol class="carousel-indicators">
										</ol>
										<!-- Wrapper for slides -->
										<div class="carousel-inner text-center">
											<div class="item active">
												<!--  fa fa-times fa fa-refresh-->
												<i class="fa fa-check-square-o" style="font-size: 100px"></i><br><p>
												<i class="fa fa-calendar"></i>&nbsp;&nbsp;<fmt:formatDate value="${e.date}" pattern="dd/MM/yyyy" />
												<fmt:formatDate value="${e.date}" pattern="HH:mm" /></p>
												<h4 style="color: #5cb85c"><spring:message code="event.message.done"/></h4>
											</div>
										</div>
									</div>
								</jstl:if>

								<jstl:if test="${e.isCancelled}">
									<div class="col-md-3" style="background-color: #f2dede; color: #a94442">
										<!-- Indicators -->
										<ol class="carousel-indicators">
										</ol>
										<!-- Wrapper for slides -->
										<div class="carousel-inner text-center">
											<div class="item active">
												<!--  fa fa-times fa fa-refresh-->
												<i class="fa fa-times"
												   style="font-size: 100px"></i><br>
												<p>
													<i class="fa fa-calendar"></i>&nbsp;&nbsp;<fmt:formatDate value="${e.date}" pattern="dd/MM/yyyy" />
													<fmt:formatDate value="${e.date}" pattern="HH:mm" /></p>
												<h4><spring:message code="event.message.cancelled"/></h4>
											</div>
										</div>
									</div>
								</jstl:if>

								<!-- Name and overview of the event -->
								<div class="col-md-6">
									<h4>${e.name}</h4>
									<p>${e.overview}</p>
								</div>

								<!-- Buttons -->
								<div class="col-md-3 text-center">

									<a style="cursor: pointer;" href="event/detailsOfEvent.do?eventId=${e.id}"
									   class="btn btn-default"> <i class="fa fa-fw fa-eye"></i> <spring:message code="event.show" /></a>

									<jstl:if test="${!e.isCancelled}">

										<jstl:if test="${requestURI == 'event/myEvents.do' && e.bookings.isEmpty() && e.date > now}">
											<a style="cursor: pointer;" id="reply-button"
											   class="btn btn-raised btn-warning"
											   href="event/edit.do?id=${e.id}"><i
													class="fa fa-edit"></i> <spring:message code="event.edit" /></a>

											<a style="cursor: pointer;" id="delete-button"
											   class="btn btn-raised btn-danger"
											   data-href="event/delete.do?id=${e.id}" data-toggle="modal"
											   data-target="#confirm-delete"> <i
													class="fa fa-exclamation-triangle"></i> <spring:message
													code="event.delete" />
											</a>
										</jstl:if>

										<jstl:if test="${requestURI == 'event/myEvents.do' && e.date > now}">
										<a style="cursor: pointer;"
												class="btn btn-raised btn-warning"
												data-href="event/cancel.do?id=${e.id}" data-toggle="modal"
												data-target="#confirm-cancel">
											<i class="fa fa-remove"></i>
											<spring:message code="event.cancel" />
										</a>
										</jstl:if>
									</jstl:if>
								</div>
							</div>
						</div>
					</div>

				</jstl:forEach>
			</jstl:if>
		</div>
	</div>

	<div class="modal fade" id="confirm-delete" tabindex="-1"
		 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<spring:message code="event.delete.confirm" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<a href="javascript:void(0)" class="btn btn-danger btn-ok">Delete</a>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="confirm-cancel" tabindex="-1"
		 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<spring:message code="event.cancel.confirm" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
					<a href="javascript:void(0)" class="btn btn-danger btn-ok">Yes</a>
				</div>
			</div>
		</div>
	</div>


	<!-- EditModal -->
	<div class="modal fade" id="editModal" role="dialog">
		<div id="editModalinject" class="modal-dialog">
			<!--  Se inyecta el model del login.jsp -->
		</div>
	</div>
	</div>

	<script>
        function addurl(url){
            $( "#editModalinject" ).load(url+" #container");
        }

        $('#confirm-delete').on('show.bs.modal', function(e) {
            $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
        });

        $('#confirm-cancel').on('show.bs.modal', function(e) {
            $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
        });
	</script>

</security:authorize>
