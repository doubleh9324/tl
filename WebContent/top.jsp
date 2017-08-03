<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<style type="text/css">
.jg{font-family: 'Jeju Gothic',sans-serif;}
</style>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   
   $('#search_bar2_2').click(function(){
      var search=$('#search_bar2_1').val();
      if(search==""){
         alert("검색어를 입력해주세요;")
      }else{
         location.href="./index.jsp?center=search.jsp&search="+search;
      }
   });
   
   $("#search_bar2_1").keyup(function(e){
      if(e.keyCode == 13){
         var search=$('#search_bar2_1').val();
         if(search==""){
            alert("검색어를 입력해주세요;")
         }else{
            location.href="./index.jsp?center=search.jsp&search="+search;
         }
      }
   });
   

  
       $("#movie").mouseover(function(){   
	      $("#movie_drop").stop().slideDown("fast");

	      
	      $("#movie_drop, #movie").mouseout(function(){
	         $("#movie_drop").stop().slideUp("fast");
	         
	       
	      });
	   });   
	
    
   
       
    

    
})




</script>
</head>
<body>
<header>
<%
   String id = (String)session.getAttribute("id");
%>
<!-- 회원 메뉴바 -->
   <div id="member_menu_1" >
      <div id="member_menu_2">
         <ul>
       <%if(id==null){ %>
            <li><a href="#">고객센터</a></li>  
             <li><a href="#">예매확인/취소</a></li>
            <li><a href="./MemberModify.me">마이페이지</a></li>
            <li><a href="./MemberJoin.me">회원가입</a></li>
             <li><a href="./MemberLogin.me">로그인</a></li>  
              <li><a href="./MemberLogin.me">로그인</a></li>  
       <%}else{%>
            
            <li><a href="#">고객센터</a></li> 
            <li><a href="#">예매확인/취소</a></li>
                 <li><a href="./MemberModify.me">마이페이지</a></li>
             <li><a href="./MemberLogout.me">로그아웃</a></li> 
              <li><a><%=id %>님 환영합니다!</a></li>
                 
       <% }%>
         </ul>
      </div>
   </div>
<!-- 가운데 로고, 검색, 이미지 --> 
   <div id="search_bar">
      <div  id="search_bar1" onclick="location.href='index.jsp'">
         <h1>Ticket <a class="fontColor">L</a>ion</h1>
      </div>   
      <span id="search_bar2">
          <input type="text" id="search_bar2_1">
                  
       </span>
           <img src="icons/searchIcon.png" width="38px" id="search_bar2_2" onclick="">
       
          <img alt="티켓사자" src="icons/banner2.png" width="300px" id="search_bar2_3">
   </div>
   
<!-- 메인 메뉴바 -->   
   <div id="menu_bar_1">
      <div id="menu_bar_2" class="jg">               
            <ul>  
               <li><a href="#">메 뉴</a></li>          
               <li id="movie"><a href="./MovieIndex.mo">영 화</a></li>
               <li><a href="#">뮤 지 컬</a></li>
               <li><a href="#">연 극</a></li>
               <li><a href="#">콘 서 트</a></li>
               <li><a href="#">공 연</a></li>
               <li><a href="#">지 역</a></li>
            </ul>                     
      </div>
      <div id="movie_drop">
           <div style="background-color: #000000;">
            <ul >
                <li> <a href="index.jsp?center=ganre.jsp&g_code=act&cate=mo">액션</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=adv&cate=mo">모험</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=ani&cate=mo">애니메이션</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=com&cate=mo">코미디</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=doc&cate=mo">다큐멘터리</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=dra&cate=mo">드라마</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=fam&cate=mo">가족</a></li>                   
           </ul>
          </div>
      </div> 
                    
   </div>
</header>
</body>
</html>