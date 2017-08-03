<%@page import="team.adboard.action.BoardListAction"%>
<%@page import="team.adboard.db.AdBoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%-- <% int member_num = (Integer)session.getAttribute("member_num");%> 나중에 멤버와 합치면 사용   --%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/game_help.css" rel="stylesheet">
<link href="../css/help_reset.css" rel="stylesheet">
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
      getList(1);
});

function ModifyReBoard(value){
		 
	if(document.getElementById("contents"+value).value==""){
		alert("내용을 입력하세요.")
		document.getElementById("contents"+value).focus();
		return;
	}	
	var fid = document.getElementById("contents"+value).value;

	if(confirm(fid+"\n 수정 하시겠습니까?")==true){
		window.location = "../ReBoardModify.rbo?q_num="+value+"&contents="+fid;
	}else{
		return;
	}
		
}

function getList(num){
   
   var add = $("#addlist");
    jQuery.ajax({
       
         type:"POST",
         url:"../BoardModifyList.abo",
         data : "pnum="+num,
         dataType:"JSON",
         success : function(data) {
            //테이블 목록 추가
            
            var str ="";
           
               //select 목록
               $.each(data.arr, function(key, value){
                         
            	   
            	   //re_state will be delete
                   if(value.re_state>'0'){
                       var re_state ="처리 완료";
                    }else{
                       var re_state ="답변 진행중"+"<img src='./images/cancel3.png' width='16px' onclick='deleteBoard("+value.q_num+")'>";
                    }

                          str += "<tr><td rowspan='3'>"+ value.q_num +"</td><td>제목</td><td ><p align='left'>"+value.title+"</p></td><td>날짜</br>"+value.q_date.substring(0,16)+"</td></tr>"
                      +"<tr><td>내용</td><td ><p align='left'>"+value.contents+"</p></td><td>고객번호</br>"+value.member_num+"</td></tr>"
                      + "<tr><td>답글</td><td ><textarea rows='3' cols='67' id='contents"+value.q_num+"'>"+value.contents2+"</textarea></td><td><img src='images/write.png' width='16px' onclick='ModifyReBoard("+value.q_num+")'></td></tr><tr><td colspan='4'></td></tr>";
               });
               add.empty();
               add.append(str);
             //목록 추가
             var totalcount = data.total;
             var pcount = data.pcount;
             var pagecount = Math.ceil(totalcount/pcount);
             var str2 ="";
            
             
             if(num==1){
                var start ="<li class='pageStart pagingLi'><a name='pre' class='in_img' id='pre' href='javascript:void(0),getList(1)' ><img src='images/prev.png' alt='previous' width='12px'></a></li>";
             }else{
                var start ="<li class='pageStart pagingLi'><a name='pre' class='in_img' id='pre' href='javascript:void(0),getList("+(num-1)+")' ><img src='images/prev.png' alt='previous' width='12px'></a></li>";    
             }
             
             if(num==pagecount){
             var end ="<li><a class='in_img pagingLi' name='next' id='next'   href='javascript:void(0),getList("+pagecount+")' ><img src='images/next.png' alt='next' width='12px'></a></li>";
             }else{
                var end ="<li><a class='in_img pagingLi' name='next' id='next'   href='javascript:void(0),getList("+(num+1)+")' ><img src='images/next.png' alt='next' width='12px' ></a></li>";
             }
             
             
             
             for(var i=(((num-1)-(num-1)%5)/5)*5; i<(((num-1)-(num-1)%5)/5+1)*5; i++){
               if(i==pagecount)break;
                if(i==(num-1)){
                   str2 += "<li class='pageStart pagingLi'><a onclick='getList("+(i+1)+")' class='paging pagingLi' href='javascript:void(0)'><b><big>"+(i+1)+"</big></b></a><li>";
                }else{
                   str2 += "<li class='pageStart pagingLi'><a onclick='getList("+(i+1)+")' class='paging pagingLi' href='javascript:void(0)'>"+(i+1)+"</a><li>";
                }
                              
             }                        
             
             $("#page").empty();
             
             $("#page").append(start);$("#page").append(str2);$("#page").append(end);
         },
         complete : function(data) {
               // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
               // TODO
         },
         error : function(xhr, status, error) {
               alert("에러발생");
         }
      });
}
</script>
</head>
<body>
<center>
   <div id="game_help" class="clfix help_color_st00">
     
      <div class="left_bx" style="height: 1011px;">
         <a href="qna_board_admin.jsp" class="online_help"
   
            id="onlineConsult">관리자 페이지 </a>
         <ul class="game_left_menu">
         </ul>
         <ul class="game_my_menu">
           <li><a href="qna_board_admin_modify.jsp" class="menu02"
               id="messageBox">문의내역</a></li>
            <li><a href="../admin_index.jsp" class="menu01"
               id="myHistory">관리자 기능</a></li>
          
            <li><a href="../MemberLogout.me" class="menu02"
               id="messageBox">로그아웃</a></li>
            <li><a href="javascript:_gotoMessageBox()" class="menu02"
               id="messageBox">계속</a></li>
            <li><a href="javascript:_gotoMessageBox()" class="menu02"
               id="messageBox">입력해주세요</a></li>
         </ul>
      </div>
      <!-- 성준 : 리스트 뿌려주는 곳 -->
      <div class="help_content_bx">
         <div class="content_bx_st">
            <strong class="tit">답변한 문의내역</strong>
            <p class="sub_copy">접수하신 1:1문의내역 및 답변 내용을 확인하실 수 있습니다.</p>
            <p class="sub_copy02">※ 문의 내용 중 개인정보가 포함되었거나 중복된 문의인 경우 삭제될 수 있습니다.</p>
            <div class="help_tbl_common help_tbl_style02">
               <table>
                  <caption>내 문의내역</caption>
                  <colgroup>
                     <col style="width: 8%">
                     <col style="width: 3%">
                     <col style="width: 69%">
                     <col style="width: 20%">
                  </colgroup>
                  
                  <tbody id="addlist">
                  </tbody>
               </table>
            </div>
<div class="paging_wrap">
<ul id="page" class="pagingUl"  >
</ul>
</div>
</div>
</div>
</center>
</body>
</html>