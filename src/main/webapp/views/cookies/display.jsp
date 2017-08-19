<%@page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
		  uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<style>
	.cookies {
		margin-top: 100px;
	}
</style>


<div class="cookies">

	<div class="container">
		<h2>
			<spring:message code="cookies" />
		</h2>
		<br />
		<p>
			<spring:message code="cookiesP1" />
		</p>

		<div class='row'>
			<div class='col-md-12'>
				<div class="panel-group" id="accordion">

					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
								   href="#collapse1"> <spring:message
										code="cookiesCT1" />
								</a>
							</h4>
						</div>
						<div id="collapse1" class="panel-collapse collapse in">
							<div class="panel-body">
								<p>
									<spring:message code="cookiesC1" />
								</p>

								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#collapse1"
											   href="#collapse2"> <spring:message
													code="cookiesCT2" />
											</a>
										</h4>
									</div>
									<div id="collapse2" class="panel-collapse collapse">
										<div class="panel-body">
											<p>
												<spring:message code="cookiesC2.1" />
											</p>
										</div>
									</div>
								</div>

								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#collapse1"
											   href="#collapse3"> <spring:message
													code="cookiesCT3" />
											</a>
										</h4>
									</div>
									<div id="collapse3" class="panel-collapse collapse">
										<div class="panel-body">
											<p>
												<spring:message code="cookiesC3.1" />
											</p>
										</div>
									</div>
								</div>

								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#collapse1"
											   href="#collapse4"> <spring:message
													code="cookiesCT4" />
											</a>
										</h4>
									</div>
									<div id="collapse4" class="panel-collapse collapse">
										<div class="panel-body">
											<p>
												<spring:message code="cookiesC4.1" />
											</p>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
								   href="#collapse5"> <spring:message
										code="cookiesCT5" />
								</a>
							</h4>
						</div>
						<div id="collapse5" class="panel-collapse collapse">
							<div class="panel-body">
								<p>
									<spring:message code="cookiesC5.1" />
								</p>

								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#collapse5"
											   href="#collapse6"> <spring:message
													code="cookiesCT6" />
											</a>
										</h4>
									</div>
									<div id="collapse6" class="panel-collapse collapse">
										<div class="panel-body">
											<p>
												<spring:message code="cookiesC6.1" />
											</p>
											<p>
												<spring:message code="cookiesC6.2" />
											</p>
											<ul style="margin-left:25px;">
												<li><a href="http://www.microsofttranslator.com/bv.aspx?from=es&to=en&a=http%3A%2F%2Fwindows.microsoft.com%2Fes-es%2Fwindows7%2Fblock-enable-or-allow-cookies" target="_blank">
													<spring:message code="cookiesC6.3" />
												</a></li>
												<li><a href="http://www.microsofttranslator.com/bv.aspx?from=es&to=en&a=https%3A%2F%2Fsupport.google.com%2Faccounts%2Fanswer%2F61416%3Fhl%3Des" target="_blank">
													<spring:message code="cookiesC6.4" />
												</a></li>
												<li><a href="http://www.microsofttranslator.com/bv.aspx?from=es&to=en&a=https%3A%2F%2Fsupport.apple.com%2Fkb%2FPH19214%3Flocale%3Des_ES%26viewlocale%3Des_ES" target="_blank">
													<spring:message code="cookiesC6.5" />
												</a></li>
												<li><a href="http://www.microsofttranslator.com/bv.aspx?from=es&to=en&a=https%3A%2F%2Fsupport.mozilla.org%2Fes%2Fkb%2Fhabilitar-y-deshabilitar-cookies-sitios-web-rastrear-preferencias" target="_blank">
													<spring:message code="cookiesC6.6" />
												</a></li>
												<li><a href="http://www.microsofttranslator.com/bv.aspx?from=es&to=en&a=http%3A%2F%2Fhelp.opera.com%2FWindows%2F11.50%2Fes-ES%2Fcookies.html" target="_blank">
													<spring:message code="cookiesC6.7" />
												</a></li>
											</ul>
											<br>
											<p>
												<spring:message code="cookiesC6.8" />
											</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>