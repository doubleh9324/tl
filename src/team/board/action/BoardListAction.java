
package team.board.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.board.db.BoardBean;
import team.board.db.BoardDao;

public class BoardListAction implements Action{

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      
      BoardDao bdo= new BoardDao();
      List<BoardBean> arr= new ArrayList<BoardBean>();
      
      int member_num = (int) request.getSession().getAttribute("member_num");
      int pnum = Integer.parseInt(request.getParameter("pnum"));
      int start = 0;
      
      if(pnum == 1){
         
      }else{
         start = (pnum-1) * 5;
      }
      
      arr = bdo.ListBoard(start, 5, member_num);
      int total = bdo.selectTotalCount(member_num);
      
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