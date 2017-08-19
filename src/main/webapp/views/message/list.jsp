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

<div class="section-mini-padding">
	<h2>
		<i class="fa fa-comments-o"></i> -
		<spring:message code="message.title" />
	</h2>
</div>

<div class="container">
	<div class="row section-content-padding">
		<div class="col-md-7">
				<div class="input-group">
					<span class="input-group-addon" id="basic-addon1"
						style="background-color: #ddd;"><i class="fa fa-search"></i></span>
					<input type="text" class="form-control" id="system-search" name="q"
						placeholder="Search your messages" aria-describedby="basic-addon1">
				</div>
		</div>
		<div class="col-md-5 text-center">
			<a href="message/actor/list.do" class="btn btn-default"><i
				class="fa fa-envelope-o"></i> <spring:message code="message.inbox" /></a>
			| <a href="message/actor/listOutbox.do" class="btn btn-default"><i
				class="fa fa-envelope-open-o"></i> <spring:message
					code="message.outbox" /></a>
		</div>

	</div>

	<div class="row">
		<div class="col-md-12">
			<br> <br>
			<section class="messages-table">
				<display:table requestURI="${requestURI}"
					class="table table-striped table-list-search" defaultsort="3"
					defaultorder="descending" name="messages" id="row">

					<display:column>
						<a class="btn btn-default" id="display-button"
							style="cursor: pointer;" data-toggle="modal"
							data-target="#displayModal"
							onclick="display('message/actor/display.do?messageId='+${row.id})">
							<i class="fa fa-eye"></i> - <spring:message
								code="message.display" />
						</a>
					</display:column>

					<spring:message code="message.subject" var="subjectHeader" />
					<display:column title="${subjectHeader}" sortable="true">
						<jstl:if test="${row.isRead eq false}">
							<strong><jstl:out value="${row.subject}" /></strong>
						</jstl:if>
						<jstl:if test="${row.isRead eq true}">
							<jstl:out value="${row.subject}" />
						</jstl:if>
					</display:column>

					<spring:message code="message.sentMoment" var="sentMomentHeader" />
					<display:column title="${sentMomentHeader}" sortable="true">
						<jstl:if test="${row.isRead eq false}">
							<strong><fmt:formatDate pattern="dd-MM-yyyy HH:mm"
									value="${row.sentMoment}" /></strong>
						</jstl:if>
						<jstl:if test="${row.isRead eq true}">
							<fmt:formatDate pattern="dd-MM-yyyy HH:mm"
								value="${row.sentMoment}" />
						</jstl:if>
					</display:column>

					<jstl:if test="${requestURI eq 'message/actor/list.do'}">
						<spring:message code="message.sender" var="senderHeader" />
						<display:column property="senderActor.userAccount.username"
							title="${senderHeader}" sortable="true" />
					</jstl:if>

					<jstl:if test="${requestURI eq 'message/actor/listOutbox.do'}">
						<spring:message code="message.recipient" var="recipientHeader" />
						<display:column property="recipientActor.userAccount.username"
							title="${recipientHeader}" sortable="true" />
					</jstl:if>

					<jstl:if test="${requestURI eq 'message/actor/list.do'}">
						<display:column>
							<a class="btn btn-default" id="reply-button"
								style="cursor: pointer;" data-toggle="modal"
								data-target="#createModal"
								onclick="create('message/actor/create.do?tourfriendId='+${row.senderActor.id})">
								<spring:message code="message.reply" /> <i
								class="fa fa-mail-forward"></i>
							</a>
						</display:column>
					</jstl:if>

				</display:table>
			</section>
		</div>
	</div>

	<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<spring:message code="message.delete.confirm" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<a href="javascript:void(0)" class="btn btn-danger btn-ok">Delete</a>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- Confirm delete -->

<script>
$('#confirm-delete').on('show.bs.modal', function(e) {
    $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
});
</script>

<!-- CreateMessageModal -->
<div class="modal fade" id="createModal" role="dialog">
	<div id="createModalinject" class="modal-dialog">
		<!--  Se inyecta el model del edit.jsp -->
	</div>
</div>

<script>
function create(url){
	$( "#createModalinject" ).load(url + " #container");	
}
</script>

<!-- DisplayMessageModal -->
<div class="modal fade" id="displayModal" role="dialog">
	<div id="displayModalinject" class="modal-dialog">
		<!--  Se inyecta el model del display.jsp -->
	</div>
</div>

<script>
function display(url){
	$( "#displayModalinject" ).load(url + " #container");	
}
</script>

<script>$(document).ready(function() {
    var activeSystemClass = $('.list-group-item.active');

    //something is entered in search form
    $('#system-search').keyup( function() {
       var that = this;
        // affect all table rows on in systems table
        var tableBody = $('.table-list-search tbody');
        var tableRowsClass = $('.table-list-search tbody tr');
        $('.search-sf').remove();
        tableRowsClass.each( function(i, val) {
        
            //Lower text for case insensitive
            var rowText = $(val).text().toLowerCase();
            var inputText = $(that).val().toLowerCase();
            if(inputText != '')
            {
                $('.search-query-sf').remove();
                tableBody.prepend('<tr class="search-query-sf"><td colspan="6"><strong><spring:message code="message.searchingFor" />"'
                    + $(that).val()
                    + '"</strong></td></tr>');
            }
            else
            {
                $('.search-query-sf').remove();
            }

            if( rowText.indexOf( inputText ) == -1 )
            {
                //hide rows
                tableRowsClass.eq(i).hide();
                
            }
            else
            {
                $('.search-sf').remove();
                tableRowsClass.eq(i).show();
            }
        });
        //all tr elements are hidden
        if(tableRowsClass.children(':visible').length == 0)
        {
            tableBody.append('<tr class="search-sf"><td class="text-muted" colspan="6"><spring:message code="message.noEntriesFound" /></td></tr>');
        }
    });
});</script>