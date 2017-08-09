package team.musical.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.movie.db.MovieBean;
import team.musical.db.MusicalBean;

public class MusicalDAO {
	
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Ticketlion");
		con=ds.getConnection();
		return con;
	}
	/////////////////////////////////////////////////////////////////////
	public Vector<MusicalBean> playingMusicals(){ //占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 占쎈쐻占쎈짗占쎌굲占쎌넅 
		Vector<MusicalBean> v= new Vector<MusicalBean>();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			sql="select m1.musical_num, m1.name, m2.image, m1.open_day, m1.close_day from musical m1,musical_detail m2 where m1.musical_num=m2.musical_num and curdate()<=m1.close_day and curdate()>=m1.open_day order by 1";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb= new MusicalBean();
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setOpen_day(rs.getString("open_day"));
				mb.setClose_day(rs.getString("close_day"));
				
				v.add(mb);
			}
		}catch(Exception e){
			System.out.println("playingMusicals�: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return v;
	}
	///////////////////////////////////////////////////////////////////
	public List  playingMusicalsPick4Length(){
		ArrayList length= new ArrayList();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			sql="select count(*) from musical m1, musical_detail m2 where m1.musical_num = m2.musical_num and curdate()>=open_day and curdate()<=close_day";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				length.add("{length:"+rs.getString(1)+"}");
			}
		}catch(Exception e){
			System.out.println("playingMusicalsPick4Length�뿉�꽌 �삤瑜�: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return length;
	}
	///////////////////////////////////////////////////////////////////////////
	public Vector<MusicalBean> playingMusicalsPick4(){ //占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 占쎈쐻占쎈짗占쎌굲占쎌넅 
		Vector<MusicalBean> v= new Vector<MusicalBean>();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			sql="select m1.musical_num, m1.name, m2.image, m1.open_day, m1.close_day from musical m1,musical_detail m2 where m1.musical_num=m2.musical_num and curdate()<=m1.close_day and curdate()>=m1.open_day order by 4";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb= new MusicalBean();
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setOpen_day(rs.getString("open_day"));
				mb.setClose_day(rs.getString("close_day"));
				
				v.add(mb);
			}
		}catch(Exception e){
			System.out.println("playingMusicals�뜝�럥�뱺�뜝�럡�맋 �뜝�럩沅롳옙紐닷뜝占�: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return v;
	}
	//////////////////////////////////////////////////////////////////////
	public List<MusicalBean> scheduledMusicals(){
		List<MusicalBean> musicalList=new ArrayList<MusicalBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql="";
		try{
			con=getConnection();
			sql="select m.musical_num,m.name, m.open_day, m2.image from musical m, musical_detail m2 where m.musical_num=m2.musical_num and curdate() < open_day order by 3 limit 0,5";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb = new MusicalBean();
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setOpen_day(rs.getString("open_day"));
				mb.setImage(rs.getString("image"));
				musicalList.add(mb);
			}
		}catch(Exception e){
			System.out.println("scheduledMusicals: "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return musicalList;
	}
	/////////////////////////////////////////////////////////////////////
	public List popularMusicals(){
		List<MusicalBean> musicalList = new ArrayList<MusicalBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql="";
		try{
			con=getConnection();
			sql="select m1.musical_num,m1.name, m2.image,m2.grade from musical m1, musical_detail m2  where m1.musical_num = m2.musical_num order by 4 desc limit 0,10";
			pstmt =con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb = new MusicalBean(); 
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setGrade(rs.getDouble("grade"));
				musicalList.add(mb);
				
			}
		}catch(Exception e){
			System.out.println("popularMusicals�뿉�꽌 �삤瑜�: "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return musicalList;
		
		
	}
	
	
	/////////////////////////////////////////////////////////////////////////
	public List<MusicalBean> getAllMusicals(){ 
		List<MusicalBean> musicalList= new ArrayList<MusicalBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
	
		try{
			con=getConnection();
			sql="select m1.musical_num,m1.name,m1.age,m2.image,m2.grade from musical m1, musical_detail m2 "
					+ "where m1.musical_num=m2.musical_num order by 2";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				do{
					MusicalBean mb = new MusicalBean();
					mb.setMusical_num(rs.getString("musical_num"));
					mb.setName(rs.getString("name"));
					mb.setAge(rs.getString("age"));
					mb.setImage(rs.getString("image"));
					mb.setGrade(rs.getDouble("grade"));
					musicalList.add(mb);
				}while(rs.next());
				return musicalList;
			}else{
				return Collections.emptyList();
			}
			
		}catch(Exception e){
			System.out.println("getAllMusicals�뜝�럥�뱺�뜝�럡�맋 �뜝�럩沅롳옙紐닷뜝占�: "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
		return Collections.emptyList();
	}
	
	public boolean insertMusical(MusicalBean mb){ //占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 占쎈쐻占쎈솯�ⓦ끉�굲
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		int count=0;
		int result=0;
		try{
			con=getConnection();
			sql="select count(musical_num) from musical";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				count=rs.getInt(1)+1;
			}else count=1;
			
			sql="insert into musical(musical_num,g_code,name,director,open_day,close_day,actor,production,age)"
				+" values(?,?,?,?,?,?,?,?,?)";
				
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, mb.getG_code());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getDirector());
			pstmt.setString(5, mb.getOpen_day());
			pstmt.setString(6, mb.getClose_day());
			pstmt.setString(7, mb.getActor());
			pstmt.setString(8, mb.getProduction());
			pstmt.setString(9, mb.getAge());
			pstmt.executeUpdate();
			
			sql="insert into musical_detail(musical_num,g_code,contents,image,video)"
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
			System.out.println("insertMusical : "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return false;
	}
	
	public MusicalBean selectMusical(String musical_num){ 
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		MusicalBean mb = null;
		String sql="";
		try{
			con=getConnection();
			sql="select * from musical m1,musical_detail m2, ganre g "
					+ "where m1.musical_num=m2.musical_num and m1.g_code=g.g_code and m1.musical_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, musical_num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb=new MusicalBean();
				mb.setAge(rs.getString("age"));
				mb.setActor(rs.getString("actor"));
				mb.setG_code(rs.getString("g_code"));
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setDirector(rs.getString("director"));
				mb.setName(rs.getString("name"));
				mb.setOpen_day(rs.getString("open_day"));
				mb.setClose_day(rs.getString("close_day"));
				mb.setProduction(rs.getString("production"));
				mb.setGrade(rs.getDouble("grade"));
				mb.setContents(rs.getString("contents"));
				mb.setImage(rs.getString("image"));
				mb.setVideo(rs.getString("video"));
				mb.setGanre(rs.getString("ganre"));
				mb.setPlaying(rs.getString("playing"));
			}
			
		}catch(Exception e){
			System.out.println("selectMusical : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return mb;
	}
	
	public List searchMusical(String search){  //占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 占쎈쐻占쎈뼑占쎄땔占쎌굲
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		ArrayList<MusicalBean> v= new ArrayList<MusicalBean>();
		String sql="";
		String musical_num;
		try{
			con=getConnection();
			sql="select musical_num from musical where name like '%"+search+"%'";
			pstmt=con.prepareStatement(sql);

			rs=pstmt.executeQuery();
			while(rs.next()){
				musical_num=rs.getString("musical_num");
				sql="select m.musical_num, m.name,m.age, m.open_day,m.close_day, m.director, m2.grade, m2.image ,g.ganre from musical m, musical_detail m2, ganre g where m.musical_num=m2.musical_num and m.g_code=g.g_code and m.musical_num=? order by 2";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, musical_num);
				ResultSet rs2=pstmt.executeQuery();
				while(rs2.next()){
					MusicalBean mb=new MusicalBean();
					
					mb.setMusical_num(rs2.getString("musical_num"));
					mb.setDirector(rs2.getString("director"));
					mb.setName(rs2.getString("name"));
					mb.setOpen_day(rs2.getString("open_day"));
					mb.setClose_day(rs2.getString("close_day"));
					mb.setGrade(rs2.getDouble("grade"));
					mb.setImage(rs2.getString("image"));
					mb.setGanre(rs2.getString("ganre"));
					mb.setAge(rs2.getString("age"));
					
					v.add(mb);
				}
			}
			
		}catch(Exception e){
			System.out.println("searchMusical: "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return v;
	}
	///////////////////////////////////////////////////////////
	public List getGanreMusicals(){
		List<MusicalBean> musicalList = new ArrayList<MusicalBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql="";
		try{
			con=getConnection();
			sql="select m1.musical_num,m1.name, m2.image, m2.grade, m1.g_code from musical m1, musical_detail m2  where m1.musical_num = m2.musical_num and m1.g_code ='ori' order by 2 limit 0,5";
			pstmt =con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb = new MusicalBean(); 
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setG_code(rs.getString("g_code"));
				musicalList.add(mb);
				
			}
			sql="select m1.musical_num,m1.name, m2.image, m2.grade, m1.g_code from musical m1, musical_detail m2  where m1.musical_num = m2.musical_num and m1.g_code ='lic' order by 2 limit 0,5";
			pstmt =con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb = new MusicalBean(); 
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setG_code(rs.getString("g_code"));

				musicalList.add(mb);
				
			}
			sql="select m1.musical_num,m1.name, m2.image, m2.grade, m1.g_code from musical m1, musical_detail m2  where m1.musical_num = m2.musical_num and m1.g_code ='non' order by 2 limit 0,5";
			pstmt =con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb = new MusicalBean(); 
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setG_code(rs.getString("g_code"));

				musicalList.add(mb);
				
			}
			sql="select m1.musical_num,m1.name, m2.image, m2.grade, m1.g_code from musical m1, musical_detail m2  where m1.musical_num = m2.musical_num and m1.g_code ='cre' order by 2 limit 0,5";
			pstmt =con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb = new MusicalBean(); 
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setG_code(rs.getString("g_code"));

				musicalList.add(mb);
				
			}
		}catch(Exception e){
			System.out.println("getGanreMusicals�뿉�꽌 �삤瑜�: "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return musicalList;
		
		
	}
	
	public List getMusicalInfo(String musical_num){
		ArrayList list = new ArrayList();
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		MusicalBean mb = null;
		String sql="";
		try{
			con=getConnection();
			sql="select m1.age, m1.musical_num, m1.name, g.ganre from musical m1, ganre g "
					+ "where m1.g_code=g.g_code  and m1.musical_num=?  order by 3";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, musical_num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb=new MusicalBean();
				mb.setAge(rs.getString("age"));
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setGanre(rs.getString("ganre"));
				list.add(mb);
			}
			
		}catch(Exception e){
			System.out.println("getMusiclaInfo : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return list;
	}
	
	public List searchMusicalGanre(String g_code){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql="";
		ArrayList<MusicalBean> list = new ArrayList<MusicalBean>();
		try{
			con=getConnection();
			sql="select m.musical_num, m.name,m.age, m.open_day,m.close_day, m.director, m2.grade, m2.image ,g.ganre from musical m,musical_detail m2,ganre g "
					+ "where m.g_code=g.g_code and m.musical_num=m2.musical_num and m.g_code=? order by 2";			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, g_code);
			rs=pstmt.executeQuery();
			while(rs.next()){
		
					MusicalBean mb=new MusicalBean();
					
					mb.setMusical_num(rs.getString("musical_num"));
					mb.setGanre(rs.getString("ganre"));
					mb.setName(rs.getString("name"));
					mb.setGrade(rs.getDouble("grade"));
					mb.setOpen_day(rs.getString("open_day"));
					mb.setClose_day(rs.getString("close_day"));
					mb.setDirector(rs.getString("director"));
					mb.setImage(rs.getString("image"));
					mb.setAge(rs.getString("age"));
					
					list.add(mb);
				
			}
			
		}catch(Exception e){
			System.out.println("searchMusicalGanre : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}
		return list;
	}
	
	public Vector<MusicalBean> playingMusicalsPick4w(int count){ //占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲 占쎈쐻占쎈짗占쎌굲占쎌넅 
		Vector<MusicalBean> v= new Vector<MusicalBean>();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			
			sql = "select m1.musical_num, m1.name, m2.image, m1.open_day, m1.close_day from musical m1,musical_detail m2 " 
					+"where m1.musical_num=m2.musical_num and open_day >= (curdate() - interval 1 week) "
					+"and open_day <=curdate() order by 4 limit ?,2";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb= new MusicalBean();
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				mb.setOpen_day(rs.getString("open_day"));
				mb.setClose_day(rs.getString("close_day"));
				
				v.add(mb);
			}
		}catch(Exception e){
			System.out.println("playingMusicals�뜝�럥�뱺�뜝�럡�맋 �뜝�럩沅롳옙紐닷뜝占�: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return v;
	}
	
}
