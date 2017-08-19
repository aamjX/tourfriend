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

<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<security:authorize access="hasRole('TOURFRIEND')">

	<div class="section-mini-padding">
		<h2>
			<i class="fa fa-road" aria-hidden="true"></i> - <spring:message code="route.title" />
		</h2>
	</div>

	<div class="container">
		<div class="row section-content-padding">
			<div class="col-md-6 col-md-offset-3">
				<a href="route/step-1.do" class="btn btn-default mano" id="reply-button" style="width:100%;font-size: 20px;padding-bottom: 40px;padding-top: 10px;"><i class="fa fa-plus-circle"></i> <spring:message code="route.create.new" /></a>
			</div>
		</div>

		<div class="row" style="margin-top: 10px;">
			<div class="col-md-12">
				<jstl:if test="${param['showSuccess']}">
					<acme:mensajeSuccess messageText="route.success.create"/>
				</jstl:if>
			</div>
		</div>

		<div class="row">
			<jstl:if test="${!routes.isEmpty()}">
				<jstl:forEach items="${routes}" var="r" varStatus="loopPrincipal">
					<div class="card card-route" style="margin-top:20px !important;">
						<div class="container-fluid">
							<div class="wrapper row">
								<div class="preview col-md-5">
									<div class="preview-pic tab-content">
										<jstl:forEach items="${r.pois}" var="i" varStatus="loop1">
											<jstl:forEach items="${i.photos}" var="p" varStatus="loop2">
												<jstl:if test="${loop1.first && loop2.first}">
													<div class="tab-pane active" id="pic-${loopPrincipal.index}${loop1.index}${loop2.index}"><img src="data:image/jpeg;base64,${p}" /></div>
												</jstl:if>
												<jstl:if test="${!loop1.first || !loop2.first}">
													<div class="tab-pane" id="pic-${loopPrincipal.index}${loop1.index}${loop2.index}"><img src="data:image/jpeg;base64,${p}" /></div>
												</jstl:if>
											</jstl:forEach>
										</jstl:forEach>
									</div>
									<ul class="preview-thumbnail nav nav-tabs">
										<jstl:forEach items="${r.pois}" var="i" varStatus="loop1">
											<jstl:forEach items="${i.photos}" var="p" varStatus="loop2">
												<jstl:if test="${loop1.first && loop2.first}">
													<li class="active mano"><a data-target="#pic-${loopPrincipal.index}${loop1.index}${loop2.index}" data-toggle="tab"><img src="data:image/jpeg;base64,${p}" /></a></li>
												</jstl:if>
												<jstl:if test="${!loop1.first || !loop2.first}">
													<li class="mano"><a data-target="#pic-${loopPrincipal.index}${loop1.index}${loop2.index}" data-toggle="tab"><img src="data:image/jpeg;base64,${p}" /></a></li>
												</jstl:if>
											</jstl:forEach>
										</jstl:forEach>
									</ul>
								</div>
								<div class="details col-md-5">
									<h3 class="route-title"><jstl:out value="${r.city}" />
										<br/>
										<jstl:out value="${r.name}" />
										<br/></h3>
									<p class="route-description"><jstl:out value="${r.description}" /></p>

									<jstl:if test="${!r.events.isEmpty()}">
										<jstl:forEach var="i" items="${r.events}" varStatus="loop">
											<jstl:if test="${loop.first}">
												<jstl:set var="price_event" value="${i.price}"/>
											</jstl:if>
											<jstl:if test="${price_event > i.price}">
												<jstl:set var="price_event" value="${i.price}"/>
											</jstl:if>
										</jstl:forEach>

										<h4 class="price"><spring:message code="route.price.from"/>: <span>${price_event}</span> &#8364;</h4>

									</jstl:if>

									<p class="route-categories">

										<strong><spring:message code="route.categories" />:</strong>

										<jstl:forEach items="${r.categories}" var="c" varStatus="loop">
											<jstl:if test="${loop.first}">
												<jstl:out value="${c.name}"/>
											</jstl:if>
											<jstl:if test="${!loop.first && !loop.end}">
												<jstl:out value="${c.name}"/>
											</jstl:if>
											<jstl:if test="${loop.end}">
												<jstl:out value="${c.name}"/>
											</jstl:if>
										</jstl:forEach>

									</p>

									<div class="action">
										<jstl:if test="${!r.isDisabled}">
											<a href="route/detailsOfRoute.do?routeId=${r.id}"><button class="btn btn-default mano" style="margin-top:5px;margin-bottom: 5px;width:100%; margin-top: 10px;"><i class="fa fa-eye" aria-hidden="true"></i> <spring:message code="route.details"/></button></a>
										</jstl:if>
										<security:authorize access="hasRole('TOURFRIEND')">
											<jstl:if test="${r.events.isEmpty()}">

												<jstl:if test="${!r.isDisabled}">
													<button style="cursor: pointer; margin-top:5px;margin-bottom:15px;width:100%; color:white;"
															class="btn btn-default btn-default" id="delete-button"
															data-href="route/disable.do?routeId=${r.id}" data-toggle="modal"
															data-target="#confirm-delete">
														<i class="fa fa-exclamation-triangle"></i> <spring:message
															code="route.disable" />
													</button>
												</jstl:if>

												<jstl:if test="${r.isDisabled}">
													<a href="javascript:void(0)" style="margin-top:5px;margin-bottom:15px;width:100%;" class="btn btn-warning"><spring:message code="route.disable.message.list" /></a>
												</jstl:if>

											</jstl:if>
										</security:authorize>
									</div>

								</div>

								<div class="col-md-2 text-center">
									<img class="" src="data:image/jpeg;base64,${r.tourFriendCreator.image}"><br>
									<jstl:if test="${r.tourFriendCreator.rating != 'NaN'}">
										<acme:ratingStars stars="${r.tourFriendCreator.rating}" />
									</jstl:if>
								</div>
							</div>
						</div>
					</div>
				</jstl:forEach>
			</jstl:if>
		</div>
	</div>

	<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog"
		 aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<spring:message code="route.disable.message" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger mano" data-dismiss="modal"><spring:message code="route.disable.close" /></button>
					<a href="javascript:void(0)" class="btn btn-success btn-ok mano"><spring:message code="route.disable.confirm" /></a>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal para crear una nueva ruta -->
	<div class="modal fade" id="createModal2" role="dialog">
		<div id="createModalinject" class="modal-dialog">

		</div>
	</div>
	<!-- End modal para crear una nueva ruta -->

	<script>
        function addurl(url){
            $( "#editModalinject" ).load(url+" #container");
        }

        function create2(url){
            $( "#createModalinject" ).load(url + " #container");
        }

        function load_home() {
            document.getElementById("test").innerHTML='<object type="text/html" data="route/step-1.do" ></object>';
        }

        $('#confirm-delete').on('show.bs.modal', function(e) {
            $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
        });
	</script>


	<jstl:if test="${routeModal}">
		<acme:routeModal/>
	</jstl:if>
	<jstl:if test="${poiListModal}">
		<acme:poiListModal/>
	</jstl:if>
	<jstl:if test="${poiAddPhotoModal}">
		<acme:poiAddPhotoModal/>
	</jstl:if>
	<jstl:if test="${poiAddNewPoiModal}">
		<acme:poiAddNewPoiModal/>
	</jstl:if>
	<jstl:if test="${categoryListModal}">
		<acme:categoryListModal/>
	</jstl:if>




</security:authorize>