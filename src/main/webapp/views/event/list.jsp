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

<script>
    $().ready(function(){
        $('[rel="tooltip"]').tooltip();

    });

    function rotateCard(btn){
        var $card = $(btn).closest('.card-container');
        console.log($card);
        if($card.hasClass('hover')){
            $card.removeClass('hover');
        } else {
            $card.addClass('hover');
        }
    }

</script>

<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCnpBhHuVjijtDEVMw-zSGWID4btWRQey4&v=3.exp&sensor=false&libraries=places">
</script>

<script>
    function initialize() {

        var input = document.getElementById('city');
        var autocomplete = new google.maps.places.Autocomplete(
            input);
    }

    google.maps.event.addDomListener(window, 'load', initialize);
</script>


<security:authorize access="hasRole('TOURFRIEND')">

	<div class="section-mini-padding">
		<h2><i class="fa fa-server"></i> - <spring:message code="event.title" /></h2>
	</div>

	<div class="container" style="padding-top: 25px;">
		<form action="event/search.do" method="get">
			<div class="row">
				<div class="col-md-5">
					<div class="form-group">
						<label for="city"><spring:message code="event.search.city" /></label>
						<input type="text" class="form-control" placeholder="<spring:message code="event.advancedSearch.city" />" name="city" id="city"/>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label><spring:message code="event.search.date" /></label>
						<div class='input-group date' id='datetimepicker1'>
							<input type='text' class="form-control" name="date" id="date"
								   pattern="(0[1-9]|1[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/[0-9]{4} (0[1-9]|1[0-9]|2[0-3]):[0-5][0-9]" />
							<span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="sel1"><spring:message
								code="event.search.orderBy" /></label><select class="form-control"
																			  id="orderBy" name="orderBy">
						<option value="date"><spring:message
								code="event.search.date" /></option>
						<option value="price"><spring:message
								code="event.search.price" /></option>
						<option value="rating"><spring:message
								code="event.search.rating" /></option>
					</select>
					</div>
				</div>
			</div>
			<div id="filter-panel" class="collapse filter-panel">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-md-3">
								<div class="row">
									<div class="col-md-12 text-center">
										<label><spring:message code="event.search.numPersonas" /></label>
									</div>
									<div class="col-md-6">
										<input type="number" min=1 class="form-control"
											   name="numPersonasMin" id="numPersonasMin" placeholder="Min">
									</div>
									<div class="col-md-6">
										<input type="number" min=1 class="form-control"
											   name="numPersonasMax" id="numPersonasMax" placeholder="Max">
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="row">
									<div class="col-md-12 text-center">
										<label><spring:message code="event.search.priceRange" /></label>
									</div>
									<div class="col-md-6">
										<input type="number" min=0 class="form-control"
											   name="precioMin" id="precioMin" placeholder="Min" step="0.1">
									</div>
									<div class="col-md-6">
										<input type="number" min=0 class="form-control"
											   name="precioMax" id="precioMax" placeholder="Max" step="0.1">
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="row">
									<div class="col-md-12 text-center">
										<label><spring:message
												code="event.search.calificationRangeRoute" /></label>
									</div>
									<div class="col-md-6">
										<input type="number" min=0 max=5 class="form-control"
											   name="calificationMin" id="calificationMin" placeholder="Min" value=0>
									</div>
									<div class="col-md-6">
										<input type="number" min=0 max=5 class="form-control"
											   name="calificationMax" id="calificationMax" placeholder="Max" value=5>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="row">
									<div class="col-md-12 text-center">
										<label><spring:message
												code="event.search.calificationRangeTourFriend" /></label>
									</div>
									<div class="col-md-6">
										<input type="number" min=0 max=5 class="form-control"
											   name="calificationTRMin" id="calificationTRMin" placeholder="Min" value=0>
									</div>
									<div class="col-md-6">
										<input type="number" min=0 max=5 class="form-control"
											   name="calificationTRMax" id="calificationTRMax" placeholder="Max" value=5>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-3 text-center">
					<button type="button" class="mano btn btn-default"
							style="width: 100%; height: auto" id="reply-button" data-toggle="collapse"
							data-target="#filter-panel">
						<span class="glyphicon glyphicon-cog"></span>
						<spring:message code="event.search.advanced" />
					</button>
				</div>
				<div class="col-md-3 text-center">

					<button type="submit" class="mano btn btn-default" id="green-button"
							style="width: 100%; height: auto;">
						<span class="glyphicon glyphicon-search"></span>
						<spring:message code="event.search.submit" />
					</button>
				</div>
				<div class="col-md-3"></div>
			</div>
			<br>
		</form>

	</div>

	<div class="container">
		<jstl:if test="${!events.isEmpty()}">
			<jstl:forEach items="${events}" var="e">

				<!-- Card-->
				<div class="col-md-4 col-sm-6">
					<div class="card-container card-container-aux manual-flip">
						<div class="card">
							<div class="front">
								<div class="cover">
									<div class="carousel slide" data-ride="carousel" id="carousel-example-generic">


										<!-- Wrapper for slides -->
										<div class="carousel-inner slider-size ">
											<jstl:set var="positionImage" value="0"/>
											<jstl:forEach items="${e.route.pois}" var="i">
												<jstl:forEach items="${i.photos}" var="eachPicture">
													<jstl:if test="${positionImage == 0}">
														<div class="item active">
															<!-- img src="${eachPicture}"/> -->
															<img src="data:image/jpeg;base64,${eachPicture}" />
														</div>
													</jstl:if>
													<jstl:if test="${positionImage != 0}">
														<div class="item">
															<!-- img src="${eachPicture}"/> -->
															<img src="data:image/jpeg;base64,${eachPicture}" />
														</div>
													</jstl:if>
													<jstl:set var="positionImage" value="1"/>
												</jstl:forEach>
											</jstl:forEach>
										</div>


      </div>  
      </div>
                        <div class="content">
                            <div class="main">
                                <p class="text-center">${e.name}</p>
                                <p class="profession">
									${e.route.city}
									<br/>
									<fmt:formatDate value="${e.date}" pattern="dd-MM-yyyy HH:mm" />
								</p>
                                <p class="name">${e.price} &euro;</p>
                            </div>
                            <div class="footer">
                                <ul>
                  			     <li class="card-see-tourfriend-event" style="width:50%;" onclick="rotateCard(this)" ><i class="fa fa-mail-forward"></i> <spring:message code="event.seeTourFriend" /></li>
                 			     <li class="card-info-event" style="width:50%;"><a href="event/detailsOfEvent.do?eventId=${e.id}"><spring:message code="eventDetails" /></a></li>
								</ul>	
                            </div>
                        </div>
                    </div> <!-- end front panel -->
                    
                    <div class="back">
                       
                        <div class="content">
                            <div class="main">
                             <div class="user">
                            <img class="img-circle" src="data:image/jpeg;base64,${e.tourFriend.image}" /> 
                      		  </div>
                                <h4 class="text-center">${e.tourFriend.firstName} ${e.tourFriend.lastName}</h4>
                                <div class="stars"><acme:ratingStars stars="${e.tourFriend.rating}"/></div>


										<div class="stats-container">
											<div class="stats">
												<h4>${e.tourFriend.myRoutes.size()}</h4>
												<p>
													<spring:message code="event.routes" />
												</p>
											</div>
											<div class="stats">
												<h4>${e.tourFriend.events.size()}</h4>
												<p>
													<spring:message code="event.events" />
												</p>
											</div>
											<div class="stats">
												<h4>${e.tourFriend.commentTourFriends.size()}</h4>
												<p>
													<spring:message code="event.comments" />
												</p>
											</div>
										</div>

									</div>
								</div>
								<div class="footer footerBack">
									<ul>
										<li class="card-see-tourfriend-event" onclick="rotateCard(this)" style="width:100%;"><i class="fa fa-reply"></i> <spring:message code="event.back" /></li>
										<li  style="width:50%;  cursor:default"></li>
									</ul>
								</div>
							</div> <!-- end back panel -->
						</div> <!-- end card -->
					</div> <!-- end card-container -->
				</div> <!-- end col sm 3 -->



			</jstl:forEach>
		</jstl:if>
	</div>

	<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog"
		 aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<spring:message code="event.delete.confirm" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<a href="javascript:void(0)" class="btn btn-danger btn-ok">Delete</a>
				</div>
			</div>
		</div>
	</div>


	<!-- EditModal -->
	<div class="modal fade" id="editModal" role="dialog">
		<div id="editModalinject" class="modal-dialog">
			<!--  Se inyecta el model del login.jsp -->
		</div>
	</div>

	<script>
        function addurl(url){
            $( "#editModalinject" ).load(url+" #container");
        }

        $('#confirm-delete').on('show.bs.modal', function(e) {
            $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
        });
	</script>

</security:authorize>
