package team.musical.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import team.musical.db.MusicalDAO;

public class MusicalGetInfoAction implements Action{
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		String num= request.getParameter("num");
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		MusicalDAO dao = new MusicalDAO();
		List musicalInfo = dao.getMusicalInfo(num);
		
		jsonObject.put("setFlag", "y");
	    jsonObject.put("musicalInfo", jsona.fromObject(musicalInfo));
	    
	    forward.setRedirect(false); 
	
        response.setContentType("application/x-json; charset=utf-8");
        response.getWriter().print(jsonObject);
		
		return null;
	}
}
