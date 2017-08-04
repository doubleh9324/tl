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
<script type="text/javascript">
$(document).ready(function(){
	TopgradeFunction();
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
   
//    $("movie").mouseover(function(){
//       $("movie_drop").slideDown("slow");
//       $("movie").mouseout(function(){
//          $("movie_drop").slideUp("slow");
//       })
//    });
   
   $("#movie,#movie_drop").mouseover(function(){   
      $("#movie_drop").stop().slideDown("fast");
      
      $("#movie,#movie_drop").mouseout(function(){
         $("#movie_drop").stop().slideUp(10);
      });      
   });
   
   $("#musical,#musical_drop").mouseover(function(){   
      $("#musical_drop").stop().slideDown("fast");
      
      $("#musical,#musical_drop").mouseout(function(){
         $("#musical_drop").stop().slideUp(10);
      });      
   });
//    호버 색깔 유지하는 메서드 아직 미완성
   $("#movie").mouseover(function(){
      $("#movie").css("color","#f0403c");
   })
   
})


function TopgradeFunction(){
	var setflag=$("#setFlag").val();
	if(setflag!='y'){
		jQuery.ajax({
			type:"POST",
			url:"./MovieOrderGradeAction.mo",
			dataType:"JSON",
			
			success:function(data){
				$("#mo_recommand").html("");
				var h5_code="<h5>영화 <br>추천</h5>"
					$("#mo_recommand").append(h5_code);
			
				$.each(data.movieGrade, function(key,value){
					if(key<4){
						var li_code='<a href="./MovieContentAction.mo?num='+value.movie_num+'"><img src="MovieImage/'+value.image+'">'+'</a>';
						
						$("#mo_recommand").append(li_code);
					}
					
				});
				
			},
			error: function(xhr, status, error){
				
			}
		});
	}
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
           <img src="icons/searchIcon.png" width="38px" id="search_bar2_2" onclick="">
       
          <img alt="티켓사자" src="icons/banner2.png" width="300px" id="search_bar2_3">
   </div>
   
<!-- 메인 메뉴바 -->   
   <div id="menu_bar_1">
      <div id="menu_bar_2" class="jg">               
            <ul>  
               <li><a href="#">메 뉴</a></li>          
               <li id="movie" onclick="location.href='./MovieIndex.mo'"><a>영 화</a> </li>
               
               <li id="musical" onclick="location.href='./MusicalIndex.mu'"><a>뮤 지 컬</a></li>
               <li><a href="#">연 극</a></li>
               <li><a href="#">콘 서 트</a></li>
               <li><a href="#">공 연</a></li>
               <li><a href="index.jsp?center=location/LocationList.jsp">지 역</a></li>
            </ul>                     
      </div>
      <div id="movie_drop" class="jg">
           <!-- 목록 -->
           <div style="width:200px; height:350px; background-color: white;">
            <p>영화</p>
            <ul>                
                <li> <a href="index.jsp?center=ganre.jsp&g_code=act&cate=mo">액션</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=adv&cate=mo">모험</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=ani&cate=mo">애니메이션</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=com&cate=mo">코미디</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=doc&cate=mo">다큐멘터리</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=dra&cate=mo">드라마</a></li>
                <li> <a href="index.jsp?center=ganre.jsp&g_code=fam&cate=mo">가족</a></li>                   
            </ul>
          </div>
          <div id="mo_recommand" style="width:449px; height:134px; background-color: white;">
             
             
             
         </div>
         <div class="clear"></div>
                       
         <div style="width:449px; background-color: skyblue ;">
             
             
             <!-- 이미지 -->
             <img alt="musical" src="img/musical_1.jpg" style="width:449px">
             
         </div>
      </div>
      
       <div id="musical_drop">
			            <div>
			               <ul>
			                  <li> <a href="index.jsp?center=ganre.jsp&g_code=ori&cate=mu">오리지널/내한</a></li>
			                  <li> <a href="index.jsp?center=ganre.jsp&g_code=lic&cate=mu">라이센스 </a></li>
			                  <li> <a href="index.jsp?center=ganre.jsp&g_code=cre&cate=mu">창작 뮤지컬</a></li>
			                  <li> <a href="index.jsp?center=ganre.jsp&g_code=non&cate=mu">넌버벌 공연</a></li>
			              </ul>                
			            </div>
			      </div>
   
      
                    
   </div>
</header>
</body>
</html>