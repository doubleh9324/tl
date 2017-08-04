package team.location.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import team.location.db.LocationDAO;
import team.location.db.LocationListBean;
import team.reservation.db.ActionForward;

@WebServlet("/LocationInfoController.do")
public class LocationInfoController extends HttpServlet {
	
	protected void pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
			int l_num =    Integer.parseInt(request.getParameter("l_num"));
			LocationDAO ldao = new LocationDAO();
			
			LocationListBean locationListBean = ldao.getOneLocation(l_num);
			
			
			JSONObject jsonObject = new JSONObject();
			
			jsonObject.put("bean", locationListBean);
			
			ActionForward forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("index.jsp?center=location/LocationList.jsp");
			
			response.setContentType("application/x-json; charset=utf-8");
			response.getWriter().print(jsonObject);
			
		//	RequestDispatcher dis = 
		//			request.getRequestDispatcher("index.jsp?center=location/LocationList.jsp");
		//	dis.forward(request, response);
			
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		pro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		pro(request, response);
	}

}
