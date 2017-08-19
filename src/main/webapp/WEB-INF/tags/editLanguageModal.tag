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

			<script>
				window.onload = function() {
					$("#modalLanguage").modal()
				};
			</script>


<div class="modal fade" id="modalLanguage" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><spring:message code="profile.modal.changeImage" /></h4>
      </div>
      <form action="profile/changeImage.do" method="post" enctype="multipart/form-data">
	      <div class="modal-body">
			
			<div class="container">
				<div class="row">
					<jstl:forEach items="${languageCheked}" var="lanAll">
						<div class="col-md-6">
							<input type="checkbox" name="chekcLanguage" checked value="lanAll.id" />
						</div>
						<div class="col-md-6">
							<p>${lanAll.name}</p>
						</div>
					</jstl:forEach>
					
					<jstl:forEach items="${languageUnCheked}" var="lanAll2">
						<div class="col-md-6">
							<input type="checkbox" name="chekcLanguage" value="lanAll2.id" />
						</div>
						<div class="col-md-6">
							<p>${lanAll2.name}</p>
						</div>
					</jstl:forEach>
					

					
				</div>

			</div>
	      	      
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default mano" data-dismiss="modal"><spring:message code="profile.modal.changeImage.close" /></button>
	        <button type="submit" class="btn btn-primary mano"><spring:message code="profile.modal.changeImage.send" /></button>
	      </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</security:authorize>

