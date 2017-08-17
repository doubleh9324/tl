<%@page import="team.member.db.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery.min.js"></script>

<style>
body{
scrollbar-3dlight-color:#FFFFFF;
scrollbar-arrow-color:#C3C3C3;
scrollbar-track-color:#FFFFFF;
scrollbar-darkshadow-color:#FFFFFF;
scrollbar-face-color:#FFFFFF;
scrollbar-highlight-color:#C3C3C3;
scrollbar-shadow-color:#C3C3C3;
}
</style>


<script type="text/javascript" async="" src="http://www.google-analytics.com/plugins/ua/ec.js"></script>
<script type="text/javascript" async="" src="http://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.googletagmanager.com/gtm.js?id=GTM-5QCJFLB"></script>
<script language="javascript" src="http://ticketimage.interpark.com/js/interpark_pcid.js"></script>


<script type="text/javascript">
	jQuery.noConflict();
	var j$ = jQuery;
	
	
	function check_and_submit(){
		if(document.rs.BYear.value==""){
			alert("년도를 선택해주세요.");
			
			document.rs.BYear.focus();
		}

		else if(document.rs.BMonth.value==""){
			alert("월을 선택해주세요");
			document.rs.BMonth.focus();
			
		}else{
			document.rs.submit();
			
		}
		
	}
	
	function deletePop(r_num){
		
		
		window.open("./ReserveDelete.me?r_num="+r_num, "", "width=450, height=200");
		
	}

	
	
</script>





<link rel="stylesheet" href="css/join.css" />

<link rel="stylesheet" href="css/mypage_new_ssl.css" />
<link rel="stylesheet" href="css/mypage_ssl.css" />
<link rel="stylesheet" href="css/mypage.css" />


<link rel="stylesheet" href="css/reserve.css" />

<link rel="stylesheet" href="css/common.css" />


</head>


<%

	//세션값 가져오기
   String id=(String)session.getAttribute("id");
	String pass=(String)session.getAttribute("pass");
	String r_num = request.getParameter("r_num");
   //세션값이 없으면  ./MemberLogin.me
  
   

%> 

<body>

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
					&gt; 예매확인/취소
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
        <h3><img src="https://sslimage.interpark.com/_mypage_n/title/tit_mypage.gif" alt="마이페이지"></h3>
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
						<div class="tit_Ipont">
						</div>
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
					<li><a href="#">서비스게시판</a></li>
					
				</ul>

			</div>
		
			
		</div>

	<!--menu left E  -->

	<!-- 예매확인 -->


	<div class="mp_contents">

		
			<!-- 예매확인취소 리스트 -->
			<div class="timeSelect">
				<h3><img src="http://ticketimage.interpark.com/TicketImage/event/100913_my/ttl_reserveinfo.gif" alt="예매내역 확인·취소"></h3>
				<p class="all">
					* <strong class="txtRed">${bean.name }</strong>님의 영화 예매내역은 총 <strong class="txtRed">${fn:length(list)}건</strong>입니다. 
				</p>
				
				<!-- 기간선택 -->
				<div class="box">
					<form name="rs" id="rs" method="post" action="./MemberReservationMv.me">  
					<p class="title"><img src="http://ticketimage.interpark.com/TicketImage/event/100913_my/ttl_times.gif" alt="조회기간선택"></p>
					<div class="date">
						<p>주문일자별</p>
						<ul>
							<li>
								<select name="Option" id="Option" style="width:65px; height:19px;" class="select">
									<option value="B" selected="">예매일</option>
									<option value="P">공연일</option>
								</select>
							</li>
							<li>
								<select name="BYear" id="BYear" style="width:53px; height:19px;" class="select">
									<option value="">-----</option>
									<option value="2018">2018</option><option value="2017">2017</option><option value="2016">2016</option><option value="2015">2015</option><option value="2014">2014</option><option value="2013">2013</option>						
								</select>
								년 </li>
							<li>
								<select name="BMonth" id="BMonth" style="width:38px; height:19px;" class="select">
									<option value="">-----</option>
									<option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option><option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option><option value="09">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
								</select>
								월 &nbsp;&nbsp;</li>
							<li><button type="button" onclick="check_and_submit()" width="40px" height="20px" style="border:0;background-color: white;">
								<img src="http://openimage.interpark.com/ticketimage/TicketImage/common/bt_search.gif" border="0" style="cursor:pointer;">
								</button></li>
								
								
						</ul>
					</div>
					</form>
				</div>
				<!-- //기간선택 -->
			</div>
	
			<!-- 리스트 -->
			<div class="Rlist">

				<form name="TopOption2" id="TopOption2" method="post" action="#">  
				<div class="tab">
					<ul>
						<li><a href="./MemberReservation.me"><img src="http://openimage.interpark.com/ticketimage/TicketImage/reserve/template/100927/1122_play_tab_01_b.gif"" name="pic1" border="0" alt="공연/스포츠"></a></li>
						<li><img src="http://openimage.interpark.com/ticketimage/TicketImage/reserve/template/100927/play_tab_03_on.gif" name="pic1" onmouseover="document.pic1.src='http://ticket.interpark.com/Board/images/play_tab_03_on.gif'" border="0" onclick="CancelInfo.GetBookedList('','01002','N');" style="cursor:pointer;" alt="영화"></li>
					</ul>
				</div>
				</form>
				<table>
					<colgroup>
					<col width="70px">
					<col width="100px">
					<col width="200px">
					<col width="140px">
					<col width="145px">
					<col width="110px">
					</colgroup>
					<tbody><tr>
						<th>예약번호</th>
						<th>예약일</th>
						<th>관람일/매수</th>
						<th>좌석정보</th>
						<th>결제일/가격</th>
						<th>취소여부</th>
					</tr>
					
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach items="${list }" var="val">
							<input type="hidden" id="r_num" name="r_num" value="${val.r_num }">
								<tr>
									<td><a href="./ReserveConfirm.me?id=<%=id %>&r_num=${val.r_num }">${val.r_num }</a></td>
									<td>${val.reser_day }</td>
									<td>${fn:substring(val.view_date,0,16) } / ${val.reseat_num}</td>
									<td>${val.screen_name} ${val.seat }</td>
									<td>${val.pay_day } / <fmt:formatNumber value="${val.price}" pattern="#,###"/>원</td>
									<td>
									<a href="javascript:deletePop(${val.r_num });">						
									<img src = "https://sslimage.interpark.com/_mypage_n/btn/bt_cancel02.gif" width="45px" border="0" alt="취소" >
									</a></td>
								</tr>
							
							</c:forEach>
						
						</c:when>
					<c:otherwise>
					<tr>
						<td colspan="6">설정된 기간에 맞는 ${bean.name } 님의 예매 내역이 없습니다.</td>						
					</tr>
					</c:otherwise>
					</c:choose>
		
				</tbody></table>
			</div>
			<!-- //리스트 -->
			 
			<div class="txtguide">
				<p class="txtRed">※ [상세보기]에서 예매 상세내역 확인 및 예매 취소를 하실 수 있습니다. </p>
				<p class="txt11 txtDefault">&nbsp;&nbsp;&nbsp;&nbsp;티켓이 배송된 이후에는 인터넷 취소가 안되며,
					배송받으신 티켓이 취소일 이전까지 인터파크 본사로 접수된 이후에 취소가능합니다. <a href="http://ticket.interpark.com/TiKi/Info/BookingGuide.asp?Url=guide_05.html"><span class="txtU">[상세보기]</span></a></p>
			</div>



					</div>		
			
	</div>


</div><!-- //INTERPARK -->




</body>



</html>
