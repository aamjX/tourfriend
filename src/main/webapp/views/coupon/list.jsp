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

<div class="section-mini-padding">
	<h2>
		<i class="fa fa-diamond"></i> -
		<spring:message code="coupon.title" />
	</h2>
</div>


<div class="container">

	<div class="row section-content-padding">
		<div class="col-md-3"></div>
		<div class="col-md-6">
				<div class="input-group">
					<span class="input-group-addon" id="basic-addon1"
						style="background-color: #ddd;"><i class="fa fa-search"></i></span>
					<input type="text" class="form-control" id="system-search" name="q" aria-describedby="basic-addon1">
				</div>
		</div>
		<div class="col-md-3"></div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<br> <br>
			<section class="messages-table">
				<display:table requestURI="${requestURI}"
					class="table table-striped table-list-search" name="coupons"
					id="row">

					<spring:message code="coupon.name" var="nameHeader" />
					<display:column title="${nameHeader}" sortable="true">
						<jstl:out value="${row.name}" />
					</display:column>

					<spring:message code="coupon.description" var="descriptionHeader" />
					<display:column title="${descriptionHeader}" sortable="true">
						<jstl:out value="${row.description}" />
					</display:column>

					<spring:message code="coupon.value" var="valueHeader" />
					<display:column title="${valueHeader}" sortable="true">
						<jstl:out value="${row.value}" /> &#8364;
		</display:column>

					<spring:message code="coupon.points" var="pointsHeader" />
					<display:column title="${pointsHeader}" sortable="true">
						<jstl:out value="${row.points}" />
					</display:column>
					<security:authorize access="hasRole('ADMIN')">
						<spring:message code="coupon.isDisabled" var="isDisabledHeader" />
						<display:column title="${isDisabledHeader}" sortable="true">
							<jstl:out value="${row.isDisabled}" />
						</display:column>


						<spring:message code="coupon.enable" var="enableHeader" />
						<display:column>
							<jstl:if test="${row.isDisabled eq true}">
								<a href="coupon/admin/enable.do?couponId=${row.id}"> <spring:message
										code="coupon.enable" />
								</a>
							</jstl:if>
							<jstl:if test="${row.isDisabled eq false}">
								<a href="coupon/admin/disable.do?couponId=${row.id}"> <spring:message
										code="coupon.disable" />
								</a>
							</jstl:if>
						</display:column>
					</security:authorize>


					<security:authorize access="hasRole('TOURFRIEND')">
						<display:column>
							<a href="coupon/tourfriend/exchange.do?couponId=${row.id}"
								class="btn btn-default"><i class="fa fa-handshake-o"></i> - <spring:message
									code="coupon.exchange" />
							</a>
						</display:column>
					</security:authorize>


				</display:table>
			</section>

			<security:authorize access="hasRole('ADMIN')">
				<button style="cursor: pointer;" type="button"
					class="btn btn-success btn-green" data-toggle="modal"
					data-target="#createCouponModal"
					onclick="create('coupon/admin/create.do')">
					<spring:message code="coupon.create" />
				</button>
			</security:authorize>
		</div>
	</div>
</div>

<!-- CreateMessageModal -->
<div class="modal fade" id="createCouponModal" role="dialog">
	<div id="createModalinject" class="modal-dialog">
		<!--  Se inyecta el model del edit.jsp -->
	</div>
</div>

<script>
	function create(url) {
		$("#createModalinject").load(url + " #container");
	}
</script>
<script>
	$(document)
			.ready(
					function() {
						var activeSystemClass = $('.list-group-item.active');

						//something is entered in search form
						$('#system-search')
								.keyup(
										function() {
											var that = this;
											// affect all table rows on in systems table
											var tableBody = $('.table-list-search tbody');
											var tableRowsClass = $('.table-list-search tbody tr');
											$('.search-sf').remove();
											tableRowsClass
													.each(function(i, val) {

														//Lower text for case insensitive
														var rowText = $(val)
																.text()
																.toLowerCase();
														var inputText = $(that)
																.val()
																.toLowerCase();
														if (inputText != '') {
															$(
																	'.search-query-sf')
																	.remove();
															tableBody
																	.prepend('<tr class="search-query-sf"><td colspan="6"><strong><spring:message code="coupon.searchingFor" />"'
																			+ $(
																					that)
																					.val()
																			+ '"</strong></td></tr>');
														} else {
															$(
																	'.search-query-sf')
																	.remove();
														}

														if (rowText
																.indexOf(inputText) == -1) {
															//hide rows
															tableRowsClass
																	.eq(i)
																	.hide();

														} else {
															$('.search-sf')
																	.remove();
															tableRowsClass
																	.eq(i)
																	.show();
														}
													});
											//all tr elements are hidden
											if (tableRowsClass
													.children(':visible').length == 0) {
												tableBody
														.append('<tr class="search-sf"><td class="text-muted" colspan="6"><spring:message code="coupon.noEntriesFound" /></td></tr>');
											}
										});
					});
</script>
