<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<style type="text/css">.jg{font-family: 'Jeju Gothic',sans-serif;}</style> <!-- 제주 고딕 폰트 - 이 방식이 가장 많이 로딩 시간 단축 가능. -->
<script type="text/javascript">
// <!-- Channel Plugin Scripts -->
window.channelPluginSettings = {
	    "plugin_id": "6ecf8b4f-1195-494d-81e5-2a4ddbfdb53f",
	    "user": {
	      "id": "YOUR_USER_ID",
	      "name": "YOUR_USER_NAME",
	      "mobileNumber": "YOUR_USER_MOBILE_NUMBER",
	      "meta": {
	        "CUSTOM_VALUE_1": "VALUE_1",
	        "CUSTOM_VALUE_2": "VALUE_2"
	      }
	    }
	  };
	  (function() {
	    var node = document.createElement('div');
	    node.id = 'ch-plugin';
	    document.body.appendChild(node);
	    var async_load = function() {
	      var s = document.createElement('script');
	      s.type = 'text/javascript';
	      s.async = true;
	      s.src = '//cdn.channel.io/plugin/ch-plugin-web.js';
	      s.charset = 'UTF-8';
	      var x = document.getElementsByTagName('script')[0];
	      x.parentNode.insertBefore(s, x);
	    };
	    if (window.attachEvent) {
	      window.attachEvent('onload', async_load);
	    } else {
	      window.addEventListener('load', async_load, false);
	    }
	  })();

	  
