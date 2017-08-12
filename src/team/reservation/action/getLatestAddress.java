package team.reservation.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.member.db.memberDAO;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;

public class getLatestAddress implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int mnum = Integer.parseInt(request.getParameter("mnum"));
		
		memberDAO memberDao = new memberDAO();
		List<Map<String, Object>> addressList = memberDao.getAddressList(mnum);
		
        response.setContentType("application/x-json; charset=utf-8");
		
	    request.setAttribute("addressList", addressList);
	    ActionForward forward=new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("/reservation/LatestAddress.jsp");
	   
		return forward;
	}
}
