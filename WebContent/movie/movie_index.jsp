<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/movie_index.css">
<style type="text/css">

</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	imageFunction(0);
	reservFunction();
	setInterval(autoChangeFuction, 7000);
	
	soonMovieFunction(0);
	
	adBanner();
	
	$("#ad_banner").click(function(){
		var ad_m_num = $("#ad_m_num").val();
		location.href="./MovieContentAction.mo?num="+ad_m_num;
	});
	
	$('#picture').click(function(){
		location.href="./MovieContentAction.mo?num="+$('#curr_num').val();
	});
})
///////////////////////////////////////////////////////////

function adBanner(){
	var random = Math.floor(Math.random() * 5);
	var random_m_num =[ '20161481','20164621','20177761','20173403','20177181'];
	$("#ad_banner").append('<img src="icons/ad_'+random+'.jpg"><input type="hidden" id="ad_m_num" value="'+random_m_num[random]+'">');
}

////////////////////////////////////////////////////////
function autoChangeFuction(){
	var next_num = Number($('#next_num').val());
	if(next_num==4){ next_num=0;}
	imageFunction(next_num);
	
}

function imageFunction(num){  
	var img_name= [ 'dunkirk','taxidriver','gunhamdo','yourname' ];
	var img_num = Number(num)
	var m_num=['20164621','20162869','20161481','20161872'];
	var imagePath='MovieImage/'+img_name[img_num]+'.jpg';
	
	document.getElementById("picture").innerHTML="";
	$("#picture").css("background","url("+'"'+imagePath+'"'+")");
	$("#picture").append('<input type="hidden" id="next_num" value='+(img_num+1)+'>');
	$("#picture").append('<input type="hidden" id="curr_num" value='+m_num[num]+'>');
	getImageInfoFunction(m_num[img_num]);
}


function getImageInfoFunction(m_num){
	var setflag=$("#setFlag").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MovieGetInfoAction.mo?num="+m_num,
			dataType:"JSON",
			
			success:function(data){
				
			 $.each(data.movieInfo, function(key,value){
				 var age = value.age;
				 if(age=="12"){ age="12세이용가"
				 }else if(age=="15"){age="15세이용가"
				 }else if(age=="all"){age="전체이용가"
			     }else{age="청소년관람불가"}
				 $('#picture').append('<div id="info"></div>');
				$('#info').append('<span id="subject">'+value.name+'</span><br>'); 
				$('#info').append('<span id="ganre">'+value.ganre+'</span><span id="age">'+age+'</span>'); 
			 });
				
			},
			error: function(xhr, status, error){
				
			
			}
		});
	}
}
////////////////////////////////////////////////////////////////////

function gradeFunction(){
	var setflag=$("#setFlag").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MovieOrderGradeAction.mo",
			dataType:"JSON",
			
			success:function(data){
				$("#rank_ul").html("");
				$("#gradeOrder").css("text-decoration","underline")
				$("#reserveOrder").css("text-decoration","none")
				$.each(data.movieGrade, function(key,value){
					var name = value.name;
					if(name.length>12){name=name.substring(0,11)+"...";}
					var grade=value.grade.toString();
					if(grade.length<3){grade=grade+".0";}
					var age=value.age.substring(0,2);
					if(age=="18"){ age="18";
					}else if(age=="al"){age="all";}
					
					
					var li_code='<li id="rank_li"><a href="./MovieContentAction.mo?num='+value.movie_num+'">'+(key+1)+'.'+'<img src="icons/grade_'+age+'.png">'+name+'</a><span>'+grade+'</span></li>';
					$("#rank_ul").append(li_code);
				});
				
			},
			error: function(xhr, status, error){
				
			}
		});
	}
}
////////////////////////////////////////////////////////////////////////////////////

function reservFunction(){
	var setflag=$("#setFlag").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./getOrderReservMo.rs",
			dataType:"JSON",
			
			success:function(data){
				$("#rank_ul").html("");
				$("#gradeOrder").css("text-decoration","none")
				$("#reserveOrder").css("text-decoration","underline")
				
				$.each(data.reservList, function(key,value){
					var name = value.name;
					if(name.length>12){name=name.substring(0,11)+"...";}
					
					var age=value.age.substring(0,2);
					if(age=="18"){ age="18";
					}else if(age=="al"){age="all";}
					var li_code='<li id="rank_li"><a href="./MovieContentAction.mo?num='+value.movie_num+'">'+(key+1)+'.'+'<img src="icons/grade_'+age+'.png">'+name+'</a><span>'+value.percent+'%</span></li>';
					$("#rank_ul").append(li_code);
				});
				
			},
			error: function(xhr, status, error){
				
			}
		});
	}
}
////////////////////////////////////////////////////////////////////
function soonMovieFunction(num){
	var setflag=$("#setFlag").val();
	var num2 =Number(num);
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MovieSoonAction.mo?count="+num2,
			dataType:"JSON",
			
			success:function(data){
				document.getElementById("contents_mo").innerHTML="";
				$.each(data.soonLength, function(key,value){
					if(num2>0){
						$('#contents_mo').append('<img id="prev_button" src="icons/button_prev.jpg" onclick="soonMovieFunction('+Number(num2-1)+')">');
					}
				});	
				$.each(data.soonList, function(key,value){
					
						$('#contents_mo').append('<img id="content" src="MovieImage/'+value.image+'" onclick="location.href='+"'"+'./MovieContentAction.mo?num='+value.movie_num+"'"+'">');			
					
				});
				$.each(data.soonLength, function(key,value){
					if(num2<=value.length-5){
						$('#contents_mo').append('<img id="next_button" src="icons/button_next.jpg" onclick="soonMovieFunction('+Number(num2+1)+')">');
					}
				});		
				
			},
			error: function(xhr, status, error){
				
			
			}
		});
	}
	
}
</script>
</head>
<body>
<div id="rank_div">
	<div id="rank">
		<div id="rank_head">
			<img alt="" src="icons/boxoffice.png">
			<div id="category">
			<span id="reserveOrder" onclick="reservFunction()">예매순</span>
			<span id="bar">|</span>
			<span id="gradeOrder" onclick="gradeFunction()">평점순</span>
			</div>
			
			<ul id="rank_ul">
				
			</ul>
			
		</div>
	</div>
	<div id="picture" style="background-image: url('MovieImage/dunkirk.jpg');">
	
	</div>
</div>
	
<div id="mid">
	 <div id="mid_category">
	  <div id="mid_subject" style="width: 1000px">
	  	<div id="subject_left"></div>
	  	<div id="subject_center" style="width: 440px;"><div>상영예정작</div></div>
	  	<div id="subject_right"></div>
	  </div>
	  <div class="clear"></div>
	 <div id="contents_mo">
	 	
	 </div>
	 </div>
</div>
	
	
	<div id="ad_banner">
	
	</div>
	

</body>
