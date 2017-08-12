package team.reservation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import team.member.db.memberDAO;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationBean;
import team.reservation.db.ReservationDAO;

public class MuReservationInsertAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//member_num, rseat_num, screen_name는 바로 받아와서 사용
		//pcode, movie_num으로 playing table에서 ping_num 가져오기
		//view_date는 String으로 받아와서 포맷 맞게 고쳐주기
		//price 콤마제거 후 형변환
		
		int member_num = Integer.parseInt(request.getParameter("mnum"));
		int pingnum = Integer.parseInt(request.getParameter("pingnum"));
		String screen_name = request.getParameter("screen_name");
		int price = Integer.parseInt(request.getParameter("price"));
		String viewdate = request.getParameter("viewdate");
		String seat_no = request.getParameter("seat_no");
		String seat = request.getParameter("seat");
		int usepoint = Integer.parseInt(request.getParameter("usepoint"));
		String payinfo = request.getParameter("payinfo");
		String grade = request.getParameter("grade").replace("석", "");
		
		ReservationBean rsb = new ReservationBean();
		ReservationDAO resDao = new ReservationDAO();
		
		rsb.setMember_num(member_num);
		rsb.setPing_num(pingnum);
		rsb.setReseat_num(seat_no);
		rsb.setScreen_name(screen_name);
		rsb.setSeat(seat);
		rsb.setPrice(price);
		rsb.setView_date(viewdate+":00");
		int point = (int) Math.round(price*0.002);
		rsb.setMPoint(point);
		rsb.setPayinfo(payinfo+"_point_"+point);
		System.out.println(payinfo);
		
		//reservation table insert 후에 reserved_seat insert
		int rnum = resDao.insertReservation(rsb);
		rsb.setR_num(rnum);
		resDao.insertReservedSeat(rsb, grade);
		
		//포인트 적용
		memberDAO memberDao = new memberDAO();
		memberDao.updateMemberPoint(member_num, point);
		memberDao.updateMemberPoint(member_num, usepoint*(-1));
		
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("reservation", rsb);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservationMU.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
		
	}

	

}
