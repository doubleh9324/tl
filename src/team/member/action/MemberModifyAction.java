package team.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.member.db.memberBean;
import team.member.db.memberDAO;

public class MemberModifyAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("MemberModifyAction execute() ");
      request.setCharacterEncoding("utf-8");
      
      String id=(String)request.getSession().getAttribute("id");
      
      memberBean bean = new memberBean();
      
      bean.setId(id);
      bean.setName(request.getParameter("name"));
      bean.setBirth(request.getParameter("birth"));
      bean.setPhone(request.getParameter("phone"));
      bean.setmPoint(Integer.parseInt(request.getParameter("mPoint")));
      bean.setPass(request.getParameter("pass"));
      
      memberDAO dao = new memberDAO();
      dao.updateMember(bean);
      
      request.setAttribute("bean", bean);
      ActionForward forward = new ActionForward();
      forward.setRedirect(false);
      forward.setPath("./MemberModifyConfirm.me");
      return forward;
   }

}