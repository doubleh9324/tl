
<%@page import="java.util.Date"%>
<%@page import="team.review.db.ReviewDAO"%>
<%@page import="team.movie.db.MovieBean"%>
<%@page import="team.movie.db.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/content.css">
<style type="text/css">

</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	
	var movie_num=<%=request.getParameter("num")%>;
	if(<%=session.getAttribute("id")!=null%>){
		getReview(movie_num,Number(0));
	}
	
	adBanner();
	
	$("#ad_banner").click(function(){
		var ad_m_num = $("#ad_m_num").val();
		location.href="./MovieContentAction.mo?num="+ad_m_num;
	});

})

function adBanner(){
	var random = Math.floor(Math.random() * 5);
	var random_m_num =[ '20161481','20164621','20177761','20173403','20177181'];
	$("#ad_banner").append('<img src="icons/ad_'+random+'.jpg"><input type="hidden" id="ad_m_num" value="'+random_m_num[random]+'">');
}

function getReview(movie_num,p_num){
	var nc_code="mo"+movie_num;
	var setflag=$("#setFlag").val();

	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./ReviewGetAction.rv",
			data:"nc_code="+nc_code+"&p_num="+p_num,
			dataType:"JSON",
			
			success:function(data){
				document.getElementById("text_body").innerHTML="";
				$.each(data.review, function(key,value){
					
					var tr_code='<tr id="text_tr"><td></td><td colspan="3">'+value.contents+'</td><td align="left"><img src="icons/star01_white.gif">'+value.grade+'</td><td align="right">'+value.id+'</td><td></td></tr>';
					$("#text_body").append(tr_code);
					
				});
				$("#text_body").append('<tr><td id="page_td" colspan="7" align="center"></td></tr>');
				$.each(data.page_count, function(key,value){
					$("#page_td").append('<span onclick="getReview('+movie_num+','+(key*10)+')">'+'['+(key+1)+']'+'</span>');
				});
				
				
			},
			
			error: function(xhr, status, error){
				alert("에러발생"+xhr+status+error);
			
			}
		});
	
	}
	
}

function insertReviewFucntion(){
	var movie_num=<%=request.getParameter("num")%>;
	var nc_code="mo"+movie_num;
	var contents = $("#contents").val();
	var member_num = <%=session.getAttribute("member_num")%>;
	if(contents==null || contents==""){
		alert("리뷰 내용을 입력해주세요.");
		return;
	}
	var id="<%=(String)session.getAttribute("id")%>";
	var grade=0;
	var radio_btn = document.getElementsByName("star");
	for(var i=0;i<radio_btn.length;i++){
		if(radio_btn[i].checked==true){
			grade=radio_btn[i].value;
		}
	}
	jQuery.ajax({
		type:"POST",
		url:"./ReviewInsertAction.rv",
		data:"nc_code="+nc_code+"&id="+id+"&grade="+grade+"&contents="+contents+"&member_num="+member_num,

		
		success:function(data){
			$("#contents").val("");
			
			getReview(movie_num,0);
			
		},
		
		error: function(xhr, status, error){
			alert("에러발생"+xhr+status+error);
		
		}
	});
	
	
}

function reservation(mnum){
	window.open("./reserveMV.rs?flag=movie&val="+mnum,"","width=1050, height=695, toolbar=no, menubar=no, scrollbars=no, resizable=no");
}

</script>
</head>
<body>
<%	MovieDAO dao = new MovieDAO();
	MovieBean mb = dao.selectMovie(request.getParameter("num"));
%>
	
