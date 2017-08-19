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

	<div class="container">
		<div class="row text-center">
			<div class="col-md-12">
				<div class="alert alert-success" style="margin-top: 80px;">
					<spring:message code="tourfriend.password.confirmation" />
				</div>

			</div>
		</div>
		<div class="row text-center">
			<div class="col-md-12">
				<a href="tourFriend/display.do?usserAccountId=${usserAccount.id}" class="btn btn-default"> <spring:message
						code="coupon.exchange.ok" />
				</a>
			</div>
		</div>
	</div>

</security:authorize>