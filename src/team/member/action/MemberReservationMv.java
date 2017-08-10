package team.member.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.member.db.memberBean;
import team.member.db.memberDAO;
import team.reservation.db.ReservationBean;

public class MemberReservationMv implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("MemberReservationMv execute() ");
      request.setCharacterEncoding("utf-8");
      
      String id = (String)request.getSession().getAttribute("id");
      memberDAO dao = new memberDAO();
      int mnum = dao.getMnum(id);
      memberBean bean = dao.getmember(id);
      String day = request.getParameter("BYear")+"-"+request.getParameter("BMonth")+"-";
      String option = request.getParameter("Option");
      
      
      if(id==null){
    	  response.setContentType("text/html; charset=UTF-8");
    	  PrintWriter out = response.getWriter();
    	  out.println("<script>");
    	  out.println("alert('로그인해주세요.');");
    	  out.println("location.href='./MemberLogin.me'");
    	  out.println("</script>");
    	  out.close();
    	  
    	  return null;
    	  
      }else{
    	  ArrayList<ReservationBean> list = dao.getReservation(mnum, day, option);
    	  request.setAttribute("bean", bean);
    	  request.setAttribute("list", list);
    	  
    	  ActionForward forward = new ActionForward();
    	  forward.setRedirect(false);
    	  forward.setPath("index.jsp?center=member/reserveCheckMv.jsp");
    	  return forward;
      }
      
      
      }
   }

