package team.reboard.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReBoardFrontController extends HttpServlet {

	protected void doReBoard(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		String requestURL= request.getRequestURI();
		System.out.println(requestURL);
		String contextpath=request.getContextPath();
		System.out.println(contextpath);
		String command=requestURL.substring(contextpath.length());
		System.out.println(command);
		ActionForward forward=null;
		Action action=null;
		
		if(command.equals("/ReBoardList.bo")){
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./reply_board/qna_board_list.jsp");//
			
		}else if(command.equals("/ReBoardInsert.rbo")){

			action=new ReBoardInsertAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				System.out.println("ReboardInsert controll error");
				e.printStackTrace();
			}
			
		}else if(command.equals("/ReBoardModify.rbo")){

			action=new ReBoardModifyAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				System.out.println("ReboardModify controll error");
				e.printStackTrace();
			}	
			
		}else if(command.equals("/ReBoardDelete.rbo")){
	         int q_num = Integer.parseInt(request.getParameter("q_num"));
	         request.setAttribute("q_num", q_num);
	         action=new ReBoardDeleteAction();
	         try {
	            action.execute(request, response);
	         } catch (Exception e) {
	            System.out.println("ReBoardDelete Controller Error");
	            e.printStackTrace();
	         }
	      }
		
		
		if(forward != null){// new actionforward() ��ü�� ����
			
			if(forward.isRedirect()){//true �϶�  -> ������ �ּҰ�� ����  
				response.sendRedirect(forward.getPath());
			}else{//false �϶�  forward()��� -> ������ �ּҰ�� ���� ���� 
				 RequestDispatcher view=request.getRequestDispatcher(forward.getPath());
				view.forward(request, response);
			}			
		}	
	}	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doReBoard(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doReBoard(request, response);
	}

	
}
