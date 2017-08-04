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

@WebServlet("/LocationListController.do")
public class LocationListController extends HttpServlet {
	
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LocationDAO ldao = new LocationDAO();
		
		Vector<LocationListBean> vector= ldao.getAllLocationlist();
		
		
		request.setAttribute("v", vector);
		
		RequestDispatcher dis = 
				request.getRequestDispatcher("index.jsp?center=location/LocationList.jsp");
		dis.forward(request, response);
		
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		service(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		service(request, response);
	}

}
