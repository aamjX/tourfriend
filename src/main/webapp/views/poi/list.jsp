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
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					
					<h3 class="modal-title" id="lineModalLabel"><spring:message code="poi.createorsearch" /></h3>
					
					<jstl:if test="${showInfo}">
						<acme:mensajeInfo messageText="${info_msg}" />
					</jstl:if>
					<jstl:if test="${showSuccess }">
						<acme:mensajeSuccess messageText="${success_msg}" />
					</jstl:if>
					<jstl:if test="${showWarning}">
						<acme:mensajeWarning messageText="${warning_msg}" />
					</jstl:if>
					<jstl:if test="${showDanger}">
						<acme:mensajeDanger messageText="${danger_msg}" />
					</jstl:if>
					</div>
				<div class="modal-body">

					<!-- content goes here -->
					<div class="row">
						<form action="#" method="get">
							<div class="col-md-2">
								<h4><span class="label label-primary"><spring:message code="poi.search.btn" />: </span></h4>
							</div>
							<div class="col-md-10">
								<div class="form-group">
									<input type="text" name="keyword" id="keyword"
										   class="form-control"  />
								</div>
							</div>
						</form>
					</div>

					<div class="row" id="buscador">

						<form:form action="poi/step-2.do" modelAttribute="poi" id="form"
							method="post">

							<display:table pagesize="5"
								class="table table-striped table-hover" name="pois"
								requestURI="${requestURI}" id="rowPoi">

								<display:column>
									<input type="checkbox" value="${rowPoi.id}" name="chk_group"
										id="chk_group" />
								</display:column>
								<acme:displayColumnMD var="name" code="poi.name" />
								<acme:displayColumnMD var="description" code="poi.description" />
								<acme:displayColumnMD var="place" code="poi.place" />
							
							
							</display:table>
							
							<div id="searchResult">
							
							
							</div>

							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<a class="btn btn-info btn-group-justified" href="poi/create.do">
											<spring:message code="poi.create" />
										</a>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="modal-footer">
									<div class="btn-group btn-group-justified" role="group"
										aria-label="group button">
										<div class="col-md-4 text-center">
											<div class="btn-group" role="group">
												<button type="button" class="btn btn-danger"
													data-dismiss="modal" role="button"><spring:message code="poi.cancel" /></button>
											</div>
										</div>
										<div class="col-md-4 text-center" >
											<div class="btn-group" role="group">
													<button type="submit" onclick="goBack()" name="save" class="btn btn-success">
														<spring:message code="previuos.step" />
													</button>
			
											</div>
										</div>
										<div class="col-md-4 text-center">
											<div class="btn-group" role="group">
												<button type="submit" name="save"
													class="btn btn-success">
													<spring:message code="poi.save" />
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
    $(document)
        .ready(
            function() {
                var activeSystemClass = $('.list-group-item.active');

                //something is entered in search form
                $('#keyword')
                    .keyup(
                        function() {
                            var that = this;
                            console.info('entra');
                            // affect all table rows on in systems table
                            var tableBody = $('.table-hover tbody');
                            var tableRowsClass = $('.table-hover tbody tr');
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
                                            .prepend('<tr class="search-query-sf"><td colspan="6"><strong>Searching for: "'
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
                                    .append('<tr class="search-sf"><td class="text-muted" colspan="6">No entries found.</td></tr>');
                            }
                        });
            });
</script>

<script type="text/javascript">
function searchAjax() {

	var search = {}
	search["keyword"] = $("#keyword").val();
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : "poi/search.do?keyword",
		data : JSON.stringify(search),
		dataType : 'json',
		timeout : 100000,
		success : function(data) {
			console.log("SUCCESS: ", data);
			//alert(data);
		},
		error : function(e) {
			console.log("ERROR: ", e);
			//alert("Erorr " +e);
		},
		done : function(e) {
			console.log("DONE");
			enableSearchButton(true);
		}
	});

}
</script>

<script>
	function goBack() {
	    window.history.back();
	}
</script>


