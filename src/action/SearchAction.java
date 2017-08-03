package action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.omg.CORBA.Request;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;
import team.musical.db.MusicalDAO;

@WebServlet("/SearchAction.sc2")
public class SearchAction extends HttpServlet{
	
	protected ActionForward doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		String search = req.getParameter("search");
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		   
		MovieDAO dao = new MovieDAO();
		List movieSearch = dao.searchMovie(search);
		MusicalDAO dao2 = new MusicalDAO();
		List musicalSearch= dao2.searchMusical(search);
		jsonObject.put("setFlag", "y");
		jsonObject.put("movieSearch", jsona.fromObject(movieSearch));
		jsonObject.put("musicalSearch", jsona.fromObject(musicalSearch));
		     

	      forward.setRedirect(false);
	      
	      resp.setContentType("application/x-json; charset=utf-8");
	      resp.getWriter().print(jsonObject);
	      System.out.println(jsonObject);
		
		return null;
	}
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
	
}
