<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

$(document).ready(function(){

	reservFunctionMovie();
/*	reservFunctionMusical();*/
	

})


/* 영화 랭킹 */
function reservFunctionMovie(){
	var setflag=$("#setFlag").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./getOrderReservMo2.rs",
			dataType:"JSON",
			
			success:function(data){
				$("#rank_box").html("");
				
				$("#reserveOrderMovie").css("color","#ff7d52")
				$("#reserveOrderMusical").css("color","#6f6f6f")
				
				$.each(data.reservList, function(key,value){
					var name = value.name;
					if(name.length>12){name=name.substring(0,11)+"...";}	
 					
					var div_code='<div="rank_div"><a href="./MovieContentAction.mo?num='+value.movie_num+'">'
								+'<img src="MovieImage/'+value.movie_num+'.jpg" width="100px" height="145px" class="rank_img">'
								+'<p>'+'['+(key+1)+'] '+name+'<span>'+'<br>'+value.percent+'%</span></p></a></div>';
					$("#rank_box").append(div_code);
				});
				
			},
			error: function(xhr, status, error){
				
			}
		});
	}
}



/* 뮤지컬 랭킹 수정전 */
/*
function reservFunctionMusical(){
	var setflag=$("#setFlag").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./getOrderReservMo2.rs",
			dataType:"JSON",
			
			success:function(data){
				$("#rank_box").html("");
				$("#reserveOrderMusical").css("color","#ff7d52")
				$("#reserveOrderMovie").css("color","#6f6f6f")
				
				$.each(data.reservList, function(key,value){
					var name = value.name;
					if(name.length>12){name=name.substring(0,11)+"...";}	
 					
					var div_code='<div="rank_div"><a href="./MusicalContentAction.mu?num='+value.musical_num+'">'
								+'<img src="MusicalImage/'+value.musical_num+'.jpg" width="100px" height="145px" class="rank_img">'
								+'<p>'+'['+(key+1)+'] '+name+'<span>'+'<br>'+value.percent+'%</span></p></a></div>';
					$("#rank_box").append(div_code);
				});
				
			},
			error: function(xhr, status, error){
				
			}
		});
	}
}

*/
</script>


</head>
<body>
<!-- 영화랭킹 -->

	<div id="rank">
		<div id="rank_head">		
			
			<span id="reserveOrderMovie" onclick="reservFunctionMovie()">영화</span>
			<span id="bar">|</span>		
		<!-- 	<span id="reserveOrderMusical" onclick="reservFunctionMusical()">뮤지컬</span> -->
			<span >뮤지컬</span>
			<span id="bar">|</span>
			<span>연극</span>
			<span id="bar">|</span>
			<span>콘서트</span>
			<span id="bar">|</span>
			<span>공연</span>	
					
						
		</div>
		<div id="rank_img"><img src="img/rankingMore.gif"></div>
		<div id="rank_hr"></div>
		<div id="rank_box">
				
		</div>
	</div>
	


<!-- 뮤지컬랭킹 -->




</body>
</html>