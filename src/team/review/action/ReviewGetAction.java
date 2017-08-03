package team.review.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.review.db.ReviewDAO;


public class ReviewGetAction implements Action{


	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		String nc_code = request.getParameter("nc_code");
		int p_num =Integer.parseInt(request.getParameter("p_num"));
		//String member_num = (String)request.getSession().getAttribute("member_num");
		
		System.out.println(nc_code+" "+p_num);
		
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();

		ReviewDAO dao=new ReviewDAO();
		List review = dao.getReview(nc_code,p_num);
		int count = dao.getReviewCount(nc_code);
		int page_count = (count/10)+(count%10==0? 0:1);
		List page_count_list = new ArrayList();
		for(int i=0;i<page_count;i++){
			page_count_list.add(i+1);
		}
		
		
		
		jsonObject.put("setFlag", "y");
	    jsonObject.put("review", jsona.fromObject(review));
	    jsonObject.put("page_count", jsona.fromObject(page_count_list));
	    
	    forward.setRedirect(false); 
	
	     
        response.setContentType("application/x-json; charset=utf-8");
        response.getWriter().print(jsonObject);
        System.out.println(jsonObject);
		
		return null;
	}

}
