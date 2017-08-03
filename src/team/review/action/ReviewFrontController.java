package team.review.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;


public class ReviewFrontController extends HttpServlet {
	
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String RequestURI=req.getRequestURI();
		System.out.println(RequestURI);
		
		String contextPath=req.getContextPath();
		System.out.println(contextPath.length());
		
		String command = RequestURI.substring(contextPath.length());
		System.out.println(command);
		
		ActionForward forward = null;
		Action action= null;
		
		if(command.equals("/ReviewGetAction.rv")){
			action = new ReviewGetAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ReviewInsertAction.rv")){
			action = new ReviewInsertAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ReviewGetFromMemberAction.rv")){
			action = new ReviewGetFromMemberAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ReviewGetFromMember.rv")){
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("index.jsp?center=member/memberReview.jsp");
		}
		
		
		
	
		if(forward!=null){
			if(forward.isRedirect()){
				resp.sendRedirect(forward.getPath());
			}else{ 
				RequestDispatcher view = req.getRequestDispatcher(forward.getPath());
				view.forward(req, resp);
			}
		
		}
	}
		
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
}
