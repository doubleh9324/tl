package action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.movie.db.MovieDAO;
import team.musical.db.MusicalDAO;

@WebServlet("/GanreAction.ga")
public class GanreAction extends HttpServlet {

	protected ActionForward doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		String g_code = req.getParameter("g_code");
		String cate = req.getParameter("cate");
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		List ganreResult=null;
		
		   
		if(cate.equals("mo")){
			MovieDAO dao = new MovieDAO();
			ganreResult = dao.searchMovieGanre(g_code);
		}else{
			MusicalDAO dao2 = new MusicalDAO();
			ganreResult= dao2.searchMusicalGanre(g_code);
		}
		
		jsonObject.put("setFlag", "y");
		jsonObject.put("ganreResult", jsona.fromObject(ganreResult));
		     

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
