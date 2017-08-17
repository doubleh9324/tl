package team.reservation.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationDAO;

public class getOrderReservMoAction2 implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		ReservationDAO dao = new ReservationDAO();
		List reservList = dao.getOrderReservMo2();
		jsonObject.put("setFlag", "y");
	    jsonObject.put("reservList", jsona.fromObject(reservList));
	    
	    forward.setRedirect(false); 
	
	     
        response.setContentType("application/x-json; charset=utf-8");
        response.getWriter().print(jsonObject);
        System.out.println(jsonObject);
		
		return null;
	}

}
