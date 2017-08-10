<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>티켓사자-회원가입</title>

<!-- css -->
<link rel="stylesheet" href="css/join.css" />
<!-- <link rel="stylesheet" href="css/gatewayBar_ssl.css" /> -->
<!-- 다음 주소 api -->
<span id="guide" style="color:#999"></span>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>


<!-- 아이디 중복확인, 이메일 인증 함수 -->

<script src="//code.jquery.com/jquery.min.js"></script>



<script type="text/javascript">

 function winopen() {
   //회원가입시 id입력란에 아이디를 입력하지 않았을 때 
   if(document.join.id.value == ""){
      alert("아이디를 입력하세요.");
      document.join.id.focus();
      return; //아래 문장 실행 안되게 하는 것
   }
   
   //작은 창 열기 join_IDCheck.jsp width=400, height=200
   var jid = document.join.id.value;
   window.open("member/join_IDCheck.jsp?userid="+jid, "" , "width=400, height=200");
}
 

 function checkValue(){
    var join = document.join;
    
    if(!join.id.value){
       alert("아이디를 입력하세요.");
       return false;
    }
    
    if(join.idDup.value != "idCheck"){
       alert("아이디 중복체크를 해주세요.");
       return false;
    }
    
    if(join.mailDup.value != "mailCheck"){
        alert("이메일 인증을 해주세요.");
        return false;
     }else{
        if(join.mailDupId.value != join.id.value){
           alert("이메일 인증을 다시 해주세요.");
           return false;
        }
     }
    
     if(!join.name.value){
         alert("이름을 입력하세요.");
         return false;
     }

    if(!join.pass.value){
       alert("비밀번호를 입력하세요.");
       return false;
    }
    
    if(join.pass.value != join.pass2.value){
       alert("비밀번호를 동일하게 입력하세요.");
       return false;
    }
    
     if(!join.phone.value){
         alert("전화번호을 입력하세요.");
         return false;
     } 
    
     if(!join.gender.value){
        alert("성별을 선택하세요.");
        return false;
     }
    
 }
 
 function inputIdChk() {
      document.join.inDup.value="idUncheck";
   }
 
 
 function idSubmit(){
    if(join.idDup.value != "idCheck"){
          alert("아이디 중복체크를 해주세요.");
          return false;
    }else{
       
       if(join.idDupID.value != join.id.value){
           alert("아이디 중복 체크를 다시 해주세요.");
           return false;
        }else{
       var id = $("#id").val();
       
       window.alert(id);
       window.open("./MemberMail.me?id="+$('#id').val(),"","width=400, height=200");
        }
    }
 }
 </script>

