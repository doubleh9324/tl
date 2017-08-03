package team.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team.member.db.memberBean;
import team.member.db.memberDAO;

public class MemberModifyConfirm implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("MemberModifyConfirm execute() ");
      request.setCharacterEncoding("utf-8");
      
      String id=(String)request.getSession().getAttribute("id");
      
      memberDAO dao = new memberDAO();
      memberBean bean = dao.getmember(id);
      
      request.setAttribute("bean", bean);
      ActionForward forward = new ActionForward();
      forward.setRedirect(false);
      forward.setPath("index.jsp?center=member/modifyconfirm.jsp");
      return forward;
   }

}