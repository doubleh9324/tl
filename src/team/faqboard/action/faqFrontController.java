package team.faqboard.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




public class faqFrontController extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doPro(req, resp);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPro(req, resp);
	}
	
protected void doPro(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	//가상 요청 주소 가져오기
	String RequestURI = req.getRequestURI();
	System.out.println(RequestURI);	
	
	String ContextPath = req.getContextPath();
	System.out.println(ContextPath);
	System.out.println(ContextPath.length());
	
	String command = RequestURI.substring(ContextPath.length());
	System.out.println(command + "는 커맨드");

	
	/*주소 비교*/
	//페이지 이동방식 여부값, 이동페이지 경로값 저장하여 리턴해주는 객체를 저장할 참조 변수 선언
	ActionForward forward = null;
	
	//자식 Action객체들을 담을 인터페이스 타입의 참조 변수 선언
	Action action = null;
	
	if(command.equals("/FaqSearchAction.fa")){
		action = new FaqSearchAction();
		try{
			forward=action.execute(req, resp);			
		}catch(Exception e){e.printStackTrace();}
		
	}else if(command.equals("/FaqCateAction.fa")){
		action = new FaqSearchAction();
		try{
			forward=action.execute(req, resp);			
		}catch(Exception e){e.printStackTrace();}
	}else if(command.equals("/GetContentsAction.fa")){
		action = new GetContentsAction();
		try{
			forward=action.execute(req, resp);			
		}catch(Exception e){e.printStackTrace();}}
	
	//(실제 주소로 이동)
	if(forward!=null){//new ActionForward()객체가 존재하고
		if(forward.isRedirect()){//true -> sendRedirect()방식
			
			resp.sendRedirect(forward.getPath());
			
		}else{//false -> forward()방식
				RequestDispatcher view = req.getRequestDispatcher(forward.getPath());
				view.forward(req, resp);
			}
		}
	
	
	
	}
}
