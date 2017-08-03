<%@page import="team.movie.db.MovieBean"%>
<%@page import="java.util.List"%>
<%@page import="team.movie.db.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/login.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
	div#movie{
		width: 1000px;


		text-align: center;
		margin: auto auto;
	}
	div#movie_object{
		margin: 15px;
		width:220px;
		height:360px;
		float:left;

	}
	div#movie_object div{
		margin-top: 5px;
	}
	div#movie_object img{
		width:220px;
		height:330px;
	}
	
	.clear{
		clear:both;
	}
		div#subject{
		width: 960px;
		height: 80px;
	
	}
	div#subject_left{
		width:280px;
		height: 80px;
		background-image: url("icons/subject_left.jpg");
		display:inline-block;
		float:left;
		margin-top: 1px;
	}
	div#subject_center{
		width:400px;
		height: 80px;
		display:inline-block;
		float:left;
	
	
	}
	div#subject_center div{
	width:150px;
	height: 60px;
	
	color: #787878;
	font-size: 30px;
	margin-top:20px;

	}
	div#subject_right{
	width:280px;
	height: 80px;
	margin-top: 1px;
	background-image: url("icons/subject_right.jpg");
	display:inline-block;
	
}
</style> 
</head>
<body>
<center>
<c:set var="i" value="0"/>

<div id="subject">
  	<div id="subject_left"></div>
  	<div id="subject_center"><div>Movie</div></div>
  	<div id="subject_right"></div>
  </div>
  <div class="clear"></div>
<div id="movie">
<c:choose>
<c:when test="${fn:length(movieList) > 0}">
<c:forEach var="movieList" items="${movieList}">
		<div id="movie_object" >
		<a href="./MovieContentAction.mo?num=${movieList.movie_num}" ><img  src="MovieImage/${movieList.image }" alt=""><br>
		<div>${movieList.name} </a></div>
		</div>
<c:set var="i" value="${i+1 }"/>
</c:forEach>
</c:when>

<c:otherwise>
	<div id="movie">조회된 결과가 없습니다.</div>
</c:otherwise>
</c:choose>
</div>
	
</center> 




</body>
</html>