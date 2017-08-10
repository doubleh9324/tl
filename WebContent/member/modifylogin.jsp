<%@page import="team.member.db.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<link rel="stylesheet" href="css/join.css" />

<link rel="stylesheet" href="css/mypage_new_ssl.css" />
<link rel="stylesheet" href="css/mypage_ssl.css" />
<link rel="stylesheet" href="css/mypage.css" />

<link rel="stylesheet" href="css/common.css" />


</head>


<%

	//세션값 가져오기
   String id=(String)session.getAttribute("id");
	String pass=(String)session.getAttribute("pass");
   //세션값이 없으면  ./MemberLogin.me
  
   

%> 

<body>

<style>
body {}
</style>
<!-- //Header -->

<!-- Navigation -->
<script type="text/javascript">
	var navigation = "> 마이페이지";
	
	var lastSlash = document.URL.lastIndexOf("/");
		
	if (document.URL.substring(lastSlash).indexOf("memberjoin.do?_method=upMemberFront") != -1){
		navigation = "> <a href='#'>마이페이지</a> > 회원 정보조회/수정 " ;
	}
</script>

	<div style="display: block; width: 100%; text-align: center"
		class="clearfix">
		<div class="dpGnb">
			<ul class="dpNavi">
				<li class="home"><p>
						<a href="index.jsp" target="_top">홈</a>
					</p></li>
				<li class="nor">&gt; <a
					href="#">마이페이지</a>
					&gt; 회원 정보조회/수정
				</li>
			</ul>
		</div>
	</div>
	<!-- //Navigation -->

<div id="INTERPARK">

	<!-- ###Start of 980### -->
	<div class="IP_cont_980">
		




		<div class="MPleft_area">


<script language="javascript">
$(document).ready(function() { 
});

function fncDisplay(type, idx){
    if(type == 'IPOINT'){
        if(idx == '1'){
            document.getElementById("layer_question").style.display = "block";
        }else{
            document.getElementById("layer_question").style.display = "none";
        }
    }else{
        if(idx == '1'){
            document.getElementById("layer_question2").style.display = "block";
        }else{
            document.getElementById("layer_question2").style.display = "none";
        }
    }
}

function openChangeIpointPop() {
    var wnd = window.open("http://ipointmall.interpark.com/ipoint/hurdle/IPointHurdleCommon.do?_method=changePop", "ChangeIpointPop", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=534,height=402"); 
}
</script>


<!-- 좌측 마이페이지 -->
<div id="myinfoWrap">
    <div class="mypage">
       <form action="./MemberModifyAction.me" method="post" id="join">
       	<input type="hidden" name="idd" value="<%=id %>">
        <h3><img src="img/MYPAGE.jpg" alt="마이페이지"></h3>
        <div class="level">
            <div class="myinfo_txt">
                <span class="st">${bean.name }님!</span>&nbsp;안녕하세요^^)/<br>
            </div>
            <p class="btn">
                <a href="./MemberModify.me"><img src="https://sslimage.interpark.com/_mypage_n/btn/bt_m_modify.gif" alt="회원정보수정"></a>
            </p>
        </div>
		<div class="possess">
			<ul>
				<li class="line_o">
					<div class="pos_1">
						<div class="tit_Ipont"><img src="img/lpoint.jpg" alt="L-Point"></div>
						<div class="info_r">
							<div id="ipoint1"><a href="#">${bean.mPoint }</a></div>
						</div>
					</div>
				</li>
			</ul>
		</div>
		</form>
	</div>
	<div class="bg_bottom"></div>
</div>
<!-- 좌측 마이페이지 end -->				
 
			<!-- menu left S -->
			<div class="ml_box">
				<h3><img src="https://sslimage.interpark.com/_mypage_n/ml_list_buying.gif" alt="예약내역"></h3>
				<ul class="list">
					<li><a href="./MemberReservation.me">예약조회</a></li>
		
					<li><a href="#">예약취소</a></li>
				</ul>
				
	
				<h3><img src="https://sslimage.interpark.com/_mypage_n/ml_list_review.gif" alt="기타"></h3>
				<ul class="list">
					<li><a href="./ReviewGetFromMember.rv?name=${bean.name}&mPoint=${bean.mPoint}">리뷰</a></li>
					<li><a href="index.jsp?center=board/qna_board_list.jsp">내 문의내역</a></li>
					
				</ul>

			</div>
		
			
		</div>

		<div class="MPright_area">

		<form name="MemberJoinForm" method="post">
			<input type="hidden" id="id" value="<%=id %>"/>            

			<!-- 쇼핑내역/구매현황 S -->
			<h3 class="title">
				<div class="tit"><img src="https://sslimage.interpark.com/_mypage_n/title/ts_mem_modify_info.gif" alt="회원정보수정"></div>
			</h3>			
			<!-- 쇼핑내역/구매현황 E -->
			
			<!-- 080430 비밀번호 확인 S -->
			<ul class="box_caution_tb fl mgl10">
				<li><strong>${bean.name }</strong>님의 정보를 안전하게 보호하기 위하여 <strong>비밀번호를 다시 한 번 확인합니다.</strong></li>			
			</ul>

			<table cellspacing="0" cellpadding="0" width="785" class="tb_myPg03 mgt_2">


			<colgroup><col width="111"><col style="">
			</colgroup><tbody><tr>
				<th><span>아이디</span></th>
				<td class="f11"><strong class="fr11"><%=id %></strong></td>
			</tr>
			<tr>
				<th><span>비밀번호</span></th>
				<td class="in"><input type="password" id="pass" name="pass" value="" onblur="" class="fl box_gray" style="width:120px; height:20px;"></td>
			</tr>
			<tr>
				<th class="last"><span>주의사항</span></th>
				<td class="f11 last"><span class="fr11">비밀번호가 타인에게 노출되지 않도록 항상 주의해 주세요.</span></td>
			</tr>
			</tbody></table>

					<div class="tac mgt15 clearfix">
					
						<img id="okbtn"
							src="https://sslimage.interpark.com/_mypage_n/btn/bt_confirm.gif"
							class="pointer mglr5" alt="확인" onclick="modifyCheck();">
							<a
							href="./index2.jsp"><img
							src="https://sslimage.interpark.com/_mypage_n/btn/bt_cancel02.gif"
							class="mglr5" alt="취소"></a>
					</div>

				</form>
		</div><!--//MPright_area-->
 
	</div>


</div><!-- //INTERPARK -->



<!-- 모디파이체크 modifyCheck -->

	<script type="text/javascript">
		function modifyCheck() {

			var id = $("#id").val();
			var pass = $("#pass").val();

			location.href = "./MemberModifyCheck.me?id=" + id + "&pass=" + pass;
		}
	</script>

</body>



</html>
