<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 본문내용 -->
<center>

		<article>
			<h1>Join Us</h1>
			<%--MemberFrontController서블릿에.. 회원가입 처리 요청! --%>
			<form action="./ReBoardInsert.rbo" id="qna_write" method="post">
				
				<fieldset>
				<legend>Basic Info</legend>
				<label>q_num(del)</label>
					<input type="text" name="q_num" class="q_num"><br>
				<label>re_num(del)</label>
					<input type="text" name="re_num" class="re_num"><br>
				<label>contents</label>
					<input type="text" name="contents"><br>
				<label>re_date</label>
					<input type="date" name="re_date"><br>
				
						<input type="submit" value="Submit" class="submit">
						<input type="reset" value="Cancel" class="cancel">
				</fieldset>			
			</form>
		</article>

</center>
<!-- 본문내용 -->
</body>
</html>