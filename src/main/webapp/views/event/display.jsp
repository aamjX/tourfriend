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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<div class="section-mini-padding">
	<h2>
		<i class="fa fa-info" aria-hidden="true"></i> - <spring:message code="eventDetails" />
	</h2>
</div>

<div class="container">
	<div class="row">
		<div class="row section-content-padding">

			<jstl:choose>
				<jstl:when test="${event.date.getMonth()+1==1}">
					<jstl:set var="month" value="january" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==2}">
					<jstl:set var="month" value="february" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==3}">
					<jstl:set var="month" value="march" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==4}">
					<jstl:set var="month" value="april" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==5}">
					<jstl:set var="month" value="may" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==6}">
					<jstl:set var="month" value="june" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==7}">
					<jstl:set var="month" value="july" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==8}">
					<jstl:set var="month" value="august" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==9}">
					<jstl:set var="month" value="september" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==10}">
					<jstl:set var="month" value="october" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==11}">
					<jstl:set var="month" value="november" />
				</jstl:when>
				<jstl:when test="${event.date.getMonth()+1==12}">
					<jstl:set var="month" value="december" />
				</jstl:when>
				<jstl:otherwise>
					<jstl:set var="month" value="default" />
				</jstl:otherwise>
			</jstl:choose>
			<div class="col-md-1">
				<br>
				<p class="calendar">
					${event.date.getDate()}
						<em>
							<spring:message code="event.${month}" /> - ${event.date.getYear() + 1900}
						</em>
						<em>
							${event.date.getHours()}:${event.date.getMinutes()}
						</em>
				</p>
			</div>
			<!--./col-md-->

			<div class="col-md-6">
				<h3>
					${event.name} <small> ${event.meetingPoint}</small>
				</h3>

				<p>
					<span class="span-bold"> <spring:message code="event.city" />
					</span> ${event.route.city}
				</p>
				<p>
					<span class="span-bold"> <spring:message
							code="event.duration" />
					</span> ${event.duration}
				</p>
				<p>
					<span class="span-bold"> <spring:message
							code="event.overview" />
					</span> ${event.overview }
				</p>
				<br>
				<p>
					<iframe src="https://www.google.com/maps?q=[${event.meetingPoint}]&output=embed" width="100%" height="400" style="border: 0"></iframe>
				</p>
			</div>
			<!--/. col-md -->

			<div class="col-md-5 text-center">
				<!-- item -->
				<div class="panel-pricing">
					<div class="panel-heading">
						<img class="photoBig" src="data:image/jpeg;base64,${event.tourFriend.image}"><br>
						<a
								href="tourFriend/display.do?usserAccountId=${event.tourFriend.userAccount.id}">${event.tourFriend.firstName}
							${event.tourFriend.lastName}</a>
						<acme:ratingStars stars="${event.tourFriend.rating}" />
					</div>
					<div class="panel-body text-center">
						<p>
							<strong>${event.price} &euro;</strong>
						</p>
					</div>
					<ul class="list-group text-center">
						<li class="list-group-item"><span class="span-bold"><spring:message
								code="event.maxPeople" />:</span> ${event.maxPeople}</li>
						<li class="list-group-item"><span class="span-bold"><spring:message
								code="event.minPeople" />:</span> ${event.minPeople}</li>
						<li class="list-group-item"><span class="span-bold"><spring:message
								code="booking.details.event.availableSlots" />:</span>
							${event.getAvailableSlots()}</li>
					</ul>

					<jstl:set var="currentDate" value="<%=new java.util.Date()%>"/>
					<fmt:formatDate var="now" value="${currentDate}" pattern="dd-MM-yyyy HH:mm:ss"/>
					<sec:authentication var="principal" property="principal" />


					<div class="panel-footer panel panel-danger">
						<ul>
							<jstl:if test="${event.date > now && event.tourFriend.userAccount.id != principal.id && event.getAvailableSlots() > 0}">
							<li class="info-booking" style="width: 40%;"><a
									href="booking/checkout.do?idEvent=${event.id}"><i class="fa fa-calendar" aria-hidden="true"></i> <spring:message
									code="event.book" /></a></li>
							<li class="cancel-booking" style="width: 30%;"><a
									data-toggle="modal" data-target="#createModal"
									onclick="create('message/actor/create.do?tourfriendId='+${event.tourFriend.id})">
								<i class="fa fa-envelope-open" aria-hidden="true"></i> <spring:message code="event.contactOwner" />
							</a></li>
							</jstl:if>
							<jstl:if test="${event.tourFriend.userAccount.id != principal.id}">
							<li class="report-booking" style="width: 30%;">
								<a data-toggle="modal" data-target="#modalReport"><i class="fa fa-flag" aria-hidden="true"></i> <spring:message code="event.report" /></a>
							</li>
							</jstl:if>
						</ul>
					</div>
				</div>

				<div id="slider">
					<a href="javascript:void(0)" class="control_next">></a> <a
						href="javascript:void(0)" class="control_prev"><</a>
					<ul>
						<jstl:forEach var="p" items="${event.route.pois}">
							<jstl:forEach var="i" items="${p.photos}">
								<li><img style="height: 300px;" src="data:image/jpeg;base64,${i}" /></li>
							</jstl:forEach>
						</jstl:forEach>
					</ul>
				</div>

			</div>
			<!--/row-->
			<div class="col-md-5 col-md-offset-7">

			</div>
		</div>
	</div>
</div>


<div class="mini-section-mini-padding" style="margin-bottom: 20px;">
	<h3>
		<i class="fa fa-users" aria-hidden="true"></i> - <spring:message code="event.users" />
	</h3>
