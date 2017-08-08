package team.board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.board.db.BoardDao;


public class BoardDeleteAction extends HttpServlet implements Action{
   
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  
      int q_num = Integer.parseInt(request.getParameter("q_num"));
      BoardDao bd = new BoardDao();
      int result = bd.deleteBoard(q_num);
      
      if(result !=0){
         
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         out.println("<script>");
         out.println("alert('delete complete');");
         out.println("location.href='index.jsp?center=board/qna_board_list.jsp'");      
         out.println("</script>");
         
      }else{
         
         request.setAttribute("result", result);
         
         RequestDispatcher dis = request.getRequestDispatcher("./qna_board_list.jsp");
         dis.forward(request, response);
      
      }
      return null;
      
   }
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      execute(request, response);
   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      execute(request, response);
   }

}