$(document).ready(function(){ //검색 기능
   TopgradeFunction();
   TopgradeFunction2();
   
   $('#search_bar2_2').click(function(){
      var search=$('#search_bar2_1').val();
      if(search == ""){
         alert("검색어를 입력해주세요;");
      }else{
         location.href="./index.jsp?center=search.jsp&search="+search;
      }
   });
   
   $("#search_bar2_1").keyup(function(e){
      if(e.keyCode == 13){
         var search=$('#search_bar2_1').val();
         if(search==""){
            alert("검색어를 입력해주세요;");
         }else{
            location.href="./index.jsp?center=search.jsp&search="+search;
         }
      }
   });
   
   //메뉴바 제이쿼리 8.7 pm 15:33
   //무비 드롭다운
   $("#movie,#movie_drop").mouseover(function(){//메뉴, 드롭 다운 메뉴에 mouseover했을 때   
      $("#movie_drop").stop().slideDown("fast"); //드롭 다운 메뉴 나오게 하고 유지
      $("#movie").css("background-color","#f0403c"); //메뉴 '영화'색상 유지
      
      $("#movie,#movie_drop").mouseout(function(){ // 메뉴, 드롭 다운 메뉴 mouseout했을 때
         $("#movie_drop").stop().slideUp(10); //드롭 다운 메뉴 올라가게 
         $("#movie").css("background-color","rgba(0,0,0,0)"); //메뉴 '영화'색상 원상태로
      });      
   });
   
   //뮤지컬 드롭다운  8.7 pm 15:33
   $("#musical,#musical_drop").mouseover(function(){   
      $("#musical_drop").stop().slideDown("fast");
      $("#musical").css("background-color","#f0403c");
      
      $("#musical,#musical_drop").mouseout(function(){
         $("#musical_drop").stop().slideUp(10);
         $("#musical").css("background-color","rgba(0,0,0,0)");
      });      
   });
   
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

function TopgradeFunction2(){
   var setflag=$("#setFlag").val();
   if(setflag!='y'){
      jQuery.ajax({
         type:"POST",
         url:"./MusicalPopularAction.mu",
         dataType:"JSON",
         
         success:function(data){
            $("#mu_recommand").html("");
            var h5_code="<h5>뮤지컬 <br>추천</h5>"
               $("#mu_recommand").append(h5_code);
         
            $.each(data.pop_musicalList, function(key,value){
               if(key<4){
                  var li_code='<a href="./MusicalContentAction.mu?num='+value.musical_num+'"><img src="MusicalImage/'+value.image+'">'+'</a>';
                  
                  $("#mu_recommand").append(li_code);
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
<%String id = (String)session.getAttribute("id");%>
<!-- 회원 메뉴바 -->
 <div id="member_menu_1"><!-- 재공학 할 때는 변수명 정리. 언더바 사용 X -->
      <div id="member_menu_2">
         <ul>
       <%if(id==null){ %><!-- 로그인 여부 확인 -->           
            <li><a href="index.jsp?center=board/qna_board_faq.jsp">고객센터</a></li>  
            <li><a href="./MemberReservation.me">예매확인/취소</a></li>
            <li><a href="./MemberModify.me">마이페이지</a></li>
            <li><a href="./MemberJoin.me">회원가입</a></li>
            <li ><a href="./MemberLogin.me">로그인</a></li>  
       <%}else{%>            
             <li><a href="index.jsp?center=board/qna_board_faq.jsp">고객센터</a></li>    
            <li><a href="./MemberReservation.me">예매확인/취소</a></li>
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
         <img alt="logo" src="img/logo6.png">
      </div>   
      <span id="search_bar2">
         <input type="text" id="search_bar2_1"><!-- 검색 텍스트 상자 -->               
      </span>
         <img alt="searchIcon" src="icons/search.png" width="30px" id="search_bar2_2" onclick=""><!-- 서치 아이콘 -->      
         <img alt="티켓사자" src="icons/banner2.png" width="300px" id="search_bar2_3"><!-- 배너 이미지 -->
   </div>  
<!-- 메인 메뉴바 -->   
   <div id="menu_bar_1">
      <div id="menu_bar_2" class="jg">               
            <ul>  
               <li><a href="#">메 뉴</a></li>          
               <li id="movie" onclick="location.href='./MovieIndex.mo'"><a>영 화</a></li>               
               <li id="musical" onclick="location.href='./MusicalIndex.mu'"><a>뮤 지 컬</a></li>
               <li><a href="#">연 극</a></li>
               <li><a href="#">콘 서 트</a></li>
               <li><a href="#">공 연</a></li>
               <li><a href="index.jsp?center=location/LocationList.jsp">지 역</a></li>
            </ul>                     
      </div>
      <div id="movie_drop" class="jg"><!-- 영화 메뉴 드롭 다운 -->
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
                <!-- 영화 드롭 다운 추천 이미지  들어가는 곳 -->    
          </div>
         <div class="clear"></div>                      
         <div style="width:449px; background-color: skyblue ;">          
             <!-- 이미지 -->
             <img alt="musical" src="img/taxi3.png" style="width:449px">
       </div>
      </div>      
       <div id="musical_drop" class="jg"><!-- 뮤지컬 메뉴 드롭 다운 --> 
           <div style="width:200px; height:350px; background-color: white;">
            <p>뮤지컬</p>
               <ul>
                  <li> <a href="index.jsp?center=ganre.jsp&g_code=ori&cate=mu">오리지널/내한</a></li>
                  <li> <a href="index.jsp?center=ganre.jsp&g_code=lic&cate=mu">라이센스 </a></li>
                  <li> <a href="index.jsp?center=ganre.jsp&g_code=cre&cate=mu">창작 뮤지컬</a></li>
                  <li> <a href="index.jsp?center=ganre.jsp&g_code=non&cate=mu">넌버벌 공연</a></li>
              </ul>                
            </div>
           <div id="mu_recommand" style="width:449px; height:134px; background-color: white;">
                  <!-- 뮤지컬 드롭 다운 추천 이미지  들어가는 곳 -->  
           </div>
         <div class="clear"></div>
                       
         <div style="width:449px; background-color: skyblue ;">          
             <!-- 이미지  width:449px height:215.09px-->
             <img alt="musical" src="./img/musical_1.jpg" style="width:449px">            
         </div>                  
   </div>
</header>
</body>
</html>