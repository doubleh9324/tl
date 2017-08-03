package team.member.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberFrontController extends HttpServlet {
	
	
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	
		String RequestURI = req.getRequestURI();
		System.out.println(RequestURI);
		
		
		String contextPath = req.getContextPath();
		
		
		System.out.println(contextPath.length());
		
		

		String command = RequestURI.substring(contextPath.length());
		System.out.println(command);
		

		
		ActionForward forward = null;
		
		Action action = null;
		
		if(command.equals("/MemberJoin.me")){
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("index.jsp?center=member/join.jsp");
			
		
		}else if(command.equals("/MemberJoinAction.me")){
			
			action = new MemberJoinAction();
			
			try{				
				forward = action.execute(req, resp);
				
			} catch (Exception e) {
				System.out.println("회占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 : "+e);
				
			}
			
		}else if (command.equals("/MemberLogin.me")){
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("index.jsp?center=member/login.jsp");
			
			
			
		}else if(command.equals("/MemberLoginAction.me")){
			
			action = new MemberLoginAction();
			try {
				
			forward = action.execute(req, resp);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		
		}else if(command.equals("/MemberLogout.me")){
			
			action = new MemberLogoutAction();
			try {
				
				forward = action.execute(req, resp);
					
				} catch (Exception e) {
					e.printStackTrace();
					
				}
			
		
		}else if(command.equals("/Index.me")){
		
			forward = new ActionForward();
			forward.setRedirect(false);	
			forward.setPath("index.jsp");
				
		}
		else if(command.equals("/MemberDelete.me")){
			forward = new ActionForward();
			forward.setRedirect(false);	//占쌍소곤옙 占쏙옙占쏙옙 X
			forward.setPath("./member/delete_pop.jsp");
			
		}
		else if(command.equals("/MemberDeleteAction.me")){
			
			action = new MemberDeleteAction();
			
			try {
				forward = action.execute(req, resp);
				
			} catch (Exception e) {
				System.out.println("탈占쏙옙 占쏙옙占쏙옙 : "+e);
			}
			
			
		}else if(command.equals("/MemberMail.me")){
	         action = new MemberMailAction();
	         
	         try{
	            forward = action.execute(req, resp);
	         }catch(Exception e){
	            System.out.println("占쏙옙占쏙옙 占쏙옙占쏙옙"+e);
	            e.printStackTrace();
	         }
	         
	         
	      /* 회占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 */   
	      }else if(command.equals("/MemberModify.me")){
        action = new MemberModify();
        try {
           forward=action.execute(req, resp);
        } catch (Exception e) {
           e.printStackTrace();
        }
     
     }else if(command.equals("/MemberModifyGo.me")){
         action = new MemberModifyGo();
         try {
            forward=action.execute(req, resp);
         } catch (Exception e) {
            e.printStackTrace();
         }
	      
			
         }else if(command.equals("/MemberModifyAction.me")){
        action = new MemberModifyAction();
        
        try {
           forward = action.execute(req, resp);
           
        } catch (Exception e) {
           e.printStackTrace();
           System.out.println("MemberModifyAction�뿉�꽌 �떎�뙣 : "+e);
        }
		
     }else if(command.equals("/MemberModifyCheck.me")){
         action = new MemberModifyCheck();
         
         try {
            forward = action.execute(req, resp);
            
         } catch (Exception e) {
            e.printStackTrace();
            System.out.println("MemberModifyCheck�뿉�꽌 �떎�뙣 : "+e);
         }
		
     }else if(command.equals("/MemberModifyConfirm.me")){
         action = new MemberModifyConfirm();
         
         try {
            forward = action.execute(req, resp);
            
         } catch (Exception e) {
            e.printStackTrace();
            System.out.println("MemberModifyConfirm�뿉�꽌 �떎�뙣 : "+e);
         }
		
     }
		//(占쏙옙占쏙옙 占쌍소뤄옙 占싱듸옙)
			if(forward != null) {	// 
					
				if(forward.isRedirect()){	//true ->sendredirect占쏙옙占�
						
					resp.sendRedirect(forward.getPath());
				}else{	//false ->forward 占쏙옙占�
					
					RequestDispatcher view = req.getRequestDispatcher(forward.getPath());
					view.forward(req, resp);
				}
					
			
			
			}

	}


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doProcess(req, resp);
	}
	
	
	
	

}
