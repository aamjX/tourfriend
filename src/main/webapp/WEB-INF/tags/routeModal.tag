<%@ tag language="java" body-content="empty" %>

<%-- Taglibs --%>

<%@ taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags" %>

<security:authorize access="hasRole('TOURFRIEND')">
	<form:form action="route/step-1.do" modelAttribute="route" id="form"
			   method="post">
		<script
				src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCnpBhHuVjijtDEVMw-zSGWID4btWRQey4&v=3.exp&sensor=false&libraries=places"></script>
		<script>
            function initialize() {

                var input = document.getElementById('searchTextField');
                var autocomplete = new google.maps.places.Autocomplete(input);
            }
            var options = {
                types: ['(cities)'],
                componentRestrictions: {country: 'ES'}};

            google.maps.event.addDomListener(window, 'load', initialize,options);

		</script>

		<script>
            window.onload = function() {
                $("#squarespaceModal").modal()
            };
		</script>

		<form:hidden path="id" />
		<form:hidden path="version" />
		<form:hidden path="tourFriendCreator" />
		<form:hidden path="events" />
		<form:hidden path="favouriteTourFriends" />
		<form:hidden path="pois" />
		<form:hidden path="categories" />





		<div class="modal fade" id="squarespaceModal" tabindex="-1"
			 role="dialog" aria-labelledby="modalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h3 class="modal-title" id="lineModalLabel"><spring:message code="route.new" /></h3>

						<jstl:if test="${showDanger}">
							<acme:mensajeDanger messageText="${danger_msg}"/>
						</jstl:if>


					</div>
					<div class="modal-body">

						<!-- content goes here -->
						<div class="row">
							<div class="col-md-12">
								<form>
									<div class="form-group">
										<spring:message code="route.name.input" var="inputname" />
										<acme:textbox code="route.name" path="name"
													  css="form-control" placeholder="${inputname}" />
									</div>
									<div class="form-group">
									 	<spring:message code="route.description.input" var="inputdescription" />
										<acme:textarea code="route.description" path="description"
													   css="form-control reportArea" placeholder="${inputdescription}" />
									</div>
									<div class="form-group">
										<spring:message code="route.insert.city" var="messageInsertCity"/>
										<acme:textbox id="searchTextField" code="route.city"
													  path="city" css="form-control" placeholder="${messageInsertCity}"/>
									</div>
									<input type="hidden" value="true" name="step2" />

								</form>

							</div>

						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group btn-group-justified" role="group"
							 aria-label="group button">
							<div class="btn-group" role="group">
								<a href="poi/cancel.do" class="btn btn-default mano" id="delete-button"><i class="fa fa-times" aria-hidden="true"></i> <spring:message code="poi.cancel" /></a>
							</div>
							<div class="btn-group" role="group">
								<button type="submit" name="save"
										class="btn btn-default mano" id="green-button">
									<spring:message code="route.save" /> <i class="fa fa-arrow-right" aria-hidden="true"></i>
								</button>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form:form>
</security:authorize>