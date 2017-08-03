package team.adboard.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.adboard.db.AdBoardBean;
import team.adboard.db.AdBoardDao;

public class BoardModifyListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		
		AdBoardDao bdo= new AdBoardDao();
		List<AdBoardBean> arr= new ArrayList<AdBoardBean>();
		
		int pnum = Integer.parseInt(request.getParameter("pnum"));
		int start = 0;
		
		if(pnum == 1){
			
		}else{
			start = (pnum-1) * 5;
		}
		
		arr = bdo.ModifyListBoard(start, 5);					
		int total = bdo.selectTotalCount(1);									
	
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("arr", jsona.fromObject(arr));
		jsonObject.put("total", total);
		jsonObject.put("pcount",5);		
		jsonObject.put("num",pnum);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./ajaxlist.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		System.out.println(jsonObject);
		
		
		return null;
	}

}
