<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>

<link href="css/login.css" rel="stylesheet">


<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
center a {
	color: #33333b;
	text-decoration: none;
}

center  a:hover {
	color: #da6464;
	text-decoration: underline;
}

center  a, center  img {
	border: none;
}

td {
	font-size: 11px;
}

ul.loginMenu {
	width: 100%;
	overflow: auto;
	overflow: hidden;
	margin-top: 12px;
	letter-spacing: -1px;
}

ul.loginMenu	 li {
	float: right;
	height: 14px;
	padding: 0 15px 0 6px;
	background:
		url("https://sslimage.interpark.com/ticketimage/TicketImage/main/100506_main/login/bl_gray_arrow.gif")
		no-repeat 0 3px;
}
</style>



</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">

<script type="text/javascript">
$(document).ready(function(){
	$('#id').keyup(function(){
		$('#id').css("background","none");
	});
	$('#pass').keyup(function(){
		$('#pass').css("background","none");
	});
	
	$("#id").keyup(function(e){
		if(e.keyCode == 13){
			check_and_submit()
		}
	});
	
	$("#pass").keyup(function(e){
		if(e.keyCode == 13){
			check_and_submit()
		}
	});
	
})
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
function check_and_submit(){
	if(document.fr.id.value==""){
		alert("아이디를 입력해주세요.");
		
		document.fr.id.foucus();
	}

	if(document.fr.pass.value==""){
		alert("비밀번호를 입력해주세요");
		document.fr.pass.foucus();
		
	}else{
		document.fr.submit();
		
	}
	
}

</script>


	<div style="display: block; width: 100%; text-align: center;">
		<div class="dpGnb">
			<ul class="dpNavi">
				<li class="home"><p>
						<a target="_top" href="index.jsp">TICKET LION</a>
					</p></li>
				<li class="nor">&gt; 로그인</li>
			</ul>
		</div>
	</div>
	<!-- s: 로그인영역 -->
	<div class="login_warp">
		<dl class="login_form">
			<dt class="login_input">
				<!-- 20130430-->
				<div class="login_logo">
				 <h1>Ticket
				 <img alt="티켓사자" src="icons/lionLogo.png" width="71px" id="search_bar2_4">
				<a class="fontColor">L</a>ion</h1></div>
				<div class="Login_iF_120106">

					<!-- 레이어 -->

					<!-- //레이어 -->
					<!-- 20130430-->
					<table cellpadding="0" cellspacing="0" border="0" width="308">
							<tr on> 
								<td valign="top" height="48"><img
									src="https://sslimage.interpark.com/ticketimage/TicketImage/main/100506_main/login/tit_login.gif"></td>

							</tr>
							<!--아래 ID,PWD Form값 넘기면 안되서 여기까지 Form 끊음-->
							<tr>
								<td>
									<!-- s: 로그인 테이블 시작-->
									<div id="login_type1" style="display: block">
										<form class="form-signin" action="./MemberLoginAction.me" name="fr" id="join">
											<table cellpadding="0" cellspacing="0" border="0" width="308">
												<colgroup>
													<col width="219px">
													<col width="">
												</colgroup>
												<tbody>
													<tr valign="top">
														<td><input type="text" id="id" name="id"
															maxlength="100" 
															style="float: left; width: 200px; height: 28px; background: url(&quot;https://sslimage.interpark.com/ticketimage/TicketImage/main/100506_main/login/bg_input_id.gif&quot;); border: 1px solid rgb(234, 234, 234); font-style: normal; font-variant: normal; font-weight: bold; font-stretch: normal; font-size: 14px; line-height: normal; font-family: 돋움; color: rgb(53, 53, 53); padding: 6px 0px 0px 10px;"
															class="input_text" tabindex="1"></td>


														<td rowspan="2">
															<button type="button" width="91px" height="66px" onclick="check_and_submit()" style="border:0;background-color: white;">
																<img class="btn-img"
																	src="icons/bt_login_or.png"
																	style="cursor: hand; ;" tabindex="3" width="100px" >
															</button>
														</td>
													</tr>
													<tr>
														<td><input type="password" id="pass" name="pass"
															maxlength="16" 
															style="width: 200px; height: 28px; background: #FAFAFA url(https://sslimage.interpark.com/ticketimage/TicketImage/main/100506_main/login/bg_input_pwd.gif) no-repeat left; border: 1px solid #EAEAEA; font: bold 14px 돋움; color: #353535; padding: 6px 0 0 10px"
															class="input_text" tabindex="2"></td>
													</tr>
													
												</tbody>
											</table>
										</form>
									</div> <!-- e: 로그인 테이블 시작-->
								</td>
							</tr>
							<!-- 자동로그인 체크 -->
							
							<!-- 자동로그인 체크 -->
							<tr>
								<td>
									<ul class="loginMenu">
										<li class="last"><a href="#"
											alt="ID 찾기">아이디</a> <span> · </span><a
											href="#" alt="PWD 찾기">비밀번호찾기</a></li>

										<li id="loginMenu1" style="display: block"><a
											href="./MemberJoin.me"
											target="_parent" alt="회원가입하기">회원가입</a></li>

									</ul>
								</td>
							</tr>
							<!--</form>-->
							<!--기존 Form 위치-->
						</tbody>
					</table>
				</div>
			</dt>
		</dl>
	</div>
	<!-- e: 로그인영역 -->



</body>