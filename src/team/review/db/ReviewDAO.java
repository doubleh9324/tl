package team.review.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class ReviewDAO {
	
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Ticketlion");
		con=ds.getConnection();
		return con;
	}
	////////////////////////////////////////////////
	public int getReviewCount(String nc_code){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		int count=0;
		try{
			con=getConnection();
			String sql="select count(*) from review_board where nc_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, nc_code);
			rs=pstmt.executeQuery();
			if(rs.next()){
				count=rs.getInt(1);
			}
			
		}catch(Exception e){
			System.out.println("getReviewCount占쎈퓠占쎄퐣 占쎌궎�몴占�"+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return count;
	}
	
	
	////////////////////////////////////////////////////////////
	
	public List<ReviewBean> getReview(String nc_code,int p_num){
		ArrayList<ReviewBean> review = new ArrayList<ReviewBean>();
		Connection con=null;
		PreparedStatement pstmt= null;
		ResultSet rs=null;
		String sql="";
		
		try{
			con=getConnection();
			sql="select id,contents,grade,date from  review_board  where nc_code=? order by 4 desc limit ?,10";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, nc_code);
		
			pstmt.setInt(2, p_num);
			rs=pstmt.executeQuery();
			while(rs.next()){
				ReviewBean bean = new ReviewBean();
				bean.setId(rs.getString("id"));
				bean.setContents(rs.getString("contents"));;
				bean.setGrade(rs.getDouble("grade"));
				review.add(bean);
			}
		
		
			
			
			
		}catch(Exception e){
			System.out.println("getReview占쎈퓠占쎄퐣 占쎌궎�몴占�: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return review;
	}
	//////////////////////////////////////////////////////////////
	public void insertReview(ReviewBean bean){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql="";
		
		try{
			con=getConnection();
			sql="insert into review_board values (?,?,?,?,now(),?)";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1, bean.getNc_code());
			pstmt.setString(2, bean.getId());
			pstmt.setString(3, bean.getContents());
			pstmt.setDouble(4, bean.getGrade());
			pstmt.setInt(5, bean.getMember_num());
			pstmt.executeUpdate();
			
			String cate = bean.getNc_code().substring(0, 2);
			String m_num = bean.getNc_code().substring(2);
			System.out.println(cate);
			System.out.println(m_num);
			if(cate.equals("mo")){
				sql="select grade from movie_detail where movie_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, m_num);
				rs=pstmt.executeQuery();
				double ori_grade=0;
				if(rs.next()){
					ori_grade=rs.getDouble("grade");
				}
				sql="update movie_detail set grade=round(?,1) where movie_num=?";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setDouble(1, (bean.getGrade()+ori_grade)/2);
				pstmt.setString(2, m_num);
				pstmt.executeUpdate();
			}else{
				sql="select grade from musical_detail where musical_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, m_num);
				rs=pstmt.executeQuery();
				double ori_grade=0;
				if(rs.next()){
					ori_grade=rs.getDouble("grade");
				}
				sql="update musical_detail set grade=round(?,1) where musical_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setDouble(1, (bean.getGrade()+ori_grade)/2);
				pstmt.setString(2, m_num);
				pstmt.executeUpdate();
			}
			
		}catch(Exception e){
			System.out.println("insertReview�뿉�꽌 �삤瑜�:"+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}			
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
	}
	//////////////////////////////////////////////////////////////
	public List getReviewMovie(String id, int p_num, int member_num){
		ArrayList<ReviewBean> reviewList= new ArrayList<ReviewBean>();
		Connection con=null;
		PreparedStatement pstmt= null;
		ResultSet rs =null;
		String sql="";
		try{
			con=getConnection();
			sql="select m.name,r.contents, r.grade,  DATE_FORMAT(r.date, '%Y-%m-%d %H:%i') from review_board r,movie m where substring(r.nc_code,3)=m.movie_num and r.id=? and r.member_num=? order by 4 desc limit ?,15";		
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			pstmt.setInt(2, member_num);
			pstmt.setInt(3, p_num);
			rs=pstmt.executeQuery();
			while(rs.next()){
				ReviewBean rb = new ReviewBean();
				rb.setName(rs.getString("name"));
				rb.setContents(rs.getString("contents"));
				rb.setGrade(rs.getDouble("grade"));
				rb.setDate(rs.getString(4));
				reviewList.add(rb);
				
			}
			
			
		}catch(Exception e){
			System.out.println("getReviewMovie�뿉�꽌 �삤瑜�:"+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}			
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
		
		return reviewList;
	}
	
	public int getReviewMovieCount(String id,int member_num){
		int count=0;
		Connection con=null;
		PreparedStatement pstmt= null;
		ResultSet rs =null;
		String sql="";
		try{
			con=getConnection();
			sql="select count(*) from review_board r,movie m where substring(r.nc_code,3)=m.movie_num and r.id=? and r.member_num=?";		
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, member_num);
	
			rs=pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			
			
		}catch(Exception e){
			System.out.println("getReviewMovieCount�뿉�꽌 �삤瑜�:"+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}			
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return count;
	}



	public List getReviewMusical(String id, int p_num,int member_num){
		ArrayList<ReviewBean> reviewList= new ArrayList<ReviewBean>();
		Connection con=null;
		PreparedStatement pstmt= null;
		ResultSet rs =null;
		String sql="";
		try{
			con=getConnection();
			sql="select m.name,r.contents, r.grade,  DATE_FORMAT(r.date, '%Y-%m-%d %H:%i') from review_board r,musical m where substring(r.nc_code,3)=m.musical_num and r.id=? and r.member_num=? order by 4 desc limit ?,15";		
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, member_num);
			pstmt.setInt(3, p_num);
			rs=pstmt.executeQuery();
			while(rs.next()){
				ReviewBean rb = new ReviewBean();
				rb.setName(rs.getString("name"));
				rb.setContents(rs.getString("contents"));
				rb.setGrade(rs.getDouble("grade"));
				rb.setDate(rs.getString(4));
				reviewList.add(rb);
				
			}
			
			
		}catch(Exception e){
			System.out.println("getReviewMusical�뿉�꽌 �삤瑜�:"+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}			
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
		
		return reviewList;
	}
	
	public int getReviewMusicalCount(String id,int member_num){
		int count=0;
		Connection con=null;
		PreparedStatement pstmt= null;
		ResultSet rs =null;
		String sql="";
		try{
			con=getConnection();
			sql="select count(*) from review_board r,musical m where substring(r.nc_code,3)=m.musical_num and r.id=? and r.member_num=?";		
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, member_num);
	
			rs=pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			
			
		}catch(Exception e){
			System.out.println("getReviewMusicalCount�뿉�꽌 �삤瑜�:"+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}			
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return count;
	}

}
