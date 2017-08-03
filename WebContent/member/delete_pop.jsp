<%@page import="team.member.db.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>티켓사자 - 회원정보수정상세</title>


<!-- CSS -->

<link rel="stylesheet" href="css/topnav_ssl.css" />
<link rel="stylesheet" href="css/join.css" />
<link rel="stylesheet" href="css/gatewayBar_ssl.css" />


<link rel="stylesheet" href="css/mypage_new_ssl.css" />
<link rel="stylesheet" href="css/mypage_ssl.css" />
<link rel="stylesheet" href="css/mypage.css" />

<link rel="stylesheet" href="css/common.css" />
<link rel="stylesheet" href="css/mypage_pop_style.css" />
<link rel="stylesheet" href="css/common_style.css" />


<script src="//code.jquery.com/jquery.min.js"></script>
</head>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
	<div
		style="position: absolute; left: 0px; top: 0px; z-index: 250; border-style: none; visibility: hidden; width: 0px;">
		<iframe name="_ifmlayer0" width="100%" height="100%"
			src="https://incorp.interpark.com/static/empty.html" marginwidth="0"
			marginheight="0" frameborder="0" scrolling="no"
			style="border: none; border-width: 0px"></iframe>
	</div>
	<script language="JavaScript">

</script>






	<!-- 세션 -->
	<% 
String id = (String)session.getAttribute("id"); 
String pass = request.getParameter("pass");
%>










	<script language="JavaScript">
document.domain="interpark.com";
function gotopage(url)
{
	top.opener.location.href=url;
	window.close();	
}
</script>


	<form action="./MemberDeleteAction.me" method="post">

		<input type="hidden" id="id" value="<%=id %>" /> <input type="hidden"
			id="pass" value="<%=pass%> " />
		<%
System.out.println("pop"+id);
System.out.println("pop"+pass);
%>
		<input type="hidden" name="_method" value="login">

		<h1>
			<img
				src="http://openimage.interpark.com/_mypage/title/tm_memberOut.gif"
				width="74" height="23" alt="회원탈퇴">
		</h1>

		<div class="box_popup">
			<div class="box_pop_lt">
				<div class="box_pop_rb">
					<div class="box_pop_lb">

						<!-- content Start -->
						<div style="width: 440px; height: 360px;">

							<dl class="break">
								<h2 class="h2_normal">
									안녕하세요. <strong><%=id %></strong> 고객님.
								</h2>
								<dd class="mt15">
									티켓라이언은 인터넷 쇼핑몰 사업에서 다년간의 노하우와<br>경험치를 가지고 고객님께 최상의 서비스를
									제공하고자 합니다.
								</dd>
								<dd class="mt15">
									특히 고객님의 개인정보 보호를 위해 각종 보안시스템 및 솔루션을 도입하여<br> 시스템에 대한 외부의
									접근을 사전에 차단하고 정보의 유출을 방지하고<br> 있습니다. <br> 또한 정보보안조직의
									운영과 우수한 보안업체와 협업하여<br> 보안정책을 수립하고 정보보안에 대한 예방 및 통제를 실시하고
									있으며<br> 실시간 모니터링을 통해 즉시 대응하고 있습니다.
								</dd>
								<dd class="mgt20">
									고객님께서 개인정보 및 메일 수신에 대해 불편을 느끼셨다면,<br> 고객센터를 통해 고객님의 불편을
									신속히 해결해 드리도록 하겠습니다. 구구절절... ㅠㅠ

								</dd>

								<dd class="mt15">티켓라이언은 고객님의 불편을 최소화할 수 있도록 최선을 다하겠습니다.</dd>
							</dl>


							<div class="pop_btm_btn mgt15">
								<!-- 	<a href="./MemberDeleteAction.me"> -->


								<input type="submit" value="탈퇴하기"> &nbsp; <input
									type="button" value="취소하기" onclick="window.close()">
							</div>
	</form>
	<!-- test -->


	</div>
	<!-- content End -->

	</div>
	</div>
	</div>
	</div>

	<div class="div_btclose">
		<a href="javascript:window.close();"><img
			src="http://openimage.interpark.com/_mypage/btn/bt_close.gif"
			width="43" height="10" alt="close"></a>
	</div>

	</form>



</body>
</html>