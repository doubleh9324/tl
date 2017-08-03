package team.review.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.review.db.ReviewBean;
import team.review.db.ReviewDAO;

public class ReviewInsertAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		String id = request.getParameter("id");
		String nc_code = request.getParameter("nc_code");
		String contents= request.getParameter("contents");
		double grade=Double.valueOf(request.getParameter("grade"));
		int member_num =Integer.parseInt(request.getParameter("member_num"));
		System.out.println(id+","+nc_code+","+contents+","+grade+","+member_num);
		ReviewBean bean = new ReviewBean();
		bean.setContents(contents);
		bean.setGrade(grade);
		bean.setId(id);
		bean.setNc_code(nc_code);
		bean.setMember_num(member_num);
		
		ReviewDAO dao=new ReviewDAO();
		dao.insertReview(bean);

	    
	    forward.setRedirect(false); 
	
	     
   
		
		return null;
	}

}
