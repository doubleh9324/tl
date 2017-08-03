package team.board.action;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import team.board.db.BoardBean;
import team.board.db.BoardDao;
import team.reboard.db.ReBoardBean;
import team.reboard.db.ReBoardDao;
public class BoardViewAction implements Action {
   
   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {  
	   		
	   		int q_num = Integer.parseInt(request.getParameter("q_num"));
	   		BoardDao bd = new BoardDao();
	   		BoardBean bb = new BoardBean();
	      	bb = bd.viewBoard(q_num);
	      	request.setAttribute("bb", bb);
      	
	      	///////////// reply part //////////////	

	      	ReBoardDao rbd = new ReBoardDao();
	        ReBoardBean rbb = new ReBoardBean();
	        rbb = rbd.viewReplyBoard(q_num);    
	         	
	        if(rbb.isEmpty()){            
	            request.setAttribute("rbbRe", "n");
	        }else{
	            request.setAttribute("rbb", rbb);
	            System.out.println("BoardViewAction rbb q_num="+rbb.getQ_num());
	        }
	      	//////////////////////////////////////
	      		      	
	        ActionForward forward = new ActionForward();
	      	forward.setRedirect(false);
	      	forward.setPath("index.jsp?center=board/qna_board_view.jsp");
	      	return forward;
   }
}
