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
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<%-- Attributes --%>

<%@ attribute name="message" required="true"%>
<%@ attribute name="id" required="true"%>




<%-- Definition --%>

<div id="${id}" class="alert alert-warning"
	style="display: none; width: 400px; height: 90px; margin-right: auto; margin-left: auto;">
	<strong><spring:message code="${message}" /></strong><br> 
	<input type="submit" name="delete" 	value="<spring:message code="confirm.yes" />" />&nbsp;
	<input type="button" name="delete" 	value="<spring:message code="confirm.no" />" onclick="hiddenOrShowById(${id});" />&nbsp;
</div>