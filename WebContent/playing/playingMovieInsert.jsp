<%@page import="team.movie.db.MovieBean"%>
<%@page import="team.movie.db.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
function selectFunction(){
	var setflag = $("#setFlag").val();
	var p_code = $("#p_code").val();
	
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./PlaceSelectAction.pc?code="+p_code,
			dataType:"JSON",
			success:function(data){
				document.getElementById("place_table").innerHTML="";
	
				$.each(data.placeList, function(key,value){
					
					$("#place_table").append('<tr><td id="check_'+(key+1)+'" name="check">'+'</td><td id="p_codes">'+value.p_code+'</td><td>'+value.name+'</td><td>'+value.address+'</td><td><input type="checkbox" name="screen_name" value="'+value.screen_name+'" onclick="checkFunction('+"'"+(key+1)+"'"+",'"+value.p_code+"'"+')">'+value.screen_name+'</td><td>'+value.capacity+'</td></tr>');
					
				});	
				
				
					
			},
			
			error: function(xhr, status, error){ 
				alert("에러발생");
				
			}
		});
		nameFunction();
	}
	
}

function nameFunction(){
	var setflag = $("#setFlag").val();
	var p_code = $("#p_code").val();
	
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./PlaceGetNameAction.pc?code="+p_code,
			dataType:"JSON",
			success:function(data){
				document.getElementById("name").innerHTML="";

				$("#name").append('<option value="">전체</option>');
				$.each(data.nameList, function(key,value){
					$("#name").append('<option value="'+value.name+'">'+value.name+'</option>');
				});		
			},
			
			error: function(xhr, status, error){ 
				alert("에러발생");
				
			}
		});
		
	}
}

function nameSelectFunction(){
	var setflag=$("#setFlag").val();
	var p_code = $("#p_code").val();
	var name=$("#name").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./PlaceSelectNameAction.pc?code="+p_code+"&name="+name,
			dataType:"JSON",
			success:function(data){
				document.getElementById("place_table").innerHTML="";
				
				$.each(data.list, function(key,value){
					
					$("#place_table").append('<tr><td id="check_'+(key+1)+'" name="check">'+'</td><td id="p_codes">'+value.p_code+'</td><td>'+value.name+'</td><td>'+value.address+'</td><td><input type="checkbox" id="screen_name" name="screen_name" value="'+value.screen_name+'" onclick="checkFunction('+"'"+(key+1)+"'"+",'"+value.p_code+"'"+')">'+value.screen_name+'</td><td>'+value.capacity+'</td></tr>');
					
				});		
			},
			
			error: function(xhr, status, error){ 
				alert("에러발생");
				
			}
		});
		
	}
	
}

function checkFunction(num,p_code){
	
		document.getElementById("check_"+num).innerHTML="";
		$("#check_"+num).append('<input type="checkbox" checked="checked" name="ck_pcode" value="'+p_code+'">');
}

function insertFunction(){
	document.forms[0].submit();
	
}

</script>
<title>Insert title here</title>
</head>
<body>
<% 
	request.setCharacterEncoding("utf-8");
	String movie_num = request.getParameter("num");
	MovieDAO dao = new MovieDAO();
	MovieBean bean = dao.selectMovie(movie_num);
%>

<form action="./PlayingInsertAction.pl" method="post">
영화고유번호 : <input type="text" value="<%=movie_num%>" readonly="readonly"><br>
<img src="MovieImage/<%=bean.getImage() %>" alt="" width="150px" height="200px"><br>
제목 : <%=bean.getName() %> <br>
고유분야코드: <input type="text" name="nc_code" value="mo<%=bean.getMovie_num()%>" readonly="readonly" ><br>
시작날짜: <input type="text" name="start_day" value="<%=bean.getOpen_day() %>" readonly="readonly">
<hr>
지역:<select id="p_code" onchange="selectFunction()" >
	<option value="">선택</option>
	<option value="bs">부산</option>
	<option value="cc" >충청</option>
	<option value="dj">대전</option>
	<option value="ic">인천</option>
	<option value="jj">제주</option>
	<option value="jr">전라</option>
	<option value="kb">경북</option>
	<option value="kj">광주</option>
	<option value="kk">경기</option>
	<option value="kn">경남</option>
	<option value="ks">경상</option>
	<option value="kw">강원</option>
	<option value="sj">세종</option>
	<option value="su">서울</option>
	<option value="tk">대구</option>
	<option value="us">울산</option>	
</select>
<select id="name" onchange="nameSelectFunction()">
</select>
<table>
	<thead>
		<th>번호</th>
		<th>장소코드</th>
		<th>장소</th>
		<th>주소</th>
		<th>관</th>
		<th>좌석수</th>
	</thead>
	<tbody id="place_table">
	
	</tbody>
	
</table>

<hr>
<button onclick="insertFunction()">추가</button>
</form>





</body>
</html>