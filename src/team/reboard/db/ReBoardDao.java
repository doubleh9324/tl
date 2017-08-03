package team.reboard.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReBoardDao {
	
	// DB Connect
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Ticketlion");
		con=ds.getConnection();
		return con;
	}
	
	// Reply 답변 달기
	public boolean insertReboard(ReBoardBean rb){
				
		Connection con=null;
		String sql="";
		PreparedStatement pstmt= null;
		
		int result =0; 
		try{
			
			con=getConnection();

			sql="insert into question_reply (contents,re_date,q_num,re_num) values(?,?,?,?)";
			
			pstmt=con.prepareStatement(sql);									
			pstmt.setString(1, rb.getContents());
			pstmt.setString(2, rb.getRe_date());
			pstmt.setInt(3, rb.getQ_num());
			pstmt.setInt(4, rb.getQ_num());

			result=pstmt.executeUpdate();
			
			sql = "UPDATE question_board SET re_state=1 WHERE q_num=?";
	        pstmt=con.prepareStatement(sql);
	        pstmt.setInt(1, rb.getQ_num());
	        pstmt.executeUpdate();
						
			if(result != 0){
				return true;				
			}
			
		}catch(Exception e){
			System.out.println("insertReboard():"+e);
		}finally{
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return false;
	}

	// reply modify 답변글 수정
	public boolean ModifyReboard(ReBoardBean rb){
				
		Connection con=null;
		String sql="";
		PreparedStatement pstmt= null;
		
		int result =0; 
		try{			
			con=getConnection();

			sql = "UPDATE question_reply SET re_date=now(),contents=? WHERE q_num=?";			
			pstmt=con.prepareStatement(sql);						
			pstmt.setInt(2, rb.getQ_num());
			pstmt.setString(1, rb.getContents());			
			result=pstmt.executeUpdate();
					
			if(result != 0){
				return true;				
			}
			
		}catch(Exception e){
			System.out.println("modifyReboard() method error:"+e);
		}finally{
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return false;
	}	
	// not used. 사용되지 않으나 혹시나 해서 넣어둠.
	public int deleteBoard(int q_num){
	      
	      Connection con = null;
	      String sql = "";
	      PreparedStatement pstmt = null;
	      int result = 0;
	      
	      
	      try {
	         con = getConnection();
	         sql = "DELETE FROM question_reply WHERE q_num=?";
	         
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, q_num);
	         pstmt.executeUpdate();
	         
	         con.close();
	         pstmt.close();
	         result = 1;
	      } catch (Exception e) {
	         e.printStackTrace();
	         System.out.println("deleteBoard���� ���� �߻�"+e);
	         result = 0;
	      }
	      return result;
	   }
	
	// not used. 사용되지 않으나 혹시나 해서 넣어둠.
	public ReBoardBean viewReplyBoard(int q_num) {
	      
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = "";
	      ReBoardBean rbb = null;
	      
	      try {
	         rbb = new ReBoardBean();
	         sql = "SELECT * FROM question_reply WHERE q_num=?";
	         con = getConnection();
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, q_num);
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         rbb.setQ_num(rs.getInt("q_num"));
	         rbb.setContents(rs.getString("contents"));
	         rbb.setRe_date(rs.getString("re_date"));         
	         
	         con.close();
	         pstmt.close();
	         rs.close();
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	         System.out.println("viewReplyBoard() Error"+e);
	      }   
	      return rbb;
	   }
	
}
