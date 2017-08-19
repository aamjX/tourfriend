<%--
 * footer.jsp
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>

<hr />

<footer>
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<h5 class="text-center">TourFriend</h5>
				<hr>
				
				<p><spring:message code="footer.about" /></p>
				<p>
					<a target="_blank" href="welcome/termsAndConditions.do"><spring:message code="footer.generalterms"/></a>
					<br/>
					<a target="_blank" href="welcome/cookies.do"><spring:message code="footer.cookiesPolicy"/></a>
				</p>
				<p>
					<jstl:if test="${requestScope['javax.servlet.forward.request_uri'].split('/')[2] != 'edit.do'}">
						<a href="${requestScope['javax.servlet.forward.request_uri']}?${requestScope['javax.servlet.forward.query_string'].replaceAll("[&?]language=([^&]$|[^&]*)", "")}&language=es"><img alt="Spanish" src="/images/spain.png" style="width: 20px; height: auto"></a> | <a href="${requestScope['javax.servlet.forward.request_uri']}?${requestScope['javax.servlet.forward.query_string'].replaceAll("[&?]language=([^&]$|[^&]*)", "")}&language=en"> <img alt="English" src="/images/gb.png" style="width: 20px; height: auto"></a>
					</jstl:if>
				</p>
			</div>
			<div class="col-md-4 text-center">
				<h5 class="text-center"><spring:message code="footer.links"/></h5>
				<hr>
				<a target="_blank" href="https://twitter.com/friend_tour"><i class="fa fa-twitter"
					style="font-size: 24px; color: #fff"></i></a>&nbsp; &nbsp;<a target="_blank" href="https://www.instagram.com/tourfriendapp/"><i
					class="fa fa-instagram" style="font-size: 24px; color: #fff"></i></a>&nbsp; &nbsp;<a target="_blank" href="https://www.facebook.com/Tourfriend-1874469736147152/"><i
					class="fa fa fa-facebook" style="font-size: 24px; color: #fff"></i></a>&nbsp;&nbsp;
				<a target="_blank" href="https://www.youtube.com/channel/UCXe9NATvkggz436mUSXnjNw"><i class="fa fa-youtube-play"
					style="font-size: 24px; color: #fff"></i></a>&nbsp; &nbsp;<a class="mano" data-toggle="modal" data-target="#modalEmail" ><i class="fa fa-at" style="font-size:24px; color:#fff"></i></a>
			</div>
			<div class="col-md-4">
				<h5 class="text-center"><spring:message code="footer.address"/></h5>
				<hr>
				<p>Av. Reina Mercedes<br>
				Edificio CRAI Antonio de Ulloa sala 1.14<br>
				41012, Sevilla,<br>
				España</p>
			</div>
		</div>
		<div class="row text-center"><p>Copyright © 2017 TourFriend Co., Inc.</p></div>
		</div>
		
		<div class="modal fade" id="modalEmail" tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title"><spring:message code="modal.contactus" /></h4>
		      </div>
		      <form action="welcome/sendMail.do" method="post">
			      <div class="modal-body">
			      
			      
				      <div class="form-group">
				        
				        <div class="input-group">
				        	
							<span class="input-group-addon" id="sizing-addon2"><spring:message code="welcome.message" /></span>
							<textarea name="msnBody" rows="5" cols="5" class="form-control reportArea" required placeholder="<spring:message code="modal.contactus.textArePlaceHolder" />"></textarea>
						</div>
				      </div>
				        
				        
				        <div class="form-group">
					        <div class="input-group">
							  <span class="input-group-addon" id="sizing-addon2">Email <i class="fa fa-envelope" aria-hidden="true"></i></span>
							  <spring:message code="welcome.email" var="inputemail" />
							  <input type="email" required="required" class="form-control" name="email" placeholder="${inputemail}" />
							</div>
						</div>
				        
				        
				        
				        			        
				      
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default mano" data-dismiss="modal"><spring:message code="modal.contactus.close" /></button>
			        <button type="submit" class="btn btn-primary mano"><spring:message code="modal.contactus.send" /></button>
			      </div>
		      </form>
		    </div>
		  </div>
		</div>
</footer>

<script>
var intputElements = document.getElementsByTagName("textarea");
for (var i = 0; i < intputElements.length; i++) {
    intputElements[i].oninvalid = function (e) {
        e.target.setCustomValidity("");
        if (!e.target.validity.valid) {
        	 if (e.target.type == "email") {
                 e.target.setCustomValidity('<spring:message code="master.page.email"/>');
        	 }else if(e.target.type == "date"){
                 e.target.setCustomValidity('<spring:message code="master.page.date"/>');
        	 }
             else {
                 e.target.setCustomValidity('<spring:message code="master.page.required"/>');
             }

        }
    };
}


var intputElements1 = document.getElementsByTagName("input");
for (var i = 0; i < intputElements1.length; i++) {
    intputElements1[i].oninvalid = function (e) {
        e.target.setCustomValidity("");
        if (!e.target.validity.valid) {
        	 if (e.target.type == "email") {
                 e.target.setCustomValidity('<spring:message code="master.page.email"/>');
        	 }else if(e.target.type == "date"){
                 e.target.setCustomValidity('<spring:message code="master.page.date"/>');
        	 }else if(e.target.name == "username"){
        		 e.target.setCustomValidity('<spring:message code="master.page.user&password"/>');
        	 }else if(e.target.name == "password" || e.target.name == "password1" || e.target.name == "password2"){
        		 e.target.setCustomValidity('<spring:message code="master.page.user&password"/>');
        	 }
             else {
                 e.target.setCustomValidity('<spring:message code="master.page.required"/>');
             }

        }
    };
}
</script>