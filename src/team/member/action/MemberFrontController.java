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
				System.out.println("회MemberJoinAction  : "+e);
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
			forward.setRedirect(false);	
			forward.setPath("./member/delete_pop.jsp");
		}
		else if(command.equals("/MemberDeleteAction.me")){
			action = new MemberDeleteAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				System.out.println("MemberDeleteAction : "+e);
			}
		}else if(command.equals("/MemberMail.me")){
	         action = new MemberMailAction();
	         try{
	            forward = action.execute(req, resp);
	         }catch(Exception e){
	            System.out.println("MemberMail :"+e);
	            e.printStackTrace();
	         }
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
	           System.out.println("MemberModifyAction : "+e);
		        }
	     }else if(command.equals("/MemberModifyCheck.me")){
	         action = new MemberModifyCheck();
	         try {
	            forward = action.execute(req, resp);
	         } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println("MemberModifyCheck : "+e);
	         }
	     }else if(command.equals("/MemberModifyConfirm.me")){
	         action = new MemberModifyConfirm();
	         try {
	            forward = action.execute(req, resp);
	         } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println("MemberModifyConfirm : "+e);
	         }
	     }else if(command.equals("/getMemberPoint.me")){
	         action = new getMemberPoint();
	         
	         try {
	            forward = action.execute(req, resp);
	            
	         } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println("getMemberPoint: "+e);
	         }
	     }else if(command.equals("/MemberReservation.me")){
	         action = new MemberReservation();
	         
	         try {
	            forward = action.execute(req, resp);
	            
	         } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println("MemberReservation에서 오류 발생 : "+e);
	         }
			
	     }else if(command.equals("/MemberReservationMv.me")){
	         action = new MemberReservationMv();
	         
	         try {
	            forward = action.execute(req, resp);
	            
	         } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println("MemberReservation에서 오류 발생 : "+e);
	         }
			
	     }else if(command.equals("/ReserveDelete.me")){
				forward = new ActionForward();
				forward.setRedirect(false);	
				forward.setPath("./member/reserveDelete_pop.jsp");
				
			}else if(command.equals("/ReserveDeleteCheck.me")){
	         action = new ReserveDeleteCheck();
	         
	         try {
	            forward = action.execute(req, resp);
	            
	         } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println("ReserveDeleteCheck에서 오류 : "+e);
	         }
			
	     }else if(command.equals("/ReserveConfirm.me")){
				action = new ReserveConfirm();

				try {
					forward = action.execute(req, resp);

				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("ReserveConfirm에서 오류 발생 : " + e);
				}
				
				
			}else if(command.equals("/ReserveConfirmLoc.me")){
				action = new ReserveConfirmLoc();

				try {
					forward = action.execute(req, resp);

				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("ReserveConfirmLoc에서 오류 발생 : " + e);
				}
				
				
			}else if(command.equals("/LocationInfoController.me")){
				forward = new ActionForward();
				forward.setRedirect(false);	
				forward.setPath("./member/LocationInfo.jsp");
				
			}
		
		
		if(forward != null) {
			if(forward.isRedirect()){
				resp.sendRedirect(forward.getPath());
			}else{
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
