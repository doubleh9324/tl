<%@page import="team.board.db.BoardDao"%>
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
<style type="text/css">
#bt_inquiry:HOVER {
	cursor: pointer;
}
</style>
<%
BoardBean bb = new BoardBean();
BoardDao ba= new BoardDao();

int q_num = Integer.parseInt(request.getParameter("q_num"));
bb=ba.viewBoard(q_num);
%>

<script type='text/javascript' src='http://code.jquery.com/jquery-1.8.0.min.js'></script>
<script language='javascript' type='text/javascript'>
$(document).ready(function Selected(){
	
	document.getElementById("<%=bb.getQ_code()%>").selected="true";
	
	$('#bt_inquiry').click(function(){
		document.fr.submit();
	});
	
});
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
                        <a href="javascript:goToMyHistory();" class="menu01" id="myHistory">1:1 문의하기</a>
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
<form action="./BoardModify.bo" id="qna_write" name="fr" method="post">
         <input type="hidden" name="q_num" value=<%=bb.getQ_num() %>>
   <div class="question_input_bx" id="inquiryForm">
   
           <div class="help_question_input">
<%--     <!-- delete line start -->
    delete this line: member_num <input type="text" name="member_num" class="member_num" value="<%=bb.getMember_num()%>"><br>
    <!-- delete line end --> 
      --%>
               <strong class="help_question_tit">문의수정</strong>

               <div class="help_tbl_common help_tbl_style01">
               
           
                   <table>
   
                       <tbody>
                       
                           <tr>
                               <th scope="row">상담분류<%=bb.getQ_code()%></th>
                               <td>
                                   <select style="width:251px" title="문의분야 선택" class="select_st"  name="q_code" value="<%=bb.getQ_code()%>">
                                        
                                   <option id="buy" value="buy">티켓예매/발권</option>
                                   <option id="del" value="del">배송/반송</option>
                                   <option id="can"value="can">취소/환불</option>
                                   <option id="doc"value="doc">증빙서류</option>
                                   <option id="mov"value="mov">영화관련</option>
                                   <option id="ect"value="etc">기타</option>
                                   </select>
                               </td>
                           </tr>
                           <tr>
                               <th scope="row">제목</th>
                               <td colspan="3">
                                   <input type="text" style="width:631px" class="input_st"  name="title" value="<%=bb.getTitle()%>">
                               </td>
                           </tr>
                           <tr id="inquirytrText">
                               <th>내용</th>
                               <td colspan="3">
                                   <textarea class="input_st" style="width:631px;height:150px" name="contents"><%=bb.getContents()%>
                                   </textarea>
                               </td>
                           </tr>
                  </tbody>
                   </table>                
               </div>                       
               <div class="btn_zone">
                   <span id="bt_inquiry">
                     <img src="board/images/write.png" width="16px" >수정하기
                  </span>                   
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