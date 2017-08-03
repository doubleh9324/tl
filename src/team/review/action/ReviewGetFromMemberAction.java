package team.review.action;
import java.util.ArrayList;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import team.review.db.ReviewDAO;


public class ReviewGetFromMemberAction implements Action {
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		ReviewDAO dao = new ReviewDAO();
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		String id=(String)request.getSession().getAttribute("id");
		int p_num = Integer.parseInt(request.getParameter("p_num"));
		String cate = request.getParameter("cate");
		int member_num = (int)request.getSession().getAttribute("member_num");
		
		System.out.println(id+","+p_num+","+cate+","+member_num);
		List reviews;
		int count=0;
		if(cate.equals("mo")){
			 reviews = dao.getReviewMovie(id, p_num,member_num);
			 count=dao.getReviewMovieCount(id,member_num);
		}else{
			 reviews = dao.getReviewMusical(id, p_num,member_num);
			 count=dao.getReviewMusicalCount(id,member_num);
		}
		
		int page_count=(count/15)+(count%15==0? 0:1);
		List page_count_list = new ArrayList();
		for(int i=0;i<page_count;i++){
			page_count_list.add(i+1);
		}
		
		
		
		jsonObject.put("setFlag", "y");
	    jsonObject.put("reviews", jsona.fromObject(reviews));
	    jsonObject.put("page_count", jsona.fromObject(page_count_list));


	
	    
	    response.setContentType("application/x-json; charset=utf-8");
	    response.getWriter().print(jsonObject);
	    System.out.println(jsonObject);
	        
		ActionForward forward=new ActionForward();
	    forward.setRedirect(false);
	
	    return null;
	}

}
