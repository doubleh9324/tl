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

</head>
<body>

<c:set var="center" value="${param.center }"/>
<c:if test="${center==null }">
	<c:set var="center" value="main.jsp"/>
</c:if>
		<jsp:include page="top2.jsp"></jsp:include>
		
<center>	 
		<jsp:include page="${center}"/>
</center>

		<jsp:include page="bottom.jsp"></jsp:include>
	
</body>
</html>