<center>
	
	<div id="video_div">
		<div id="video_content">
			${bean.video}
		</div>
	</div>
	<div id="top_div">영화상세</div>
	<div id="info_div">
		<div id="image_div">
			<a href="MovieImage/${bean.image }"><img alt="" src="MovieImage/${bean.image}"></a><br>
		<c:if test="${bean.playing==1 }">
		
			<input type="button" value="예매하기" id="reserve_button" onclick="reservation(${bean.movie_num})">
			
		</c:if>
		</div>
		<div id="text_div">
			<div id="title"><strong style="float: left;">${bean.name }</strong>
			<ul>
				<li style="background-image: url('icons/facebook.gif');"></li>
				<li style="background-image: url('icons/twitter.gif');"></li>
				<li style="background-image: url('icons/kakao.gif');"></li>
				<li style="width:35px; background-image: url('icons/url.gif');"></li>
			</ul>
			</div>
			<div id="ganre">장르 <span>${bean.ganre}</span></div>
			<div id="open_day">개봉일 <span>${bean.open_day }</span></div>
			<div id="grade">평점  <span>${bean.grade }</span></div>
			<c:set var="age" value=""/>
			<c:choose>
				<c:when test="${bean.age=='12'}">
					<c:set var="age" value="12세이용가"/>
				</c:when>
				<c:when test="${bean.age=='15'}">
					<c:set var="age" value="15세이용가"/>
				</c:when>
				<c:when test="${bean.age=='18'}">
					<c:set var="age" value="청소년관람불가"/>
				</c:when>
				<c:otherwise>
					<c:set var="age" value="전체이용가"/>
				</c:otherwise>
			</c:choose>
			<div id="age">등급 <span>${age }</span></div>
			<div id="director">감독 <span>${bean.director }</span></div>
			<div id="actor">배우  <div>${bean.actor }</div></div>
			
			
		</div>
		<div class="clear"></div>
	
	</div>
	<div id="synop_div">시놉시스</div>
	<div id="content_div">	
	 <%= mb.getContents().replace("\n", "<br>")%> 
	</div>
<%if(session.getAttribute("id")!=null){ %>
		<div id="review_div">
			
			<table id="review" cellspacing="0" cellpadding="0" border="0">
				<thead> 
				<tr id="star_tr">
				<td></td>
					<td ><input type="radio" value="5.0" id="star" name="star" checked="checked">
					    <img src="icons/star01.gif" id="star" >
					    <img src="icons/star01.gif" id="star">
					    <img src="icons/star01.gif" id="star">
					    <img src="icons/star01.gif" id="star">
					    <img src="icons/star01.gif" id="star"> 
					</td>
					<td><input type="radio" value="4.0" id="star" name="star">
					    <img src="icons/star01.gif" id="star" >
					    <img src="icons/star01.gif" id="star">
					    <img src="icons/star01.gif" id="star">
					    <img src="icons/star01.gif" id="star">
					    <img src="icons/star00.gif" id="star">
				    </td>
					<td>
						<input type="radio" value="3.0" id="star" name="star">
					    <img src="icons/star01.gif" id="star" >
					    <img src="icons/star01.gif" id="star">
					    <img src="icons/star01.gif" id="star">
					    <img src="icons/star00.gif" id="star">
					    <img src="icons/star00.gif" id="star" > </td>
					<td><input type="radio" value="2.0" id="star" name="star">
					    <img src="icons/star01.gif" id="star" >
					    <img src="icons/star01.gif" id="star">
					    <img src="icons/star00.gif" id="star">
					    <img src="icons/star00.gif" id="star">
					    <img src="icons/star00.gif" id="star"> </td>
					<td><input type="radio" value="1.0" id="star" name="star">
					    <img src="icons/star01.gif" id="star" >
					    <img src="icons/star00.gif" id="star">
					    <img src="icons/star00.gif" id="star">
					    <img src="icons/star00.gif" id="star">
					    <img src="icons/star00.gif" id="star"> </td>
					    <td></td>
				</tr>
				
				<tr id="input_tr" >
					<td colspan="7" align="center"><input type="text" id="contents" style="width: 600px;">
					<button id="review_btn" onclick="insertReviewFucntion()">등록</button></td>
				</tr>
				</thead>
				<tbody id="text_body">
				 
				 
				</tbody>
				
			</table>
			<div>
			
				
			</div>
		</div>
<%} %>

	
	<div id="ad_banner">
	
	</div>
	
</center>
</body>
