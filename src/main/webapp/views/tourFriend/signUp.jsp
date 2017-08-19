<%--
 * action-1.jsp
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

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

<script src="https://www.google.com/recaptcha/api.js">

function edad(Fecha) {

	var str = Fecha;
	var res = str.split("/");
	var day = res[0];
	var month = res[1] - 1;
	var year = res[2];

	cumpleanos = new Date(year, month, day);
	hoy = new Date()

	var ed = hoy.getFullYear() - cumpleanos.getFullYear();
	var m = hoy.getMonth() - cumpleanos.getMonth();

	if (m < 0 || (m === 0 && hoy.getDate() < cumpleanos.getDate())) {
		ed--;
	}
	if (ed < 18) {
		document.getElementById('errorDate').value = '<spring:message code="tourfriend.age"/>';
		document.getElementById("reply-button1").disabled = true;
	} else {
		document.getElementById('errorDate').value = "";
		document.getElementById("reply-button1").disabled = false;
	}
}

</script>

<style>
#errorDate {
	font-size: 11px;
	color: red;
	background-color: #FFFFFF;
	border-width: 0;
}
</style>

<div id="container">
	<spring:message code="tourFriend.firstName" var="firstNamem" />
	<spring:message code="tourFriend.lastName" var="lastNamem" />
	<spring:message code="tourFriend.email" var="emailm" />
	<spring:message code="tourFriend.phone" var="phonem" />
	<spring:message code="tourFriend.dateOfBirth" var="dateOfBirthm" />
	<spring:message code="tourFriend.username" var="usernamem" />
	<spring:message code="tourFriend.password1" var="pass1" />
	<spring:message code="tourFriend.password2" var="pass2" />
	<spring:message code="tourFriend.signUp" var="signUpm" />
	<spring:message code="tourfriend.iAgree" var="iAgreem" />
	<spring:message code="tourFriend.acceptation" var="txt" />
	<spring:message code="tourFriend.acceptation1" var="txt1" />
	<spring:message code="tourFriend.acceptation2" var="txt2" />
	<spring:message code="tourFriend.acceptation3" var="txt3" />




	<div class="modal-content">
		<div class="modal-body">
			<div class="row">
				<div
					class="col-xs-12 col-sm-6 col-md-10 col-sm-offset-2 col-md-offset-1">
					<form:form role="form" action="tourFriend/signUp.do"
						modelAttribute="tourFriendRegisterForm">
						<h2 class="text-center">${signUpm}</h2>
						<jstl:if test="${showError == true}">
							<div class="alert alert-danger alert-dismissible" role="alert">
								<spring:message code="${message}" />
							</div>
							<br />
						</jstl:if>
						<hr class="colorgraph">
						<div class="row">
							<div class="col-xs-12 col-sm-6 col-md-6">
								<div class="form-group">
									<acme:textbox code="tourFriend.firstName" path="firstName"
										css="form-control input-lg" autofocus="autofocus"
										placeholder="${firstNamem }" required="required" />

								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-6">
								<div class="form-group">
									<acme:textbox code="tourFriend.lastName" path="lastName"
										css="form-control input-lg" placeholder="${lastNamem}"
										required="required" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12 col-sm-6 col-md-6">
								<div class="form-group">
									<label><spring:message code="tourFriend.dateOfBirth" />:</label>
									<div class='input-group date' id='datetimepickerRegister'>
										<acme:textbox path="dateOfBirth" css="form-control input-lg"
											placeholder="${dateOfBirthm }" required="required"
											pattern="(0[1-9]|1[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/[0-9]{4}"
											onblur="edad(this.value)" />
										<span class="input-group-addon"> <span
											class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
									<input type="text" readonly="readonly" name="errorDate" id="errorDate" />
							</div>

							</div>
							<div class="col-xs-12 col-sm-6 col-md-6">
								<div class="form-group">
									<acme:textbox code="tourFriend.phone" path="phone"
										css="form-control input-lg" placeholder="${phonem }"
										required="required" />
								</div>
							</div>
						</div>

						<div class="form-group">
							<acme:textbox code="tourFriend.email" path="email" type="email"
								css="form-control input-lg" placeholder="${emailm }"
								required="required" />
						</div>
						<div class="form-group">
							<acme:textbox code="tourFriend.username" path="username"
								required="required" maxlength="32" minlength="5"
								css="form-control input-lg" placeholder="${usernamem }" />
						</div>
						<div class="row">
							<div class="col-xs-12 col-sm-6 col-md-6">
								<div class="form-group">
									<acme:password code="tourFriend.password1" path="password1"
										name="password1" required="required" maxlength="32"
										minlength="5" css="form-control input-lg"
										placeholder="${pass1 }" />
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-6">
								<div class="form-group">
									<acme:password code="tourFriend.password2" path="password2"
										name="password1" required="required" maxlength="32"
										minlength="5" css="form-control input-lg"
										placeholder="${pass2 }" />
								</div>
							</div>
						</div>


						<div class="row">
							<div class="col-md-8 col-centered">
								<div class="form-groupCaptcha">
									<div class="g-recaptcha"
										data-sitekey="6LfOJBgUAAAAAEzNuB4eSgwJKMh9z9akFP-02Atj"></div>
								</div>
								<br>
							</div>
						</div>

						<div class="row">
							<div class="col-xs-4 col-sm-3 col-md-3">
								<span class="button-checkbox">
									<button type="button" class="btn" data-color="info">${iAgreem}</button>
									<acme:checkbox css="hidden" value="false"
										path="termsAndConditions" />
								</span>
							</div>
							<div class="col-xs-8 col-sm-9 col-md-9">
								${txt} <strong class="label label-primary">${signUpm}</strong>,
								${txt1} <a target="_blank" href="welcome/termsAndConditions.do">${txt2}</a>
								${txt3}
							</div>
						</div>

						<hr class="colorgraph">
						<div class="row">
							<div class="col-xs-12 col-md-6">
								<acme:submit name="save" code="tourFriend.signUp"
									disabled="false" css="btn btn-default mano"
									css_id="reply-button1" style="width:100%" />
							</div>
							<div class="col-xs-12 col-md-6">
								<a data-target="#loginModal" data-dismiss="modal"
									data-toggle="modal" class="btn btn-default btn-block mano"
									style="width: 100%" id="green-button"><spring:message
										code="master.page.login" /></a><br />
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>





