<%--
 * submit.tag
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@ tag language="java" body-content="empty" %>

<%-- Taglibs --%>

<%@ taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags" %>

<%-- Attributes --%> 

<%@ attribute name="name" required="true" %> 
<%@ attribute name="code" required="true" %>
<%@ attribute name="css" required="false" %>
<%@ attribute name="css_id" required="false" %>
<%@ attribute name="style" required="false" %>
<%@ attribute name="disabled" required="false" %>

<%-- Definition --%>
<jstl:if test="${css != null }">
<button type="submit" name="${name}" id="${css_id}" class="${css}" style="${style}">
	<spring:message code="${code}" />
</button>
</jstl:if>
<jstl:if test="${css == null }">
	<jstl:if test="${disable == null }">
		<button type="submit" name="${name}" id="${css_id}" class="btn btn-default mano">
			<spring:message code="${code}" />
		</button>
	</jstl:if>
	<jstl:if test="${disable != null }">
		<button type="submit" name="${name}" id="${css_id}" disabled="${disabled}" class="btn btn-default mano">
			<spring:message code="${code}" />
		</button>
	</jstl:if>
</jstl:if>
