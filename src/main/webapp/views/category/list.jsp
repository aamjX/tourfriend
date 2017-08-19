<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>



<security:authorize access="hasRole('TOURFRIEND')">

	<script>
		window.onload = function() {
			$("#squarespaceModal").modal()
		};
	</script>


	<div class="modal fade" id="squarespaceModal" tabindex="-1"
		role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="lineModalLabel">
						<spring:message code="category.searchorcreate" />
					</h3>
				</div>
				<div class="modal-body">

					<!-- content goes here -->
					<div class="row">
						<form action="category/search.do" method="get">
							<div class="col-md-10">
								<div class="form-group">

									<input type="text" name="keyword" id="keyword"
										class="form-control" />
								</div>

							</div>
							<div class="col-md-2">
								<input type="submit" value="Buscar" />
							</div>
						</form>


					</div>

					<div class="row" id="buscador">

						<form:form action="category/step-3.do" modelAttribute="category"
							id="form" method="post">

							<display:table pagesize="5"
								class="table table-striped table-hover" name="categorys"
								requestURI="${requestURI}" id="rowCategory">

								<display:column>
									<input type="checkbox" value="${rowCategory.id}"
										name="chk_group" id="chk_group" />
								</display:column>
								<acme:displayColumnMD var="name" code="category.name" />

							</display:table>

							<div class="row">
							
								<div class="modal-footer">
									<div class="btn-group btn-group-justified" role="group"
										aria-label="group button">
										<div class="col-md-4 text-center">
											<div class="btn-group" role="group">
												<button type="button" class="btn btn-danger"
													data-dismiss="modal" role="button">
													<spring:message code="category.cancel" />
												</button>
											</div>
										</div>
										<div class="col-md-4 text-center">
											<div class="btn-group" role="group">
												<button type="submit" onclick="goBack()" name="save" class="btn btn-success">
													<spring:message code="previuos.step" />
												</button>
		
											</div>
										</div>
										
										<div class="col-md-4 text-center">
											<div class="btn-group" role="group">
												<button type="submit" name="save" class="btn btn-success">
													<spring:message code="category.save" />
												</button>
		
											</div>
										</div>
									</div>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>

		</div>
	</div>
</security:authorize>

<script type="text/javascript">
	var typingTimer;
	var doneTypingInterval = 500;
	var $input = $('input#keyword1');

	$input.on('keyup', function() {
		clearTimeout(typingTimer);
		typingTimer = setTimeout(doneTyping, doneTypingInterval);
	});

	$input.on('keydown', function() {
		clearTimeout(typingTimer);
	});

	function doneTyping() {
		reloadItems();
	}

	function reloadItems() {
		var keyword = $('input#keyword1').val();
		var placeholder = $('body');

		placeholder.load("category/search.do?keyword=" + keyword);
	}
</script>

<script>
	function goBack() {
	    window.history.back();
	}
</script>

