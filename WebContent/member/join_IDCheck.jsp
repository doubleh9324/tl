
<%@page import="team.member.db.memberDAO"%>
<%@page import="team.member.db.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/join.css" />
<script type="text/javascript">

   function result() {
      //중복체크 결과인 idCheck값을 전달
      opener.document.join.idDup.value="idCheck";
      
      
      opener.document.join.idDupID.value = document.njoin.userid.value;
      
      //join_IDCheck.jsp창을 open하게 해준 join.jsp=join_IDCheck.jsp 창 페이지
      opener.document.join.id.value = document.njoin.userid.value;
     
      
      //창닫기
      window.close();
   }
   

</script>

</head>
<body>
   <%
      //1.join.jsp의 function winopen()함수에 의해서 전달 받은 userid값 가져오기 
      //2.맨아래의 중복확인 버튼 <form>태그로부터 전달받은 userid값 가져오기 
      String id = request.getParameter("userid");
   
      //아이디 중복 체크 DB작업을 위한 DAO객체 생성 
      memberDAO dao = new memberDAO();
   
      //memberDao클래스에 아이디 중복 체크 유무 값 가져오기 DB작업을 위한 idCheck()메소드 추가 하기 
      
      //전달 받은 사용자가 입력한 id값을 idCheck()라는 메소드에 인자로 전달하여 
      //메소드의 리턴값으로 아이디 중복 체크 유무값 가져오기 
      //check == 1  ->  아이디 있음, 아이디 중복 
      //   del_flag == 1 -> 탈퇴X, 아이디 중복 
      //  del_flag == 0 -> 탈퇴O, 사용가능
      //check == 0  ->  아이디 없음, 중복아님
      
      int check = dao.idCheck(id);
      
      if(check==1){
            out.println("사용중인 아이디입니다.");

      }else{
         out.println("사용 가능한 아이디입니다.");
      %>
         <%--사용가능한 아이디이면 사용 버튼 눌러서 부모창(join.jsp)의 id입력란에 사용가능한 ID값 나타내기  --%>
    	 <input type="button" class="button" value="사용" onclick="result()"/>
   <%
      }
   %>

   <form action="join_IDCheck.jsp" method="post" name="njoin">
      아이디 : <input type="text" class="memtxt" name="userid" value="<%=id%>">
      <input type="submit" class="button" value="중복확인">
   </form>

</body>
</html>