package team.board.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.board.db.BoardBean;
import team.board.db.BoardDao;

public class BoardModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		BoardBean qb= new BoardBean();
		
		qb.setQ_num(Integer.parseInt(request.getParameter("q_num")));//i will kill Q_num.
		qb.setQ_code(request.getParameter("q_code"));
		qb.setTitle(request.getParameter("title"));
		qb.setContents(request.getParameter("contents"));
		qb.setQ_date(new Timestamp(System.currentTimeMillis()));
				
		boolean result = false;			
		BoardDao bdao = new BoardDao();		
		result = bdao.ModifyBoard(qb);		
		
		if(result==false){
			System.out.println("this is boardModifyAction page  hahaha");
			return null;			
		}
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(true);
		forward.setPath("index.jsp?center=board/qna_board_list.jsp");
		return forward;
		
	}

}
