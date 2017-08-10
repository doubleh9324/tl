package team.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team.member.db.memberDAO;

public class ReserveDeleteCheck implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("ReserveDeleteCheck execute()");
      request.setCharacterEncoding("utf-8");

	  HttpSession session = request.getSession();
      String id = request.getParameter("id");
      String r_num = request.getParameter("r_num");
      
      System.out.println(id);
      System.out.println(r_num);

      memberDAO dao = new memberDAO();  
      dao.ReserveDelete(id, r_num);

//		ActionForward forward = new ActionForward();
//		forward.setRedirect(true);
//		
//		forward.setPath("./MemberReservationMv.me");
//		
      response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		out.println("<script>");
		out.println("alert('취소성공');");
		out.println("window.opener.location.reload();");
		out.println("window.close();");
		out.println("</script>");
		out.close();
		return null;
   }

}