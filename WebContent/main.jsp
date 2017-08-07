<%@page import="team.movie.db.MovieBean"%>
<%@page import="java.util.Vector"%>
<%@page import="team.movie.db.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/slidebanner.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.banner.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	/* setInterval(autoChangeFuction, 7000);  */
	scheduledMusicalFunction();
	listMovieFunction(0);
	listMovieFunction2(0);
	listMusicalFunction(0);
	listMusicalFunction2(0);
	
	  var result = getCookie('popup');
	   if (result == 'end') {
	      $("#popup").css("display","none");
	      }
	
})
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function autoChangeFuction(){
	var curr_num = Number($('#curr_num').val());
	if(curr_num==13){ curr_num=1;}
	changeImageFunction(curr_num);

}


function changeImageFunction(num){  // 작은 사진을 클릭하면 배너의 사진이 바뀌는 메서드
	var m_num= [ '20167303', '20178982', '20164621','20158485','20179901','20166967','20171000','20171001','20171005','20171008','20171028','20171009' ]; //영화또는 뮤지컬고유번호
	if(num<7){ 
		var img_code='<img id="top_button" src="icons/btn_detail.png" onclick="location.href='+"'"+'./MovieContentAction.mo?num='+m_num[Number(num)-1]+"'"+'">';
	}else {
		var img_code='<img id="top_button" src="icons/btn_detail.png" onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+m_num[Number(num)-1]+"'"+'">';
	}
	
	var imagePath='topimage/'+num+'.jpg';
	document.getElementById("top").innerHTML="";
	var changeTag ='<div id="top_frame" style="background-image:url('+imagePath+');">'+
	'<input type="hidden" id="curr_num" value='+(Number(num)+1)+'>'+
	img_code+
	'<ul id="photo_list">'+
		'<li id="photo_object"><img src="topimage/1_mini.jpg" onclick="changeImageFunction(1)"></li>'+
		'<li id="photo_object"><img src="topimage/2_mini.jpg" onclick="changeImageFunction(2)"></li>'+
		'<li id="photo_object"><img src="topimage/3_mini.jpg" onclick="changeImageFunction(3)"></li>'+
		'<li id="photo_object"><img src="topimage/4_mini.jpg" onclick="changeImageFunction(4)"></li>'+
		'<li id="photo_object"><img src="topimage/5_mini.jpg" onclick="changeImageFunction(5)"></li>'+
		'<li id="photo_object"><img src="topimage/6_mini.jpg" onclick="changeImageFunction(6)"></li>'+
		'<li id="photo_object"><img src="topimage/7_mini.jpg" onclick="changeImageFunction(7)"></li>'+
		'<li id="photo_object"><img src="topimage/8_mini.jpg" onclick="changeImageFunction(8)"></li>'+
		'<li id="photo_object"><img src="topimage/9_mini.jpg" onclick="changeImageFunction(9)"></li>'+
		'<li id="photo_object"><img src="topimage/10_mini.jpg" onclick="changeImageFunction(10)"></li>'+
		'<li id="photo_object"><img src="topimage/11_mini.jpg" onclick="changeImageFunction(11)"></li>'+
		'<li id="photo_object"><img src="topimage/12_mini.jpg" onclick="changeImageFunction(12)"></li>'+
	'</ul>';

	$('#top').append(changeTag);
	
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function listMovieFunction(num){
	var setflag=$("#setFlag").val();
	var num2 =Number(num);
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MoviePlaying4Action.mo?count="+num2,
			dataType:"JSON",
			
			success:function(data){
				document.getElementById("contents_mo").innerHTML="";
				$.each(data.movieLength, function(key,value){
					if(num2>0){
						$('#contents_mo').append('<img id="prev_button" src="icons/button_prev.jpg" onclick="listMovieFunction('+Number(num2-1)+')">');
					}
				});	
				$.each(data.movieList, function(key,value){
					
						$('#contents_mo').append('<img id="content" src="MovieImage/'+value.image+'" onclick="location.href='+"'"+'./MovieContentAction.mo?num='+value.movie_num+"'"+'">');			
					
				});
				$.each(data.movieLength, function(key,value){
					if(num2<=value.length-5){
						$('#contents_mo').append('<img id="next_button" src="icons/button_next.jpg" onclick="listMovieFunction('+Number(num2+1)+')">');
					}
				});		
				
				
				
				
				
			},
			error: function(xhr, status, error){
				
			
			}
		});
	}
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* S:이주의 상영작 */


function listMovieFunction2(num){
	var setflag=$("#setFlag").val();
	var num2 =Number(num);
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MoviePlaying4Action2.mo?count="+num2,
			dataType:"JSON",
			
			success:function(data){
				document.getElementById("contents_mo2").innerHTML="";				
				$.each(data.movieList, function(key,value){					
						$('#contents_mo2').append('<img id="content_w" src="MovieImage/'+value.image+'" onclick="location.href='+"'"+'./MovieContentAction.mo?num='+value.movie_num+"'"+'">');			
					
				});				
			},
			error: function(xhr, status, error){			
			}
		});
	}
	
}




