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
<%@taglib prefix="acme" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div class="section-mini-padding">
	<h2>
		<i class="fa fa-user-circle"></i> -

		<jstl:if test="${ownProfile}">
			<spring:message code="profile.own.title" />
		</jstl:if>

		<jstl:if test="${!ownProfile}">
			<spring:message code="profile.title" />
		</jstl:if>

	</h2>
</div>

<style>
.itemsContainer:hover .play {
	display: block
}

.play {
	position: absolute;
	display: none;
	top: 20%;
	width: 40px;
	margin: 0 auto;
	left: 0px;
	right: 0px;
	z-index: 100
}
</style>

<body>

	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1 span well">
				<jstl:if test="${resp == 'SUCCESS'}">
					<div class="alert alert-success">
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<spring:message code="tourFriend.withdraw.success.paypal" />
					</div>
				</jstl:if>

				<jstl:if test="${resp == 'FAILURE'}">
					<div class="alert alert-danger alert-dismissable">
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<strong><spring:message
								code="tourFriend.withdraw.error.paypal" /></strong>
					</div>
				</jstl:if>

				<div class="" style="background-color: #ededed;">

					<jstl:if test="${ownProfile}">
						<div class="col-md-12 section-content-padding text-right">
							<span><i class="fa fa-money"></i> <spring:message
									code="tourfriend.profile.available.balance" /> <jstl:out
									value="${tf.availableBalance}" /> &#8364;</span><br> <a
								href="tourFriend/withdraw.do"><spring:message
									code="tourfriend.profile.balance.withdraw" /></a><br> <br>
							<span><spring:message
									code="tourfriend.profile.available.points" /> <jstl:out
									value="${tf.availablePoints}" /></span>
						</div>
					</jstl:if>

					<div class="text-center">

						<div class="itemsContainer">
							<div class="image">

								<img src="data:image/jpeg;base64,${tf.image}" name="aboutme"
									class="img-circle" style="max-width: 225px; max-height: 225px">

							</div>
							<jstl:if test="${ownProfile}">
							<div class="">
								<a class="mano" data-toggle="modal" data-target="#modalImage">
									<span class="glyphicon glyphicon-camera fa-2x"></span>
								</a>
							</div>
							</jstl:if>
						</div>
						<br>
						<jstl:if test="${tf.rating != 'NaN'}">
							<acme:ratingStars stars="${tf.rating}" />
						</jstl:if>
						<h3>
							<c:out value="${tf.firstName} ${tf.lastName}"></c:out>
						</h3>
						<jstl:if test="${ownProfile}">

							<strong><spring:message code="tourfriend.profile.email" />:</strong>
							<jstl:out value="${tf.email}" />
							<br>
							<strong><spring:message code="tourfriend.profile.phone" />:</strong>
							<jstl:out value="${tf.phone}" />
							<br>
						</jstl:if>
						<em>
							<strong><spring:message code="tourfriend.profile.age" />:</strong>
							<jstl:set var="datePartsBirthday" value="${fn:split(tf.dateOfBirth, '-')}"></jstl:set>
							<jstl:set var="dayAndHourBirthday" value="${fn:split(datePartsBirthday[2], ' ')}"></jstl:set>
							<jstl:out value="${dayAndHourBirthday[0]}-${datePartsBirthday[1]}-${datePartsBirthday[0]}"/>
						</em>
						<jstl:if test="${ownProfile}">
						<div class="row">
							<div class="col-md-12 text-center">
							<br><br><a style="cursor: pointer"  id="green-button" data-toggle="modal" data-target="#editProfileModal" class="btn btn-default"><spring:message
									code="tourfriend.profile.editProfile" /></a>
							<a style="cursor: pointer"  id="delete-button" href="/tourFriend/setPassword.do" class="btn btn-default"><spring:message
									code="tourfriend.profile.setPassword" /></a> </div></div>
						</jstl:if>
						<hr>
						<div>
							<!-- Nav tabs -->
							<ul class="nav nav-tabs" id="profile-tabs" role="tablist">
								<li role="presentation" class="active"><a href="#aboutMe"
									aria-controls="home" role="tab" data-toggle="tab"><spring:message
											code="tourfriend.profile.aboutme" /></a></li>
								<li role="presentation"><a href="#nextEvents"
									aria-controls="profile" role="tab" data-toggle="tab"><spring:message
											code="tourfriend.profile.nextEvents" /></a></li>
								<li role="presentation"><a href="#lastComments"
									aria-controls="messages" role="tab" data-toggle="tab"><spring:message
											code="tourfriend.profile.lastComments" /></a></li>
							</ul>
							<br>
						</div>
					</div>
					<!-- Tab panes -->
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane active" id="aboutMe">
							<c:out value="${tf.aboutMe}"></c:out>
						</div>
						<div role="tabpanel" class="tab-pane" id="nextEvents">
							<c:forEach items="${events}" var="e">
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-8 nextEvents">
										<a href="/event/detailsOfEvent.do?eventId=${e.id}"
											class="btn btn-default mano" style="width: 100%; height: auto"><i
											class="fa fa-eye"></i> - ${e.name}</a>
									</div>
									<div class="col-md-2"></div>
								</div>
								<br>
							</c:forEach>
						</div>
						<div role="tabpanel" class="tab-pane" id="lastComments">

							<c:forEach items="${comments}" var="comment">
								<div class="row">
									<div class="col-md-2">
										<img src="data:image/jpeg;base64,${comment.tourFriendCreator.image}"
											class="img-circle"
											style="width: 100px; height: auto; margin: 0 auto">
										<p class="text-center">
											<acme:ratingStars stars="${comment.score}" />
										</p>
									</div>
									<script>
										$(document).on('ready', function() {
											var a = "#input-4-";
											var b = $
											{
												comment.id
											}
											;
											var res = a.concat(b);
											$(res).rating({
												displayOnly : true
											});
										});
									</script>
									<div class="col-md-10">
										<div class="panel panel-default">
											<div class="panel-body">
												<p>
													<c:out value="${comment.description}"></c:out>
												</p>
												<p class="text-right">
													<jstl:set var="dateParts" value="${fn:split(comment.creationMoment, '-')}"></jstl:set>
													<jstl:set var="dayAndHour" value="${fn:split(dateParts[2], ' ')}"></jstl:set>
													<jstl:set var="hourAndMinutes" value="${fn:split(dayAndHour[1], ':')}"></jstl:set>

													<jstl:out value="${dayAndHour[0]}-${dateParts[1]}-${dateParts[0]} ${hourAndMinutes[0]}:${hourAndMinutes[1]}"/>

												</p>
											</div>
										</div>
									</div>
								</div>
								<hr>
							</c:forEach>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<!-- CreateMessageModal -->
