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
<%@taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<div class="container">
	<div style="padding-top: 200px;">
		
		<jstl:if test="${showError == true}">
                    <div class="alert alert-danger">
                       <spring:message code="${message}"/>
                    </div>
                </jstl:if>
                
                
		<display:table pagesize="5" requestURI="${requestURI}"
			class="table table-striped table-hover" name="tourfriends"
			id="tourFriendRow">

			<spring:message code="tourFriend.firstName" var="firstName" />
			<display:column title="${firstName}" sortable="true">
				<jstl:out value="${tourFriendRow.firstName}" />
			</display:column>

			<spring:message code="coupon.enable" var="enableHeader" />
			<display:column>
				<jstl:if test="${tourFriendRow.userAccount.isEnabled()==true}">
					<a href="tourFriend/ban.do?tourfriendId=${tourFriendRow.id}"><spring:message
							code="tourfriend.ban" /></a>

				</jstl:if>

				<jstl:if test="${tourFriendRow.userAccount.isEnabled()==false}">
					<a href="tourFriend/unban.do?tourfriendId=${tourFriendRow.id}"><spring:message
							code="tourfriend.unban" /></a>

				</jstl:if>
			</display:column>





		</display:table>

	</div>
</div>
