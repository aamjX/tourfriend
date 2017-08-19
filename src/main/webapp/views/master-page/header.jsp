<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<div class="header-top-area">
		<div class="navbar navbar-default navbar-fixed-top active" role="navigation">
			<div class="container">
				<div>
					<ul class="nav navbar-nav navbar-right">
						<a class="navbar-brand" href="javascript:void(0)"><img
								src="/images/nav-logo.png" /></a>
					</ul>
				</div>
			</div>
		</div>

	<security:authorize access="hasRole('TOURFRIEND')">
		<security:authentication property="principal" var="usserAccount" />
		<div id="wrapper">
			<!-- Sidebar -->
			<div id="sidebar-wrapper">
				<ul class="sidebar-nav">
					<li class="sidebar-brand text-center"><a class="navbar-brand" href="/"><img
							src="/images/nav-logo.png" /></a></li>
					<br>
					<li><a
						href="tourFriend/display.do?usserAccountId=${usserAccount.id}"><spring:message
								code="master.page.tourFriend.profile" /></a></li>
					<li><a href="message/actor/list.do"><spring:message
								code="master.page.message.list" /></a></li>
					<li><a href="booking/myBookings.do"><spring:message
								code="master.page.booking" /></a></li>
                    <li><a href="route/list.do"><spring:message
								code="master.page.route" /></a></li>
					<li data-toggle="collapse" data-target="#events"
						class="collapsed active"><a href="javascript:void(0)"><spring:message
								code="master.page.events" /><span class="arrow"></span></a></li>
					<li>
						<ul class="sub-menu collapse" id="events">
							<li><a href="event/allEvents.do">&nbsp;&nbsp;&nbsp;<spring:message
										code="master.page.events.listAll" /></a></li>
							<li><a href="event/myEvents.do">&nbsp;&nbsp;&nbsp;<spring:message
										code="master.page.events.listMy" /></a></li>
						</ul>
					</li>
					<li><a href="coupon/tourfriend/list.do"><spring:message
								code="master.page.coupon.list" /></a></li>
					<li><a href="j_spring_security_logout"><spring:message
								code="master.page.logout" /></a></li>
				</ul>
			</div>
			<!-- /#sidebar-wrapper -->
			<!-- Page Content -->
			<div id="page-content-wrapper">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12">
							<a href="#menu-toggle" class="sign-in-up-btn-sidebar"
								id="menu-toggle"><i class="fa fa-bars"
								style="font-size: 18px"></i></a>
						</div>
					</div>
				</div>
			</div>
			<!-- /#page-content-wrapper -->

		</div>
	</security:authorize>

	<security:authorize access="hasRole('ADMIN')">
		<security:authentication property="principal" var="usserAccount" />
		<div id="wrapper">
			<!-- Sidebar -->
			<div id="sidebar-wrapper">
				<ul class="sidebar-nav">
					
					<li class="sidebar-brand text-center"><a href="#"><security:authentication
								property="principal.username" /></a></li>
					<li><a href="message/actor/list.do"><spring:message
								code="master.page.message.list" /></a></li>
					<li><a href="coupon/admin/list.do"><spring:message
								code="master.page.coupon.list" /></a></li>
								
					<li><a
						href="tourFriend/list.do"><spring:message
								code="master.page.administrator.listUser" /></a></li>

					<li><a
						href="dashboard/admin/display.do"><spring:message
								code="master.page.administrator.dashBoard" /></a></li>

					<li><a href="j_spring_security_logout"><spring:message
								code="master.page.logout" /></a></li>
				</ul>
			</div>
			<!-- /#sidebar-wrapper -->
			<!-- Page Content -->
			<div id="page-content-wrapper">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12">
							<a href="#menu-toggle" class="sign-in-up-btn-sidebar"
								id="menu-toggle"><i class="fa fa-bars"
								style="font-size: 18px"></i></a>
						</div>
					</div>
				</div>
			</div>
			<!-- /#page-content-wrapper -->

		</div>
	</security:authorize>

	<security:authorize access="isAuthenticated()">

	</security:authorize>

	<!-- Menu Toggle Script -->
	<script>
	$("#menu-toggle").click(function(e) {
		e.preventDefault();
		$("#wrapper").toggleClass("toggled");
	});
</script>
   	<noscript>
  	     	 <div class="noscript__wrapper">
         <span class="noscript__msg animated shake">
            <span><spring:message code="noscript.message"/></span>
         </span>
      </div>
   	</noscript>

</div>

