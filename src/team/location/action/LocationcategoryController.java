package team.location.action;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.location.db.LocationDAO;
import team.location.db.LocationListBean;

@WebServlet("/LocationcategoryController.do")
public class LocationcategoryController extends HttpServlet{
	
	protected void requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		String l_category = request.getParameter("l_category");
		String l_category2 = request.getParameter("l_category2");
		
		LocationDAO ldao = new LocationDAO();
		
		Vector<LocationListBean> v = ldao.getCategoryLocationList(l_category, l_category2);
	
		
		request.setAttribute("v", v);
		
		RequestDispatcher view = 
					request.getRequestDispatcher("index.jsp?center=location/LocationList.jsp");
		view.forward(request, response);
		
		
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			requestPro(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			requestPro(request, response);
	}

}