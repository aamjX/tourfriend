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




<security:authorize access="hasRole('TOURFRIEND')">


	<form:form action="poi/step-2-addPhoto.do" id="form" method="post" enctype="multipart/form-data">
			<script>
			
			function checkImages(){
			
				auxHiddenErrors();
				if(!document.getElementById("f1").value.length==0){
					if (!/.(jpeg|jpg|png)$/i.test(document.getElementById("f1").value))
					{
						showErrors("showError1");
						return false;
					}else{
						if(document.getElementById('f1').files.length>3 || document.getElementById('f1').files.length<3){
							showErrors("showError2");
							return false;
						}else{
								var imageSize = document.getElementById('f1');
								
								if(imageSize.files[0].size > 512000){
									showErrors("showError3");
									return false;
									
								}if(imageSize.files[1].size > 512000){
									showErrors("showError4");
									return false;
								}if(imageSize.files[2].size > 512000){
									showErrors("showError5");
									return false;
								}
							}
						}
					}else{
						showErrors("showError6");
						return false;
					}
				}
			
			function showErrors(show){
				 div = document.getElementById(show);
		         div.style.display = '';
			}
			
			function auxHiddenErrors(){
				 div = document.getElementById("showError1");
		         div.style.display = 'none';
		         div2 = document.getElementById("showError2");
		         div2.style.display = 'none';
		         div3 = document.getElementById("showError3");
		         div3.style.display = 'none';
		         div4 = document.getElementById("showError4");
		         div4.style.display = 'none';
		         div5 = document.getElementById("showError5");
		         div5.style.display = 'none';
		         div6 = document.getElementById("showError6");
		         div6.style.display = 'none';
			}
			


			
		</script>
			
			
			
			
			<script>
				window.onload = function() {
					$("#squarespaceModal").modal()
				};
			</script>

			<div class="modal fade" id="squarespaceModal" tabindex="-1"
				role="dialog" aria-labelledby="modalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
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
							
							<div class="alert alert-danger" id="showError1" style="display:none;" role="alert">
  								<p><spring:message code="poi.showError1" /></p>
							</div>
							<div class="alert alert-danger" id="showError2" style="display:none;" role="alert">
  								<p><spring:message code="poi.showError2" /></p>
							</div>
							<div class="alert alert-danger" id="showError3" style="display:none;" role="alert">
  								<p><spring:message code="poi.showError3" /></p>
							</div>
							<div class="alert alert-danger" id="showError4" style="display:none;" role="alert">
  								<p><spring:message code="poi.showError4" /></p>
							</div>
							<div class="alert alert-danger" id="showError5" style="display:none;" role="alert">
  								<p><spring:message code="poi.showError5" /></p>
							</div>
							<div class="alert alert-danger" id="showError6" style="display:none;" role="alert">
  								<p><spring:message code="poi.showError6" /></p>
							</div>
						
						<div class="modal-body">
						<input type="hidden" value="<spring:message code="poi.languaje" />" id="idioma" />
						

							<!-- content goes here -->
							<div class="row">
								<div class="col-md-12">
									<div id="mulitplefileuploader"><spring:message code="poi.choose" /></div>

									<div id="status"></div>
									
									<div id="startbutton" class="ajax-file-upload-green"><spring:message code="poi.upload" /></div>
									

								</div>
								<div class="col-md-12">
									<div class="alert alert-warning" id="showError7" role="alert">
	  									<p><spring:message code="poi.maxUpload" /></p>
									</div>
									<div class="alert alert-warning" id="showError7" role="alert">
	  									<p><spring:message code="poi.selectimages" /></p>
									</div>
								</div>
								
							</div>
						</div>
						<div class="modal-footer">
							<div class="btn-group btn-group-justified" role="group"
								aria-label="group button">
								<div class="btn-group" role="group">
									<button type="button" class="btn btn-default mano" id="delete-button"
										data-dismiss="modal" role="button">
										<i class="fa fa-times" aria-hidden="true"></i> <spring:message code="poi.cancel" />
									</button>
								</div>
								<div class="btn-group" role="group">
									<a onclick="checkPhoto();" class="btn btn-default mano" id="green-button"><i class="fa fa-arrow-right" aria-hidden="true"></i> <spring:message code="poi.save" /></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<script>
			
			var extraObj = $("#mulitplefileuploader").uploadFile(
					{
				    url: "poi/step-2-addPhoto.do",
					method: "POST",
					allowedTypes:"jpg,png,gif",
					fileName: "file",
					multiple: true,
					dragdropWidth:570,
				    autoSubmit:false,
				    maxFileSize: 512000,
				    maxFileCount: 3
				    
					});
					
					$("#startbutton").click(function()
					{
						var img1 = document.getElementsByClassName("ajax-file-upload-statusbar")[0];
						var img2 = document.getElementsByClassName("ajax-file-upload-statusbar")[1];
						var img3 = document.getElementsByClassName("ajax-file-upload-statusbar")[2];

						if(img1 == null || img2 == null ||img3 == null){
							alert('<spring:message code="poi.selectimages" />');
						}else{
							extraObj.startUpload();
						}
					});
			
			
			</script>
			
			<script>
				
			function checkPhoto(){
				var enviar = true;
				var img1 = document.getElementsByClassName("ajax-file-upload-bar")[0];
				var img2 = document.getElementsByClassName("ajax-file-upload-bar")[1];
				var img3 = document.getElementsByClassName("ajax-file-upload-bar")[2];

				if(img1.style.width != "100%" || img2 == null ||img3 == null){
					alert('<spring:message code="poi.selectimages" />');
				}else{
					window.location.href = "poi/next.do";
				}
			}
			
			
			
			</script>
	</form:form>
</security:authorize>

