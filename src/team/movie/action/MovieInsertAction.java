package team.movie.action;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import action.ActionForward;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;

public class MovieInsertAction implements Action{

	
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String postername=new String();
		int max = 10*1024*1024;
		String path="D:\\TeamWorkspace\\TeamProject\\WebContent\\MovieImage";
		MultipartRequest multi = new MultipartRequest(request,path ,max,"utf-8", new DefaultFileRenamePolicy());
		

		Enumeration e = multi.getFileNames();
		while(e.hasMoreElements()){
		    String filename=(String)e.nextElement();
		    String saveFiles=multi.getFilesystemName(filename);//占쏙옙占쏙옙占쏙옙 占쏙옙占싸듸옙占� 占쏙옙占쏙옙占쏙옙 占싱몌옙
		    postername=saveFiles;
		}
		
		MovieBean mb = new MovieBean();
		mb.setMovie_num(multi.getParameter("movie_num"));
		mb.setG_code(multi.getParameter("g_code"));
		mb.setName(multi.getParameter("name"));
		mb.setDirector(multi.getParameter("director"));
		mb.setOpen_day(multi.getParameter("open_day"));
		mb.setActor(multi.getParameter("actor"));
		mb.setProduction(multi.getParameter("production"));
		mb.setAge(multi.getParameter("age"));
		mb.setContents(multi.getParameter("contents"));
		mb.setImage(postername);
		mb.setVideo(multi.getParameter("video"));
		
		
		boolean result=false;
		MovieDAO dao = new MovieDAO();
		result = dao.insertMovie(mb);
		
		if(result==false){
			System.out.println("占쏙옙화 占쌩곤옙 占쏙옙占쏙옙");
			return null;
		}
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(true);
		
		forward.setPath("admin/admin_index.jsp");
		
		return forward;
	}

}
