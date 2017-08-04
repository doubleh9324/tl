package team.movie.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.musical.db.MusicalBean;

public class MovieDAO {
	
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Ticketlion");
		con=ds.getConnection();
		return con;
	}
	/*public Vector<MovieBean> playingMovies(){
		Vector<MovieBean> v= new Vector<MovieBean>();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			sql="select m1.movie_num, m1.name, m1.open_day, m2.image from movie m1,movie_detail m2 where m1.movie_num=m2.movie_num and curdate()<=date_add(m1.open_day, interval 1 month) and curdate()>=m1.open_day order by 1";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MovieBean mb= new MovieBean();
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setOpen_day(rs.getString("open_day"));
				v.add(mb);
			}
		}catch(Exception e){
			System.out.println("playingMovies�뿉�꽌 �삤瑜�: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return v;
	}*/
	
	
	public List playingMoviesHasPick4Length(){
		ArrayList length= new ArrayList();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			sql="select count(*) from movie m1, movie_detail m2 where m1.movie_num = m2.movie_num and curdate()<=date_add(m1.open_day, interval 1 month) and curdate()>=m1.open_day  and  m2.image != 'default-image.jpg'";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				length.add("{length:"+rs.getString(1)+"}");
			}
		}catch(Exception e){
			System.out.println("playingMoviesHasPick4Length�뿉�꽌 �삤瑜�: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return length;
	}
	
	
	public List playingMoviesPick4(int count){
		 ArrayList movieList= new ArrayList();
		
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			
			sql="select m1.movie_num, m1.name, m1.open_day, m2.image from movie m1,movie_detail m2 where m1.movie_num=m2.movie_num "
					+ "and curdate()<=date_add(m1.open_day, interval 1 month) and curdate()>=m1.open_day and m2.image != 'default-image.jpg' order by 3 limit ?,4";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MovieBean mb= new MovieBean();
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setOpen_day(rs.getString("open_day"));
				movieList.add(mb);
				
			}
		}catch(Exception e){
			System.out.println("playingMoviesPick4�뿉�꽌 �삤瑜�: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return movieList;
	}
	
	public List<MovieBean> getAllMovies(){
		ArrayList<MovieBean> movieList= new ArrayList<MovieBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		
		try{
			con=getConnection();
			sql="select m1.movie_num,m1.name, m2.image from movie m1,movie_detail m2 where m1.movie_num=m2.movie_num order by 3 asc,2 asc";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				do{
					MovieBean mb = new MovieBean();
					mb.setMovie_num(rs.getString("movie_num"));
					mb.setName(rs.getString("name"));
					mb.setImage(rs.getString("image"));
					movieList.add(mb);
				}while(rs.next());
				return movieList;
			}else{
				return Collections.emptyList();
			}
			
		}catch(Exception e){
			System.out.println("getAllMovies�뜝�럥�뱺�뜝�럡�맋 �뜝�럩沅롳옙紐닷뜝占�: "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
		return Collections.emptyList();
	}
	
	public List<MovieBean> getSoonMovies(int count){
		ArrayList<MovieBean> soonList= new ArrayList<MovieBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		
		try{
			con=getConnection();
			sql="select m.movie_num, m2.image, m.open_day from movie m , movie_detail m2 where m.movie_num=m2.movie_num and open_day> curdate() and m2.image!='default-image.jpg' order by 3 limit ?,4";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			rs=pstmt.executeQuery();
			if(rs.next()){
				do{
					MovieBean mb = new MovieBean();
					mb.setMovie_num(rs.getString("movie_num"));
					mb.setImage(rs.getString("image"));
					soonList.add(mb);
				}while(rs.next());
				return soonList;
			}else{
				return Collections.emptyList();
			}
			
		}catch(Exception e){
			System.out.println("getSoonMovies에서 오류: "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
		return Collections.emptyList();
	}
	
	public List getSoonMoviesLength(){
		ArrayList length= new ArrayList();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			sql="select count(*) from movie m1, movie_detail m2 where m1.movie_num = m2.movie_num and m1.open_day>curdate()  and  m2.image != 'default-image.jpg'";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				length.add("{length:"+rs.getString(1)+"}");
			}
		}catch(Exception e){
			System.out.println("getSoonMoviesLength에서 오류: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return length;
	}
	
	public boolean insertMovie(MovieBean mb){
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		int count=0;
		int result=0;
		try{
			con=getConnection();
			sql="select count(movie_num) from movie";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				count=rs.getInt(1)+1;
			}else count=1;
			
			sql="insert into movie(movie_num,g_code,name,director,open_day,actor,production,age)"
				+" values(?,?,?,?,?,?,?,?)";
				
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, mb.getG_code());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getDirector());
			pstmt.setString(5, mb.getOpen_day());
			pstmt.setString(6, mb.getActor());
			pstmt.setString(7, mb.getProduction());
			pstmt.setString(8, mb.getAge());
			pstmt.executeUpdate();
			
			sql="insert into movie_detail(movie_num,g_code,contents,image,video)"
					+" values(?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, mb.getG_code());
			pstmt.setString(3, mb.getContents());
			pstmt.setString(4, mb.getImage());
			pstmt.setString(5, mb.getVideo());
			result=pstmt.executeUpdate();
			if(result!=0){
				return true;
			}
		}catch(Exception e){
			System.out.println("insertMovie占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 : "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return false;
	}
	
	public MovieBean selectMovie(String movie_num){
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		MovieBean mb = null;
		String sql="";
		try{
			con=getConnection();
			sql="select * from movie m1, movie_detail m2,ganre g "
					+ "where m1.g_code=g.g_code and m1.movie_num=m2.movie_num and m1.movie_num=?  order by 3";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, movie_num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb=new MovieBean();
				mb.setAge(rs.getString("age"));
				mb.setActor(rs.getString("actor"));
				mb.setG_code(rs.getString("g_code"));
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setDirector(rs.getString("director"));
				mb.setName(rs.getString("name"));
				mb.setOpen_day(rs.getString("open_day"));
				mb.setProduction(rs.getString("production"));
				mb.setGrade(rs.getDouble("grade"));
				mb.setContents(rs.getString("contents"));
				mb.setImage(rs.getString("image"));
				mb.setVideo(rs.getString("video"));
				mb.setGanre(rs.getString("ganre"));
				mb.setPlaying(rs.getString("playing"));
			}
			
		}catch(Exception e){
			System.out.println("selectMovie占 : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return mb;
	}
	
	public List getMovieInfo(String movie_num){
		ArrayList list = new ArrayList();
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		MovieBean mb = null;
		String sql="";
		try{
			con=getConnection();
			sql="select m1.age, m1.movie_num, m1.name, g.ganre from movie m1, ganre g "
					+ "where m1.g_code=g.g_code  and m1.movie_num=?  order by 3";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, movie_num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb=new MovieBean();
				mb.setAge(rs.getString("age"));
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setName(rs.getString("name"));
				mb.setGanre(rs.getString("ganre"));
				list.add(mb);
			}
			
		}catch(Exception e){
			System.out.println("getMovieInfo : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return list;
	}
	
	public List getMovieOrderGrade(){
		ArrayList list = new ArrayList();
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			sql="select m.movie_num, m.name , m2.grade, m.age, m2.image from movie m,movie_detail m2 where m.movie_num=m2.movie_num order by 3 desc limit 0,10";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MovieBean mb=new MovieBean();
				mb.setAge(rs.getString("age"));
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setName(rs.getString("name"));
				mb.setGrade(rs.getDouble("grade"));
				mb.setImage(rs.getString("image"));
				list.add(mb);
			}
			
		}catch(Exception e){
			System.out.println("getMovieOrderGrade에서 오류: "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return list;
	}
	
	
	
	public List searchMovie(String search){
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		ArrayList v= new ArrayList();
		String sql="";
		String movie_num;
		try{
			con=getConnection();
			sql="select movie_num from movie where name like '%"+search+"%'";
			pstmt=con.prepareStatement(sql);

			rs=pstmt.executeQuery();
			while(rs.next()){
				movie_num=rs.getString("movie_num");
				sql="select m.movie_num, m.name,m.age, m.open_day, m.director, m2.grade, m2.image ,g.ganre from movie m,movie_detail m2,ganre g "
						+ "where m.g_code=g.g_code and m.movie_num=m2.movie_num and m.movie_num=? order by 2";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, movie_num);
				ResultSet rs2=pstmt.executeQuery();
				while(rs2.next()){
					MovieBean mb=new MovieBean();
					
					mb.setMovie_num(rs2.getString("movie_num"));
					mb.setGanre(rs2.getString("ganre"));
					mb.setName(rs2.getString("name"));
					mb.setGrade(rs2.getDouble("grade"));
					mb.setOpen_day(rs2.getString("open_day"));
					mb.setDirector(rs2.getString("director"));
					mb.setImage(rs2.getString("image"));
					mb.setAge(rs2.getString("age"));
					
					v.add(mb);
				}
			}
			
		}catch(Exception e){
			System.out.println("searchMovie占 : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return v;
	}
	
	
	public List searchMovieGanre(String g_code){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql="";
		ArrayList<MovieBean> list = new ArrayList<MovieBean>();
		try{
			con=getConnection();
			sql="select m.movie_num, m.name,m.age, m.open_day, m.director, m2.grade, m2.image ,g.ganre from movie m,movie_detail m2,ganre g "
					+ "where m.g_code=g.g_code and m.movie_num=m2.movie_num and m.g_code=? order by 2";			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, g_code);
			rs=pstmt.executeQuery();
			while(rs.next()){
		
					MovieBean mb=new MovieBean();
					
					mb.setMovie_num(rs.getString("movie_num"));
					mb.setGanre(rs.getString("ganre"));
					mb.setName(rs.getString("name"));
					mb.setGrade(rs.getDouble("grade"));
					mb.setOpen_day(rs.getString("open_day"));
					mb.setDirector(rs.getString("director"));
					mb.setImage(rs.getString("image"));
					mb.setAge(rs.getString("age"));
					
					list.add(mb);
				
			}
			
		}catch(Exception e){
			System.out.println("searchMovieGanre : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}
		return list;
	}
	//////////////////////////////////////////////////////////////
	public Vector<MovieBean> playingMovies(){
		Vector<MovieBean> v= new Vector<MovieBean>();
		Connection con=null;
		PreparedStatement pstmt = null;
		PreparedStatement prepstmt = null;
		PreparedStatement prepstmt2 = null;
		ResultSet rs=null;
		String sql="";
		String presql="";
		String presql2="";
		try{
			con=getConnection();
			
			//playing.end_day가 오늘보다 이전이면 movie table.playing set 0
			presql = "update movie a left join playing b on(a.movie_num = substring(b.nc_code, 3)) set a.playing = 0 where b.end_day < curdate()";
			prepstmt=con.prepareStatement(presql);
			prepstmt.executeUpdate();
			presql2 = "delete from playing where end_day < curdate()";
			prepstmt2=con.prepareStatement(presql2);
			prepstmt2.executeUpdate();
			
			sql="select m1.movie_num, m1.name, m1.open_day, m2.image, m1.age from movie m1,movie_detail m2 where playing = 1  and m1.movie_num = m2.movie_num";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MovieBean mb= new MovieBean();
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setAge(rs.getString("age"));
				
				v.add(mb);
			}
		}catch(Exception e){
			System.out.println("playingMovies���� ����: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{prepstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{prepstmt2.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return v;
	}
	
	public boolean setPlaying(String movie_num){
		Connection con=null;
		PreparedStatement pstmt = null;
		String sql="";
		try{
			con=getConnection();
			
			sql = "update movie set playing = 1 where movie_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movie_num);
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("setPlayingMovies : "+e);
			
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return false;
	}
	
	public Vector<MovieBean> splayingMovies(String s_cate, String s_movie){
		Vector<MovieBean> v= new Vector<MovieBean>();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			
			if(s_cate.equals("name")){
				sql="select movie_num, name, director, production, open_day from movie "
						+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day and "
						+ "name like concat('%',?,'%') and playing =0";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, s_movie);
			}else if(s_cate.equals("director")){
				sql="select movie_num, name, director, production, open_day from movie "
						+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day and "
						+ "director like concat('%',?,'%') and playing =0";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, s_movie);
			}else if(s_cate.equals("production")){
				sql="select movie_num, name, director, production, open_day from movie "
						+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day and "
						+ "production like concat('%',?,'%') and playing =0";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, s_movie);
			}else if(s_cate.equals("all")){
				if(s_movie == null){
					sql="select movie_num, name, director, production, open_day from movie "
							+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day and playing =0";
					pstmt=con.prepareStatement(sql);
				} else {
					sql="select movie_num, name, director, production, open_day from movie "
							+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day and "
							+ "(name like concat('%',?,'%') or director like concat('%',?,'%') or "
							+ "production like concat('%',?,'%') or actor like concat('%',?,'%')) and playing =0";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, s_movie);
					pstmt.setString(2, s_movie);
					pstmt.setString(3, s_movie);
					pstmt.setString(4, s_movie);
				}
			}
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				MovieBean mb= new MovieBean();
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setName(rs.getString("name"));
				mb.setDirector(rs.getString("director"));
				mb.setProduction(rs.getString("production"));
				mb.setOpen_day(rs.getString("open_day"));
				v.add(mb);
			}
		}catch(Exception e){
			System.out.println("splayingMovies : "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return v;
	}
	
	
	public List playingMoviesPick4w(int count){
		 ArrayList movieList= new ArrayList();
		
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();

			
			sql="select m1.movie_num, m1.name, m1.open_day, m2.image from movie m1, movie_detail m2 "
				+"where m1.movie_num=m2.movie_num and open_day >= (curdate() - interval 1 week) and open_day <=curdate() "
				+"and m2.image != 'default-image.jpg' order by 3 limit ?, 2";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MovieBean mb= new MovieBean();
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setOpen_day(rs.getString("open_day"));
				movieList.add(mb);
				
			}
		}catch(Exception e){
			System.out.println("playingMoviesPick4占쎈퓠占쎄퐣 占쎌궎�몴占�: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return movieList;
	}
	//상영중인 영화 리스트에 해당하는 이벤트가 있는지를 찾아 부여하는 메소드
	   public List<MovieBean> getEvent(List<MovieBean> movieList){
	      Connection con=null;
	      PreparedStatement pstmt = null;
	      ResultSet rs=null;
	      String sql="";
	      try{
	         con=getConnection();
	         sql="select ev.target,ev.event_code, ev_ca.event from event ev,event_category ev_ca where ev.event_code=ev_ca.event_code";
	         pstmt=con.prepareStatement(sql);
	         rs= pstmt.executeQuery();
	         while(rs.next()){
	         // 이벤트 대상 영화 번호를 모아놓은 taget을 토크나이저로 만든다.   
	         StringTokenizer st = new StringTokenizer(rs.getString("ev.target"));
	         while(st.hasMoreTokens()){//다음 토큰이 있는 경우 반복
	            // 대상영화 부르기
	            String tarNum = st.nextToken();
	            //상영중인 영화 목록에 대상 영화가 있는지 확인하는 반복문
	            for(int i=0;i<movieList.size();i++){
	               //상영중인 영화 가져오기
	               String   showing = movieList.get(i).getMovie_num();
	               //X번째 대상영화 번호에 해당하는 영화가 있다면
	               if(tarNum.equals(showing)){
	                  movieList.get(i).setName(movieList.get(i).getName()+rs.getString("ev_ca.event"));;
	                  movieList.get(i).setEvent(rs.getString("ev.event_code"));
	                  
	               }//상영중인 영화목록 불러오는 for문 끝   
	            
	            }
	         }//st.hasMoreTokens while 끝
	         
	         }//rs.next while 끝
	         
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally{
	         if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
	         if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
	         if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
	      }
	      
	      
	       return movieList;
	   }
	   
	
}
