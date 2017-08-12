package team.member.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.member.db.memberDAO;

public class insertAddress implements Action {

	   @Override
	   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	      
	      request.setCharacterEncoding("utf-8");
	      
	      int mnum = Integer.parseInt(request.getParameter("mnum"));

	      Map<String, Object> address = new HashMap<>();
	      address.put("post_code", request.getParameter("postcode"));
	      address.put("address", request.getParameter("address"));
	      address.put("add_detail", request.getParameter("add_detail"));
	      address.put("member_num", mnum);
	      address.put("default_flag", "n");
	      
	      memberDAO memberDao = new memberDAO();
	      memberDao.insertAddress(address);
	      
	      ActionForward forward = new ActionForward();
	      forward.setRedirect(false);
	      return null;
	   }
	   
}
