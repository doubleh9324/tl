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
<script src="https://connect.facebook.net/signals/config/135611513637810?v=2.7.18" async=""></script>
<script async="" src="https://connect.facebook.net/en_US/fbevents.js"></script>
<script language="javascript" src="http://ticketimage.interpark.com/js/interpark_pcid.js"></script>

<script language="javascript" src="js/Egs.js"></script>
<script language="javascript" src="js/block.js"></script>
<script language="javascript" src="js/MyIPoint.js"></script>
<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="js/SearchAutoComplete.js"></script>
<script type="text/javascript" src="js/BookAPI.js"></script>
<script language="javascript" src="js/prototype_1_7_2.js"></script>
<script type="text/javascript" src="js/TPBanner_2015.js"></script>
<script type="text/javascript" src="js/MainShoppingBar.js"></script>
<script language="javascript" src="js/layerEffect.js"></script>
<script type="text/javascript" src="js/AddTPFooter.js"></script>
<script type="text/javascript" src="js/Cancel.js"></script>

<script type="text/javascript">
	jQuery.noConflict();
	var j$ = jQuery;
	
	
	function check_and_submit(){
		if(document.rs.BYear.value==""){
			alert("년도를 선택해주세요.");
			
			document.rs.BYear.foucus();
		}

		if(document.rs.BMonth.value==""){
			alert("월을 선택해주세요");
			document.rs.BMonth.foucus();
			
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
<link rel="stylesheet" href="css/reserveconfirm.css" />
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
                <span class="st">${mbean.name }님!</span>&nbsp;안녕하세요^^)/<br>
            </div>
            <p class="btn">
                <a href="./MemberModify.me"><img src="https://sslimage.interpark.com/_mypage_n/btn/bt_m_modify.gif" alt="회원정보수정"></a>
            </p>
        </div>
		<div class="possess">
			<ul>
				<li class="line_o">
					<div class="pos_1">
						<div class="tit_Ipont"><img src="https://sslimage.interpark.com/_mypage_n/title/tit_ipoint.gif" alt="I-Point"></div>
						<div class="info_r">
							<div id="ipoint1"><a href="#">${mbean.mPoint }</a></div>
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
					<li><a href="#">예약조회</a></li>
		
					<li><a href="#">예약취소</a></li>
				</ul>
				
	
				<h3><img src="https://sslimage.interpark.com/_mypage_n/ml_list_review.gif" alt="기타"></h3>
				<ul class="list">
					<li><a href="./ReviewGetFromMember.rv?name=${mbean.name}&mPoint=${mbean.mPoint}">리뷰</a></li>
					<li><a href="#">서비스게시판</a></li>
					
				</ul>

			</div>
		
			
		</div>

	<!--menu left E  -->

	<!-- 예매확인 -->


	<div class="mp_contents">

		
			<!-- 예매확인취소 리스트 -->
			<div class="reserveInfo">
				<h3><img src="http://ticketimage.interpark.com/TicketImage/event/100913_my/ttl_reserveinfo.gif" alt="예매내역 확인·취소"></h3>
					<div class="subject">
						<span class="title">${name }</span> 
					</div>

				<div class="info">
				<div class="poster">
				
					<p class="post">
					<img src="MovieImage/${image }" onerror="javascript:this.src='http://ticketimage.interpark.com/Play/image/large/NoImage.gif'"></p>
					<br/><p class="btn"><a href="./MovieContentAction.mo?num=${movie_num }" style="margin-right:3px;"><img src="http://ticketimage.interpark.com/TicketImage/myscrap/btn_detail.gif" alt="공연정보 자세히보기"></a>
				
					</p>
				</div>			
				<div class="con">
					<table width="570">
						<colgroup>
						<col width="110px">
						<col width="460px">
						</colgroup>
						<tbody><tr>
							<th>예매자</th>
							<td>${mbean.name }</td>
						</tr>
						<tr>
							<th>예약번호</th>
							<td><div id="divTicketno"><%=r_num %> </div>
							
							</td>
						</tr>
						<tr>
							<th>이용일</th>
							<td>
							<div id="divPlayDate">
							${fn:substring(rbean.view_date,0,16) }
							</div>
							</td>
						</tr>
						
						<tr>
							<th>장소</th>
							<td>${pname }
							
							<a href="./ReserveConfirmLoc.me?pname=${pname }"><img src="http://ticketimage.interpark.com/TicketImage/event/100913_my/btn_map.gif" class="btn" alt="지도보기" style="cursor:pointer;"></a>
							
							</td>
						</tr>
						
						<tr>
							<th>좌석</th>
							<td><span id="divSeatNo">${rbean.screen_name} ${rbean.seat }</span> &nbsp;
							</td>
						</tr>
						
						<tr>
							<th>유의사항</th>
							<td> 

								<div class="exp">
									<p class="txtB">[예매 취소]</p>
								
									<p>영화 상영이 시작된 이 후에는 환불이 불가합니다.&nbsp;예매 취소를 원하시면 상영 시작 전까지 예매 취소 페이지를 통해 취소 부탁드립니다.</p>							
									<p class="txtB">[티켓 교환]</p>
								
									<p>영화 상영 전까지 현장에서 실물 티켓으로 교환하실 수 있습니다.<br>영화관 예매 데스크 혹은 영화관 내 무인 예약기를 이용하시면 됩니다.</p>							
								
								</div>
							
							</td>
						</tr>
						
					</tbody></table>
				</div>
			</div>

			<div class="paymentCont paymentCont2">
			<h3><img src="http://ticketimage.interpark.com/TicketImage/event/100913_my/ttl_payment.gif" alt="결제내역"></h3>
			<table>
				<colgroup>
				<col width="120px">
				<col width="250px">
				<col width="120px">
				<col width="220px">
				</colgroup>
				<tbody><tr>
					<th>예매일</th>
					<td class="bdr">${rbean.reser_day }</td>
					<th>현재상태</th>
					<td><span class="txtRed">예매</span></td>
				</tr>
				<tr>
					<th>결제수단</th>
					<td class="bdr"><span class="txtRed">${payway }</span></td>
					<th>결제상태</th>
					<td>결제</td>
				</tr>
				<tr>
					<th>총 결제금액</th>
					<td colspan="3"><fmt:formatNumber value="${rbean.price}" pattern="#,###"/>원</td>
				</tr>	
			</tbody></table>
		</div>
		<h3><img src="http://ticketimage.interpark.com/TicketImage/event/100913_my/ttl_cation.gif" alt="유의사항"></h3>	
		<div class="cationTxt">
							
					
					<p class="txtGray2">동일 상품에 대해서 날짜, 시간, 좌석, 가격 등급, 결제 등의 일부 변경을 원하시는 경우, 기존 예매 건을 취소하시고 재예매 하셔야 합니다. <span class="txtU">단, 취소 시점에 따라 예매수수료가 환불 되지 않으며,취소수수료가 부과될 수 있습니다.</span><br>(할인선택은 재예매 시점에 적용되는 할인률로만 적용 가능합니다.)</p>
					<p>이미 배송이 시작된 티켓의 경우 인터넷 및 전화로 취소할 수 없습니다. 반드시 취소마감 시간 이전에 티켓이 인터파크 고객센터로 반송되어야
					취소가능하며, 취소수수료는 도착일자 기준으로 부과됩니다.<br>
					<p class="txtGray2">예매 취소한 티켓은 처리 후에는 취소할 수 없습니다.</p>
					<p class="txtGray2">예매취소시점과 해당 카드사의 환불 처리기준에 따라 취소금액의 환급방법과 환급일은 다소 차이가 있을
					수 있습니다.</p>
					<p class="txtGray2">예매 취소 시 최초 결제 동일카드로 예매 시점에 따라 취소 수수료와 배송료를 재승인합니다. 신한카드 포인트로
					결제하신 경우, 포인트(5천포인트이상시)에서 먼저 재승인을 하고, 차액만 카드에서 승인합니다. </p>				
					<p class="txtGray2">관람일 전일 오후 5시 이후(토요일은 오전 11시) 또는 관람일 당일 예매하신 건에 대해서는 예매후
					취소/변경/환불이 불가합니다.<br>
					<span class="txt11">(일부 스포츠상품에 한해서 관람 당일 취소도 가능합니다) </span></p>
					<p>티켓 부분 취소 시 할부 결제는 티켓 예매 시점으로 적용됩니다. <span class="txt11 txtGray2">(무이자할부 행사기간이
						지날 경우 혜택받지 못하실 수 있으니 유의하시기 바랍니다)</span></p>				
					<p class="txtGray2">휴대폰결제로 예매하신 분은 휴대폰결제 이용료가 수수료에 함께 부과됩니다. 예매취소시는 환원됩니다. <a href="http://ticket.interpark.com/TiKi/Info/TPSiteTotalInfo.asp?Url=TPAccount.html&amp;Flag=2#cel" target="new"><span class="txtGray2 txtU txtB">[자세히보기]</span></a></p>	
					<p class="txtRed">기타 문의사항은 <a href="http://ticket.interpark.com/TiKi/Info/BookingGuide.asp?Url=guide_05.html"><span class="txtRed txtU txtB">[이용안내]</span></a>를 참조하시거나, 콜센터 (7777-1717) 혹은 <a href="http://ticket.interpark.com/HelpDesk/HelpDeskMain.asp"><span class="txtRed txtU txtB">[고객센터]</span></a>를 이용하시기 바랍니다. </p>
				<br/><br/><br/>
				</div>
		</div>					
	</div>
</div>
</div>
</body>
</html>
