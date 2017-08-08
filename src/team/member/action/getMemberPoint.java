package team.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;
import team.member.db.memberDAO;

public class getMemberPoint implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("getMemberPoint execute()");
		request.setCharacterEncoding("utf-8");
      
		int member_num= Integer.parseInt(request.getParameter("member_num"));	      
		memberDAO dao = new memberDAO();
		int point = dao.getMemberPoint(member_num);		
				
		JSONObject jsonObject = new JSONObject();
				
		jsonObject.put("point", point);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservationMV.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
			
		return null;	
}

}
