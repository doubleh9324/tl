

package team.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team.member.action.ActionForward;
import team.member.db.memberBean;
import team.member.db.memberDAO;

public class MemberLoginAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	   ActionForward forward = new ActionForward();  
      String id = request.getParameter("id");
      String pass = request.getParameter("pass");
      
      
      if(id.equals("administrator")&&pass.equals("1234")){
    	  HttpSession session = request.getSession();   
          session.setAttribute("id", id);
          session.setAttribute("member_num", 0);
    	  forward.setRedirect(true);
    	  forward.setPath("board/qna_board_admin.jsp");
    	;
    	  return forward;
      }
  
      
      memberDAO dao = new memberDAO();

      int check = dao.userCheck(id, pass);

      if(check == 0){
         System.out.println("check");
         response.setContentType("text/html; charset=UTF-8"); 
         PrintWriter out = response.getWriter();
         out.println("<script>");
         out.println("alert('비밀번호가 틀렸습니다.');");
         out.println("history.back();");
         out.println("</script>");
         out.close();

         return null;

      
      }else if(check == -1){

         response.setContentType("text/html; charset=UTF-8"); 
         PrintWriter out = response.getWriter();
         out.println("<script>");
         out.println("alert('아이디가 틀렸습니다.');");
         out.println("history.back();");
         out.println("</script>");
         out.close();

      }else{

         memberBean memberBean = dao.getmember(id);         
         HttpSession session = request.getSession();   
         session.setAttribute("id", id);
         session.setAttribute("member_num", memberBean.getMember_num());
         System.out.println("id:"+id);
         System.out.println("member_num:"+memberBean.getMember_num());
       
      }
   
               
         forward.setRedirect(true);   
         forward.setPath("index.jsp");

      return forward;
      
   }
   
}