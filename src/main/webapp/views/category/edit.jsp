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

<security:authorize access="hasRole('TOURFRIEND')">

	<jstl:if test="${showInfo}">
		<acme:mensajeInfo messageText="${info_msg}" />
	</jstl:if>
	<jstl:if test="${showSuccess }">
		<acme:mensajeSuccess messageText="${success_msg}" />
	</jstl:if>
	<jstl:if test="${showWarning}">
		<acme:mensajeWarning messageText="${warning_msg}" />
	</jstl:if>
	<jstl:if test="${showDanger}">
		<acme:mensajeDanger messageText="${danger_msg}" />
	</jstl:if>
	
	
	
	
	
	
	<form:form action="category/editNew.do" modelAttribute="category" id="form"
		method="post">
	
			<script>
				window.onload = function() {
					$("#squarespaceModal").modal()
				};
			</script>

			<form:hidden path="id" />
			<form:hidden path="version" />
			<form:hidden path="routes" />

			
			


			<div class="modal fade" id="squarespaceModal" tabindex="-1"
				role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span><span class="sr-only">Close</span>
							</button>
							<h3 class="modal-title" id="lineModalLabel">Search a Category or create a new Category</h3>
						</div>
						<div class="modal-body">

							<!-- content goes here -->
							<div class="row">
								<div class="col-md-12">
									<form>
										<div class="form-group">
										<acme:textbox code="category.name" path="name"
											css="form-control" />
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<div class="btn-group btn-group-justified" role="group"
								aria-label="group button">
								<div class="btn-group" role="group">
									<button type="button" class="btn btn-default"
										data-dismiss="modal" role="button">Close</button>
								</div>
								<div class="btn-group btn-delete hidden" role="group">
									<button type="button" id="delImage"
										class="btn btn-default btn-hover-red" data-dismiss="modal"
										role="button">Delete</button>
								</div>
								<div class="btn-group" role="group">
									<button type="submit" name="save"
										class="btn btn-default btn-hover-green">
										<spring:message code="category.save" />
									</button>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</form:form>
</security:authorize>