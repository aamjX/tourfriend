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

<security:authorize access="hasRole('TOURFRIEND')">

	<jstl:if test="${availableBalance < 1.0}">
		<div class="section-mini-padding">
			<h2><spring:message code="tourFriend.withdraw.balance" /></h2>
		</div>

		<div class="container">
			<div class="row section-content-padding">
				<div class="[ col-xs-10 col-xs-offset-1 col-sm-offset-1 col-sm-10 text-center ]">
					<div class="alert alert-warning">
						<spring:message code="tourFriend.withdraw.error.notenough" />
					</div>

					<a class="btn btn-primary" style="cursor:pointer;" href="tourFriend/display.do?usserAccountId=${tf.userAccount.id}"><spring:message code="tourFriend.withdraw.back.profile" /></a>
				</div>
			</div>
		</div>
	</jstl:if>

	<jstl:if test="${availableBalance >= 1.0}">
		<div class="section-mini-padding">
			<h2><i class="fa fa-credit-card" aria-hidden="true"></i> - <spring:message code="tourFriend.withdraw.balance" /></h2>
		</div>

		<div class="container">
			<div class="row section-content-padding">
				<div class="[ col-xs-10 col-xs-offset-1 col-sm-offset-1 col-sm-10 ]">

					<div class="alert alert-info">
						<spring:message code="tourFriend.withdraw.message1" /> <span id="balanceSelected"></span> &#8364;.
						<spring:message code="tourFriend.withdraw.message2" /> <span id="balanceWithPayPalFee"></span> &#8364;
					</div>

				</div>

				<div class="[ col-xs-10 col-xs-offset-1 col-sm-offset-3 col-sm-6 text-center ]">

					<h4 class="text-center"><spring:message code="tourFriend.withdraw.message.select"/></h4>
					<hr>
					<div class="range range-info">
						<input type="range" name="range" step="0.1" min="1" max="<jstl:out value="${availableBalance}"/>" value="<jstl:out value="${availableBalance}"/>" onchange="range.value=value">
						<output id="range"><jstl:out value="${availableBalance}"/></output>
					</div>
					<hr>

					<h4 class="text-center"><spring:message code="tourFriend.withdraw.message3"/></h4>
					<input class="form-control" type="email" name="email" id="inputEmail" />
					<span style="color:red;" id="invalidEmail"><spring:message code="tourFriend.withdraw.error.email" /> </span><br><br>

					<a class="btn btn-primary mano" style="cursor:pointer;" href="javascript:void(0)" id="withdrawUrl"><spring:message code="tourFriend.withdraw.balance" /></a>

				</div>
			</div>
		</div>

		<script>

			$( window ).load(function() {

				$('#invalidEmail').hide();

				var balanceSelected = parseFloat($('#range').html());
				var balanceWithPayPalFee = balanceSelected - parseFloat(balanceSelected * parseFloat(0.08)).toFixed(2);

				$('#balanceSelected').html(balanceSelected.toFixed(2));

				$('#balanceWithPayPalFee').html(balanceWithPayPalFee.toFixed(2));
			});

			$('#range').on('DOMSubtreeModified',function(){

				var balanceSelected = parseFloat($('#range').html());
				var balanceWithPayPalFee = balanceSelected - parseFloat(balanceSelected * parseFloat(0.08)).toFixed(2);

				$('#balanceSelected').html(balanceSelected.toFixed(2));

				$('#balanceWithPayPalFee').html(balanceWithPayPalFee.toFixed(2));
			});

			$('#withdrawUrl').click(function(event) {

				if (!isValidEmailAddress($('#inputEmail').val())){
					event.preventDefault();
					$('#invalidEmail').show();
				}else{

					var balanceSelected = parseFloat($('#range').html());
					var balanceWithPayPalFee = balanceSelected - parseFloat(balanceSelected * parseFloat(0.08)).toFixed(2);

					$('#balanceSelected').html(balanceSelected.toFixed(2));

					$('#balanceWithPayPalFee').html(balanceWithPayPalFee.toFixed(2));

					var url = "";

					if (window.location.hostname == "localhost"){
						url = window.location.protocol+'//'+window.location.hostname+':'+window.location.port+'/'+window.location.pathname.split('/')[1]+"/"+window.location.pathname.split('/')[2]+'/withdrawBalance.do?';
					}else{
						url = window.location.protocol+'//'+window.location.hostname+':'+window.location.port+'/'+window.location.pathname.split('/')[1]+'/withdrawBalance.do?';
					}

					url = url + 'amount='+balanceSelected;
					url = url + '&email='+$('#inputEmail').val();

					$('#withdrawUrl').attr('href', url);
				}
			});

			function isValidEmailAddress(emailAddress) {
				var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
				return pattern.test(emailAddress);
			};

		</script>
	</jstl:if>
</security:authorize>