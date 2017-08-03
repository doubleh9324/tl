package team.reboard.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.reboard.db.ReBoardBean;
import team.reboard.db.ReBoardDao;


public class ReBoardModifyAction extends HttpServlet implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      request.setCharacterEncoding("UTF-8");
      ReBoardBean rb= new ReBoardBean();
      
      rb.setQ_num(Integer.parseInt(request.getParameter("q_num")));
      rb.setContents(request.getParameter("contents"));
      rb.setRe_date(new Timestamp(System.currentTimeMillis()));
      
      boolean result = false;      
      ReBoardDao bdao = new ReBoardDao();
      
      result = bdao.ModifyReboard(rb);
      
      if(result==false){
         System.out.println("ModifyAction error");
         return null;
         
      }else{
         response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('수정 성공');");
            out.println("location.href='board/qna_board_admin_modify.jsp'");      
            out.println("</script>");
      
      ActionForward forward = new ActionForward();         
      forward.setRedirect(false);   
      forward.setPath("board/qna_board_admin_modify.jsp");
      return forward;
      }    
   } 
}