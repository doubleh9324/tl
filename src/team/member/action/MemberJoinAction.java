package team.member.action;

import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.member.db.memberBean;
import team.member.db.memberDAO;


public class MemberJoinAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      
      request.setCharacterEncoding("utf-8");
      
      memberBean dto = new memberBean();
      
      
      dto.setName(request.getParameter("name"));
      dto.setPass(request.getParameter("pass"));
      dto.setId(request.getParameter("id"));
      dto.setPhone(request.getParameter("phone"));
      dto.setBirth(request.getParameter("birthyy")+"-"+request.getParameter("birthmm")+"-"+request.getParameter("birthdd"));
      //bean.setDel_flag(Integer.parseInt(request.getParameter("del_flag")));
      dto.setGender(Integer.parseInt(request.getParameter("gender")));
      
      
      boolean result = false;
      
      memberDAO dao = new memberDAO();
      
      
      result = dao.insertMember(dto);
      
      
      if(result == false){
         System.out.println("�쉶�썝媛��엯 �떎�뙣");
         return null;
      }else{
    	  response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입되었습니다.');");
			out.println("location.href='./MemberLogin.me'");
			out.println("</script>");
      }
	      ActionForward forward = new ActionForward();
	      
	      forward.setRedirect(false);
	 
	      
	      return null;
      
      
      
      
      
   }
   
   
   
   

}