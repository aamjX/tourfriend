<%--
 * select.tag
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@ tag language="java" body-content="empty" %>

<%-- Taglibs --%>

<%@ taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags" %>

<%-- Attributes --%> 

<%@ attribute name="stars" required="true" %>


<%-- Definition --%>

	<div class="rating-container rating-animate">
								<div class="rating-stars" title="${e.tourFriend.rating}">
									<span class="empty-stars"><span class="star"><i
											class="glyphicon glyphicon-star-empty"></i> </span><span
										class="star"><i class="glyphicon glyphicon-star-empty"></i>
									</span><span class="star"><i
											class="glyphicon glyphicon-star-empty"></i> </span><span
										class="star"><i class="glyphicon glyphicon-star-empty"></i>
									</span><span class="star"><i
											class="glyphicon glyphicon-star-empty"></i> </span> </span><span
										class="filled-stars" style="width: ${(stars)*100/5}%;"><span
										class="star"> <i class="glyphicon glyphicon-star"></i></span><span
										class="star"><i class="glyphicon glyphicon-star"></i></span><span
										class="star"><i class="glyphicon glyphicon-star"></i></span><span
										class="star"><i class="glyphicon glyphicon-star"></i></span><span
										class="star"><i class="glyphicon glyphicon-star"></i></span><span
										class="star"><i class="glyphicon glyphicon-star"></i></span><span
										class="star"><i class="glyphicon glyphicon-star"></i></span><span
										class="star"><i class="glyphicon glyphicon-star"></i></span></span>
								</div>
							</div>


