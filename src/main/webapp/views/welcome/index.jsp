<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<link rel="stylesheet" href="/styles/animate.min.css" type="text/css">

<style>
.noscript__wrapper {
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 99999;
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	background-color: rgba(255, 255, 255, 0.5);
}

.noscript__msg {
	text-align: center;
	max-width: 500px;
	background-color: #f3f3f3;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	padding: 3em 4em;
	font-family: sans-serif;
	line-height: 1.4;
}

.noscript__msg span {
	display: block;
	color: #555;
	font-size: 1rem;
}

#errorDate {
	font-size: 11px;
	color: red;
	background-color: #FFFFFF;
	border-width: 0;
}
</style>

<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCnpBhHuVjijtDEVMw-zSGWID4btWRQey4&v=3.exp&sensor=false&libraries=places">
	
</script>

<script>
	function initialize() {

		var input = document.getElementById('city');
		var autocomplete = new google.maps.places.Autocomplete(input);
	}

	google.maps.event.addDomListener(window, 'load', initialize);
</script>

<header class="welcome-area">
	<div class="welcome-image-area" data-stellar-background-ratio="0.8"
		style="background-position: 0% 0%">
		<div class="display-table">
			<div class="display-table-cell">
				<div class="container">
					<div class="row">
						<div class="col-md-10 col-md-offset-1">
							<div class="header-text text-center">
								<h2>Tour Friend</h2>
								<p>
									<spring:message code="welcome.eslogan" />
								</p>
								<security:authorize access="isAuthenticated()">
									<p>
										<spring:message code="master.page.noReadMessage" />
										<jstl:out value="${noReadMessage}" />
									</p>
								</security:authorize>
								<security:authorize access="isAnonymous()">
									<a class="sign-in-up-btn mano" data-toggle="modal"
										data-target="#loginModal"><spring:message
											code="master.page.login" /></a>
									<a class="sign-in-up-btn mano" data-toggle="modal"
										data-target="#signUpModal"><spring:message
											code="master.page.signUp" /></a>
								</security:authorize>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<section class="section-padding" style="text-align: center"
	id="divSearchRoutesWelcome">
	<div class="container">
		<form action="welcome/index.do#divSearchRoutesWelcome" method="get">
			<div class="row">
				<div class="col-md-12">
					<div class="col-md-10">
						<input type="text" class="form-control"
							placeholder="<spring:message code="route.search.city" />"
							name="city" id="city">
					</div>

					<div class="col-md-2">
						<button type="submit" class="btn btn-default mano"
							id="reply-button"
							style="width: 100%; height: auto; margin-top: 3px;">
							<span class="glyphicon glyphicon-search"></span>
							<spring:message code="event.search.submit" />
						</button>
					</div>
				</div>
			</div>
		</form>
		<jstl:if test="${citySearch != null}">
			<p>
				<spring:message code="welcome.searchBy" />
				<jstl:out value="${citySearch}" />
			</p>
		</jstl:if>
	</div>
	<noscript>
		<div class="noscript__wrapper">
			<span class="noscript__msg animated shake"> <span><spring:message
						code="noscript.message" /></span>
			</span>
		</div>
	</noscript>

	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<jstl:if test="${showRoutes}">
					<div id="slider">
						<a href="javascript:void(0)" class="control_next">></a> <a
							href="javascript:void(0)" class="control_prev"><</a>
						<ul>
							<jstl:forEach items="${highRatedRoutes}" var="route">
						<jstl:forEach var="p" items="${route.pois}">
							<jstl:forEach var="i" items="${p.photos}">
								<li><img style="height: 300px;" src="data:image/jpeg;base64,${i}"/></li>
									</jstl:forEach>
								</jstl:forEach>

							</jstl:forEach>
						</ul>
					</div>
				</jstl:if>
				<jstl:if test="${!showRoutes}">
					<p>
						<spring:message code="welcome.empty" />
				</jstl:if>
			</div>
			<div class="col-md-6 align-middle" style="margin-top: 5%;">
				<p
					style="color: #2d3235; font-size: 50px; margin-bottom: 55px; margin-top: 25px;">
					<spring:message code="welcome.question"></spring:message>
				</p>
				<p style="color: #000; font-size: 18px;">
					<spring:message code="welcome.description" />
				</p>
			</div>
		</div>
	</div>
	<noscript>
		<div class="noscript__wrapper">
			<span class="noscript__msg animated shake"> <span><spring:message
						code="noscript.message" /></span>
			</span>
		</div>
	</noscript>
</section>

