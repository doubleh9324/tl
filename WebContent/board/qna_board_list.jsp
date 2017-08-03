<%@page import="team.board.action.BoardListAction"%>
<%@page import="team.board.db.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<%-- <% int member_num = (Integer)session.getAttribute("member_num");%> 나중에 멤버와 합치면 사용   --%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/game_help.css" rel="stylesheet">
<link href="css/help_reset.css" rel="stylesheet">
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
<%
//세션값 가져오기
String id=(String)session.getAttribute("id");
//세션값이 없으면  ./MemberLogin.me
if(id==null){%>
	alert("로그인해주세요.")
  location.href="./MemberLogin.me";
<% }%>  

$(document).ready(function(){
      getList(1);
});

function deleteBoard(value){
   window.location = "./BoardDelete.bo?q_num="+value;
}

function getList(num){
   
   var add = $("#addlist");
    jQuery.ajax({
       
         type:"POST",
         url:"./BoardList.bo?member_num=1",
         data : "pnum="+num,
         dataType:"JSON",
         success : function(data) {
            //테이블 목록 추가
            
            var str ="";
           
               //select 목록
               $.each(data.arr, function(key, value){
                          
                   if(value.re_state>'0'){
                       var re_state ="처리 완료";
                    }else{
                       var re_state ="답변 진행중"+"<img src='board/images/cancel3.png' width='16px' onclick='deleteBoard("+value.q_num+")'>";
                    }
                       str += "<tr><td>"+ value.q_num +"</td><td><a href='./BoardView.bo?q_num="+ value.q_num +"'>"
                      + value.title +"</a></td><td>"+ value.q_date.substring(0,10) +"</td><td>"+ re_state +"</td></tr>";                              
                  
               });
               add.empty();
               add.append(str);
             //목록 추가
             var totalcount = data.total;
             var pcount = data.pcount;
             var pagecount = Math.ceil(totalcount/pcount);
             var str2 ="";
                         
             if(num==1){
                var start ="<li class='pageStart pagingLi'><a name='pre' class='in_img' id='pre' href='javascript:void(0),getList(1)' ><img src='board/images/prev.png' alt='previous' width='12px'></a></li>";
             }else{
                var start ="<li class='pageStart pagingLi'><a name='pre' class='in_img' id='pre' href='javascript:void(0),getList("+(num-1)+")' ><img src='board/images/prev.png' alt='previous' width='12px'></a></li>";    
             }
             
             if(num==pagecount){
             var end ="<li><a class='in_img pagingLi' name='next' id='next'   href='javascript:void(0),getList("+pagecount+")' ><img src='board/images/next.png' alt='next' width='12px'></a></li>";
             }else{
                var end ="<li><a class='in_img pagingLi' name='next' id='next'   href='javascript:void(0),getList("+(num+1)+")' ><img src='board/images/next.png' alt='next' width='12px' ></a></li>";
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
 
<div id="game_help" class="clfix help_color_st00">
      <div class="left_bx" style="height: 1011px;">
         <a href="index.jsp?center=board/qna_board_faq.jsp" class="online_help"
            id="onlineConsult">고객센터</a>        
         <ul class="game_left_menu">
         </ul>         
         <ul class="game_my_menu">       
            <li><a href="index.jsp?center=board/qna_board_write.jsp" class="menu01"
               id="myHistory">1:1 문의하기</a></li>                       
            <li><a href="index.jsp?center=board/qna_board_list.jsp" class="menu02"
               id="messageBox">내 문의내역</a></li>
            <li><a href="javascript:_gotoMessageBox()" class="menu02"
               id="messageBox">추가</a></li>
            <li><a href="javascript:_gotoMessageBox()" class="menu02"
               id="messageBox">계속</a></li>
            <li><a href="javascript:_gotoMessageBox()" class="menu02"
               id="messageBox">입력해주세요</a></li>
         </ul>
      </div>
      <!-- 성준 : 리스트 뿌려주는 곳 -->
      <div class="help_content_bx">
         <div class="content_bx_st">
            <strong class="tit">내 문의내역</strong>
            <p class="sub_copy">접수하신 1:1문의내역 및 답변 내용을 확인하실 수 있습니다.</p>
            <p class="sub_copy02">※ 문의 내용 중 개인정보가 포함되었거나 중복된 문의인 경우 삭제될 수 있습니다.</p>
            <div class="help_tbl_common help_tbl_style02">
               <table>
                  <caption>내 문의내역</caption>
                  <colgroup>
                     <col style="width: 10%">
                     <col style="width: 50%">
                     <col style="width: 20%">
                     <col style="width: 30%">
                  </colgroup>
                  <thead>
                     <tr>
                        <th scope="col">번호</th>
                        <th scope="col">제목</th>
                        <th scope="col">날짜</th>
                        <th scope="col">상태</th>
                     </tr>
                  </thead>
                  <tbody id="addlist">
				  <!-- 글 뿌려주는 곳 -->
                  </tbody>
               </table>
            </div>
<div class="paging_wrap">
<ul id="page" class="pagingUl"  >
</ul>
</div>
</div>
</div>
</body>
