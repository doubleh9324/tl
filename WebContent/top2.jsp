<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/top2.css">
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<style type="text/css">
.jg{font-family: 'Jeju Gothic',sans-serif;}
</style>
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

 
 

})

function dropMenu(){
   document.getElementById("dropSub").classList.toggle("show");
  
} 
</script>
</head>
<body>
<header>
<%
   String id = (String)session.getAttribute("id");


%>
<!-- 회원 메뉴바 -->
   <div id="member_menu_1">
      <div id="member_menu_2">
         <ul>
       <%if(id==null){ %>
       		
            <li><a href="index.jsp?center=board/qna_board_faq.jsp">고객센터</a></li>  
              <li><a href="#">예매확인/취소</a></li>
            <li><a href="./MemberModify.me">마이페이지</a></li>
              <li><a href="./MemberJoin.me">회원가입</a></li>
            <li ><a href="./MemberLogin.me">로그인</a></li>  
       <%}else{%>
       		
       			<li><a href="index.jsp?center=board/qna_board_faq.jsp">고객센터</a></li> 
   
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
           <img src="icons/searchIcon.png" width="40px" id="search_bar2_2" onclick="">
       
          <img alt="티켓사자" src="icons/lionLogo.png" width="100px" id="search_bar2_3">
   </div>
   
<!-- 메인 메뉴바 -->   
   <div id="menu_bar_1">
      <div id="menu_bar_2" class="jg">               
            <ul>  
              <li onclick="dropMenu()" ><a href="#" id="Hover">메뉴</a></li>          
               <li><a href="./MovieIndex.mo">영화</a></li>   
                <li><a href="./MusicalIndex.mu">뮤지컬</a></li>
               <li><a href="#">연극</a></li>
               <li><a href="#">콘서트</a></li>
               <li><a href="#">공연</a></li>
               <li><a href="#">지역</a></li>
            </ul>                 
      </div> 
      
   
      <div id="dropSub" class="dropSubBody">
      <!--       드롭 다운 버튼                        
                 영화
             
                 연극
                 
                 뮤지컬 -->  <ul>
              

                           <li> <a href="index.jsp?center=ganre.jsp&g_code=act&cate=mo">액션</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=adv&cate=mo">모험</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=ani&cate=mo">애니메이션</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=com&cate=mo">코미디</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=doc&cate=mo">다큐멘터리</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=dra&cate=mo">드라마</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=fam&cate=mo">가족</a></li>
                           
       
                    
                 </ul>

                 <ul>
              

                           <li> <a href="index.jsp?center=ganre.jsp&g_code=fan&cate=mo">판타지</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=his&cate=mo">사극</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=hor&cate=mo">호러</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=mys&cate=mo">미스터리</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=rom&cate=mo">멜로/로맨스</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=sf&cate=mo">SF</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=thr&cate=mo">스릴러</a></li>
                    
                 </ul>
                 <ul>
                 
                  
                    <li><a href="#"></a></li>
                       <li><a href="#"></a></li>
                       <li><a href="#"></a></li>
                        <li><a href="#"></a></li>
                       <li><a href="#"></a></li>
                       <li><a href="#"></a></li>
                 </ul>
                 <ul>
              

                           <li> <a href="index.jsp?center=ganre.jsp&g_code=ori&cate=mu">오리지널/내한</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=lic&cate=mu">라이센스 </a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=cre&cate=mu">창작 뮤지컬</a></li>
                           <li> <a href="index.jsp?center=ganre.jsp&g_code=non&cate=mu">넌버벌 공연</a></li>
                          
                    
                 </ul>
                 <ul>
                 
                  
                    <li><a href="#"></a></li>
                       <li><a href="#"></a></li>
                       <li><a href="#"></a></li>
                        <li><a href="#"></a></li>
                       <li><a href="#"></a></li>
                       <li><a href="#"></a></li>
                 </ul>
                   <ul> 
                      
                           <li> <a href="#">서울/경기</a></li>
                           <li> <a href="#">인천/강원</a></li>
                          <li>  <a href="#">충북/충남</a></li>
                          <li>  <a href="#">대전/경북</a></li>
                           <li> <a href="#">울산/부산</a></li>
                          <li>  <a href="#">전북/전남</a></li>
                          <li>  <a href="#">광주/제주</a></li>
                
                 </ul>   
<!--                    
            드롭 다운 버튼 마지막 -->
            </div> 
   </div>
</header>
</body>
</html>