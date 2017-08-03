package team.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.member.db.memberBean;
import team.member.db.memberDAO;

public class MemberModifyGo implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("MemberModifyGo execute() ");
      
      String id=(String)request.getSession().getAttribute("id");
      
      memberDAO dao = new memberDAO();
      memberBean bean = dao.getmember(id);
      
      request.setAttribute("bean", bean);
      ActionForward forward = new ActionForward();
      forward.setRedirect(false);
      forward.setPath("index.jsp?center=member/modify.jsp");
      return forward;
   }

}