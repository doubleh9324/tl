package team.reservation.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;

public class DeleteCheckedSeatInfo implements Action{
	@Override
	public ActionForward execute( HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pcode = request.getParameter("pcode");
		String mo_num = request.getParameter("mo_num");
		String screen_name = request.getParameter("screen_name");
		String viewdate = request.getParameter("viewdate");
		String[] seats = request.getParameter("seat").split(" ");
		
		ServletContext application = request.getServletContext();
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> checked = (List<Map<String, Object>>)application.getAttribute("checked");
		
		JSONObject jsonObject = new JSONObject();
		
		//현재 선택한 값과 비교해서 삭제
		System.out.println("리스트 크기 : " +checked.size());
		System.out.println("삭제");
		for(int i=0; i<checked.size(); i++){
			
			boolean isdate = (viewdate.equals((String) checked.get(i).get("viewdate"))? true : false );
			boolean ispcode = (pcode.equals((String) checked.get(i).get("pcode"))? true : false );
			boolean ismo_num = (mo_num.equals((String) checked.get(i).get("mo_num"))? true : false );
			boolean isscreen = (screen_name.equals((String) checked.get(i).get("screen_name"))? true : false );
			System.out.println(checked.get(i).get("viewdate") +" "+ checked.get(i).get("pcode") +" "+ checked.get(i).get("mo_num") + " "+checked.get(i).get("screen_name"));
			boolean same = false;
			
			//해당 날짜시간, pcode, 영화번호, 스크린 이릅이 모두 같으면
			if(isdate && ispcode && ismo_num && isscreen){
				String[] appSeats = (String[]) checked.get(i).get("seats");
				for(int s=0; s<seats.length; s++){
					for(int ss=0; ss<appSeats.length; ss++){
						if(seats[s].equals(appSeats[ss])){
							same = true;
						}
					}
				}
			}
			
			if(same){
				//해당하는 좌석 정보를 찾으면 삭제
				checked.remove(i);
				//삭제되고나면 이후의 index가 한칸씩 옮겨지므로
				i--;
			}
		}
		application.setAttribute("checked", checked);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservationMV.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
	
		
	}
}