function listMusicalFunction2(num){
	var setflag=$("#setFlag").val();
	var num2 =Number(num);
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MusicalPlaying4Action2.mu?count="+num2,
			dataType:"JSON",
			
			success:function(data){
				document.getElementById("contents_mu2").innerHTML="";				
				$.each(data.musicalList, function(key,value){					
						$('#contents_mu2').append('<img id="content_w" src="MusicalImage/'+value.image+'" onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'">');		
					
				});						
			},
			error: function(xhr, status, error){			
			
			}
		});
	}
}

//슬라이드업배너 슬라이드배너

$(function() {
	$("#image_list_1").jQBanner({	//롤링을 할 영역의 ID 값
		nWidth:960,					//영역의 width
		nHeight:150,				//영역의 height
		nCount:3,					//돌아갈 이미지 개수
		isActType:"up",				//움직일 방향 (left, right, up, down)
		nOrderNo:1,					//초기 이미지

	nDelay : 3000
		//롤링 시간 타임 (1000 = 1초)
		/*isBtnType:"li"*///라벨(버튼 타입) - 여기는 안쓰임
		});

		
	});
/* E:이주의 상영작 */

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function listMusicalFunction(num){
	var setflag=$("#setFlag").val();
	var num2 =Number(num);
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MusicalPlaying4Action.mu?count="+num2,
			dataType:"JSON",
			
			success:function(data){
				document.getElementById("contents_mu").innerHTML="";
				$.each(data.musicalLength, function(key,value){
					if(num2>0){
						$('#contents_mu').append('<img id="prev_button" src="icons/button_prev.jpg" onclick="listMusicalFunction('+Number(num2-1)+')">');
					}
				});	
				$.each(data.musicalList, function(key,value){
					
						$('#contents_mu').append('<img id="content" src="MusicalImage/'+value.image+'" onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'">');			
					
				});
				$.each(data.musicalLength, function(key,value){
					if(num2<=value.length-5){
						$('#contents_mu').append('<img id="next_button" src="icons/button_next.jpg" onclick="listMusicalFunction('+Number(num2+1)+')">');
					}
				});		
				
			},
			error: function(xhr, status, error){
				
			
			}
		});
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function scheduledMusicalFunction(){
	var setflag=$("#setFlag").val();
	
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MusicalScheduleAction.mu",
			dataType:"JSON",
			
			success:function(data){
				document.getElementById("sche_mu_content").innerHTML="";
				$.each(data.sche_musicalList, function(key,value){
					var onclick_code=' onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'"';

					$('#sche_mu_content').append('<li><img src="MusicalImage/'+value.image+'"'+onclick_code +'></li>');
				});
				
				$.each(data.sche_musicalList, function(key,value){
					
					var name = value.name;
					var namelength = name.substring(0,10);
					var dots ="..";
					
					if(namelength.length>9){ namelength=namelength+dots;}
					$('#sche_mu_content').append('<li id="name">'+namelength+'</li>')

				});
				$.each(data.sche_musicalList, function(key,value){
					$('#sche_mu_content').append('<li id="open_day">'+value.open_day+' 개막'+'</li>')

				});
			},
			
			error: function(xhr, status, error){
				
			
			}
		});
	
	}
}

function popularMusicalFunction(){
	var setflag=$("#setFlag").val();
	
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MusicalPopularAction.mu",
			dataType:"JSON",
			
			success:function(data){
				document.getElementById("sche_mu_content").innerHTML="";
				$.each(data.pop_musicalList, function(key,value){
					if(key==5) return false;
					var onclick_code=' onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'"';

					$('#sche_mu_content').append('<li><img src="MusicalImage/'+value.image+'"'+onclick_code +'></li>');
				});
				
				$.each(data.pop_musicalList, function(key,value){
					if(key==5) return false;
					var name = value.name;
					var namelength = name.substring(0,10);
					var dots ="..";
					
					if(namelength.length>9){ namelength=namelength+dots;}
					
					$('#sche_mu_content').append('<li id="name">'+namelength+'</li>')

				});
				$.each(data.pop_musicalList, function(key,value){
					if(key==5) return false;
					$('#sche_mu_content').append('<li id="open_day">'+'평점 : '+value.grade+'</li>')

				});
			},
			
			error: function(xhr, status, error){
				
			
			}
		});
	
	}
}


////////////////////////////////

