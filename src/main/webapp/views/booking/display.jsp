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
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<div class="section-mini-padding">
	<h2>
		<i class="fa fa-calendar-check-o"></i> - <spring:message code="booking.details.title" />
	</h2>
</div>



<div class="container">
	<div class="row section-content-padding">
		<!-- Error de reservas en PayPal -->
		<jstl:if test="${commentError == true}">
			<div class="alert alert-danger">
				<spring:message code="booking.comment.error"/>
			</div>
		</jstl:if>
		<jstl:if test="${commentError == false}">
			<div class="alert alert-success">
				<spring:message code="booking.comment.success"/>
			</div>
		</jstl:if>

		<ul class="booking-list">
			<jstl:set var="dateParts" value="${fn:split(booking.event.date, '-')}"></jstl:set>
			<jstl:set var="dayAndHour" value="${fn:split(dateParts[2], ' ')}"></jstl:set>
			<jstl:set var="hourAndMinutes" value="${fn:split(dayAndHour[1], ':')}"></jstl:set>

			<li class="col-sm-6"><time datetime="${booking.event.date}">
					<span class="day">${dayAndHour[0]}</span> <span class="month">${dateParts[1]}</span>
					<span class="year">${dateParts[0]}</span>
				</time>
				<div class="info">
					<p class="desc">
						<span class="span-bold"><spring:message
								code="booking.place.hour" /></span>: ${booking.event.meetingPoint} -
						${hourAndMinutes[0]}:${hourAndMinutes[1]}
					</p>
					<p class="desc">
						<span class="span-bold"><spring:message
								code="booking.code.value" /></span>: ${booking.code.value}
					</p>
					<p class="desc">
						<span class="span-bold"><spring:message
								code="booking.number.people" /></span>: ${booking.numPeople}
					</p>
					<p class="desc">
						<span class="span-bold"><spring:message
								code="booking.payment.total" /></span>: ${booking.payment.amount}
						&#8364;
					</p>
				</div></li>
		</ul>
	</div>
</div>

<div class="mini-section-mini-padding">
	<h3>
		<i class="fa fa-server" aria-hidden="true"></i> - <spring:message code="booking.event.details.title" />
	</h3>
</div>

<div class="container">
	<div class="row section-content-padding">
		<div class="col-md-12">

			<div class="col-md-6">
				<p>
					<span class="span-bold"><spring:message
							code="booking.details.event.name" /></span>:
					<a target="_blank" href="/event/detailsOfEvent.do?eventId=${booking.event.id}">
						<jstl:out value="${booking.event.name}" />
					</a>
				</p>
				<p>
					<span class="span-bold"><spring:message
							code="booking.details.event.overview" /></span>:
					<jstl:out value="${booking.event.overview}" />
				</p>
				<p>
					<span class="span-bold"><spring:message
							code="booking.details.event.city" /></span>:
					<jstl:out value="${booking.event.route.city}" />
				</p>
				<p>
					<span class="span-bold"><spring:message
							code="booking.details.event.duration" /></span>:
					<jstl:out value="${booking.event.duration}" />
				</p>
				<p>
					<span class="span-bold"><spring:message
							code="booking.details.event.max" /></span>:
					<jstl:out value="${booking.event.maxPeople}" />
				</p>
				<p>
					<span class="span-bold"><spring:message
							code="booking.details.event.min" /></span>:
					<jstl:out value="${booking.event.minPeople}" />
				</p>
				<p>
					<a target="_blank" href="route/detailsOfRoute.do?routeId=${booking.event.route.id}"><spring:message
							code="booking.details.route.link" /></a>
				</p>
			</div>
			<div class="col-md-1">
				<p>
					<span class="span-price"> <jstl:out
							value="${booking.event.price}" /> &#8364;
					</span>
				</p>
			</div>
			<div class="col-md-5">
				<div id="slider">
					<a href="javascript:void(0)" class="control_next">></a> <a
						href="javascript:void(0)" class="control_prev"><</a>
					<ul>
						<jstl:forEach var="poi" items="${booking.event.route.pois}">
							<jstl:forEach var="i" items="${poi.photos}">
								<li><img style="height: 300px;" src="data:image/jpeg;base64,${i}" /></li>
							</jstl:forEach>
						</jstl:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>


<jstl:if
	test="${checkEventPass == true &&  checkPrincipalNoCreatorEvent == true && checkCodeVerified == true}">
	<div class="container">
		<spring:message code="booking.commentPlaceholder"
			var="commentPlaceholder" />
		<div class="row">
			<div class="col-md-12">
				<div class="well well-sm">
					<div class="text-right">
						<a class="btn btn-success" id="open-review-box"><spring:message
								code="booking.leaveComment" /></a>
					</div>

					<div class="row" id="post-review-box" style="display: none;">
						<div class="col-md-12">
							<form:form action="comment/editCommentEvent.do"
								modelAttribute="commentEvent">

								<form:hidden path="id" />
								<form:hidden path="version" />
								<form:hidden path="creationMoment" />
								<form:hidden path="tourFriendCreator" />
								<form:hidden path="event" />

								<input id="ratings-hidden" name="rating" type="hidden">
								<acme:textarea path="description" required="required"
									css="form-control animated" cols="60" id="new-review"
									placeholder="${commentPlaceholder}" rows="5" />

								<div class="text-right">
									<div class="ratingInputBooking">
									<form:input path="score" class="rating rating-loading"
										id="input-2-xs" name="input-2" data-step="1"
										required="required" data-size="xs" />
									<a class="btn btn-danger btn-md" href="#" id="close-review-box"
										style="display: none; margin-right: 10px;"> <span
										class="glyphicon glyphicon-remove"></span> <spring:message
											code="booking.cancel" />
									</a>
									<acme:submit name="save" code="booking.sendComment"
										css="btn btn-success btn-md" />
									</div>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</jstl:if>

