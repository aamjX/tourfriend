<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>

<head>


    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><tiles:insertAttribute name="title" ignore="true" /></title>
	<link rel="shortcut icon" href="favicon.ico"/>

	<script>
        var str = document.location.protocol + '//' + document.location.host + '/';

		if(document.location.pathname != ''){
		    var pathname = document.location.pathname;
		 	var splitPathname = pathname.split('/');
		 	if(splitPathname[1] == 'Tourfriend'){
		 		str += splitPathname[1] + '/';
		 	}
		}

        document.write('<base href="'+str+'">');
	</script>

	<link rel="stylesheet" href="/styles/bootstrap.min.css">
	<link rel="stylesheet" href="/styles/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="/styles/custom.css" type="text/css">
	<link rel="stylesheet" href="/styles/bootstrap-datetimepicker.min.css" type="text/css"/>
	<link rel="stylesheet" href="/styles/bubbletip/bubbletip-IE.css" type="text/css"/>
	<link rel="stylesheet" href="/styles/bubbletip/bubbletip.css" type="text/css"/>
	<link rel="stylesheet" href="/styles/uploadfile.css" type="text/css">
	<link rel="stylesheet" href="/styles/select2.min.css" type="text/css"/>
	<link rel="stylesheet" href="/styles/animate.min.css" type="text/css"/>

	<script src="/scripts/jquery.min.js"></script>
	<script src="/scripts/select2.min.js"></script>
	<script src="/scripts/moment.min.js"></script>
	<script src="/scripts/bootstrap.min.js"></script>
	<script src="/scripts/jquery.stellar.min.js"></script>
	<script src="/scripts/bootstrap-datetimepicker.min.js"></script>
	<script src="/scripts/custom.js"></script>
	<script src="/scripts/recaptchaApi.js"></script>
	<script src="/scripts/jQuery.bubbletip.js"></script>
	<script src="/scripts/jquery.uploadfile.min.js" charset="UTF-8"></script>
	<link href="https://rawgithub.com/hayageek/jquery-upload-file/master/css/uploadfile.css" rel="stylesheet">
	

	<script type="text/javascript" id="cookieinfo"
			src="/scripts/cookieinfo.min.js"
			data-bg="#645862"
			data-fg="#FFFFFF"
			data-link="#F1D600"
			data-cookie="CookieInfoScript"
			data-text-align="center"
			data-close-text="X"
			data-message="<spring:message code="master.page.cookieMessage" />"
			data-linkmsg="<spring:message code="master.page.cookieLink" />" >
	</script>
</head>

<style>
	.preloader-area{
		z-index: 99998;
	}
</style>

<noscript>
    <div class="noscript__wrapper">
        <span class="noscript__msg animated shake">
         <span><spring:message code="noscript.message"/></span>
        </span>
    </div>
</noscript>

<body>

    <div class="preloader-area">
        <div class="spinner">
            <div class="dot1"></div>
            <div class="dot2"></div>
        </div>
    </div>
	
    <tiles:insertAttribute name="header" />

    <tiles:insertAttribute name="body" />

    <tiles:insertAttribute name="footer" />
    
    <tiles:insertAttribute name="info" />

</body>

</html>