//팝업 광고를 사용자가 이용하려고 할 경우
function reservation(){
   $("#popup").css("display","none");
   window.open("./reserveMV.rs","","width=1050, height=795, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
}
//

//팝업창에서 오늘은 열지 않기 클릭시 종료 하고 쿠키를 삽입하는 함수
function noshow(){
   
   setCookie( "popup", "end" , 1);
   $("#popup").css("display","none");
   
}
  
 //셋쿠키 
function setCookie(cname, value, expire) {
      var todayValue = new Date();
      // 오늘 날짜를 변수에 저장

      todayValue.setDate(todayValue.getDate() + expire);
      document.cookie = cname + "=" + encodeURI(value) + "; expires=" + todayValue.toGMTString() + "; path=/;";
   }      



 function getCookie(name) { 
      var cookieName = name + "=";
      var x = 0;
      while ( x <= document.cookie.length ) { 
         var y = (x+cookieName.length); 
         if ( document.cookie.substring( x, y ) == cookieName) { 
            if ((lastChrCookie=document.cookie.indexOf(";", y)) == -1) 
               lastChrCookie = document.cookie.length;
            return decodeURI(document.cookie.substring(y, lastChrCookie));
         }
         x = document.cookie.indexOf(" ", x ) + 1; 
         if ( x == 0 )
            break; 
         } 
      return "";
   }
</script>
</head>

<body style="margin: 0px; padding:0px; z-index: 0;">
<div id="top">
<div id="top_frame" style="background-image:url('topimage/1.jpg');">
	<input type="hidden" id="curr_num" value="2">
	<img id="top_button" src="icons/btn_detail.png" onclick="location.href='./MovieContentAction.mo?num=20167303'">
	<ul id="photo_list">
		<li id="photo_object"><img src="topimage/1_mini.jpg" onclick="changeImageFunction(1)"></li>
		<li id="photo_object"><img src="topimage/2_mini.jpg" onclick="changeImageFunction(2)"></li>
		<li id="photo_object"><img src="topimage/3_mini.jpg" onclick="changeImageFunction(3)"></li>
		<li id="photo_object"><img src="topimage/4_mini.jpg" onclick="changeImageFunction(4)"></li>
		<li id="photo_object"><img src="topimage/5_mini.jpg" onclick="changeImageFunction(5)"></li>
		<li id="photo_object"><img src="topimage/6_mini.jpg" onclick="changeImageFunction(6)"></li>
		<li id="photo_object"><img src="topimage/7_mini.jpg" onclick="changeImageFunction(7)"></li>
		<li id="photo_object"><img src="topimage/8_mini.jpg" onclick="changeImageFunction(8)"></li>
		<li id="photo_object"><img src="topimage/9_mini.jpg" onclick="changeImageFunction(9)"></li>
		<li id="photo_object"><img src="topimage/10_mini.jpg" onclick="changeImageFunction(10)"></li>
		<li id="photo_object"><img src="topimage/11_mini.jpg" onclick="changeImageFunction(11)"></li>
		<li id="photo_object"><img src="topimage/12_mini.jpg" onclick="changeImageFunction(12)"></li>
		
	</ul>	
</div>
<div class="clear" ></div>
</div>

<div id="popup">
<div onclick="reservation()"><img src="img/popup1.jpg" id="pop1"><img src="img/popup2.jpg"></div>
<div id ="noshow" onclick="noshow()">이 글을 클릭하시면 하루동안 보이지 않습니다</div>
</div>
<!--------------------------------------------------------- -->
<div id="mid">
 <div id="category">
  <div id="subject">
  	<div id="subject_left"></div>
  	<div id="subject_center"><div>MOVIE</div></div>
  	<div id="subject_right"></div>
  </div>
  <div class="clear"></div>
 <div id="contents_mo">
 	
 </div>
 </div>
 
 
  <div id="category">
  <div id="subject">
  	<div id="subject_left"></div>
  	<div id="subject_center"><div>MUSICAL</div></div>
  	<div id="subject_right"></div>
  </div>
  <div class="clear"></div>
 <div id="contents_mu">
 	
 </div>
 </div>
 
 <div id="category_week">
  <div id="subject">
  	<div id="subject_left"></div>
  	<div id="subject_center"><div>이주의 상영작</div></div>
  	<div id="subject_right"></div>
  </div>
  <div class="clear"></div> 
  <div id="weekBox1">  
  	<jsp:include page="slideweek.jsp"/>  
  </div>
  <div id="weekBox2">
  
	  <div id="contents_mo2" class="week_smallbox"> 	
	  </div>
	  <div id="contents_mu2" class="week_smallbox"> 	
	  </div> 
    
  </div> 
  <div id="weekBox3">
	<div id="image_list_1">
	<div class="clsBannerScreen">
	<div class="images" style="display:block"><a href="./MovieContentAction.mo?num=20167904"><img src="img_week/wb3.png" height="150px"/></a></div>
	<div class="images"><a href="./MusicalContentAction.mu?num=20171013"><img src="img_week/wb2.png"  height="150px"/></a></div>
	<div class="images"><a href="./MusicalContentAction.mu?num=20171025"><img src="img_week/wb1.png"  height="150px"/></a></div>	
	</div>
</div>
  </div> 
  </div>
 
</div>
<!--------------------------------------------------------------->
<div id="bottom">
	<div id="schedule_musical">
		<div id="sche_mu_object">
			<ul id="sche_mu_cate">
				<li onclick="scheduledMusicalFunction()">개막예정 </li>
				<li onclick="popularMusicalFunction()">인기뮤지컬</li>
			</ul>
		<div class="clear" ></div>	
			<ul id="sche_mu_content" >
				
				
			</ul>
			
			
		<div class="clear"></div>	
		</div>
	</div>
</div>	
</body>
