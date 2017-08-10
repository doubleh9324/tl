<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/reservedelpop.css">
<link rel="stylesheet" href="css/reserve_pop_style.css" />
<script src="//code.jquery.com/jquery.min.js"></script>
</head>





<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">>
	<div
		style="position: absolute; left: 0px; top: 0px; z-index: 250; border-style: none; visibility: hidden; width: 0px;">
		<iframe name="_ifmlayer0" width="100%" height="100%"
			src="https://incorp.interpark.com/static/empty.html" marginwidth="0"
			marginheight="0" frameborder="0" scrolling="no"
			style="border: none; border-width: 0px"></iframe>
	</div>

	<!-- 세션 -->
	<% 
	String id = (String)session.getAttribute("id"); 
	String r_num = request.getParameter("r_num");
	%>
<center>
	<div class="box_popup">
	<div class="box_pop">
		<div style="width: 350px; height:100px;">
		<div class="content"><strong><%=id %></strong>님! <br/>선택하신 예매 내역을 진짜 취소하시겠습니까? <br/><strong>다시 한 번 확인 부탁드립니다.</strong><br/><br/></div>

		 <input style="font-family: 'Jeju Gothic', sans-serif" class="button" type="button" value="예매 확인 페이지로 돌아가기" onclick="window.close()"> &nbsp;
		 <input style="font-family: 'Jeju Gothic', sans-serif" class="button" type="button" value="예매 취소하기" onclick="location.href='./ReserveDeleteCheck.me?id=<%=id%>&r_num=<%=r_num%>'">
	</div>
	</div></div>
</center>
</body>
</html>