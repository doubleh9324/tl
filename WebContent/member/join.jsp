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
                                 <input type="button" value="아이디중복체크" onclick="winopen()">                         
                                 <input type="button" value="이메일 인증" onclick="idSubmit();"/>
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
            <input type="submit" value="submit" class="submit">
              <input type="reset" value="cancel" class="cancel">
        </div>
        <!-- //회원가입 버튼 -->

    </div>
</div>

</form>
<!-- E:입력폼 -->




</body>
</html>