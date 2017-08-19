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

	<security:authentication property="principal" var="usserAccount" />

	<div class="section-mini-padding">
		<h2>
			<i class="fa fa-user-circle"></i>
			<spring:message code="tourfriend.profile.setPassword" />
		</h2>
	</div>

	<div class="container" style="padding-top: 25px;">
		<form action="tourFriend/receivePassword.do" method="post">

			<jstl:if test="${fail}">
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						<div class="alert alert-danger">
							<spring:message code="tourfriend.validation.badPassWord" />
						</div>
					</div>
					<div class="col-md-3"></div>
				</div>
			</jstl:if>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6 text-center">
					<div id="error" class=""></div>
				</div>
				<div class="col-md-3"></div>
			</div>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="new_password_1"><spring:message
								code="tourfriend.newPassword1" />: </label> <input
							onchange="myFunction()" type="password" class="form-control"
							name="new_password_1" id="new_password_1">
					</div>
				</div>
				<div class="col-md-4"></div>
			</div>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="new_password_2"><spring:message
								code="tourfriend.newPassword2" />: </label> <input
							onchange="myFunction()" type="password" class="form-control"
							name="new_password_2" id="new_password_2">
					</div>
				</div>
				<div class="col-md-4"></div>
			</div>

			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="old_password"><spring:message
								code="tourfriend.oldPassword" />: </label> <input type="password"
							class="form-control" name="old_password" id="old_password">
					</div>
				</div>
				<div class="col-md-4"></div>
			</div>

			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-2">
					<a href="tourFriend/display.do?usserAccountId=${usserAccount.id}"
						class="mano btn btn-default" id="delete-button"
						style="width: 100%; height: auto;"> <span
						class="fa fa-mail-reply"></span> <spring:message
							code="tourFriend.cancel" />
					</a>
				</div>
				<div class="col-md-2">
					<button disabled="true" type="submit" class="mano btn btn-default"
						id="green-button" style="width: 100%; height: auto;">
						<span class="fa fa-check"></span>
						<spring:message code="tourFriend.save" />
					</button>
				</div>
				<div class="col-md-4"></div>
				<br>
			</div>
		</form>
	</div>
</security:authorize>

<script>
	function myFunction() {

		var new_password_1 = document.getElementById("new_password_1").value;
		var new_password_2 = document.getElementById("new_password_2").value;

		if (new_password_1 != new_password_2) {

			document.getElementById("error").className = "alert alert-danger";
			document.getElementById("error").innerHTML = '<spring:message code="tourfriend.validation.notOk" />'
			document.getElementById('green-button').disabled = true;

		} else {
			document.getElementById("error").className = "alert alert-success";
			document.getElementById("error").innerHTML = '<spring:message code="tourfriend.validation.ok"/>'
			document.getElementById('green-button').disabled = false;
		}

	}
</script>