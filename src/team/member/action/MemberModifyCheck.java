package team.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team.member.db.memberDAO;

public class MemberModifyCheck implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("MemberModifyCheck execute()");
      request.setCharacterEncoding("utf-8");

	  HttpSession session = request.getSession();
      String id = request.getParameter("id");
      String pass = request.getParameter("pass");
      
      System.out.println(id);
      System.out.println(pass);
//      memberBean bean = new memberBean();
//      
//      bean.setBirth(request.getParameter("birth"));
//      bean.setId(request.getParameter("id"));
//      bean.setName(request.getParameter("name"));
//      bean.setPass(request.getParameter("pass"));
//      bean.setPhone(request.getParameter("phone"));
	  
      memberDAO dao = new memberDAO();
      
      int check = dao.modifyCheckMember(id, pass);
      System.out.println("check�뒗 "+check);      
      
      if(check != 0){

  		session.setAttribute("pass", pass);

  	
      }else{
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out=response.getWriter();
         out.println("<script>");
         out.println("alert('비밀번호가 틀렸습니다.');");
         out.println("history.back();");
         out.println("</script>");
         out.close();
         
      }
      


		ActionForward forward = new ActionForward();

		forward.setRedirect(true);

		forward.setPath("./MemberModifyGo.me");
		return forward;
   }

}