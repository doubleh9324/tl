package team.adboard.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.adboard.db.AdBoardBean;

public class AdBoardDao {
	
	// DB Connect
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Ticketlion");
		con=ds.getConnection();
		return con;
	}
		
	// A list need answers  답변 달아야 하는 목록들을 뿌려주는 리스트
	public List<AdBoardBean> ListBoard (int start, int list_su){
	      	      
	      ArrayList<AdBoardBean> arr = new ArrayList<AdBoardBean>();
	      Connection con=null;
	      String sql="";
	      PreparedStatement pstmt= null;
	      ResultSet rs= null;
	      
	      try {
	         con=getConnection();
	         sql="select * from question_board WHERE re_state=0 order by q_num desc limit ?,?";
	         pstmt=con.prepareStatement(sql);
	       
	         pstmt.setInt(1, start);
	         pstmt.setInt(2, list_su);
	         rs=pstmt.executeQuery();
	         
	         while(rs.next()){
	            AdBoardBean bb=new AdBoardBean();
	            bb.setQ_num(rs.getInt("q_num"));
	            bb.setMember_num(rs.getInt("member_num"));
	            bb.setQ_code(rs.getString("q_code"));
	            bb.setTitle(rs.getString("title"));
	            bb.setContents(rs.getString("contents"));
	            bb.setQ_date(rs.getString("q_date"));
	            bb.setRe_state(rs.getInt("re_state"));
	            arr.add(bb);
	         }
	         
	      } catch (Exception e) {
	         System.out.println("ListBoard() Error : " + e);
	      }finally{
	         if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
	         if(con!=null)try{con.close();}catch(SQLException ex){}
	         if(rs!=null)try{rs.close();}catch(SQLException ex){}
	         
	      }	      
	      return arr;
	      
	   }
	
	// List showing the contents to be modified 수정할 내역들을 뿌려주는 페이지
	public List<AdBoardBean> ModifyListBoard (int start, int list_su){
	      	      
	      ArrayList<AdBoardBean> arr = new ArrayList<AdBoardBean>();
	      Connection con=null;
	      String sql="";
	      PreparedStatement pstmt= null;
	      ResultSet rs= null;
	      
	      try {
	         con=getConnection();
	         sql="select * from question_board q1, question_reply  q2 WHERE q1.q_num=q2.q_num order by re_date desc limit ?,?";
	         pstmt=con.prepareStatement(sql);
	       
	         pstmt.setInt(1, start);
	         pstmt.setInt(2, list_su);
	         rs=pstmt.executeQuery();
	         
	         while(rs.next()){
	            AdBoardBean bb=new AdBoardBean();
	            bb.setQ_num(rs.getInt(1));
	            bb.setMember_num(rs.getInt(2));
	            bb.setQ_code(rs.getString(3));
	            bb.setTitle(rs.getString(4));
	            bb.setContents(rs.getString(5));
	            bb.setQ_date(rs.getString(6));
	            bb.setRe_state(rs.getInt(7));
	            bb.setContents2(rs.getString(10));
	            arr.add(bb);
	         }
	         
	      } catch (Exception e) {
	         System.out.println("ModifyListBoard() Error : "+e);
	      }finally{
	         if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
	         if(con!=null)try{con.close();}catch(SQLException ex){}
	         if(rs!=null)try{rs.close();}catch(SQLException ex){}
	         
	      }	      
	      return arr;	      
	   }
		
	//total list count 총 글 개수 구하는 함수
	public int selectTotalCount(int re_state){
		
		Connection con=null;
		String sql="";
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		
		try{			
			con=getConnection();			
			sql="select count(*) from question_board where re_state=?";			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, re_state);
			rs=pstmt.executeQuery();
			
			rs.next();
			
			return rs.getInt(1);
					
		}catch(Exception e){
			System.out.println("selectTotalCount() error : "+e);
		}finally{
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return 0;
	}	
	
}
