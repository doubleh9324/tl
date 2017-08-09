package team.movie.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.movie.db.MovieDAO;

public class MovieSoonAction implements Action {

	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		MovieDAO dao = new MovieDAO();
		List soonList = dao.getSoonMovies();
		List soonLength = dao.getSoonMoviesLength();
		
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
