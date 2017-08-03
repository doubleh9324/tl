package team.board.db;

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

public class BoardDao {
	
	// DB Connect
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Ticketlion");
		con=ds.getConnection();
		return con;
	}
	
	// Write 글 쓰기
	public boolean insertBoard(BoardBean qb){
				
		Connection con=null;
		String sql="";
		PreparedStatement pstmt= null;
		
		int result =0; 
		try{			
			con=getConnection();			
			sql="insert into question_board (member_num,q_code,title,contents,q_date) values(?,?,?,?,?)";			
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qb.getMember_num());
			pstmt.setString(2, qb.getQ_code());
			pstmt.setString(3, qb.getTitle());
			pstmt.setString(4, qb.getContents());
			pstmt.setString(5, qb.getQ_date());
						
			result=pstmt.executeUpdate();
			
			if(result != 0){
				return true;				
			}
			
		}catch(Exception e){
			System.out.println("insertBoard() error:"+e);
		}finally{
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return false;
	}
	// Modify 글 수정(답글 전에만 수정 가능)
	public boolean ModifyBoard(BoardBean qb){

		Connection con=null;
		String sql="";
		PreparedStatement pstmt= null;
		
		int result =0; 
		try{			
			con=getConnection();
			sql="update question_board set q_code=?,title=?,contents=?,q_date=? where q_num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, qb.getQ_code());
			pstmt.setString(2, qb.getTitle());
			pstmt.setString(3, qb.getContents());
			pstmt.setString(4, qb.getQ_date());
			pstmt.setInt(5, qb.getQ_num());
			
			result=pstmt.executeUpdate();
			if(result != 0){
				return true;
			}
			
		}catch(Exception e){
			System.out.println("modifyBoard() Error : "+e);
		}finally{
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return false;
	}
	
	// list 글 목록
	public List<BoardBean> ListBoard (int start, int list_su, int member_num){
	      	      
	      ArrayList<BoardBean> arr = new ArrayList<BoardBean>();
	      Connection con=null;
	      String sql="";
	      PreparedStatement pstmt= null;
	      ResultSet rs= null;
	      
	      try {
	         con=getConnection();
	         sql="select * from question_board WHERE member_num =? order by q_num desc limit ?,?";
	         pstmt=con.prepareStatement(sql);
	         pstmt.setInt(1, member_num);
	         pstmt.setInt(2, start);
	         pstmt.setInt(3, list_su);
	         
	         rs=pstmt.executeQuery();
	         
	         while(rs.next()){
	            BoardBean bb=new BoardBean();
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
	    	  System.out.println("ListBoard() Error : " +e);
	      }finally{
	         if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
	         if(con!=null)try{con.close();}catch(SQLException ex){}
	         if(rs!=null)try{rs.close();}catch(SQLException ex){}         
	      }	      
	      return arr;	      
	   }
	
	//total list count
	public int selectTotalCount(int member_num){
		
		Connection con=null;
		String sql="";
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		
		try{			
			con=getConnection();			
			sql="select count(*) from question_board where member_num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,member_num);
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
	
	// Delete 글 삭제(답변 글 달리기 전에만 삭제 가능)
	public int deleteBoard(int q_num){
	      
	      Connection con = null;
	      String sql = "";
	      PreparedStatement pstmt = null;
	      int result = 0;
	      
	      
	      try {
	         BoardBean bb = new BoardBean();
	         con = getConnection();
	         sql = "DELETE FROM question_board WHERE q_num=?";
	         
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, q_num);
	         pstmt.executeUpdate();
	         
	         con.close();
	         pstmt.close();
	         result = 1;
	         System.out.println(bb.getQ_num());
	      } catch (Exception e) {
	         e.printStackTrace();
	         System.out.println("deleteBoard Error : "+e);
	         result = 0;
	      }
	      return result;
	   }
	
	public BoardBean viewBoard(int q_num) {
	      
	      ArrayList arr = new ArrayList();
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = "";
	      BoardBean bb = new BoardBean();
	      
	      try {
	         sql = "SELECT * FROM question_board WHERE q_num=?";
	         con = getConnection();      
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, q_num);
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         bb.setQ_num(rs.getInt("q_num"));
	         bb.setMember_num(rs.getInt("member_num"));
	         bb.setQ_code(rs.getString("q_code"));
	         bb.setTitle(rs.getString("title"));
	         bb.setContents(rs.getString("contents"));
	         bb.setQ_date(rs.getString("q_date"));
	         bb.setRe_state(rs.getInt("re_state"));
	         
	         sql = "SELECT * FROM question_category WHERE q_code=?";
	 
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, bb.getQ_code());
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         bb.setQ_category(rs.getString("q_category"));
	         
	         
	         con.close();
	         pstmt.close();
	         rs.close();
	      } catch (Exception e) {
	         System.out.println("viewBoard() Error : "+e);
	      }      
	      return bb;
	   }	
}
