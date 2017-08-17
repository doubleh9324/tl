<%@page import="team.movie.db.MovieBean"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
	.news {padding:0 0px 20px;}
		.news .open-event {height:33px; position:relative; overflow:hidden;}
		.news .open-event ul{position:absolute; top:0px;}
		.news .open-event ul#notice1 {left:0;}
		.news .open-event ul#notice2 {right:20px;}
		.news .open-event ul li {height:20px;}
		.news .open-event ul li a {display:inline-block; width:140px;}
/* 		.news .open-event ul li a:hover {color:#8f7614; text-decoration:underline;} */
		.news .open-event ul li a strong {margin-right:10px;}
		.news .open-event ul li span.date {display:inline-block; width:80px;}
			.news .open-event .prev{position:absolute; top:1px; right:2px; width:7px; height:4px; line-height:0; font-size:0;}
			.news .open-event .next{position:absolute; bottom:1px; right:2px; width:7px; height:4px; line-height:0; font-size:0;}
		.news .control {float:left; margin:0px 0 0 10px; }
		/* 	.news .control a.stop {font-size:12px;}
			.news .control a.on {color:red; font-size:12px;} */
			
		.notice-list li a:VISITED {text-decoration: none;}
		.nocice-list {height: 50px;}
</style>

<link rel="stylesheet" href="css/main.css">

<script type="text/javascript">


$(document).ready(function(){
	listMovieFunction2_2();
	listMusicalFunction2_2();
	
})



function listMovieFunction2_2(){
	var setflag=$("#setFlag").val();
	
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MovieSoonAction2.mo?count="+Number(0),
			dataType:"JSON",
			
			success:function(data){
/* 				document.getElementById("open-event fl").innerHTML="";	
 */			/* 	$('#open-event fl').append('<ul class="notice-list"></ul>');  */
				$.each(data.soonList, function(key,value){		
					if(value.name.length>9){var name=value.name.substring(0,8)+"..";}else{
						name=value.name;
					}
 						$('.notice-listMo').append('<li><a href="./MovieContentAction.mo?num='+value.movie_num+'">'+name+'</a><span class="date">'+value.open_day+'</span></li>');
						
				});				
			},
			error: function(xhr, status, error){			
			}
		});
	}
	
}


function listMusicalFunction2_2(){
	var setflag=$("#setFlag").val();
	
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MusicalSoonAction.mu?count="+Number(0),
			dataType:"JSON",
			
			success:function(data){
/* 				document.getElementById("open-event fl").innerHTML="";	
 */			/* 	$('#open-event fl').append('<ul class="notice-list"></ul>');  */
				$.each(data.soonList, function(key,value){		
					if(value.name.length>9){var name=value.name.substring(0,8)+"..";}else{
						name=value.name;
					}
 						$('.notice-listMu').append('<li><a href="./MusicalContentAction.mu?num='+value.musical_num+'">'+name+'</a><span class="date">'+value.open_day+'</span></li>');
						
				});				
			},
			error: function(xhr, status, error){			
			}
		});
	}
	
}





