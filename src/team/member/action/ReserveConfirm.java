package team.member.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.member.db.memberBean;
import team.member.db.memberDAO;
import team.reservation.db.ReservationBean;

public class ReserveConfirm implements Action {
	
	

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberReservationMv execute() ");
	      request.setCharacterEncoding("utf-8");
	      
	      String id = (String)request.getSession().getAttribute("id");
	      String r_num = request.getParameter("r_num");
	      memberDAO dao = new memberDAO();
	      int mnum = dao.getMnum(id);
	      memberBean mbean = dao.getmember(id);
	      
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
	    	  Map<String, Object> map = dao.getReservationConfirm(r_num);
	    	  request.setAttribute("rbean", map.get("rbean"));
	    	  request.setAttribute("name", map.get("name"));
	    	  request.setAttribute("image", map.get("image"));
	    	  request.setAttribute("movie_num", map.get("movie_num"));
	    	  request.setAttribute("pname", map.get("pname"));
	    	  request.setAttribute("p_code", map.get("p_code"));
	    	  request.setAttribute("payway", map.get("payway"));
	    	  request.setAttribute("mbean", mbean);
	    	  
	    	  ActionForward forward = new ActionForward();
	    	  forward.setRedirect(false);
	    	  forward.setPath("index.jsp?center=member/reserveConfirm.jsp");
	    	  return forward;
	      }
	      
	      
	
	}

}
