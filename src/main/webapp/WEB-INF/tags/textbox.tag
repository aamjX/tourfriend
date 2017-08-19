<%--
 * textbox.tag
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@ tag language="java" body-content="empty"%>

<%-- Taglibs --%>

<%@ taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<%-- Attributes --%>

<%@ attribute name="path" required="true"%>
<%@ attribute name="code" required="false"%>
<%@ attribute name="required" required="false"%>
<%@ attribute name="type" required="false"%>
<%@ attribute name="step" required="false"%>
<%@ attribute name="pattern" required="false"%>
<%@ attribute name="maxlength" required="false"%>
<%@ attribute name="minlength" required="false"%>
<%@ attribute name="placeholder" required="false"%>
<%@ attribute name="css" required="false"%>
<%@ attribute name="autofocus" required="false"%>
<%@ attribute name="id" required="false"%>
<%@ attribute name="name" required="false"%>
<%@ attribute name="max" required="false"%>
<%@ attribute name="min" required="false"%>
<%@ attribute name="readonly" required="false"%>
<%@ attribute name="onblur" required="false"%>
<%@ attribute name="onchange" required="false"%>

<jstl:if test="${readonly == null}">
	<jstl:set var="readonly" value="false" />
</jstl:if>

<jstl:if test="${required == null}">
	<jstl:set var="required" value="false" />

</jstl:if>

<%-- Definition --%>

<div>
	<jstl:if test="${code != null }">
		<form:label path="${path}">
			<spring:message code="${code}" />:
		</form:label>
	</jstl:if>
	<form:input id="${id}" step="${step}" type="${type}" path="${path}" readonly="${readonly}"
		pattern="${pattern}" required="${required }" maxlength="${maxlength }"
		minlength="${minlength}" placeholder="${placeholder }" 
		cssClass="${css}" autofocus="${autofocus }" name="${name}" max="${max}" min="${min}" onchange="${onchange}" onblur="${onblur}"/>
	<form:errors path="${path}" cssClass="error" />
</div>