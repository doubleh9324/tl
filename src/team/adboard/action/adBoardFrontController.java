package team.adboard.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class adBoardFrontController extends HttpServlet {
	
	protected void doBoard(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		String requestURL= request.getRequestURI();
		System.out.println(requestURL);
		String contextpath=request.getContextPath();
		System.out.println(contextpath);
		String command=requestURL.substring(contextpath.length());
		System.out.println(command);
		ActionForward forward=null;
		Action action=null;
		
		if(command.equals("/BoardList1.abo")){
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./board/qna_board_list.jsp");
		
		}else if(command.equals("/BoardList.abo")){
			action=  new BoardListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("boardlist.abo controll error");
				e.printStackTrace();
			}
	
		}else if(command.equals("/BoardModifyList.abo")){
			action=  new BoardModifyListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("boardlist.abo controll error");
				e.printStackTrace();
			}
			
		}
		
		
		if(forward != null){// new actionforward()
			if(forward.isRedirect()){//true   
				response.sendRedirect(forward.getPath());
			}else{//false  forward()
				 RequestDispatcher view=request.getRequestDispatcher(forward.getPath());
				view.forward(request, response);
			}		
		}
	}
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doBoard(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doBoard(request, response);
	}	
}
