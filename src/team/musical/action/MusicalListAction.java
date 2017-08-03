package team.musical.action;

import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;
import team.musical.db.MusicalBean;
import team.musical.db.MusicalDAO;

public class MusicalListAction implements Action{


	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MusicalDAO dao= new MusicalDAO();
		List<MusicalBean> musicalList = dao.getAllMusicals();
		
	
	    
	    request.setAttribute("musicalList", musicalList);
		//request.setAttribute("movieList", movieList);
	    ActionForward forward=new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("index.jsp?center=musical/allmusical.jsp"); 
		
		return forward;
	}

	
}
