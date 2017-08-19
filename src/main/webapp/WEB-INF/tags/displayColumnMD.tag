<%--
 * submit.tag
 *
 * Copyright (C) 2014 Universidad de Sevilla
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
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<%-- Attributes --%>

<%@ attribute name="code" required="true"%>
<%@ attribute name="var" required="true"%>
<%@ attribute name="sortable" required="false"%>
<%@ attribute name="date" required="false" type="java.util.Date"%>

<%-- Definition --%>

<jstl:if test="${not empty date}">

	<spring:message code="${code}" var="content" />
	<display:column title="${content}" sortable="${sortable}">
		<fmt:formatDate value="${date}" pattern="dd-MM-yyyy HH:mm:ss" />
	</display:column>

</jstl:if>

<jstl:if test="${empty date}">

	<jstl:if test="${not empty sortable}">
		<spring:message code="${code}" var="content" />
		<display:column property="${var}" title="${content}"
			sortable="${sortable}" />
	</jstl:if>

	<jstl:if test="${empty sortable}">
		<spring:message code="${code}" var="content" />
		<display:column property="${var}" title="${content}" sortable="true" />
	</jstl:if>

</jstl:if>
