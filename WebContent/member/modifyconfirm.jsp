<%@page import="team.member.db.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>티켓사자 - 회원정보수정상세</title>

<link rel="stylesheet" href="css/join.css" />
<link rel="stylesheet" href="css/mypage_new_ssl.css" />
<link rel="stylesheet" href="css/mypage_ssl.css" />
<link rel="stylesheet" href="css/mypage.css" />
<link rel="stylesheet" href="css/common.css" />
<link rel="stylesheet" href="css/common_style.css" />

</head>

<%
	//세션값 가져오기
	String id = (String)session.getAttribute("id");

	//세션값이 없으면  ./MemberLogin.me
	if (id == null || id=="") {
		%>
		<script type="text/javascript">
			alert("로그인해주세요.")
			location.href("MemberLogin.me");
		</script>
	<%}

%>


<body>

	<!-- Navigation -->
	<script type="text/javascript">
	var navigation = "> 마이페이지";
	
	var lastSlash = document.URL.lastIndexOf("/");
		
	if (document.URL.substring(lastSlash).indexOf("memberjoin.do?_method=upMemberFront") != -1){
		navigation = "> <a href='http://www.interpark.com/member/MyPage.do?logintgt=mypage'>마이페이지</a> > 회원 정보조회/수정 " ;
	}
</script>

	<div style="display: block; width: 100%; text-align: center"
		class="clearfix">
		<div class="dpGnb">
			<ul class="dpNavi">
				<li class="home"><p>
						<a href="index2.jsp" target="_top">홈</a>
					</p></li>
				<li class="nor">&gt; 마이페이지</li>
			</ul>
		</div>
	</div>
	<!-- //Navigation -->

	<!-- ###Start of 980### -->
	<div id="INTERPARK">

		<!-- ###Start of 980### -->
		<div class="IP_cont_980">


			<div class="MPleft_area">


				<!-- 좌측 마이페이지 -->
				<div id="myinfoWrap">
					<div class="mypage">
						<h3>
							<img
								src="img/MYPAGE.jpg"
								alt="마이페이지">
						</h3>
						<div class="level">
							<div class="myinfo_txt">
								<span class="st">${bean.name }님!</span>&nbsp;안녕하세요^^)/<br>
							</div>
							<p class="btn">
								<a href="./MemberModify.me"><img
									src="https://sslimage.interpark.com/_mypage_n/btn/bt_m_modify.gif"
									alt="회원정보수정"></a>
							</p>
						</div>
						<div class="possess">
							<ul>
								<li class="line_o">
									<div class="pos_1">
										<div class="tit_Ipont">
											<img
												src="img/lpoint.jpg"
												alt="I-Point">
										</div>
										<div class="info_r">
											<div id="ipoint1">
												<a
													href="#">${bean.mPoint }</a>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</div>

					</div>
					<div class="bg_bottom"></div>
				</div>
				<!-- 좌측 마이페이지 end -->
				<!-- 개인화부분 E -->

				<!-- menu left S -->
				<div class="ml_box">
				<h3><img src="https://sslimage.interpark.com/_mypage_n/ml_list_buying.gif" alt="예약내역"></h3>
				<ul class="list">
					<li><a href="./MemberReservation.me">예약조회</a></li>
		
					<li><a href="#">예약취소</a></li>
				</ul>
				
	
				<h3><img src="https://sslimage.interpark.com/_mypage_n/ml_list_review.gif" alt="나의 글모음"></h3>
				<ul class="list">
					<li><a href="./ReviewGetFromMember.rv?name=${bean.name}&mPoint=${bean.mPoint}">리뷰</a></li>
					<li><a href="index.jsp?center=board/qna_board_list.jsp">내 문의내역</a></li>
		
				</ul>
				
				
				

		
			</div>

			</div>
			

			<!-- header end -->

			<div class="MPright_area">
				<h3 class="title">
		               <div class="tit"><img src="https://sslimage.interpark.com/_mypage_n/title/ts_mem_modify_info.gif" alt="회원정보수정"></div>
		         </h3>
		        <ul class="box_caution_tb fl mgl10">
		
              	  <li>기본정보</li>
				
         	   </ul>
				
  
				<!-- 회원수정확인 -->

				<form name="MemberJoinForm" method="post" action="./Index.me">
					
					<!-- 기본 정보 영역 S -->

					<table cellspacing="0" cellpadding="0" width="785"
						class="tb_myPg03 mgt_2 mgb30">
						<colgroup>
							<col width="121">
							<col width="136">
							<col width="136 ">
							<col width="121">
							<col width="136">
							<col width="135">
						</colgroup>
						<tbody>
							<tr>
								<th><span>아이디</span></th>
								<td colspan="2"><%=id%></td>
								<td><span></span></td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<th><span>이름</span></th>
								<td colspan="2">${bean.name }</td>
								<td><span></span></td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<th><span>비밀번호</span></th>
								<td colspan="5" class="in">****</td>

							</tr>

							<tr>
								<th><span>휴대폰번호</span></th>
								<td colspan="5" class="in">${bean.phone }</td>
							</tr>
							<tr>
								<th><span>생년월일</span></th>
								<td colspan="5" class="in">${bean.birth }</td>
							</tr>
						</tbody>
					</table>

					<div class="tac mgt15 clearfix">
						<button type="submit" width="91px" height="66px" style="border:0; background-color: white;">
							<img class="pointer mglr5"
								src="https://sslimage.interpark.com/_mypage_n/btn/bt_confirm.gif"
								style="cursor: hand" tabindex="3">
						</button>

					</div>
				</form>


	

</body>

</html>