<div class="col-md-12 text-center">
	<h2 class="description">
		<i class="fa fa-users" aria-hidden="true"></i>
		<spring:message code="master.page.ourteam" />
	</h2>
	<hr style="border: 2px solid #e4e4e4;">
</div>
<section class="team section-padding">
	<div class="container">

		<div class="row text-center">
			<div class="col-md-12">
				<div class="col-lg-12">
					<div class="row pt-md">
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 profile">
							<div class="img-box">
								<img src="/images/team/dani.png" class="img-responsive">
							</div>
							<h1>Daniel José Abadín Barrantes</h1>
							<h2>
								<spring:message code="welcome.teamleader" />
							</h2>
							<h2>
								<spring:message code="welcome.analyst" />
							</h2>
							<h2>
								<spring:message code="welcome.designer" />
							</h2>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 profile">
							<div class="img-box">
								<img src="/images/team/santi.png" class="img-responsive">
							</div>
							<h1>Santiago Orcajo Delgado</h1>
							<h2>
								<spring:message code="welcome.analyst" />
							</h2>
							<h2>
								<spring:message code="welcome.documentalmanager" />
							</h2>
							<h2>
								<spring:message code="welcome.programmer" />
							</h2>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 profile">
							<div class="img-box">
								<img src="/images/team/jesus.png" class="img-responsive">
							</div>
							<h1>Antonio Jesús Barrera Roldán</h1>
							<h2>
								<spring:message code="welcome.programmer" />
							</h2>
							<h2>
								<spring:message code="welcome.designer" />
							</h2>
							<h2>
								<spring:message code="welcome.tester" />
							</h2>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 profile">
							<div class="img-box">
								<img src="/images/team/angel.png" class="img-responsive">
							</div>
							<h1>Antonio Ángel Muñoz Jiménez</h1>
							<h2>
								<spring:message code="welcome.programmer" />
							</h2>
							<h2>
								<spring:message code="welcome.designer" />
							</h2>
							<h2>
								<spring:message code="welcome.tester" />
							</h2>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 profile">
							<div class="img-box">
								<img src="/images/team/laura.png" class="img-responsive">
							</div>
							<h1>Laura Padial González</h1>
							<h2>
								<spring:message code="welcome.analyst" />
							</h2>
							<h2>
								<spring:message code="welcome.designer" />
							</h2>
							<h2>
								<spring:message code="welcome.tester" />
							</h2>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 profile">
							<div class="img-box">
								<img src="/images/team/andujar.png" class="img-responsive">

							</div>
							<h1>José Antonio Andujar Luque</h1>
							<h2>
								<spring:message code="welcome.programmer" />
							</h2>
							<h2>
								<spring:message code="welcome.analyst" />
							</h2>
							<h2>
								<spring:message code="welcome.tester" />
							</h2>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 profile">
							<div class="img-box">
								<img src="/images/team/juanan.png" class="img-responsive">

							</div>
							<h1>Juan Antonio Castañeda Cortazar</h1>
							<h2>
								<spring:message code="welcome.programmer" />
							</h2>
							<h2>
								<spring:message code="welcome.financialmanager" />
							</h2>
							<h2>
								<spring:message code="welcome.tester" />
							</h2>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 profile">
							<div class="img-box">
								<img src="/images/team/antonio.png" class="img-responsive">

							</div>
							<h1>Antonio Espinosa Velasco</h1>
							<h2>
								<spring:message code="welcome.programmer" />
							</h2>
							<h2>
								<spring:message code="welcome.analyst" />
							</h2>
							<h2>
								<spring:message code="welcome.tester" />
							</h2>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 profile">
							<div class="img-box">
								<img src="/images/team/alex.png" class="img-responsive">

							</div>
							<h1>Alejandro Murillo Rodríguez</h1>
							<h2>
								<spring:message code="welcome.programmer" />
							</h2>
							<h2>
								<spring:message code="welcome.designer" />
							</h2>
							<h2>
								<spring:message code="welcome.tester" />
							</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
		<noscript>
			<div class="noscript__wrapper">
				<span class="noscript__msg animated shake"> <span><spring:message
							code="noscript.message" /></span>
				</span>
			</div>
		</noscript>
	</div>

</section>

<section class="middlearea middlearea-2"
	data-stellar-background-ratio="0.9">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="middlearea-text text-center">
					<h2>
						<spring:message code="welcome.eslogan" />
					</h2>
				</div>
			</div>
		</div>
	</div>
</section>

