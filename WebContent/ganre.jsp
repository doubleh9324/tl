<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/search.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var cate="<%=request.getParameter("cate")%>";
	var g_code="<%=request.getParameter("g_code")%>";
	getGanreResultFunction(cate,g_code);
	
	
})

function getGanreResultFunction(cate,g_code){
	var setflag=$("#setFlag").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./GanreAction.ga?cate="+cate+"&g_code="+g_code,
			dataType:"JSON",
			
			success:function(data){
				var all_count=0;
				
			 	all_count= data.ganreResult.length;
	
			 
				$.each(data.ganreResult, function(key,value){
					if(key==0){
						$("#title_subject").append(value.ganre);
					}
					
				});
			 	
				$('#all_count').append("("+all_count+")");
				
				if(cate=="mo"){
					$.each(data.ganreResult, function(key,value){
						var age = value.age;
						 if(age=="12"){ age="12세이용가"
						 }else if(age=="15"){age="15세이용가"
						 }else if(age=="all"){age="전체이용가"
					     }else if(age=="18"){age="청소년관람불가"}
						 
						var appned_code='<tr id="search_tr"><td id="long_td"><div id="info_wrap"><img src="MovieImage/'+value.image+'" onclick="location.href='+"'"+'./'+'MovieContentAction.mo?num='+value.movie_num+"'"+'"'+'>'
										+'<dl><dt id="subject"><a id="subject" onclick="location.href='+"'"+'./'+'MovieContentAction.mo?num='+value.movie_num+"'"+'"'+'>'+value.name+'</a></dt>'
										+'<dd><ul><li>장르 : '+value.ganre+'</li><li>등급 : '+age+'</li><li>감독 : '+value.director+'</li>'
										+'</ul></dd></dl></div></td>'
										+'<td id="short_td">'+value.open_day+'</td>'
										+'<td id="short_td"><img src="icons/star01_white.gif">'+value.grade+"</td>"
										+'<td id="short_td_last"><img src="icons/btn_detail2.png" onclick="location.href='+"'"+'./MovieContentAction.mo?num='+value.movie_num+"'"+'"></td></tr>';
										
						$('#search_tbody').append(appned_code);	
						
						
						
					});
				}else{
					$.each(data.ganreResult, function(key,value){
						var appned_code='<tr id="search_tr"><td id="long_td"><div id="info_wrap"><img src="MusicalImage/'+value.image+'" onclick="location.href='+"'"+'./'+'MusicalContentAction.mu?num='+value.musical_num+"'"+'"'+'>'
										+'<dl><dt id="subject"><a id="subject" onclick="location.href='+"'"+'./'+'MusicalContentAction.mu?num='+value.musical_num+"'"+'"'+'>'+value.name+'</a></dt>'
										+'<dd><ul><li>장르 : '+value.ganre+'</li><li>등급 : '+value.age+'</li><li>감독 : '+value.director+'</li>'
										+'</ul></dd></dl></div></td>'
										+'<td id="short_td">'+value.open_day+'<br>~'+value.close_day+'</td>'
										+'<td id="short_td"><img src="icons/star01_white.gif" id="star">'+value.grade+"</td>"
										+'<td id="short_td_last"><img src="icons/btn_detail2.png" onclick="location.href='+"'"+'./MusicalContentAction.mu?num='+value.musical_num+"'"+'"></td></tr>';
										
						$('#search_tbody').append(appned_code);	
						
						
						
					});
				}
			},
			
			
			error: function(xhr, status, error){
				
			
			}
		});
	}
}


</script>
</head>
<body>
<div id="body">
	<div id="result_title"><span id="title_subject"></span>에 대한 검색결과는 <span id="all_count"></span> 건 입니다.</div>
	
	<div class="clear"></div>
	<div id="result_body">
		<table id="search_table">
			<thead>
				<tr>
					<th id="long_th">작품기본정보</th>
					<th id="short_th">개봉일</th>
					<th id="short_th">평점</th>
					<th id="short_th_last">정보</th>
				</tr>
			</thead>
			<tbody id="search_tbody">
				
			
			</tbody>
		</table>
	</div>
</div>
</body>