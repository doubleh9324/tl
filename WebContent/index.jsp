<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>티켓사자 - Ticket Lion</title>
<script src="//code.jquery.com/jquery.min.js"></script>
<script>
    $(function() {
//         $(window).scroll(function() {
//             if ($(this).scrollTop() > 500) {
                $('#MOVE_TOP_BTN').fadeIn();
//             } else {
//                 $('#MOVE_TOP_BTN').fadeOut();
//             }
//         });
        
        $("#MOVE_TOP_BTN").click(function() {
            $('html, body').animate({
                scrollTop : 0
            }, 400);
            return false;
        });
    });
</script>

<style type="text/css">

a#MOVE_TOP_BTN {
    position: fixed;
    right: 18%;
    bottom: 50%;
    display: none;
    z-index: 999;
}

</style>
</head>
<body>

<a id="MOVE_TOP_BTN" href="#"><img src="img/top_btn.png" width="35px" ></a>

<c:set var="center" value="${param.center }"/>




<c:if test="${center==null }">
	<c:set var="center" value="main.jsp"/>


</c:if>
		<jsp:include page="top.jsp"></jsp:include>
		
<center>	 
		<jsp:include page="${center}"/>

</center>

		<jsp:include page="bottom.jsp"></jsp:include>
	
</body>
</html>