<jstl:if test="${showErrorLogin != false }">
	<script>
		window.onload = function() {
			$("#loginModal").modal()
		};
	</script>
</jstl:if>
<!-- LoginModal -->
<div id="loginModal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<form:form class="form-signin" action="j_spring_security_check"
			modelAttribute="credentials">
			<div class="card card-container">
				<h2 class="text-center">
					<spring:message code="welcome.login" />
				</h2>
				<hr>
				<jstl:if test="${showErrorLogin == true && showMessage == true}">
					<div class="alert alert-danger alert-dismissible" role="alert">
						<jstl:if
							test="${SPRING_SECURITY_LAST_EXCEPTION.message == 'User is disabled'}">
							<spring:message code="security.login.banned" />
						</jstl:if>
						<jstl:if
							test="${SPRING_SECURITY_LAST_EXCEPTION.message != 'User is disabled'}">
							<spring:message code="security.login.failed" />
						</jstl:if>
					</div>
					<br />
				</jstl:if>




				<spring:message code="security.username" var="usuario" />
				<form:label path="username">
					<spring:message code="security.username" />:
				</form:label>
				<form:input path="username" class="form-control input-lg"
					autofocus="autofocus" placeholder="${usuario}" required="required"
					maxlength="32" minlength="5" />
				<form:errors class="error" path="username" />
				<br />

				<spring:message code="security.password" var="pass" />
				<form:label path="password">
					<spring:message code="security.password" />:
				</form:label>
				<form:password path="password" name="password"
					class="form-control input-lg" placeholder="${pass }"
					required="required" maxlength="32" minlength="5" />
				<form:errors class="error" path="password" />
				<br /> <input class="btn btn-success btn-signin"
					style="width: 100%; background-color: #006ead;" type="submit"
					value="<spring:message code="security.login" />" />
			</div>
		</form:form>
	</div>
</div>

<jstl:if test="${showError != false }">
	<script>
		window.onload = function() {
			$("#signUpModal").modal()
		};
	</script>
</jstl:if>
<!-- SignUpModal -->
<spring:message code="tourFriend.firstName" var="firstNamem" />
<spring:message code="tourFriend.lastName" var="lastNamem" />
<spring:message code="tourFriend.email" var="emailm" />
<spring:message code="tourFriend.phone" var="phonem" />
<spring:message code="tourFriend.dateOfBirth" var="dateOfBirthm" />
<spring:message code="tourFriend.username" var="usernamem" />
<spring:message code="tourFriend.password1" var="pass1" />
<spring:message code="tourFriend.password2" var="pass2" />
<spring:message code="tourFriend.signUp" var="signUpm" />
<spring:message code="tourFriend.signUp" var="signUpm" />
<spring:message code="tourfriend.iAgree" var="iAgreem" />
<spring:message code="tourFriend.acceptation" var="txt" />
<spring:message code="tourFriend.acceptation1" var="txt1" />
<spring:message code="tourFriend.acceptation2" var="txt2" />
<spring:message code="tourFriend.acceptation3" var="txt3" />
<div id="signUpModal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
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
									<div id="error_date" style="visibility: hidden">
										<p style='color: red'><spring:message code="tourfriend.age" /></p>
									</div>
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
							<div class="col-md-12 text-center">
								<acme:submit name="save" code="tourFriend.signUp"
									disabled="false" css="btn btn-default mano"
									css_id="reply-button1" style="width:50%; margin-bottom:5px;" />
							</div>
							<div class="col-md-12 text-center">
								<button type="button" class="btn btn-default btn-danger mano" data-dismiss="modal" style="width: 50%;" aria-hidden="true"><spring:message code="modal.contactus.cancel" /></button>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	function edad(Fecha) {
        var hoy = new Date();
        var str = Fecha;
        var res = str.split("/");
        var day = res[0];
        var month = res[1];
        var year = res[2];
        var fechaFormateada = month + "/" + day + "/" + year;

        var cumpleanos = new Date(fechaFormateada);

        console.info(cumpleanos.toLocaleString("es-ES"));

		var ed = hoy.getFullYear() - cumpleanos.getFullYear();
		var m = hoy.getMonth() - cumpleanos.getMonth();

		if (m < 0 || (m === 0 && hoy.getDate() < cumpleanos.getDate())) {
			ed--;
		}
		if (ed < 18) {
            document.getElementById("error_date").style.visibility = "visible";
			document.getElementById("reply-button1").disabled = true;
		} else {
            document.getElementById("error_date").style.visibility = "hidden";
			document.getElementById("reply-button1").disabled = false;
		}
	}
</script>

