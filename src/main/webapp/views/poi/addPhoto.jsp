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

	
	<form:form action="poi/step-2-addPhoto.do" id="form" method="post" enctype="multipart/form-data" onsubmit="return checkImages();">
			
			<script>
			
			function checkImages(){
				
			
				
				if(!document.getElementById("f1").value.length==0){
					if (!/.(jpeg|jpg|png)$/i.test(document.getElementById("f1").value))
					{
						alert('Comprueba la extensión de tus imagenes, recuerda que los formatos aceptados son .jpeg, .jpg y .png');
						document.getElementById("f1").focus();
						return false;
					}
				}
			}
			
			
			</script>
			
			
			
			
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
						</div>
						
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
						
						<div class="modal-body">

							<!-- content goes here -->
							<div class="row">
								<div class="col-md-12">
									<form>
										<div class="form-group">
											<input type="file" class="file" name="file" id="f1" multiple>
										</div>
									</form>

								</div>
								
							</div>
						</div>
						<div class="modal-footer">
							<div class="btn-group btn-group-justified" role="group"
								aria-label="group button">
								<div class="btn-group" role="group">
									<button type="button" class="btn btn-danger"
										data-dismiss="modal" role="button"><spring:message code="poi.cancel" /></button>
								</div>
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
			</div>
	</form:form>
</security:authorize>