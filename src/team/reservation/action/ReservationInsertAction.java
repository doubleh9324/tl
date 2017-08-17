package team.reservation.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import team.member.db.memberDAO;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationBean;
import team.reservation.db.ReservationDAO;

public class ReservationInsertAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//member_num, rseat_num, screen_name는 바로 받아와서 사용
		//pcode, movie_num으로 playing table에서 ping_num 가져오기
		//view_date는 String으로 받아와서 포맷 맞게 고쳐주기
		//price 콤마제거 후 형변환
		
		int member_num = Integer.parseInt(request.getParameter("mnum"));
		String mo_num = request.getParameter("mo_num");
		String pcode = request.getParameter("pcode");
		String screen_name = request.getParameter("screen_name");
		int price = Integer.parseInt(request.getParameter("price").replace(",", ""));
		String viewdate = request.getParameter("viewdate");
		String seat_no = request.getParameter("seat_no");
		String seat = request.getParameter("seat");
		String time = request.getParameter("time");
		int usepoint = Integer.parseInt(request.getParameter("usepoint"));
		String payinfo = request.getParameter("payinfo");
		
		ReservationBean rsb = new ReservationBean();
		ReservationDAO resDao = new ReservationDAO();
		
		int pingnum = resDao.getPingnum(pcode, mo_num, "mo");
		
		rsb.setMember_num(member_num);
		rsb.setPing_num(pingnum);
		rsb.setReseat_num(seat_no);
		rsb.setScreen_name(screen_name);
		rsb.setSeat(seat);
		rsb.setPrice(price);
		rsb.setView_date(viewdate+time+"00");
		int point = (int) Math.round(price*0.005);
		rsb.setMPoint(point);
		rsb.setPayinfo(payinfo+"_point_"+point);
		System.out.println(payinfo);
		//예매 정보 테이블 받아와서 필요한 정보 변환 후 내보내기
		//굳이 이렇게 해야하는걸까
		int rnum = resDao.insertReservation(rsb);
		rsb.setR_num(rnum);
		resDao.insertReservedSeat(rsb);
		
		memberDAO memberDao = new memberDAO();
		memberDao.updateMemberPoint(member_num, point);
		memberDao.updateMemberPoint(member_num, usepoint*(-1));
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("resultRsb", rsb);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservationMV.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
		
	}

	

}