function fn_articleMo(containerID, buttonID, autoStart){
	var $element = $('#'+containerID).find('.notice-listMo');
//   	var $prev = $('#'+buttonID).find('.prev');
// 	var $next = $('#'+buttonID).find('.next');
	var $play = $('#'+containerID).find('.control > a.play');
	var $stop = $('#'+containerID).find('.control > a.stop');  
	var autoPlay = autoStart;
	var auto = null;
	var speed = 3000;
	var timer = null;

	var move = $element.children().outerHeight();
	var first = false;
	var lastChild;
	

	lastChild = $element.children().eq(-1).clone(true);
	lastChild.prependTo($element);
	$element.children().eq(-1).remove();

	if($element.children().length==1){
		$element.css('top','0px');
	}else{
		$element.css('top','-'+move+'px');
	}

	if(autoPlay){
		timer = setInterval(moveNextSlide, speed);
		$play.addClass('on').text('▶');
		auto = true;
	}else{
		$play.hide();
		$stop.hide();
	}

	$element.bind({
		'mouseenter': function(){
			if(auto){
				clearInterval(timer);
			}
		},
		'mouseleave': function(){
			if(auto){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	
	

	$prev.bind({
		'click': function(){
			movePrevSlide();
			return false;	
		},
		'mouseenter': function(){
			if(auto){
				clearInterval(timer);
			}
		},
		'mouseleave': function(){
			if(auto){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	$next.bind({
		'click': function(){
			moveNextSlide();
			return false;
		},
		'mouseenter': function(){
			if(auto){
				clearInterval(timer);
			}
		},
		'mouseleave': function(){
			if(auto){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	function movePrevSlide(){
		$element.each(function(idx){
			if(!first){
				$element.eq(idx).animate({'top': '0px'},'normal',function(){
					lastChild = $(this).children().eq(-1).clone(true);
					lastChild.prependTo($element.eq(idx));
					$(this).children().eq(-1).remove();
					$(this).css('top','-'+move+'px');
				});
				first = true;
				return false;
			}

			$element.eq(idx).animate({'top': '0px'},'normal',function(){
				lastChild = $(this).children().filter(':last-child').clone(true);
				lastChild.prependTo($element.eq(idx));
				$(this).children().filter(':last-child').remove();
				$(this).css('top','-'+move+'px');
			});
		});
	}

	function moveNextSlide(){
		$element.each(function(idx){

			var firstChild = $element.children().filter(':first-child').clone(true);
			firstChild.appendTo($element.eq(idx));
			$element.children().filter(':first-child').remove();
			$element.css('top','0px');

			$element.eq(idx).animate({'top':'-'+move+'px'},'normal');

		});
	}
}

//////////////////////////////////////////////////////////////////////////////////

function fn_articleMu(containerID, buttonID, autoStart){
	var $element = $('#'+containerID).find('.notice-listMu');
//   	var $prev = $('#'+buttonID).find('.prev');
// 	var $next = $('#'+buttonID).find('.next');
	var $play = $('#'+containerID).find('.control > a.play');
	var $stop = $('#'+containerID).find('.control > a.stop');  
	var autoPlay = autoStart;
	var auto = null;
	var speed = 3000;
	var timer = null;

	var move = $element.children().outerHeight();
	var first = false;
	var lastChild;
	

	lastChild = $element.children().eq(-1).clone(true);
	lastChild.prependTo($element);
	$element.children().eq(-1).remove();

	if($element.children().length==1){
		$element.css('top','0px');
	}else{
		$element.css('top','-'+move+'px');
	}

	if(autoPlay){
		timer = setInterval(moveNextSlide, speed);
		$play.addClass('on').text('▶');
		auto = true;
	}else{
		$play.hide();
		$stop.hide();
	}

	$element.bind({
		'mouseenter': function(){
			if(auto){
				clearInterval(timer);
			}
		},
		'mouseleave': function(){
			if(auto){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	
	

	$prev.bind({
		'click': function(){
			movePrevSlide();
			return false;	
		},
		'mouseenter': function(){
			if(auto){
				clearInterval(timer);
			}
		},
		'mouseleave': function(){
			if(auto){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	$next.bind({
		'click': function(){
			moveNextSlide();
			return false;
		},
		'mouseenter': function(){
			if(auto){
				clearInterval(timer);
			}
		},
		'mouseleave': function(){
			if(auto){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	function movePrevSlide(){
		$element.each(function(idx){
			if(!first){
				$element.eq(idx).animate({'top': '0px'},'normal',function(){
					lastChild = $(this).children().eq(-1).clone(true);
					lastChild.prependTo($element.eq(idx));
					$(this).children().eq(-1).remove();
					$(this).css('top','-'+move+'px');
				});
				first = true;
				return false;
			}

			$element.eq(idx).animate({'top': '0px'},'normal',function(){
				lastChild = $(this).children().filter(':last-child').clone(true);
				lastChild.prependTo($element.eq(idx));
				$(this).children().filter(':last-child').remove();
				$(this).css('top','-'+move+'px');
			});
		});
	}

	function moveNextSlide(){
		$element.each(function(idx){

			var firstChild = $element.children().filter(':first-child').clone(true);
			firstChild.appendTo($element.eq(idx));
			$element.children().filter(':first-child').remove();
			$element.css('top','0px');

			$element.eq(idx).animate({'top':'-'+move+'px'},'normal');

		});
	}
}


</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<div id="open_box">

<div class="open_img"><img src="img/onlySell.gif"></div>
<div class="clear"></div>
<div id="open_info">
	<!-- 영화 -->
	<div id="notice5" class="news" style="margin-top:35px; padding:0 0 0 0;">
		<div id="open-event fl" class="open-event fl" style="width:250px; height:40px;">
			<ul class="notice-listMo">			
			</ul>
			 	 
		</div>
		
		<script type="text/javascript"> fn_articleMo('notice5','bt5',true);</script>
	</div>
	<!-- 뮤지컬 -->
	<div id="notice6" class="news" style="margin-top:10px; padding-top:0;">
		<div id="open-event fl" class="open-event fl" style="width:250px;  height:40px;">
		
			<ul class="notice-listMu">			
			</ul>
			 
		</div>
		
		<script type="text/javascript"> fn_articleMu('notice6','bt5',true);</script>
	</div>	
</div>

</div>


</body>
</html>