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

<div class="section-mini-padding">
	<h2>
		<i class="fa fa-diamond"></i> -
		<spring:message code="coupon.title" />
	</h2>
</div>

<div class="container">
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<jstl:choose>
				<jstl:when test="${itsOk==true}">
					<div class="alert alert-success" style="margin-top: 80px;">
						<spring:message code="coupon.exchangue.message.ok" />
					</div>
					<br />
				</jstl:when>
				<jstl:otherwise>
					<div class="alert alert-danger" style="margin-top: 80px;">
						<spring:message code="coupon.exchangue.message.nok" />
					</div>
					<br />
				</jstl:otherwise>
			</jstl:choose>
		</div>
		<div class="col-md-2"></div>
	</div>
	<jstl:if test="${itsOk==true}">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<div class="alert alert-info">
					- ${coupon.points}
					<spring:message code="coupon.points" />
					/ + ${coupon.value} euros
				</div>
			</div>
		</div>
		<div class="col-md-4"></div>
	</jstl:if>
	<div class="row">
		<div class="col-md-12 text-center">
			<a href="coupon/tourfriend/list.do"
				class="btn btn-default"> <spring:message
					code="coupon.exchange.ok" />
			</a>
		</div>
	</div>

</div>


