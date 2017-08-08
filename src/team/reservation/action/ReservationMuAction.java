package team.reservation.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;
import team.musical.db.MusicalBean;
import team.musical.db.MusicalDAO;
import team.place.db.PlaceBean;
import team.place.db.PlaceDAO;
import team.place.db.V_plcaeBean;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationDAO;

public class ReservationMuAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//날짜, 회차, 좌석등급, 잔여석
		String munum = request.getParameter("munum");
		
	    MusicalDAO musicalDao = new MusicalDAO();
	    MusicalBean mub = new MusicalBean();
	    
	    mub = musicalDao.selectMusical(munum);
	    
	    PlaceDAO placeDao = new PlaceDAO();
	    PlaceBean pb = (PlaceBean)placeDao.getPlayingPlace("musical", munum);
	    
	    request.setAttribute("musical", mub);
	    request.setAttribute("place", pb);
	    ActionForward forward=new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("/reservation/reservationMU.jsp");
	   
		return forward;
	}
	

}
