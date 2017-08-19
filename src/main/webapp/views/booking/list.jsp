<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<jsp:useBean id="now" class="java.util.Date" />

<security:authorize access="hasRole('TOURFRIEND')">

    <div class="section-mini-padding">
        <h2><i class="fa fa-calendar"></i> - <spring:message code="booking.title" /></h2>
    </div>

    <div class="container">
        <div class="row section-content-padding">
            <div class="[ col-xs-12 col-sm-12 ]">

                <!-- Error de reservas en PayPal -->
                <jstl:if test="${paypalError == true}">
                    <div class="alert alert-danger">
                       <spring:message code="booking.paypal.generalError"/>
                    </div>

                    <a class="btn btn-default mano btn-block" style="margin-bottom: 20px;" id="reply-button" href="event/allEvents.do"><spring:message code="booking.back.events" /></a>
                </jstl:if>

                <!-- Cancelar la reserva en PayPal -->
                <jstl:if test="${param.paypalCancel == true}">
                    <div class="alert alert-danger">
                        <spring:message code="booking.paypal.cancelOrAlreadyPayed"/>
                    </div>
                </jstl:if>

                <!-- Errores al cancelar la reserva -->
                <jstl:if test="${errorBooking == true}">
                    <div class="alert alert-danger">
                        <spring:message code="booking.cancel.error"/>
                    </div>
                </jstl:if>

                <jstl:if test="${errorBooking == false}">
                    <div class="alert alert-info">
                        <spring:message code="booking.cancel.success"/>
                    </div>
                </jstl:if>

                <ul class="booking-list">

                    <jstl:forEach items="${bookings}" var="b">

                        <jstl:set var="dateParts" value="${fn:split(b.event.date, '-')}"></jstl:set>
                        <jstl:set var="dayAndHour" value="${fn:split(dateParts[2], ' ')}"></jstl:set>

                        <li class="col-sm-6">
                            <time datetime="${b.event.date}">
                                <span class="day">${dayAndHour[0]}</span>
                                <span class="month">${dateParts[1]}</span>
                                <span class="year">${dateParts[0]}</span>
                            </time>
                            <div class="info">
                                <h2 class="title">${b.event.name}</h2>
                                <p class="desc"><span class="span-bold"><spring:message code="booking.place.hour"/></span>: ${b.event.meetingPoint} - <fmt:formatDate value="${b.event.date}"
                                                                                                                                                                      pattern="HH:mm" /></p>
                                <p class="desc"><span class="span-bold"><spring:message code="booking.code.value"/></span>: ${b.code.value}</p>
                                <ul>
                                    <li class="info-booking" style="width:50%;"><a href="booking/detailsOfBooking.do?bookingId=${b.id}"><span class="fa fa-info"></span> <spring:message code="booking.details.btn" /></a></li>

                                    <jstl:if test="${b.isCancelled}">
                                        <li class="cancel-booking" style="width:50%; color:white; background-color: #c73636!important;"><spring:message code="booking.already.cancelled" /></li>
                                    </jstl:if>

                                    <jstl:if test="${!b.isCancelled && b.event.date > now}">
                                        <li class="cancel-booking" style="width:50%;" onclick="cancel('${b.event.date}', ${b.id})"><a data-toggle="modal" data-target="#myModal"><span class="fa fa-times"></span> <spring:message code="booking.cancel" /></a></li>
                                    </jstl:if>
                                </ul>
                            </div>
                        </li>

                    </jstl:forEach>
                </ul>
            </div>
        </div>
    </div>

    <!-- Modal para la confirmar que cancela la reserva y se le informa de que perdera su dinero o no -->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog modal-lg">

            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><spring:message code="booking.cancel.modal.title" /></h4>
                </div>
                <div class="modal-body">
                    <p id="mdlIntegro" style="color:white;"><spring:message code="booking.cancel.modal.content.integro" /></p>
                    <p id="mdlNoIntegro" style="color:white;"><spring:message code="booking.cancel.modal.content.nointegro" /></p>
                </div>
                <div class="modal-footer">
                    <a id="urlCancel" type="button" href="javascript:void(0)" class="btn btn-danger" style="cursor:pointer"><spring:message code="booking.cancel.modal.cancel" /></a>
                    <button type="button" class="btn btn-default" data-dismiss="modal" style="cursor:pointer"><spring:message code="booking.cancel.modal.close" /></button>
                </div>
            </div>

        </div>
    </div>

    <script>

        $( window ).load(function() {
            $("#mdlIntegro").hide();
            $("#mdlNoIntegro").hide();
        });

        function cancel(date, id){

            var tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            var event = new Date(date);

            if ( tomorrow < event ){
                $("#mdlIntegro").show();
                $("#mdlNoIntegro").hide();
                $(".modal-body").attr("style", "background-color:#5bc0de;");
            }else{
                $("#mdlNoIntegro").show();
                $("#mdlIntegro").hide();
                $(".modal-body").attr("style", "background-color:#d9534f;");
            }

            $("#urlCancel").attr("href", "booking/cancel.do?bookingId="+id);
        }

    </script>

</security:authorize>