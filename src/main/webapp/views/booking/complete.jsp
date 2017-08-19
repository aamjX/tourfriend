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
        <h2 style="text-align: center;">
            <spring:message code="booking.checkout.complete" />
        </h2>
    </div>

    <div class='container'>
        <div class='row section-content-padding'>
            <div class='col-md-12'>
                <div id='mainContentWrapper'>
                    <div class="col-md-8 col-md-offset-2">
                        <hr/>
                        <div class="shopping_cart">
                            <form class="form-horizontal" role="form" action="" method="post" id="payment-form">
                                <div class="panel-group" id="accordion">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-parent="#accordion"><spring:message code="booking.checkout.summary" /></a>
                                            </h4>
                                        </div>
                                        <div>
                                            <div class="panel-body">
                                                <div class="items">
                                                    <div class="col-md-8">
                                                        <table class="table table-striped">
                                                            <tr>
                                                                <td colspan="2"><jstl:out value="${event.name}"/></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <ul>
                                                                        <li><jstl:out value="${numP}"/> x <spring:message code="booking.checkout.summary.booking" /></li>
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
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-12 col-centered" style="text-align: center">
                <a href="booking/myBookings.do" style="cursor:pointer;" class="btn btn-info"><spring:message code="booking.seeMyBookings"/></a>
            </div>
        </div>
    </div>

    <script>

        $( window ).load(function() {

            $('.price-booking').html(${event.price} * parseFloat(${numP}));

            $('.price-booking-paypal').html(parseFloat(calcFee(${event.price} * parseFloat(${numP}))).toFixed(2));

            $('.price-available-balance').html(parseFloat(${balance}).toFixed(2));

            $('.price-booking-subtotal').html(parseFloat(parseFloat($('.price-booking').html()) + parseFloat($('.price-booking-paypal').html())).toFixed(2));

            $('.price-booking-total').html(parseFloat(parseFloat($('.price-booking').html()) + parseFloat($('.price-booking-paypal').html() - parseFloat(${balance}))).toFixed(2));

            var total = parseFloat($('.price-booking').html()) + parseFloat($('.price-booking-paypal').html()) - parseFloat(${balance})

            if (total <= 0.0){
                $('.price-booking-total').html(0.0);
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
</security:authorize>