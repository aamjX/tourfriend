
<%--
 * login.jsp
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
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>



		<form:form class="form-signin" action="j_spring_security_check"
			modelAttribute="credentials">
			<div class="card card-container">
			<h2 class="text-center"><spring:message code="welcome.login" /></h2>
			<hr>
				<jstl:if test="${showErrorLogin == true}">
					<div class="alert alert-danger alert-dismissible" role="alert">
						<spring:message code="security.login.failed" />
					</div>
					<br />
				</jstl:if>
				<spring:message code="security.username" var="usuario" />
				<form:label path="username">
					<spring:message code="security.username" />:
			</form:label>
				<form:input path="username" class="form-control input-lg"
					autofocus="autofocus" placeholder="${usuario }" required="required"
					maxlength="32" minlength="5" />
				<form:errors class="error" path="username" />
				<br />

				<spring:message code="security.password" var="pass" />
				<form:label path="password">
					<spring:message code="security.password" />:
			</form:label>
				<form:password path="password" name="password" class="form-control input-lg"
					placeholder="${pass }" required="required" maxlength="32"
					minlength="5"/>
				<form:errors class="error" path="password" />
				<br /> <input class="btn btn-lg btn-success btn-block btn-signin" style="background-color: #006ead;"
					type="submit" value="<spring:message code="security.login" />" />
			</div>
		</form:form>
		

