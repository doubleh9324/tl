<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<h1 align="center">영화 추가</h1>
	<form action="./MovieInsertAction.mo" method="post" enctype="multipart/form-data">

	<table width="1000" border="0" align="center">
		<tr>
			<td align="center">장르</td>
			<td>
				<select name="g_code">
					<option value="act">액션</option>
					<option value="adv">모험</option>
					<option value="ani">애니메이션</option>
					<option value="com">코미디</option>
					<option value="dra">드라마</option>
					<option value="fam">가족</option>
					<option value="hor">공포</option>
					<option value="rom">로맨스</option>
					<option value="thr">스릴러</option>
					<option value="sf">SF</option>
					<option value="mys">미스터리</option>
					<option value="his">사극</option>
					<option value="fan">판타지</option>
					<option value="doc">다큐멘터리</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="center">영화고유번호</td>
			<td><input type="text" name="movie_num" ></td>
		</tr>
		<tr>
			<td align="center">개봉일</td>
			<td><input type="date" name="open_day"></td>
		</tr>
		<tr>
			<td align="center">영화제목</td>
			<td><input type="text" name="name" ></td>
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