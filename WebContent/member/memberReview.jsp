<%@page import="team.member.db.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
     
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- CSS -->

<link rel="stylesheet" href="css/join.css" />


<link rel="stylesheet" href="css/mypage_new_ssl.css" />
<link rel="stylesheet" href="css/mypage_ssl.css" />
<link rel="stylesheet" href="css/mypage.css" />

<link rel="stylesheet" href="css/common.css" />
<link rel="stylesheet" href="css/common_style.css" />
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
tbody#review_tbody span:HOVER {
	cursor: pointer;
	color:orange;
}
td#page_td{
	text-align: center;
}

</style>

<script type="text/javascript">
$(document).ready(function(){
	getReviewMoiveFunction(0);
	
	$('#cate').change(function(){
		var cate = this.value;
		if(cate=="mo"){
			getReviewMoiveFunction(0);
		}else{
			getReviewMusicalFunction(0);
		}
	});
})

function getReviewMoiveFunction(page_num){
	var setflag=$("#setFlag").val();
	var cate="mo";
	var p_num=Number(page_num);
	
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./ReviewGetFromMemberAction.rv?p_num="+p_num+"&cate="+cate,
			
			dataType:"JSON",
			
			success:function(data){
				
					document.getElementById("review_tbody").innerHTML="";
					$.each(data.reviews, function(key, value){
						$("#review_tbody").append('<tr><td colspan="2">'+value.name+'</td><td colspan="2">'+value.contents+'</td><td colspan="1">'+value.grade+'</td><td colspan="1">'+value.date+'</td></tr>');
					});
					var tr_code='<tr><td colspan="6" id="page_td"></td></tr>';
					$('#review_tbody').append(tr_code);
					$.each(data.page_count, function(key,value){
						$("#page_td").append('<span onclick="getReviewMoiveFunction('+key*15+')">'+'['+(key+1)+']'+'</span>');
					});
			
			},
			error: function(xhr, status, error){
				alert("에러발생"+xhr+status+error);
			
			}
		});
	}
	
}

function getReviewMusicalFunction(page_num){
	var setflag=$("#setFlag").val();
    var cate = "mu";
	var p_num=Number(page_num);
	
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./ReviewGetFromMemberAction.rv?p_num="+p_num+"&cate="+cate,
			
			dataType:"JSON",
			
			success:function(data){
			
					document.getElementById("review_tbody").innerHTML="";
					$.each(data.reviews, function(key, value){
						$("#review_tbody").append('<tr><td colspan="2">'+value.name+'</td><td colspan="2">'+value.contents+'</td><td colspan="1">'+value.grade+'</td><td colspan="1">'+value.date+'</td></tr>');
					});
					var tr_code='<tr><td colspan="6" id="page_td"></td></tr>';
					$('#review_tbody').append(tr_code);
					$.each(data.page_count, function(key,value){
						$("#page_td").append('<span onclick="getReviewMusicalFunction('+key*10+')">'+'['+(key+1)+']'+'</span>');
					});
				
				
			},
			error: function(xhr, status, error){
				alert("에러발생"+xhr+status+error);
			
			}
		});
	}
}

</script>


</head>

<%
	//세션값 가져오기
	String id = (String) session.getAttribute("id");
	//String pass = request.getParameter("pass");
	//String pass=(String)session.getAttribute("pass");

	//세션값이 없으면  ./MemberLogin.me
	if (id == null) {
		response.sendRedirect("./MemberLogin.me");
	}
	String name=request.getParameter("name");
	String mPoint=request.getParameter("mPoint");
	//memberBean bean = (memberBean)request.getAttribute("bean");
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
								<span class="st"><%=name%>님!</span>&nbsp;안녕하세요^^)/<br>
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
												alt="L-Point">
										</div>
										<div class="info_r">
											<div id="ipoint1">
												<a
													href="#"><%=mPoint%></a>
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
					<li><a href="./ReviewGetFromMember.rv?name=<%=name%>&mPoint=<%=mPoint%>">리뷰</a></li>
					<li><a href="index.jsp?center=board/qna_board_list.jsp">내 문의 내역</a></li>
		
				</ul>
			
				
				

		
			</div>

			</div>
			

			<!-- header end -->

			<div class="MPright_area">
				<h3 class="title">
						내가 작성한 리뷰
		         </h3>
		        <ul class="box_caution_tb fl mgl10">
					<select id="cate" style="border: 1px solid gray" >
						<option value="mo" selected>영화</option>
						<option value="mu">뮤지컬</option>
					</select>
              	 <li> </li>
				
         	   </ul>
				
  
				<!-- 회원수정확인 -->
				<form name="MemberJoinForm" method="post" action="">
					
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
						
						<thead>
							<tr id="review_tr">	
								<th colspan="2"><span>작품명</span></th>
								<th colspan="2"><span>내용</span></th>
								<th  colspan="1"><span>평점</span></th>
								<th  colspan="1"><span>날짜</span></th>
							</tr>
						</thead>
						<tbody id="review_tbody">
							<tr><td colspan="6">작성하신 리뷰가 없습니다.</td></tr>
						</tbody>
					</table>

					
				</form>

			</div>
	
		</div>
		</div>
	
	

</body>

</html>