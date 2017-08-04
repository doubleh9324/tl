<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/musical_index.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	imageFunction(0)
	setInterval(autoChangeFuction, 7000);
	getMuscialByGradeFunction();
	adBanner();
	
	$("#ad_banner").click(function(){
		var ad_m_num = $("#ad_m_num").val();
		location.href="./MovieContentAction.mo?num="+ad_m_num;
		
		
	});
	
	$('#picture').click(function(){
		location.href="./MusicalContentAction.mu?num="+$('#curr_num').val();
	});
})
//////////////////////////////////////////////////
function autoChangeFuction(){
	var next_num = Number($('#next_num').val());
	if(next_num==4){ next_num=0;}
	imageFunction(next_num);
	
}

function imageFunction(num){  
	var img_name= [ 'hedwig','gloomyday','rebeca','horrorshow' ];
	var img_num = Number(num)
	var m_num=['20171008','20171025','20171009','20171013'];
	var imagePath='MusicalImage/'+img_name[img_num]+'.jpg';
	
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
			url:"./MusicalGetInfoAction.mu?num="+m_num,
			dataType:"JSON",
			
			success:function(data){
				
			 $.each(data.musicalInfo, function(key,value){
				 $('#picture').append('<div id="info"></div>');
				$('#info').append('<span id="subject">'+value.name+'</span><br>'); 
				$('#info').append('<span id="ganre">'+value.ganre+'</span><span id="age">'+value.age+'</span>'); 
			 });
				
			},
			error: function(xhr, status, error){
				
			
			}
		});
	}
}
///////////////////////////////////////////////////
function getMuscialByGradeFunction(){
	var setflag=$("#setFlag").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MusicalByGanreAction.mu",
			dataType:"JSON",
			
			success:function(data){
				
			 $.each(data.gan_musicalList, function(key,value){
				 var name = value.name.substring(0,10);
				 if(name.length>9){ name=name+"...";}
				 if(value.g_code=='ori'){
					 var ori_code='<div id="ori_object">'
					 			+'<img src="MusicalImage/'+value.image+'" onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'"><br>'
					 			+'<span onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'">'+name+'</span></div>';
					 $(".ori_con").prepend(ori_code);	
					
				 }else if(value.g_code=='lic'){
					 var lic_code='<div id="lic_object">'
				 			+'<img src="MusicalImage/'+value.image+'" onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'"><br>'
				 			+'<span onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'">'+name+'</span></div>';
					 $(".lic_con").prepend(lic_code);
				 }else if(value.g_code=='non'){
					 var non_code='<div id="non_object">'
				 			+'<img src="MusicalImage/'+value.image+'" onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'"><br>'
				 			+'<span onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'">'+name+'</span></div>';
					 $(".non_con").prepend(non_code);

				 }else{
					 var cre_code='<div id="cre_object">'
				 			+'<img src="MusicalImage/'+value.image+'" onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'"><br>'
				 			+'<span onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'">'+name+'</span></div>';
					 $(".cre_con").prepend(cre_code);

				 }
			 });
			



			},
			error: function(xhr, status, error){
				
			
			}
		});
	}
}
/////////////////////////////////////////////////////////////////
function gradeFunction(){
	var setflag=$("#setFlag").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MusicalPopularAction.mu",
			dataType:"JSON",
			
			success:function(data){
				$("#rank_ul").html("");
				$("#gradeOrder").css("text-decoration","underline")
				$("#reserveOrder").css("text-decoration","none")
				$.each(data.pop_musicalList, function(key,value){
					var name = value.name;
					if(name.length>12){name=name.substring(0,11)+"...";}
					var grade=value.grade.toString();
					if(grade.length<3){grade=grade+".0";}
					var li_code='<li id="rank_li">'+(key+1)+'.<a href="./MusicalContentAction.mu?num='+value.musical_num+'">'+name+'</a><span>'+grade+'</span></li>';
					$("#rank_ul").append(li_code);
				});
				
			},
			error: function(xhr, status, error){
				
			}
		});
	}
}

////////////////////////////////////////////////////////

function adBanner(){
	var random = Math.floor(Math.random() * 5);
	var random_m_num =[ '20161481','20164621','20177761','20173403','20177181'];
	$("#ad_banner").append('<img src="icons/ad_'+random+'.jpg"><input type="hidden" id="ad_m_num" value="'+random_m_num[random]+'">');
}
/////////////////////////////////////////////////////




</script>
</head>
<body>
<div id="rank_div">
	<div id="rank">
		<div id="rank_head">
			<img alt="" src="icons/boxoffice.png">
			<div id="category"><span id="reserveOrder">예매순</span><span id="bar">|</span>
			<span id="gradeOrder" onclick="gradeFunction()">평점순</span>
			</div>
			
			<ul id="rank_ul">
				<li id="rank_li">1.1234</li>
				<li id="rank_li">2.1234</li>
				<li id="rank_li">3.1234</li>
				<li id="rank_li">4.1234</li>
				<li id="rank_li">5.1234</li>
				<li id="rank_li">6.1234</li>
				<li id="rank_li">7.1234</li>
				<li id="rank_li">8.1234</li>
				<li id="rank_li">9.1234</li>
				<li id="rank_li">10.1234</li>
			</ul>
			
		</div>
	</div>
	<div id="picture" style="background-image: url('MusicalImage/hedwig.jpg');">
	
	</div>
</div>
<div id="mid">
<h1 id="ganre">장르별 공연</h1>

	<div id="ori_div">
		<div id="mu_ganre">오리지널/내한공연</div>
		<div class="clear"></div>
		<div id="content" class="ori_con">
		
			<div class="clear"></div>
		</div>
	</div>


<div id="lic_div">
	<div id="mu_ganre">라이센스 공연</div>
	<div class="clear"></div>
	<div id="content" class="lic_con">
	
		<div class="clear"></div>
	</div>	
</div>


	<div id="non_div">
		<div id="mu_ganre">넌버벌 공연</div>
		<div class="clear"></div>
		<div id="content" class="non_con">
		
			<div class="clear"></div>
		</div>
	</div>

	<div id="cre_div">
		<div id="mu_ganre">창작 뮤지컬</div>
		<div class="clear"></div>
		<div id="content" class="cre_con">
			
			<div class="clear"></div>
		</div>	
	</div>
</div>


	<div id="ad_banner">
	
	</div>

</body>
