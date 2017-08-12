package team.member.action;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.member.db.memberBean;
import team.member.db.memberDAO;


public class MemberJoinAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      request.setCharacterEncoding("utf-8");
      
      memberBean dto = new memberBean();
      
      dto.setName(request.getParameter("name"));
      dto.setPass(request.getParameter("pass"));
      dto.setId(request.getParameter("id"));
      dto.setPhone(request.getParameter("phone"));
      dto.setBirth(request.getParameter("birthyy")+"-"+request.getParameter("birthmm")+"-"+request.getParameter("birthdd"));
      //bean.setDel_flag(Integer.parseInt(request.getParameter("del_flag")));
      dto.setGender(Integer.parseInt(request.getParameter("gender")));

      memberDAO dao = new memberDAO();
      int mnum = dao.insertMember(dto);
      
      boolean result = false;
      if(mnum >0 ){
    	  result  = true;
      }
      
      
      String flag[] = request.getParameterValues("default_flag");
      

      Map<String, Object> address = new HashMap<>();
      address.put("post_code", request.getParameter("address1"));
      address.put("address", request.getParameter("address2"));
      address.put("add_detail", request.getParameter("address3"));
      address.put("member_num", mnum);
      
      if(flag != null)
    	  address.put("default_flag", request.getParameterValues("default_flag")[0]);
      else
    	  address.put("default_flag", "n");
      
      dao.insertAddress(address);
      
      if(result == false){
         System.out.println("회원가입에 실패했습니다.");
         return null;
      }else{
    	  response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입되었습니다.');");
			out.println("location.href='./MemberLogin.me'");
			out.println("</script>");
      }
	      ActionForward forward = new ActionForward();
	      
	      forward.setRedirect(false);
	      return null;
   }

}