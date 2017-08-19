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
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<security:authorize access="hasRole('TOURFRIEND')">

    <div class="section-mini-padding">
        <h2><spring:message code="booking.event.details.title" /></h2>
    </div>

    <div class="container">
        <div class="row section-content-padding">
            <div class="col-md-12">

                <div class="col-md-6">
                    <p>
                        <span class="span-bold"><spring:message code="booking.details.event.name"/></span>: <jstl:out value="${event.name}"/>
                    </p>
                    <p>
                        <span class="span-bold"><spring:message code="booking.details.event.date"/></span>: <fmt:formatDate value="${event.date}" pattern="dd-MM-yyyy HH:mm" />
                    </p>
                    <p>
                        <span class="span-bold"><spring:message code="booking.details.event.overview"/></span>: <jstl:out value="${event.overview}"/>
                    </p>
                    <p>
                        <span class="span-bold"><spring:message code="booking.details.event.availableSlots"/></span>: <jstl:out value="${event.availableSlots}"/>
                    </p>
                    <p>
                        <a target="_blank" href="route/detailsOfRoute.do?routeId=${event.route.id}"><spring:message code="booking.details.route.link"/></a>
                    </p>
                </div>
                <div class="col-md-1">
                    <p>
                        <span class="span-price"> <jstl:out value="${event.price}"/> &#8364;</span>
                    </p>
                </div>
                <div class="col-md-5">
                    <div id="slider">
                        <a href="javascript:void(0)" class="control_next">></a>
                        <a href="javascript:void(0)" class="control_prev"><</a>
                        <ul>
                            <jstl:forEach var="poi" items="${event.route.pois}">
                                <jstl:forEach var="i" items="${poi.photos}">
                                    <li><img style="height: 300px;" src="data:image/jpeg;base64,${i}" /></li>
                                </jstl:forEach>
                            </jstl:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <hr>

        <jstl:if test="${event.availableSlots <= 0}">
            <div class="alert alert-info">
                <spring:message code="booking.noAvailableSlots"/>
            </div>
        </jstl:if>
    </div>

    <jstl:if test="${event.availableSlots > 0}">

    <div class="section-mini-padding">
        <h4 style="text-align: center;">
            <spring:message code="booking.checkout.title" />
        </h4>
    </div>

    <div class='container'>
        <div class='row section-content-padding'>
            <div class='col-md-12'>
                <div id='mainContentWrapper'>
                    <div class="col-md-8 col-md-offset-2">

                        <a class="btn btn-success btn-select" style="cursor: pointer;">
                            <input type="hidden" class="btn-select-input" id="" name="" value="" />
                            <span class="btn-select-value">...</span>
                            <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                            <ul>
                                <jstl:forEach begin="1" step="1" end="${event.availableSlots}" var="i">
                                    <li>${i}</li>
                                </jstl:forEach>
                            </ul>
                        </a>

                        <hr/>
                        <div class="shopping_cart">
                            <form class="form-horizontal" role="form" action="" method="post" id="payment-form">
                                <div class="panel-group" id="accordion">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-parent="#accordion"><spring:message code="booking.checkout.review" /></a>
                                            </h4>
                                        </div>
                                        <div>
                                            <div class="panel-body">
                                                <div class="items">
                                                    <div class="col-md-8">
                                                        <table class="table table-striped">
                                                            <tr>
                                                                <td colspan="2">
                                                                    <b><spring:message code="booking.checkout.summary" /></b></b>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <ul>
                                                                        <li><spring:message code="booking.checkout.summary.booking" /></li>
                                                                        <li><spring:message code="booking.checkout.summary.paypal" /></li>
                                                                    </ul>
                                                                </td>
                                                                <td>
                                                                    <ul style="list-style-type: none;">
                                                                        <li><b><span class="price-booking"></span> &#8364;</b></li>
                                                                        <li><b><span class="price-booking-paypal"></span> &#8364;</b></li>
                                                                    </ul>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div style="text-align: center;">
                                                            <h4><spring:message code="booking.payment.totalAvailableBalance" /></h4>
                                                            <h5 style="color: green;"><span class="price-available-balance">0</span> &#8364;</h5>
                                                            <h4><spring:message code="booking.payment.totalBooking" /></h4>
                                                            <h5 style="color: orangered;"><span class="price-booking-subtotal"></span> &#8364;</h5>
                                                            <h3><spring:message code="booking.payment.total" /></h3>
                                                            <h3 style="color: green;"><span class="price-booking-total"></span> &#8364;</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <p style="text-align: center;color: #3b3b3b;padding: 10px;background-color: azure;"><spring:message code="booking.balance.current.message"/>${balance} &#8364;</p>

                        <div id="msg-balance-free" class="alert alert-success">
                            <spring:message code="booking.balance.free"/> <span id="balanceAvailable"></span>&#8364;
                        </div>

                        <div id="msg-balance-nofree" class="alert alert-info">
                            <spring:message code="booking.balance.nofree"/>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-3 col-md-4 col-sm-4 col-xs-8 col-centered">
                <a id="paypalURL" href="javascript:void(0)"><img style="border: 1px #d6d6d6 solid;border-radius: 10px;" src="https://www.paypalobjects.com/webstatic/en_US/i/btn/png/silver-rect-paypalcheckout-60px.png"></a>
                <a id="bookNowBtn" href="javascript:void(0)" class="btn btn-success" style="cursor:pointer;width: 100%;"><spring:message code="booking.bookNow" /></a>
            </div>
        </div>
    </div>

    <script>

        $( window ).load(function() {
            $("#paypalURL").hide();
            $("#bookNowBtn").hide();

            $('#msg-balance-free').hide();
            $('#msg-balance-nofree').hide();
        });

        $('.btn-select-value').on('DOMSubtreeModified',function(){

            var numP = $('.btn-select-value').html();

            $('.price-booking').html(${event.price} * parseFloat(numP));

            $('.price-booking-paypal').html(parseFloat(calcFee(${event.price} * parseFloat(numP))).toFixed(2));

            $('.price-available-balance').html(parseFloat(${balance}).toFixed(2));

            $('.price-booking-subtotal').html(parseFloat(parseFloat($('.price-booking').html()) + parseFloat($('.price-booking-paypal').html())).toFixed(2));

            $('.price-booking-total').html(parseFloat(parseFloat($('.price-booking').html()) + parseFloat($('.price-booking-paypal').html() - parseFloat(${balance}))).toFixed(2));


            //PayPal URL

            var url = "";
            url = window.location.protocol+'//'+window.location.hostname+':'+window.location.port+'/'+window.location.pathname.split('/')[1]+'/book.do?';
            url = url + 'numP='+numP;

            $('#paypalURL').attr('href', url)
            $('#bookNowBtn').attr('href', url)

            var total = parseFloat($('.price-booking').html()) + parseFloat($('.price-booking-paypal').html()) - parseFloat(${balance})

            if (total <= 0.0){
                $("#paypalURL").hide();
                $("#bookNowBtn").show();

                $('.price-booking-total').html(0.0);

                $('#msg-balance-free').show();
                $('#msg-balance-nofree').hide();

                $('#balanceAvailable').html(parseFloat(-total).toFixed(2));
            }else{
                $("#paypalURL").show();
                $("#bookNowBtn").hide();

                $('#msg-balance-free').hide();
                $('#msg-balance-nofree').show();
            }
        });

        function calcFee(amount){

            var rango1 = 40.0;
            var rango2 = 65.0;
            var rango3 = 90.0;
            var rango4 = 120.0;

            var res;

            if (amount <= rango1){
                res = amount * 0.18;
            }else if (amount > rango1 && amount <= rango2 ){
                res = amount * 0.15;
            }else if (amount > rango2 && amount <= rango3 ){
                res = amount * 0.12;
            }else if (amount > rango3 && amount <= rango4 ){
                res = amount * 0.1;
            }else{
                res = amount * 0.09;
            }

            return res;
        }

    </script>

    </jstl:if>

</security:authorize>