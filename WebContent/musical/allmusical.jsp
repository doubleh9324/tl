<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
	 div#musical{
		width: 1000px;
	
		border-top: 1px solid;

		text-align: center;
		margin: auto auto;
	}
	div#musical_object{
		margin: 15px;
		width:220px;
		height:360px;
		float:left;

	}
	 div#musical_object img{
		width:220px;
		height:330px;
	}
	
	.clear{
		clear:both;
	}
</style>
</head>
<body>
<center>
<c:set var="i" value="0"/>

<h1>전체 뮤지컬</h1>
<div id="musical">
<c:choose>
<c:when test="${fn:length(musicalList) > 0}">
<c:forEach var="musicalList" items="${musicalList}">
		<div id="musical_object" >
		<a href="./MusicalContentAction.mu?num=${musicalList.musical_num}" ><img  src="MusicalImage/${musicalList.image }" alt=""><br>
		${musicalList.name} </a>
		</div>
<c:set var="i" value="${i+1 }"/>
</c:forEach>
</c:when>

<c:otherwise>
	<div id="musical">조회된 결과가 없습니다.</div>
</c:otherwise>
</c:choose>
</div>
	<div class="clear"></div>

</center>


</body>
</html>