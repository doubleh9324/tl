
package team.board.action;

import java.io.IOException;

import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import team.board.db.BoardBean;
import team.board.db.BoardDao;


public class BoardInsertAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      request.setCharacterEncoding("UTF-8");   
      BoardBean qb= new BoardBean();
      
      qb.setMember_num((int)request.getSession().getAttribute("member_num")); 
      qb.setQ_code(request.getParameter("q_code"));
      qb.setTitle(request.getParameter("title"));
      qb.setContents(request.getParameter("contents"));
      qb.setQ_date(new Timestamp(System.currentTimeMillis()));
      
      boolean result = false;
         
      BoardDao bdao = new BoardDao();
      
      result = bdao.insertBoard(qb);
      
         
      if(result==false){
         System.out.println("it is boardinsertAction error");
         return null;
         
      }
      
      ActionForward forward = new ActionForward();
      
      forward.setRedirect(true);
      forward.setPath("index.jsp?center=board/qna_board_list.jsp");
      return forward;
      
   }

}