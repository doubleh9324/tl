package team.movie.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.movie.db.MovieDAO;

public class MovieGetInfoAction implements Action{
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		String num= request.getParameter("num");
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		MovieDAO dao = new MovieDAO();
		List movieInfo = dao.getMovieInfo(num);
		
		jsonObject.put("setFlag", "y");
	    jsonObject.put("movieInfo", jsona.fromObject(movieInfo));
	    
	    forward.setRedirect(false); 
	
        response.setContentType("application/x-json; charset=utf-8");
        response.getWriter().print(jsonObject);
		
		return null;
	}
}
