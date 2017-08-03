<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>FAQ</title>
<link href="css/game_help.css" rel="stylesheet">
<link href="css/help_reset.css" rel="stylesheet">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript">

var faqTable;

function faqSearch(){

	var keyword = $("#keyword").val();
	//var faqTable = $("#faqTable");
	doAjax("./FaqSearchAction.fa", keyword);



}//faqSearch() 끝
//////////////////////////////////////////////////////
function cateSearch(cate){
	//var keyword = $(arguments[0]).attr('name');
	// arguments로 접근
	var keyword = $(cate).attr('name');
	//만약 cate에 해당하는 인자값을 문자열로 처리해준다면
	//keyword = cate;
	//와 같은 식으로 파라미터를 받아주면 된다.
	//그 경우 cate가 엘레멘트가 아니라 해당 문자열로 인식됨
	
	// alert(keyword);
	//doAjax는 url, keyword를 인자값으로 받아서 ajax를 요청처리한다.
	doAjax("./FaqCateAction.fa",keyword);

}//cateSearch() 끝
//////////////contents 부분을 visible 속성을 이용하여 보이고 숨기게 하기///////////////////
function getcontents(con) {	
		console.log("겟~~");
		var fid = con;
		console.log(fid);
		var bflag = $("#faq"+ fid).data("flag");	
		if (bflag == "false" ) {
			bflag = "true";
			//ajax 시작
			jQuery.ajax({
			type:"POST",
			url: "./GetContentsAction.fa",
			data : "keyword="+ fid,
			dataType:"JSON",
			success : function(data) {
				console.log("Function Start");
				console.log(data);
				var total = data.total;
				var str = ""; //if 안에서 정의해줄 경우 else에서는 변수 할당이 되지 않아서 str += ... 부분에서 undefined로 인식
				if(total == 0){//검색결과가 없는경우
					str = "<tr><td colspan='4'> NO DATA </td></tr>";
					$("#faq"+ fid).after(str);	
				}else{
					$.each(data.faqList, function(key, value){
						console.log("반복문시작");
						console.log(value.contents);
						console.log(key + " : " + value);
// 						str+="<div id='con"+ fid + "'>"+ value.contents +"</div>";
 						str+="<dd id='con"+ fid + "'" + "class='nexon-hide template'>"+
                			 "<div class='help_content'>"+ value.contents +"</div></dd>";
						console.log(str);
						$("#faq"+ fid).after(str);
					});
				}
			}
			
			});//ajax끝
		} else {
			bflag = "false";
			$("#con"+ fid).remove();
		};
		$("#faq"+ fid).data("flag",bflag);
		console.log($("#faq"+ fid).data("flag",bflag));
};				
	
	//ajax 공통 로직을 하나의 function으로 정의해서 사용토록 수정
	function doAjax(url, keyword){
		
		jQuery.ajax({
			type:"POST",
			url: url,
			data : "keyword="+keyword,
			dataType:"JSON",
			success : function(data) {
				console.log("Function Start");
				console.log(data); 
				faqTable.empty();
				console.log(data); 
				var total = data.total;
				var str = ""; //if 안에서 정의해줄 경우 else에서는 변수 할당이 되지 않아서 str += ... 부분에서 undefined로 인식
				if(total == 0){//검색결과가 없는경우
					str = "<tr><td colspan='4'> NO DATA </td></tr>";
					faqTable.append(str);
			    }else{
					$.each(data.faqList, function(key, value){
						var con = value.faq_num;
						var fid = "#faq" + value.faq_num;
						console.log(fid+"들어가게 될 아이디");
						console.log(key + " : " + value)
						str+="<dt class='' id='faq"+ value.faq_num + "'>" +
		                "<a href='javascript:void(0)' class='accordion_bx ui_title open' >" +
	                    "<em>"+value.q_cate +"</em>"+
	                    "<span onclick='getcontents("+ con +");'>"+value.title+
	                    "</span></a></dt>";
				  
					});
				faqTable.append(str).trigger("create");
				$("dt[id^=faq]").data("flag","false");
				console.log($("#faq0").data("flag"));
				$("#faq0").data("flag");
				}
			},//sucess : function(data)끝	
		
			error : function(xhr, status, error) {
				console.log("error")
			    alert("에러발생");
			}

			});//ajax끝
	}
	
	
	$(document).ready(function(){
		faqTable = $("#faqTable");
	});
	window.onload = doAjax("./FaqSearchAction.fa","");
</script>
</head>
<body>


   <div id="game_help" class="clfix help_color_st00">
      <!-- 성준 // 비로그인시 문의 기능 // 나중에 참고 가능-->
      
      
      <script src="//code.jquery.com/jquery.min.js">
</script>


      <!-- 왼쪽 선택창 -->
      <div class="left_bx" style="height: 1011px;">
         <a href="index.jsp?center=board/qna_board_faq.jsp" class="online_help"
            id="onlineConsult" >고객센터</a>
            
            
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
     <!-- 왼쪽 선택창 끝 -->
<div class="help_content_bx" id="mainContents" height="1000px">
    <div class="help_menu content_bx_st">
        <strong class="tit">무엇을 도와드릴까요?</strong>

        <ul class="help_game_list help_game_list_on clfix  list6" id="depth1">
            
        <li class="">
                <a href="javascript:void(0)" onclick="cateSearch(this);" name="티켓예매/발권" class="depth1aTag">티켓예매/발권</a>
            </li><li class="">
                <a href="javascript:void(0)" onclick="cateSearch(this);" name="배송/반송" class="depth1aTag">배송/반송</a>
            </li><li class="">
                <a href="javascript:void(0)" onclick="cateSearch(this);"  name="취소/환불" class="depth1aTag">취소/환불</a>
            </li><li class="">
                <a href="javascript:void(0)" onclick="cateSearch(this);" name="증빙서류" class="depth1aTag">증빙서류</a>
            </li><li class="">
                <a href="javascript:void(0)" onclick="cateSearch(this);" name="영화관련" class="depth1aTag">영화관련</a>
            </li><li class="">
                <a href="javascript:void(0)" onclick="cateSearch(this);" name="기타" class="depth1aTag">기타</a>
            </li></ul>
            <br><br><br><br>
    </div>
    <br>
 <div class="help_game_list_sub_wrap">
      
   
    </div>
    
    
    <div class="content_bx_st help_sch clfix">
        <div class="tit_zone">
            
            <strong class="tit">도움말검색</strong>
            <p class="sub_copy">
                <b>
                    검색으로 빠르게 도움말을 찾아보실 수 있습니다.<br>
                    예) 예매, 환불
                    
                </b>
                <br>
            </p>
        </div>
        
        <!--  검색창 -->
        
        
        <div class="sch_input clfix" style="border: 1px solid #48BAE4" >
            <input type="text" title="검색어를 입력해주세요" id="keyword" name="keyword">
            <a href="javascript:void(0)" class="btn_help_sch" id="searchButton"
               onclick="faqSearch();">
                <img src="board/images/btn_help_sch.gif" alt="검색">
            </a>
        </div>
        
        <br><br>
        <!-- 검색창 끝 -->
    </div>
<hr>
	
 <div class="content_bx_st ui_accordion">

        <strong class="tit02" id="subTitle"><strong class="tit">자주찾는 도움말</strong></strong>
	<dl class="help_content_list" id="faqTable">
        <dt class="">
                <a href="javascript:void(0)" class="accordion_bx ui_title open" data-id="11383">
                    <em>유형</em>
                    <span>제목</span>
                </a>
            </dt>
           
                    </dl>     
                </div>

          
</div>
</body>
</html>