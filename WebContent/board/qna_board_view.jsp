<%@page import="team.board.action.BoardListAction"%>
<%@page import="team.board.db.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/game_help.css" rel="stylesheet">
<link href="css/help_reset.css" rel="stylesheet">
</head>
<body>
<div id="game_help" class="clfix help_color_st00">      
 
    <div class="left_bx" style="height: 1011px;">
        <a href="index.jsp?center=board/qna_board_faq.jsp" class="online_help" id="onlineConsult">고객센터</a>
        <ul class="game_left_menu">
        </ul>
        <ul class="game_my_menu"> 
                <li><a href="index.jsp?center=board/qna_board_write.jsp" class="menu01"
					id="myHistory">1:1 문의하기</a></li>									
				<li><a href="index.jsp?center=board/qna_board_list.jsp" class="menu02"
					id="messageBox">내 문의내역</a></li>                 
                <li><a href="#" class="menu02" id="messageBox">추가</a>
                </li>
                <li><a href="#" class="menu02" id="messageBox">계속</a>
                </li>
                <li><a href="#" class="menu02" id="messageBox">입력해주세요</a>
                </li>
      	</ul>
    </div>   
<!-- 성준 : 리스트 뿌려주는 곳 -->
<div class="help_content_bx">

<div class="content_bx_st">
        <strong class="tit">내 문의내역</strong>
        <p class="sub_copy">접수하신 1:1문의내역 및 답변 내용을 확인하실 수 있습니다.</p>
        <p class="sub_copy02">※ 문의 내용 중 개인정보가 포함되었거나 중복된 문의인 경우 삭제될 수 있습니다.</p>
        <div class="help_tbl_common help_tbl_style01 help_tbl_style03" id="styleclass">
            <table>
                <caption>내 문의내역</caption>
                <colgroup>
                    <col style="width:20%">
                    <col style="width:30%">
                    <col style="width:20%">
                    <col style="width:30%">
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">등록일</th>                                               
                        <td><span id="firstopendate">${bb.q_date.substring(0,16)}</span></td>                       
                        <th scope="row">처리상태 </th>                      
                    <c:choose>
                       <c:when test="${bb.re_state == '1'}">    
                        <td id="state">처리완료</td>
                        </c:when>
                        <c:when test="${bb.re_state == '0'}">
                        <td id="state">답변 진행중</td>
                        </c:when>
                    </c:choose>    
                    </tr>
                    <tr>
                        <th scope="row">문의분류</th>
                        <td colspan="3"><span id="title">${bb.q_category}</span></td><!-- q_code -->
                    </tr>
                    
                    <tr>
                        <th scope="row">제목</th>
                        <td colspan="3"><span id="title">${bb.title}</span></td>
                    </tr>
                    <tr class="help_tbl_common_contents">
                        <th scope="row">내용</th>
                        <td colspan="3" id="history">
                            <div class="tbl_content_bx">
                                <span id="content">${bb.contents}</span>
                            </div>
                        </td>
                    </tr>                    
                </tbody>
            </table>
        </div>
        
        
        
        
        
     <c:choose>
      <c:when test="${bb.re_state == '1'}">
        <div class="tbl_content_bx " id="recontent">
               <div class="help_tbl_common help_tbl_style01" id="styleclass">
                  <table>
                     <caption>답변</caption>
                     <colgroup>
                        <col style="width: 20%">
                        <col style="width: 80%">
                     </colgroup>
                     <tbody>
                        <tr id="recontent">
                           <th scope="row">답변</th>
                           <td><input type="hidden" id="communicationID_66590934"
                              value="66590934"> <input type="hidden"
                              id="communicationRating_5" value="5">
                              <div class="tbl_content_bx" id="recontent_66590934">
                                 </span><span style="color: rgb(76, 76, 76);"> </span><span
                                    style="color: rgb(76, 76, 76);"> </span>
                                 </p>
                                 <div style="font-size: 13px; line-height: 19px; color: rgb(18, 52, 86);">
                                    <span style="LINE-HEIGHT: 18px; FONT-FAMILY: 굴림, Gulim, Helvetica, 
                                    AppleGothic, sans-serif; COLOR: rgb(76, 76, 76); FONT-SIZE: 9pt">
                                    ${rbb.contents }
                                    <span style="color: rgb(76, 76, 76);">                                          
                                 </div>
                           </td>
                        </tr>
                     </tbody>
                  </table>
               </div>
      </div>
      
                        
      <div class="btn_zone">
                
               <a href="index.jsp?center=board/qna_board_list.jsp" id="btnmyHistoryList">
                  	<img src="board/images/list.png" alt="목록" width="20px"> 목록
               </a>       
               
               <a href="index.jsp?center=board/qna_board_write.jsp" id="btnremyHistoryCancel" class="">
                   <img src="board/images/write.png" alt="다시 문의하기" width="16px"> 다시 문의하기
               </a>
                       
<%-- 				<a href="./Gomodify.bo?q_num=${bb.q_num} " id="btnremyHistoryCancel" class=""> --%>
<!-- 					<img src="board/images/write.png" alt="수정" width="16px">수정 -->
<!-- 				</a> -->


	  </div>  
      
      
      </c:when>
      
      
      <c:when test="${bb.re_state == '0'}">
      <!-- re_state값이 0이면 답변 없음. -->
      				
      				
      			      <div class="btn_zone">

               <a href="index.jsp?center=board/qna_board_list.jsp" id="btnmyHistoryList">
                  	<img src="board/images/list.png" alt="목록" width="20px"> 목록
               </a>       
               
               
                       
				<a href="./Gomodify.bo?q_num=${bb.q_num} " id="btnremyHistoryCancel" class="">
					<img src="board/images/write.png" alt="수정" width="16px">수정
				</a>


	  </div>  	
      				
      				
      				
      				
      
      
      
      </c:when>
   </c:choose> 
   
   
   
   
                   
<!--       <div class="btn_zone"> -->
<!--                <a href="index.jsp?center=board/qna_board_write.jsp" id="btnremyHistoryCancel" class=""> -->
<!--                    <img src="board/images/write.png" alt="다시 문의하기" width="16px"> 다시 문의하기 -->
<!--                </a>  -->
<!--                <a href="index.jsp?center=board/qna_board_list.jsp" id="btnmyHistoryList"> -->
<!--                   	<img src="board/images/list.png" alt="목록" width="20px"> 목록 -->
<!--                </a>        -->
               
               
                       
<%-- 				<a href="./Gomodify.bo?q_num=${bb.q_num} " id="btnremyHistoryCancel" class=""> --%>
<!-- 					<img src="board/images/write.png" alt="수정" width="16px">수정 -->
<!-- 				</a> -->


<!-- 	  </div>    -->



    </div><!-- tbl_content_bx 끝 -->
</div><!-- 문의내역 끝 -->






<!--         <div id="footer" class="game_help_footer"> -->
<!--             <div class="footer"> -->
<!-- 			</div> -->
<!--         </div> -->




    </div>
</body>
</html>