</div>

<div class="container">

	<div class="row">
		<div class="col-md-12 " id="quote-carousel">
			<jstl:forEach items="${tourFriendAttendSameEvent}" var="tourFriendAttendant">
				<img class="photo" id="Id${tourFriendAttendant.id}"
					 onclick="myFunction(${tourFriendAttendant.id})"
					 onload="assingBubbles(${tourFriendAttendant.id})"
					 src="data:image/jpeg;base64,${tourFriendAttendant.image}" />
				<div id="tip${tourFriendAttendant.id}" style="display: none;">
						${tourFriendAttendant.firstName}</div>
			</jstl:forEach>
		</div>
		<jstl:if test="${isEnterCode==true && event.tourFriend.userAccount.id == principal.id}">
			<div class="row">
				<div class="col-md-12">
					<button type="button" class="btn btn-default mano" id="reply-button" style="width: 100%;margin-bottom: 15px;" data-toggle="modal"
							data-target="#myModal">
						<spring:message code="event.enterCode" />
					</button>

					<div class="modal fade" id="myModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title">
										<spring:message code="event.enterCode" />
									</h4>
								</div>
								<div class="modal-body">
									<form action="event/enterCode.do" method="get">
										<div class="row">
											<div class="col-md-2"></div>
											<div class="col-md-8">
												<div class="form-group">
													<input type="text" class="form-control" name="code"
														   id="code">
												</div>
												<input id="eventId" name="eventId" type="hidden"
													   value="${event.id}" />
											</div>
											<div class="col-md-2"></div>
										</div>
										<div class="row">
											<div class="col-md-12 text-center">
												<button type="submit" class="btn btn-default mano" id="green-button">
													<spring:message code="event.confirmation" />
												</button>
											</div>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default mano"
											data-dismiss="modal">
										<spring:message code="event.close" />
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</jstl:if>
	</div>
</div>
</div>
</div>

<div class="mini-section-mini-padding">
	<h3>
		<i class="fa fa-comments" aria-hidden="true"></i> - <spring:message code="event.comments" />
	</h3>
</div>

<div class="container section-content-padding">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="well well-sm">
				<div class="row">
					<div class="col-xs-12 col-md-12 text-center">
						<h1 class="rating-num">
							<fmt:formatNumber value="${ratingEventSameRoute}" pattern="0.00" />
							<small> / 5</small>
						</h1>
						<div class="rating">
							<div class="testimonial-writer-company">
								<input id="input-4-${event.id}" value="${event.rating}"
									   class="rating-loading" data-size="xs">
							</div>
						</div>
						<div>
							<span class="glyphicon glyphicon-user"> </span>
							<jstl:out value=" ${numOfCommentOfEventOfARoute}" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

    $(document).on('ready', function(){
        var a ="#input-4-";
        var b = ${event.id};
        var res = a.concat(b);
        $(res).rating({displayOnly: true});
    });
</script>

<div class="container" style="padding-top: 30px">
	<div class="row">

		<jstl:forEach var="c" items="${commentEvents}">
			<div class="col-sm-6">
				<div id="tb-testimonial"
					 class="testimonial testimonial-primary-filled">
					<div class="testimonial-section">
						<jstl:out value="${c.description}" />
					</div>
					<div class="testimonial-desc">
						<img src="data:image/jpeg;base64,${c.tourFriendCreator.image}" alt="" />
						<div class="testimonial-writer">
							<div class="testimonial-writer-name">${c.tourFriendCreator.firstName}
									${c.tourFriendCreator.lastName}</div>
							<div class="testimonial-writer-designation">
								<fmt:formatDate value="${c.creationMoment}"
												pattern="dd-MM-yyyy" />
							</div>
							<div class="rating">
								<div class="testimonial-writer-company">
									<input id="input-4-${c.id}" value="${c.score}"
										   class="rating-loading" data-size="xs">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<script>
                $(document).on('ready', function(){
                    var a ="#input-4-";
                    var b = ${c.id};
                    var res = a.concat(b);
                    $(res).rating({displayOnly: true});
                });
			</script>
		</jstl:forEach>

	</div>
</div>

<!-- CreateMessageModal -->
<div class="modal fade" id="createModal" role="dialog">
	<div id="createModalinject" class="modal-dialog">
		<!--  Se inyecta el model del edit.jsp -->
	</div>
</div>

<div class="modal fade" id="modalReport" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title"><spring:message code="event.modal.report" /></h4>
			</div>
			<form action="event/report.do" method="post">
				<div class="modal-body">
					<textarea name="msnBody" rows="5" cols="5" class="form-control reportArea" required placeholder="<spring:message code="event.textArePlaceHolder" />"></textarea>
					<input type="hidden" name="enventId" value="${event.id}" />
					<input type="hidden"  name="language" value=<spring:message code="event.language" /> />

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default mano" data-dismiss="modal"><spring:message code="event.modal.report.close" /></button>
					<button type="submit" class="btn btn-primary mano"><spring:message code="event.modal.report.send" /></button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
    function create(url){
        $( "#createModalinject" ).load(url + " #container");
    }

    function myFunction(id) {

        element = document.getElementById("Id"+id);
        elements = document.getElementsByClassName("photo");
        [].forEach.call(elements, function(el) {
            el.classList.remove("photoActive");
        });
        element.classList.add("photoActive");

    }

    function removeFocus(element){
        setTimeout(function(){ element.classList.remove("photoActive") }, 800);
    }

    function assingBubbles(id) {
        $('#Id'+id).bubbletip($('#tip'+id),{deltaDirection:'down', bindShow:'click'});

    }
</script>

