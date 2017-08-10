<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>티켓사자 - 회원정보수정상세</title>
<!-- CSS -->
<link rel="stylesheet" href="css/join.css" />
<link rel="stylesheet" href="css/mypage_new_ssl.css" />
<link rel="stylesheet" href="css/mypage_ssl.css" />
<link rel="stylesheet" href="css/mypage.css" />
<link rel="stylesheet" href="css/common.css" />

<script type="text/javascript">



function checkValue(){
	if(document.join.pass.value==""){
		alert("비밀번호를 입력해주세요.");
		return false;
	}
	if(document.join.pass2.value==""){
		alert("비밀번호 재입력을 입력해주세요.");
		return false;
	}
	if(document.join.pass.value != document.join.pass2.value){
		alert("비밀번호를 동일하게 입력하세요.");
		return false;
	}
}


</script>



</head>

<%
	//세션값 가져오기
   String id=(String)session.getAttribute("id");
   //세션값이 없으면  ./MemberLogin.me
   if(id==null){
      response.sendRedirect("./MemberLogin.me");
   }

%>   


<body>

	
<style>
body {
	background: none;
}
</style>

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
						<a href="index2.jsp" target="_top">홈</a>
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


	<div class="IP_cont_980">

		<div class="MPleft_area">

<!-- 좌측 마이페이지 -->
<div id="myinfoWrap">
    <div class="mypage">
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
						<div class="tit_Ipont"><img src="img/lpoint.jpg" alt="I-Point"></div>
						<div class="info_r">
							<div id="ipoint1"><a href="#">${bean.mPoint}</a></div>
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
				<h3><img src="https://sslimage.interpark.com/_mypage_n/ml_list_buying.gif" alt="쇼핑내역"></h3>
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
	
			<!-- menu left E -->
			
		</div><!--//MPleft_area-->

	
 
<script type="text/javascript">


/* 회원탈퇴팝업 함수 시작 */

function withdrawPopup()
{
   
	var id = $("#id").val();

    window.open("./MemberDelete.me?id="+id, "", "width=500, height=500");
  
   
}

/* 회원탈퇴팝업 함수 끝 */


</script>

<!-- header end -->
        
        <div class="MPright_area">

            <!-- 쇼핑내역/구매현황 S -->
            <h3 class="title">
                <div class="tit"><img src="https://sslimage.interpark.com/_mypage_n/title/ts_mem_modify_info.gif" alt="회원정보수정"></div>
            </h3>
  
            
            <!-- 기본 정보 영역 S -->
            <ul class="box_caution_tb fl mgl10">
				<!-- 170414 title 수정 -->
                <li>기본정보</li>
				<!-- // 170414 title 수정 -->
            </ul>



					<!-- S 회원탈퇴 버튼  -->
					
					
					<div class="fr mgt5">
						<a href="javascript:withdrawPopup();">
						<img src="https://sslimage.interpark.com/_mypage_n/btn/bt_memberout.gif"
							alt="회원탈퇴"></a>
					</div>
		
					
					<!-- E 회원탈퇴 버튼  -->
				
				<!-- 회원수정 -->
      <form action="./MemberModifyAction.me" method="post" id="join" name="join" onsubmit="return checkValue()">    
      <input type="hidden" id="mPoint" name="mPoint" value="${bean.mPoint }">
           
         <table cellspacing="0" cellpadding="0" width="785" class="tb_myPg03 mgt_2 mgb30">
                <colgroup><col width="121"><col width="136">  <col width="136 "><col width="121"><col width="136"><col width="135">
                </colgroup><tbody>
                <!-- 이름 -->
                <tr>
                    <th><span>이름</span></th>        
                    <td colspan="2">
                    <input type="text" id="name" name="name" value="${bean.name}" style="width:117px; border: 0px;" readonly="readonly">
                 
                    <!--<input type="button" name="changeNm" id="changeNm" value="이름변경" onclick="changeName('01')" style="margin-left: 120px;"/>-->
                   <!--  <a href="javascript:certByHp('ChgName')"><img src="https://sslimage.interpark.com/_mypage_n/btn/bt_change_name.gif" alt="이름변경" style="margin-left: 55px; margin-top: -4px;"></a> -->
                    </td>
                    <td></td>
                    <td colspan="2">

                </td>
                </tr>
                
                <tr>
                    <th><span>아이디</span></th>        
                    <td colspan="2"><input type="text" id="id" name="id" value="<%=id %>" style="width:250px; border: 0px;" readonly="readonly">
                    
                    </td>
                    <td></td>
                    <td colspan="2">

                </td>
                </tr>
                
                <tr>
                    <th><span>생년월일</span></th>

               <td colspan="5" class="in">
               <input type="text" class="box_gray" id="birth" name="birth" value="${bean.birth }" style="width:250px;" maxlength="20">
                    <input type="hidden" id="birth" value="${bean.birth }">
                    </td>
				
             <td colspan="2">
                </td>
                </tr>

                    
                <!-- 비밀번호 -->
                 <tr>
                    <th><span>비밀번호</span></th>
                    <td colspan="5" class="in">
                        
                        <input type="password" class="box_gray" id="pass" name="pass" value="" style="width:250px;" maxlength="20">
					
                    
                    </td>
                </tr>
                <tr>

                    <th><span>비밀번호 재입력</span></th>
                    <td colspan="5" class="in">
                     
                        <input type="password" class="box_gray" name="pass2" id="pass2" style="width:250px;" maxlength="20">
                     
                    </td>
                </tr>

                <tr>
                    <th><span>연락처</span></th>
                    <td colspan="5" class="in">
                        
                        <input type="text" class="box_gray" id="phone" name="phone" value="${bean.phone }" style="width:250px;" maxlength="20">
					
                    </td>
                </tr>

            </tbody></table>
            <!-- 기본 정보 영역 E -->
     
            <!-- 확인 버튼 -->
                 <div class="tac mgt15 clearfix">
                 <button type="submit" style="border:0; background-color: white;">
                 <img class="pointer mglr5" src="https://sslimage.interpark.com/_mypage_n/btn/bt_confirm.gif"
               style="cursor: hand" tabindex="3"></button>
            
                <!-- <a href="javascript:test()">연동/해지 test</a> -->
            </div>
	</form>
</div>
</div>   
</div>        
 

</body>

