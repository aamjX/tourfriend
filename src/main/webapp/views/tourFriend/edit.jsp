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



<security:authorize access="hasRole('TOURFRIEND')">
	<div id="container">
		<div class="modal-content">
			<div class="modal-body">

				<spring:message code="tourFriend.email" var="emailm" />
				<spring:message code="tourFriend.phone" var="phonem" />
				<spring:message code="tourfriend.profile.aboutme" var="aboutmem" />


				<div class="row">
					<div
						class="col-xs-12 col-sm-6 col-md-10 col-sm-offset-2 col-md-offset-1">
						<form:form role="form" action="profile/edit.do"
							modelAttribute="tourFriend">
							<form:hidden path="id" />
							<form:hidden path="version" />

							<hr class="colorgraph">

							<div class="row">

								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="form-group">
										<acme:textbox code="tourFriend.phone" path="phone"
											css="form-control input-lg" placeholder="${phonem }"
											required="required" />
									</div>
								</div>

								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="form-group">
										<acme:textbox code="tourFriend.email" path="email"
											type="email" css="form-control input-lg"
											placeholder="${emailm }" required="required" />

									</div>
								</div>
							</div>


							<div class="form-group">
								<acme:textarea code="tourfriend.profile.aboutme" path="aboutMe"
									css="form-control input-lg" placeholder="${aboutmem}" />

							</div>



							<hr class="colorgraph">
							<div class="row">

								<acme:submit name="save" code="tourFriend.save"
									css="btn btn-primary" />

							</div>




						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>

</security:authorize>



