<%@page import="team.musical.db.MusicalBean"%>
<%@page import="team.musical.db.MusicalDAO"%>
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
					
					$("#place_table").append('<tr><td>'+value.p_code+'</td><td>'+value.name+'</td><td>'+value.address+'</td><td><input type="checkbox" name="screen_name" value="'+value.screen_name+'">'+value.screen_name+'</td><td>'+value.capacity+'</td></tr>');
					
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
					
					$("#place_table").append('<tr><td>'+value.p_code+'</td><td>'+value.name+'</td><td>'+value.address+'</td><td><input type="checkbox" name="screen_name" value="'+value.screen_name+'">'+value.screen_name+'</td><td>'+value.capacity+'</td></tr>');
					
				});		
			},
			
			error: function(xhr, status, error){ 
				alert("에러발생");
				
			}
		});
		
	}
	
}

function insertFunction(){
	
	
}

</script>
<title>Insert title here</title>
</head>
<body>
<% 
	request.setCharacterEncoding("utf-8");
	String musical_num = request.getParameter("num");
	MusicalDAO dao = new MusicalDAO();
	MusicalBean bean = dao.selectMusical(musical_num);
%>
<form action="./PlayingInsertAction.pl" method="post">
영화고유번호 : <input type="text" value="<%=musical_num%>" readonly="readonly"><br>
<img src="MusicalImage/<%=bean.getImage() %>" alt="" width="150px" height="200px"><br>
제목 : <%=bean.getName() %> <br>
고유분야코드: <input type="text" name="nc_code" value="mu<%=bean.getMusical_num()%>" readonly="readonly" ><br>
시작날짜: <input type="text" name="start_day" value="<%=bean.getOpen_day() %>" readonly="readonly"><br>
폐막날짜: <input type="text" name="end_day" value="<%=bean.getClose_day()%>" readonly="readonly">
<hr>
지역:<select id="p_code" onchange="selectFunction()" >
	<option value="">선택</option>
	<option value="bs">부산</option>
	<option value="cc">충청</option>
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
		<td>장소코드</td>
		<td>장소</td>
		<td>주소</td>
		<td>관</td>
		<td>좌석수</td>
	</thead>
	<tbody id="place_table">
	
	</tbody>

</table>
<hr>
<input type="button" value="추가" onclick="insertFunction()">
</form>

</body>
</html>