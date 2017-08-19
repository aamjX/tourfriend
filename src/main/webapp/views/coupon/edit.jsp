<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<script>
	window.onload = function() {
		$("#squarespaceModal").modal()
	};
</script>
<div id="container">
		<form:form action="coupon/admin/create.do" modelAttribute="coupon">
			<div class="card card-container">
				<div class="text-center">
					<strong><spring:message code="coupon.create"/></strong>
				</div>
				<div class="cruz">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<br /><br/>
				</div>

				<form:hidden path="id" />
				<form:hidden path="version" />
				
				<acme:textbox path="name" code="coupon.name"/>
				<acme:textbox path="description" code="coupon.description"/>
				<acme:textbox path="value" code="coupon.value"/>
				<acme:textbox path="points" code="coupon.points"/>
				
				<br/>
				<div class="text-center">
					<acme:submit name="save" code="coupon.save" css="btn btn-primary mano"/>
				</div>
			</div>
		</form:form>
</div>