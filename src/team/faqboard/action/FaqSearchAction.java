package team.faqboard.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.faqboard.db.faqBean;
import team.faqboard.db.faqDao;


public class FaqSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String keyword = request.getParameter("keyword");
		System.out.println("ActionForward 의 keyword : " +  keyword);
		faqDao faqdao = new faqDao();
		ArrayList<faqBean> faqList = faqdao.search(keyword);
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("total", faqList.size());
		jsonObject.put("faqList", jsona.fromObject(faqList));
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);

		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		System.out.println(jsonObject);
		
		return null;
	}
}
