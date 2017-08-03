package team.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberLogoutAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

	
		HttpSession session = request.getSession();
		String id=(String)session.getAttribute("id");
		if(id.equals("administrator")){
			session.invalidate();
			
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자 로그아웃되었습니다.');");
			out.println("location.href='index.jsp'");
			out.println("</script>");
			out.close();
		}else{
			session.invalidate();
			
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그아웃되었습니다.');");
			out.println("location.href='index.jsp'");
			out.println("</script>");
			out.close();
			
		}
		
		return null;
	}

}
