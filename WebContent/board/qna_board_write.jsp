<%@page import="team.board.action.BoardListAction"%>
<%@page import="team.board.db.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/game_help.css" rel="stylesheet">
<link href="css/help_reset.css" rel="stylesheet">
<script type="text/javascript">
<%
//세션값 가져오기
String id=(String)session.getAttribute("id");
//세션값이 없으면  ./MemberLogin.me
if(id==null){%>
	alert("로그인해주세요.")
location.href="./MemberLogin.me";
<% }%>  
</script>
</head>
<body>
 
<div id="game_help" class="clfix help_color_st00">           
    <div class="left_bx" style="height: 1011px;">
        <a href="index.jsp?center=board/qna_board_faq.jsp" class="online_help" id="onlineConsult">고객센터</a>
        <ul class="game_left_menu">
        </ul>
        <ul class="game_my_menu"> 
                    <li>
                        <a href="index.jsp?center=board/qna_board_write.jsp" class="menu01" id="myHistory">1:1 문의하기</a>
                    </li>                                 
                    <li>
                    <a href="index.jsp?center=board/qna_board_list.jsp" class="menu02"
               id="messageBox">내 문의내역</a>
               </li>                   
                    <li>
                        <a href="javascript:_gotoMessageBox()" class="menu02" id="messageBox">추가</a>
                    </li>
                    <li>
                        <a href="javascript:_gotoMessageBox()" class="menu02" id="messageBox">계속</a>
                    </li>
                    <li>
                        <a href="javascript:_gotoMessageBox()" class="menu02" id="messageBox">입력해주세요</a>
                    </li>
      </ul>
    </div>   
<!-- 성준 : 리스트 뿌려주는 곳 -->
<div class="help_content_bx">
<form action="./BoardInsert.bo" id="qna_write" method="post" name="fr">        
   <div class="question_input_bx" id="inquiryForm">  
           <div class="help_question_input">
<!--     delete line start
    delete this line: member_num <input type="text" name="member_num" class="member_num"><br>
    delete line end     -->  
               <strong class="help_question_tit">문의입력</strong>
               <div class="help_tbl_common help_tbl_style01">         
                   <table>
   
                       <tbody>
                       
                           <tr>
                               <th scope="row">상담분류</th>
                               <td>
                                   <select style="width:251px" title="문의분야 선택" class="select_st"  name="q_code">                                       
                                   <option value="buy">티켓예매/발권</option>
                                   <option value="del">배송/반송</option>
                                   <option value="can">취소/환불</option>
                                   <option value="doc">증빙서류</option>
                                   <option value="mov">영화관련</option>
                                   <option value="etc">기타</option>
                                   </select>
                               </td>
                           </tr>
                           <tr>
                               <th scope="row">제목</th>
                               <td colspan="3">
                                   <input type="text" style="width:631px" class="input_st"  name="title">
                               </td>
                           </tr>
                           <tr id="inquirytrText">
                               <th>내용</th>
                               <td colspan="3">
                                   <textarea class="input_st" style="width:631px;height:150px" name="contents"></textarea>
                               </td>
                           </tr>
                  </tbody>
                   </table>                
               </div>                       
               <div class="btn_zone">                                 
                 <script type="text/javascript">
                  function writeSub(){
                	  document.fr.submit();
                  }                 
                  </script>
                  <a href="#" onclick="writeSub()" id="bt_inquiry" style="cursor: pointer; cursor: hand">
                     <img src="board/images/write.png" width="16px">문의하기
                  </a>                     
                   <a href="index.jsp?center=board/qna_board_list.jsp" id="bt_inquiry_cancel">
                        <img src="board/images/cancel3.png" width="16px">취소
                   </a>
               </div>               
               </div>
   </div>   
</form>
        </div>
        <div id="footer" class="game_help_footer">
            <div class="footer">
         </div>
        </div>
    </div>
</body>
</html>