<div id="editProfileModal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="row">
				<div
					class="col-xs-12 col-sm-6 col-md-10 col-sm-offset-2 col-md-offset-1">
					<form:form role="form" action="profile/edit.do" modelAttribute="tf">
						<form:hidden path="id" />
						<form:hidden path="version" />

						<hr class="colorgraph">

						<div class="row">

							<div class="col-xs-12 col-sm-6 col-md-6">
								<div class="form-group">
									<acme:textbox code="tourFriend.phone" path="phone"
										css="form-control input-lg" placeholder="${phonem }"
										required="required" />
								</div>
							</div>

							<div class="col-xs-12 col-sm-6 col-md-6">
								<div class="form-group">
									<acme:textbox code="tourFriend.email" path="email" type="email"
										css="form-control input-lg" placeholder="${emailm }"
										required="required" />

								</div>
							</div>
						</div>


						<div class="form-group">
							<acme:textarea code="tourfriend.profile.aboutme" path="aboutMe"
								css="form-control input-lg" placeholder="${aboutmem}" />

						</div>



						<hr class="colorgraph">
						<div class="row text-center">

							<acme:submit name="save" code="tourFriend.save"
								css="btn btn-primary mano" style="width: 80%" />

						</div>
						<br />
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="modalImage" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">
					<spring:message code="profile.modal.changeImage" />
				</h4>
			</div>
			<form action="profile/changeImage.do" method="post"
				enctype="multipart/form-data" onsubmit="return checkImages()">
				<div class="modal-body">

					<div class="alert alert-danger" id="showError1"
						style="display: none;" role="alert">
						<p>
							<spring:message code="poi.showError1" />
						</p>
					</div>
					<div class="alert alert-danger" id="showError2"
						style="display: none;" role="alert">
						<p>
							<spring:message code="poi.showError2" />
						</p>
					</div>
					<div class="alert alert-danger" id="showError3"
						style="display: none;" role="alert">
						<p>
							<spring:message code="poi.showError3" />
						</p>
					</div>
					<div class="alert alert-danger" id="showError4"
						style="display: none;" role="alert">
						<p>
							<spring:message code="poi.showError4" />
						</p>
					</div>
					<div class="alert alert-danger" id="showError5"
						style="display: none;" role="alert">
						<p>
							<spring:message code="poi.showError5" />
						</p>
					</div>
					<div class="alert alert-danger" id="showError6"
						style="display: none;" role="alert">
						<p>
							<spring:message code="poi.showError6" />
						</p>
					</div>

					<input type="file" class="file" name="file" id="f1">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default mano"
						data-dismiss="modal">
						<spring:message code="profile.modal.changeImage.close" />
					</button>
					<button type="submit" class="btn btn-primary mano">
						<spring:message code="profile.modal.changeImage.send" />
					</button>
				</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<jstl:if test="${editLanguage}">
	<acme:editLanguageModal />
</jstl:if>





<script>
	function create(url) {
		$("#myModalinject").load(url + " #container");
	}
</script>

<script>
	function checkImages() {

		auxHiddenErrors();
		if (!document.getElementById("f1").value.length == 0) {
			if (!/.(jpeg|jpg|png)$/i.test(document.getElementById("f1").value)) {
				//Error extension
				showErrors("showError1");
				return false;
			} else {

				var imageSize = document.getElementById('f1');
				if (imageSize.files[0].size > 4000000) {
					showErrors("showError3");
					return false;
				}
			}

		} else {
			//Error campo requerido
			showErrors("showError6");
			return false;
		}
	}

	function showErrors(show) {
		div = document.getElementById(show);
		div.style.display = '';
	}

	function auxHiddenErrors() {
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
