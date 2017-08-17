package team.musical.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.musical.db.MusicalDAO;

public class MusicalSoonAction implements Action {
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		int count = Integer.parseInt(request.getParameter("count"));
		System.out.println("뮤지컬 soon");
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		MusicalDAO dao = new MusicalDAO();
		List soonList = dao.getSoonMusicals(count);
		List soonLength = dao.getSoonMusicalsLength();
		
		jsonObject.put("setFlag", "y");
	    jsonObject.put("soonList", jsona.fromObject(soonList));
	    jsonObject.put("soonLength", jsona.fromObject(soonLength));
	    
	    forward.setRedirect(false); 
	
	     
	    response.setContentType("application/x-json; charset=utf-8");
	    response.getWriter().print(jsonObject);
	    System.out.println(jsonObject);
		
		return null;
	}
}
