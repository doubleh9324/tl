package team.reservation.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationDAO;

public class getReservedSeats implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//pcode, mo_num, screenname 가져오기
		int ping_num = Integer.parseInt(request.getParameter("ping_num"));
		//영화의 경우에만 필요
		String screen_name = request.getParameter("screen_name");
		String view_date = request.getParameter("viewdate")+"00";
		
		//pcode 관 검색(현재 모든 관이 인원수가 같아서 같은 좌석표 제공)
		ReservationDAO resDao = new ReservationDAO();
		
		//ping_num 가져와서 예약된 좌석 목록 가져오기
		List<Map<String, Object>> reserved = resDao.getReservedSeats(ping_num, view_date);
		
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("reservedSeats", reserved);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservationMV.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
	
	}
}
