<%--
 * action-1.jsp
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<style>
.termAndConditions {
	margin-top: 100px;
}
</style>


<div class="termAndConditions">

	<div class="container">
		<h2>
			<spring:message code="termsAndCondition" />
		</h2>
		<br />
		<p>
			<spring:message code="termsAndConditionP1" />
		</p>
		<p>
			<spring:message code="termsAndConditionP2" />
		</p>

		<div class='row'>
			<div class='col-md-12'>
				<div class="panel-group" id="accordion">


					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse1"> <spring:message
										code="termsAndConditionCT1" />
								</a>
							</h4>
						</div>
						<div id="collapse1" class="panel-collapse collapse in">
							<div class="panel-body">
								<p>
									<spring:message code="termsAndConditionC1" />
								</p>
							</div>
						</div>
					</div>



					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse2"> <spring:message
										code="termsAndConditionCT2" />
								</a>
							</h4>
						</div>
						<div id="collapse2" class="panel-collapse collapse">
							<div class="panel-body">
								<p>
									<spring:message code="termsAndConditionC2.1" />
								</p>
								<p>
									<spring:message code="termsAndConditionC2.2" />
								</p>
								<p>
									<spring:message code="termsAndConditionC2.3" />
								</p>
							</div>
						</div>
					</div>


					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse3"> <spring:message
										code="termsAndConditionCT3" />
								</a>
							</h4>
						</div>
						<div id="collapse3" class="panel-collapse collapse">
							<div class="panel-body">
								<p>
									<spring:message code="termsAndConditionC3.1" />
								</p>
								<p>
									<spring:message code="termsAndConditionC3.2" />
								</p>
								<p>
									<spring:message code="termsAndConditionC3.3" />
								</p>
								<p>
									<spring:message code="termsAndConditionC3.4" />
								</p>
								<p>
									<spring:message code="termsAndConditionC3.5" />
								</p>
								<p>
									<spring:message code="termsAndConditionC3.6" />
								</p>
								<p>
									<spring:message code="termsAndConditionC3.7" />
								</p>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse4"> <spring:message
										code="termsAndConditionCT4" />
								</a>
							</h4>
						</div>
						<div id="collapse4" class="panel-collapse collapse">
							<div class="panel-body">
								<p>
									<spring:message code="termsAndConditionC4.1" />
								</p>
								<li><spring:message code="termsAndConditionC4.2" /></li>
								<li><spring:message code="termsAndConditionC4.3" /></li>
								<li><spring:message code="termsAndConditionC4.4" /></li>
								<li><spring:message code="termsAndConditionC4.5" /></li>

							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse5"> <spring:message
										code="termsAndConditionCT5" />
								</a>
							</h4>
						</div>
						<div id="collapse5" class="panel-collapse collapse">
							<div class="panel-body">
								<p>
									<spring:message code="termsAndConditionC5.1" />
								</p>
								<p>
									<spring:message code="termsAndConditionC5.2" />
								</p>
								<p>
									<spring:message code="termsAndConditionC5.3" />
								</p>
								<p>
									<spring:message code="termsAndConditionC5.4" />
								</p>
								<p>
									<spring:message code="termsAndConditionC5.5" />
								</p>
								<li><spring:message code="termsAndConditionC5.6" /></li>
								<li><spring:message code="termsAndConditionC5.7" /></li>
								<li><spring:message code="termsAndConditionC5.8" /></li>
								<li><spring:message code="termsAndConditionC5.9" /></li> <br />
								<p>
									<spring:message code="termsAndConditionC5.10" />
								</p>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse6"> <spring:message
										code="termsAndConditionCT6" />
								</a>
							</h4>
						</div>
						<div id="collapse6" class="panel-collapse collapse">
							<div class="panel-body">
								<p>
									<spring:message code="termsAndConditionC6.1" />
								</p>
								<p>
									<spring:message code="termsAndConditionC6.2" />
								</p>
								<p>
									<spring:message code="termsAndConditionC6.3" />
								</p>
							</div>
						</div>
					</div>


					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse7"> <spring:message
										code="termsAndConditionCT7" />
								</a>
							</h4>
						</div>
						<div id="collapse7" class="panel-collapse collapse">
							<div class="panel-body">
								<p>
									<spring:message code="termsAndConditionC7.1" />
								</p>
								<p>
									<spring:message code="termsAndConditionC7.2" />
								</p>
								<p>
									<spring:message code="termsAndConditionC7.3" />
								</p>
							</div>
						</div>
					</div>


					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse8"> <spring:message
										code="termsAndConditionCT8" />
								</a>
							</h4>
						</div>
						<div id="collapse8" class="panel-collapse collapse">
							<div class="panel-body">
								<p>
									<spring:message code="termsAndConditionC8.1" />
								</p>
								<p>
									<spring:message code="termsAndConditionC8.2" />
								</p>
								<p>
									<spring:message code="termsAndConditionC8.3" />
								</p>
								<p>
									<spring:message code="termsAndConditionC8.4" />
								</p>
								<p>
									<spring:message code="termsAndConditionC8.5" />
								</p>
								<p>
									<spring:message code="termsAndConditionC8.6" />
								</p>
								<p>
									<spring:message code="termsAndConditionC8.7" />
								</p>
								<li><spring:message code="termsAndConditionC8.8" /></li>
								<li><spring:message code="termsAndConditionC8.9" /></li>
								<li><spring:message code="termsAndConditionC8.10" /></li>
								<li><spring:message code="termsAndConditionC8.11" /></li> <br />
								<p>
									<spring:message code="termsAndConditionC8.12" />
								</p>
								<li><spring:message code="termsAndConditionC8.13" /></li>
								<li><spring:message code="termsAndConditionC8.14" /></li>
								<li><spring:message code="termsAndConditionC8.15" /></li>
								<li><spring:message code="termsAndConditionC8.16" /></li>
							</div>
						</div>
					</div>


					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse9"> <spring:message
										code="termsAndConditionCT9" />
								</a>
							</h4>
						</div>
						<div id="collapse9" class="panel-collapse collapse">
							<div class="panel-body">
								<p>
									<spring:message code="termsAndConditionC9.1" />
								</p>
								<li><spring:message code="termsAndConditionC9.2" /></li>
								<li><spring:message code="termsAndConditionC9.3" /></li>
								<li><spring:message code="termsAndConditionC9.4" /></li>
								<li><spring:message code="termsAndConditionC9.5" /></li> <br />
								<p>
									<spring:message code="termsAndConditionC9.6" />
								</p>
								<p>
									<spring:message code="termsAndConditionC9.7" />
								</p>
								<p>
									<spring:message code="termsAndConditionC9.8" />
								</p>
								<p>
									<spring:message code="termsAndConditionC9.9" />
								</p>
							</div>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<h2>
			<spring:message code="privacyPolicy" />
		</h2>
		<br />

		<div class='row'>
			<div class='col-md-12'>
				<div class="panel-group" id="accordion">


					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse0"> <spring:message code="privacyPolicyCT1" />
								</a>
							</h4>
						</div>
						<div id="collapse0" class="panel-collapse collapse in">
							<div class="panel-body">
								<ol>
									<li><spring:message code="privacyPolicyC1" /></li>
									<ul>
										<li><spring:message code="privacyPolicyC1.1" /></li>
										<li><spring:message code="privacyPolicyC1.2" /></li>
										<li><spring:message code="privacyPolicyC1.3" /></li>
										<li><spring:message code="privacyPolicyC1.4" /></li>
										<li><spring:message code="privacyPolicyC1.5" /></li>
										<li><spring:message code="privacyPolicyC1.6" /></li>
										<li><spring:message code="privacyPolicyC1.7" /></li>
										<li><spring:message code="privacyPolicyC1.8" /></li>
										<li><spring:message code="privacyPolicyC1.9" /></li>
										<br />
									</ul>
									<li><spring:message code="privacyPolicyC2" /></li>
									<br />
									<li><spring:message code="privacyPolicyC3" /></li>
									<br />
									<li><spring:message code="privacyPolicyC4" /></li>
									<br />
									<li><spring:message code="privacyPolicyC5" /></li>
								</ol>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>



</div>