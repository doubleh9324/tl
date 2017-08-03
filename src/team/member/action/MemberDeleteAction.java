package team.member.action;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team.member.db.memberBean;
import team.member.db.memberDAO;

public class MemberDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberDeleteAction execute()");
	     request.setCharacterEncoding("utf-8");
	      
	      
	      String id=(String)request.getSession().getAttribute("id");
	      
	      memberDAO dao = new memberDAO();
	      int check = dao.deleteMember(id);		
			
			if(check !=0){
			
			//���ǰ� �ʱ�ȭ
			HttpSession session = request.getSession();
			session.invalidate();
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('탈퇴되었습니다');");
			out.println("window.close()");
			out.println("window.opener.location.href='./Index.me'");
			out.println("</script>");
			out.close();
			
			return null;
			
			}else{
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('탈퇴실패');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				
			}
			return null;
		}

	}