</head>
<body>



   <!-- S:타이틀 -->


   <div id="Tit_NewMembe">
      <h1>
         <img
            src="https://sslimage.interpark.com/_nip/Newmember/tit_memjoin.png"
            alt="회원가입">
      </h1>
   </div>
   <!-- E:타이틀 -->




   <!-- S:입력폼 -->
   <form action="./MemberJoinAction.me" id="join" method="post" name="join" onsubmit="return checkValue()">
   <div id="NewMemberwarp">
    <div class="NewMember">
        <!-- 필수입력사항 -->
        <div id="necessary">
            <h2><img src="https://sslimage.interpark.com/_nip/Newmember/tit_newmem1.gif" alt="필수입력"></h2>

            <div class="join_mem">
                <div class="join_cont1">


                     <table cellpadding="0" cellspacing="0" border="0" width="100%">
                        <colgroup>
                           <col width="156">
                           <col width="">
                        </colgroup>


                        <tbody>
                           <!-- 아이디 입력 칸 -->
                           <tr>
                              <th><span class="titR">*</span> 아이디</th>
                              <td><input type="text" id="id" name="id" placeholder="이메일을 입력하세요."
                                 maxlength="20" class="memtxt" style="width: 338px;"
                                 onkeydown="inputIdChk()"> <!-- 중복확인, 이메일 인증 -->

                                 &nbsp; 
                                 <input type="button" class="button" value="아이디중복체크" onclick="winopen()">                         
                                 <input type="button" class="button" value="이메일 인증" onclick="idSubmit();"/>
                                 <input type="hidden" name="idDup" value="idUncheck">
                                 <input type="hidden" name="idDupID" value="">
                                 <input type="hidden" name="mailDup" value="mailUncheck">
                                 <input type="hidden" name="mailDupId" value="">
                                 </td>
                           </tr>


                           <!-- 비밀번호 입력칸 -->
                           <tr>
                              <th><span class="titR">*</span> 비밀번호 입력</th>
                              <td><input type="password" class="memtxt" name="pass"
                                 value="" maxlength="12"
                                 style="width: 338px; ime-mode: disabled;"> <span
                                 class="txtR">영문, 숫자, 특수문자 조합 8~12자</span></td>
                           </tr>

                           <!-- 비밀번호 재입력칸 -->
                           <tr>
                              <th><span class="titR">*</span> 비밀번호 확인</th>
                              <td><input type="password" class="memtxt" name="pass2"
                                 value="" maxlength="12"
                                 style="width: 338px; ime-mode: disabled;"> <span
                                 class="txtR">비밀번호 재입력</span></td>
                           </tr>
                           <!-- 이름 -->
                           <tr>
                              <th><span class="titR">*</span> 이름</th>
                              <td><input type="text" name="name" value=""
                                 class="memtxt" style="width: 338px; ime-mode: active;"
                                  maxlength="20"></td>
                           </tr>
                           <!-- 생년월일 -->

                           <tr>
                              <th><span class="titR">*</span> 생년월일</th>
                              <td class="ctd pdl20">
                                 <div class="datel">
                                    <select name="birthyy" class="numbox"
                                       style="width: 65px; height: 28px;">
                                       <%
                                          for (int i = 2017; i >= 1920; i--) {
                                       %>
                                       <option value="<%=i%>"><%=i%></option>
                                       <%
                                          }
                                       %>
                                    </select> 년&nbsp; 
                                    
                                    <select name="birthmm" class="numbox"
                                       style="width: 50px">
                                       <%
                                          for (int i = 1; i <= 12; i++) {
                                       %>
                                       <option value="<%=i%>"><%=i%></option>
                                       <%
                                          }
                                       %>
                                    </select> 월&nbsp; <select name="birthdd" class="numbox"
                                       style="width: 50px">
                                       <%
                                          for (int i = 1; i <= 31; i++) {
                                       %>
                                       <option value="<%=i%>"><%=i%></option>
                                       <%
                                          }
                                       %>
                                    </select> 일&nbsp; 
                                 
                                 </div>
                                 <div class="dater">
                                    <span class="txtR">본인의 정확한 생년월일을 입력해주세요.<br>이후
                                       성인인증 및 본인확인을 위한 정보로 사용됩니다.
                                    </span>
                                 </div>
                                 
                           <!-- 연락처 -->
                                 <tr>
                                    <th><span class="titR">*</span> 연락처</th>
                                    <td><input type="text" name="phone" value=""
                                       class="memtxt" style="width: 338px; ime-mode: active;"
                                       minlength="4" maxlength="20"></td>
                                 </tr>      
                           <!-- 성별-->
                           <tr>
                              <th><span class="titR">*</span> 성별</th>
                              <td><input type="radio" class="rdo" name="gender" value="0">남 &nbsp; 
                                 <input type="radio" class="rdo" name="gender" value="1">여</td>
                           </tr>
                           <!-- 주소-->
                        <tr>
                        <th><span class="titR">*</span> 주소</th>
                        <td><script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
				<input
						type="text" class="memtxt" id="sample4_postcode" name="address1" class="mini" placeholder="우편번호" > 
					<input type="text" class="memtxt" id="sample4_roadAddress" name="address2" placeholder="도로명주소">
					<input type="text" class="memtxt" id="sample4_jibunAddress" name="address3" placeholder="나머지주소">
					<input
						type="button" class="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
					<div class="chbox"><input type="checkbox" class="cbox" id="default_flag" name="default_flag" value="y">
					<label for="default_flag">기본배송지 설정</label></div>
				</td>
				
                        </tr>

                        </tbody>

                     </table>


                  </div>
            </div>
        </div>
        <!-- // 필수입력사항 -->

        <!-- 필수항목동의 -->
      
        <!-- //필수항목동의 -->

        
      <!-- // 160926 수정 -->

        <!-- 회원가입 버튼 -->
        <div class="btn_join">
            <input type="submit" class="button" value="submit" class="submit">
              <input type="reset" class="button" value="cancel" class="cancel">
        </div>
        <!-- //회원가입 버튼 -->

    </div>
</div>

</form>
<!-- E:입력폼 -->




</body>
</html>