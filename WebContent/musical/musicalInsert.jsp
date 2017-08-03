<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<h1>뮤지컬 추가</h1>
	<form action="./MusicalInsertAction.mu" method="post" enctype="multipart/form-data">
	<table width="1000" border="0" align="center">
		<tr>
			<td align="center">장르</td>
			<td>
				<select name="g_code">
					<option value="cre">창작 뮤지컬</option>
					<option value="lic">라이센스</option>
					<option value="non">넌버벌 공연</option>
					<option value="ori">오리지널/내한공연</option>
				
				</select>
			</td>
		</tr>
		<tr>
			<td align="center">개막날짜</td>
			<td><input type="date" name="open_day"></td>
		</tr>
		<tr>
			<td align="center">폐막날짜</td>
			<td><input type="date" name="close_day"></td>
		</tr>
		<tr>
			<td align="center">뮤지컬 제목</td>
			<td><input type="text" name="name"></td>
		</tr>
		<tr>
			<td align="center">감독</td>
			<td><input type="text" name="director"></td>
		</tr>
		<tr>
			<td align="center">배우</td>
			<td><input type="text" name="actor"></td>
		</tr>
		<tr>
			<td align="center">제작사</td>
			<td><input type="text" name="production"></td>
		</tr>
		<tr>
			<td align="center">관람가</td>
			<td><input type="text" name="age"></td>	
		</tr>
		<tr>
			<td align="center">내용</td>
			<td><textarea name="contents" rows="10" cols="60"></textarea></td>	
		</tr>
		<tr>
			<td align="center">포스터</td>
			<td><input type="file" name="image" ></td>
		</tr>
		<tr>
			<td align="center">비디오링크</td>
			<td><input type="text" name="video"></td>	
		</tr>
		<tr>
			<td align="center"><input type="submit" value="추가하기"></td>		
		</tr>	
	</table>
	</form>
</body>
</html>