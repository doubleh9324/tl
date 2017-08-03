package team.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.member.db.memberBean;
import team.member.db.memberDAO;

public class MemberModify implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("MemberModify execute() ");
      
      String id=(String)request.getSession().getAttribute("id");
      if(id==null){
    		
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인해주세요.');");
			out.println("location.href='./MemberLogin.me'");
			out.println("</script>");
			out.close();

			return null;
    	  
      }else{
	      memberDAO dao = new memberDAO();
	      memberBean bean = dao.getmember(id);
	      
	      request.setAttribute("bean", bean);
	      System.out.println("mpoint========="+bean.getmPoint());
	      ActionForward forward = new ActionForward();
	      forward.setRedirect(false);
	      forward.setPath("index.jsp?center=member/modifylogin.jsp");
	      return forward;
      }
   }

}