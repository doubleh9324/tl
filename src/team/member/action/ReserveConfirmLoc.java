package team.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import team.location.db.LocationListBean;
import team.location.db.LocationDAO;
import team.member.db.memberDAO;
import team.member.action.ActionForward;

public class ReserveConfirmLoc implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReserveConfirmLoc execute()");
		request.setCharacterEncoding("utf-8");
		
		String id = (String)request.getSession().getAttribute("id");
		String pname = request.getParameter("pname");
		System.out.println(pname);
		
		memberDAO dao = new memberDAO();
		LocationListBean lbean = dao.getReserveMvLoc(pname);
		request.setAttribute("bean", lbean);
		
		
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("bean", lbean);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("index.jsp?center=member/LocationInfo.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return forward;
	}

}
