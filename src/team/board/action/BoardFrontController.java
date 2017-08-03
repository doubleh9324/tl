package team.board.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardFrontController extends HttpServlet {

	protected void doBoard(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		String requestURL= request.getRequestURI();
		System.out.println(requestURL);
		String contextpath=request.getContextPath();
		System.out.println(contextpath);
		String command=requestURL.substring(contextpath.length());
		System.out.println(command);
		
		ActionForward forward=null;
		Action action=null;
		
		if(command.equals("/BoardList1.bo")){
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("index.jsp?center=board/qna_board_list.jsp");
			
			
		}else if(command.equals("/Gomodify.bo")){
			 int q_num = Integer.parseInt(request.getParameter("q_num"));
	         request.setAttribute("q_num", q_num);
			System.out.println(q_num);
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("index.jsp?center=board/qna_board_modify.jsp?q_num="+q_num+"");
			
			
		}else if(command.equals("/BoardInsert.bo")){
			action=new BoardInsertAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("boardinsert controll error");
				e.printStackTrace();
			}
			
			
		}else if(command.equals("/BoardModify.bo")){
			action=new BoardModifyAction();
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			System.out.println(request.getParameter("q_num")+"a");
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("boardmodify controll error");
				e.printStackTrace();
			}
			
			
		}else if(command.equals("/BoardList.bo")){
			action=  new BoardListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("boardlist.bo controll error");
				e.printStackTrace();
			}

			
		}else if(command.equals("/BoardDelete.bo")){// 
	         
	         int q_num = Integer.parseInt(request.getParameter("q_num"));

	         request.setAttribute("q_num", q_num);
	         action = new BoardDeleteAction();
	         try {
	        	 forward =   action.execute(request, response);
	            
	         } catch (Exception e) {
	            System.out.println("boarddelete.bo controll error");
	            e.printStackTrace();
	         }
		
		}else if(command.equals("/BoardView.bo")){//
            
	         int q_num = Integer.parseInt(request.getParameter("q_num"));
	         request.setAttribute("q_num", q_num);  
	         action = new BoardViewAction();
	         try {
	            forward = action.execute(request, response);
	         } catch (Exception e) {
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