<div class="mini-section-mini-padding" style="margin-bottom: 20px;">
	<h3>
		<i class="fa fa-users" aria-hidden="true"></i> - <spring:message code="booking.event.tourfriends" />
	</h3>
</div>

<div class="container">
	<div class="row">
		<jstl:forEach var="t" items="${tourFriendAttendSameEvent}">
			<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4 col-xl-3">
				<ul>
					<li style="list-style: none;" id="listGroupItem">
						<div class="row">
							<div class="col-md-12">
								<div>
									<div class="text-left">
										<div class="col-xs-3 col-sm-3">
											<img src="data:image/jpeg;base64,${t.image}" class="img-responsive img-circle" />
										</div>
										<span class="name">${t.firstName}</span><span class="name">
											${t.lastName}</span><br />
										<jstl:if
											test="${checkEventPass == true && isCodeVerifiedByTourfriend.get(t.id) == true}">
											<a data-toggle="popover" data-trigger="hover" data-content="${t.phone}"><span
												class="glyphicon glyphicon-earphone text-muted c-info"></span></a>
											<a data-toggle="popover" data-trigger="hover" data-content="${t.email}"><span
												class="fa fa-comments text-muted c-info"></span></a>
										</jstl:if>
									</div>
									<br />

								</div>

							</div>
						</div>
						<div class="clearfix"></div> <br />
					</li>
				</ul>
			</div>
		</jstl:forEach>
	</div>
	<br>
	<div class="col-md-12 text-center">
		<jstl:if test="${checkEventPass == true and fn:length(tourFriendAttendSameEvent) gt 1}">
		<button style="cursor: pointer; width:50%;" type="button"
			class="btn btn-success" id="reply-button" data-toggle="modal"
			data-target="#leaveCommentTourFriendModal">
			<spring:message code="booking.leaveComment" />
		</button>
		</jstl:if>
	</div>
</div>
<br/>
<div class="mini-section-mini-padding">
	<h3>
		<i class="fa fa-comments" aria-hidden="true"></i> - <spring:message code="event.comments" />
	</h3>
</div>
<br />
<br />


<div class="container">
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
								<input id="input-4-${booking.event.id}"
									value="${booking.event.rating}" class="rating-loading"
									data-size="xs">
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
	                    var b = ${booking.event.id};
	                    var res = a.concat(b);
	                    $(res).rating({displayOnly: true});
	                });
			</script>

<div class="container">
	<div class="row section-content-padding">
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
							<div class="testimonial-writer-name">${c.tourFriendCreator.firstName}${c.tourFriendCreator.lastName}</div>
							<div class="testimonial-writer-designation">
								<fmt:formatDate value="${c.creationMoment}" pattern="dd-MM-yyyy" />
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

<style>
.input-hidden {
  position: absolute;
  left: -9999px;
}

input[type=radio]:checked + label>img {
  border: 1px solid #fff;
  box-shadow: 0 0 3px 3px #090;
}

/* Stuff after this is only to make things more pretty */
input[type=radio] + label>img {
  border: 1px dashed #444;
  width: 150px;
  height: 150px;
  transition: 500ms all;
}

</style>
<!-- LeaveCommentTourFriendModal -->
<div id="leaveCommentTourFriendModal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<spring:message code="booking.commentPlaceholder"
			var="commentPlaceholder" />
			
			<form action="comment/editCommentTourFriend.do" method="post">
			<security:authentication property="principal" var="principal"/>
			<div class="card card-container text-center">
				<input type="hidden" name="bookingId" id="bookingId" class="input-hidden" value="${booking.id}" />
				<h3><spring:message code="booking.chooseTourFriend"/></h3>
				<br/>
				<jstl:forEach items="${tourFriendAttendSameEvent}" var="t">
					<jstl:if test="${t.userAccount.id ne principal.id}">
					<input 
					  type="radio" name="tourfriendID" 
					  id="${t.userAccount.username}" class="input-hidden" value="${t.id}" />
					<label for="${t.userAccount.username}">
					  <img 
					    src="data:image/jpeg;base64,${t.image}" class="mano" alt="${t.userAccount.username}"/>
					</label>
					</jstl:if>
				</jstl:forEach>
				<br/><br/>
				<textarea name="comment" required="required" cols="42" id="new-review"
					placeholder="${commentPlaceholder}" rows="5"></textarea>
				<br/>
				<div class="text-center">
				<div class="ratingInputBooking">
				<input class="rating rating-loading"
					id="input-3-xs" name="rating" data-min="0" data-max="5"
					data-step="1" data-size="xs" required="required" />
				<br/>
				<button type="submit" name="save" id="green-button" class="btn btn-default mano">
					<spring:message code="booking.sendComment"/>
				</button>
				</div>
				</div>
			</div>

			</form>
	</div>
</div>

