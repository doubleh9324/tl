package team.reservation.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.xml.sax.HandlerBase;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationDAO;

public class getTimeSeat implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String munum = request.getParameter("munum");
		String date = request.getParameter("date");
		
		ActionForward forward =new ActionForward();
		JSONObject jsonObject = new JSONObject();
		
		ReservationDAO dao = new ReservationDAO();
		
		List<Map<String, Object>> timeseatList = new ArrayList<>();
		
		timeseatList = dao.getTimeMu(munum, date);
		
		for(int i=0; i< timeseatList.size(); i++){
			Map<String, Object> tempMap = timeseatList.get(i);
			String sclass = (String) tempMap.get("seatclass");
			
			switch(sclass){
			case "VIP":
				timeseatList.get(i).put("price", "143000");
				break;
			case "R":
				timeseatList.get(i).put("price", "132000");
				break;
			case "S":
				timeseatList.get(i).put("price", "111000");
				break;
			}
			
		}
	    jsonObject.put("timeseatList", timeseatList);
	    
	    forward.setRedirect(false); 
	     
        response.setContentType("application/x-json; charset=utf-8");
        response.getWriter().print(jsonObject);
        System.out.println(jsonObject);
		
		return null;
	}
}
