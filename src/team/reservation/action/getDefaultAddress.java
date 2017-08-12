package team.reservation.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import team.member.db.memberDAO;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;

public class getDefaultAddress implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int mnum = Integer.parseInt(request.getParameter("mnum"));
		
		memberDAO memberDao = new memberDAO();
		Map<String, Object> defaultAdd = memberDao.getDefaultAddress(mnum);
		
		JSONObject jsonObject = new JSONObject();
		
        if(defaultAdd == null){
    	    jsonObject.put("de", "n");
        }else{
        	jsonObject.put("de", "y");
        	jsonObject.put("defaultAdd", defaultAdd);
        }
	    
	    ActionForward forward=new ActionForward();
	    forward.setRedirect(false); 
	     
        response.setContentType("application/x-json; charset=utf-8");
        response.getWriter().print(jsonObject);
        System.out.println(jsonObject);
		
		return null;
	}
}
