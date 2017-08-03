package team.faqboard.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class faqDao {
	//DB연결 삼총사
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	//커넥션 풀 객체를 저장할 변수 선언
	
//디비연결 시키는메소드
private Connection getConnection() throws Exception{
	//DB삼총사
	con = null;
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/Ticketlion");
	con = ds.getConnection();
	
	return con;
}

public void freeResource(){
	if(con != null){try{con.close();}catch(Exception err){}}
	if(rs != null){try{rs.close();}catch(Exception err){}}
	if(pstmt != null){try{con.close();}catch(Exception err){}}
	}

//faq검색바를 이용할시 사용할 메서드
	public ArrayList<faqBean> search(String keyword){
		ArrayList<faqBean> faqList = new ArrayList<faqBean>();
		String sql="";
		try{
			con = getConnection();
			sql = "select faq_num,q_cate,title from faqboard where q_cate like ? or title like ? or contents like ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			pstmt.setString(3, "%" + keyword + "%");
			rs= pstmt.executeQuery();
			while(rs.next()){
				faqBean fbean = new faqBean();
				fbean.setFaq_num(rs.getInt("faq_num"));
				fbean.setQ_cate(rs.getString("q_cate"));
				fbean.setTitle(rs.getString("title"));
				faqList.add(fbean);
				
			}
			
		}catch(Exception e){e.printStackTrace();}finally{freeResource();}
	return faqList;
	}
	
	public ArrayList<faqBean> searchC(String keyword){
		ArrayList<faqBean> faqList = new ArrayList<faqBean>();
		String sql="";
		try{
			con = getConnection();
			sql = "select faq_num,q_cate,title from faqboard where q_cate=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			rs= pstmt.executeQuery();
			while(rs.next()){
				faqBean fbean = new faqBean();
				fbean.setFaq_num(rs.getInt("faq_num"));
				fbean.setQ_cate(rs.getString("q_cate"));
				fbean.setTitle(rs.getString("title"));
				faqList.add(fbean);
				
			}
			
		}catch(Exception e){e.printStackTrace();}finally{freeResource();}
	return faqList;
	}
	
	public ArrayList<faqBean> getContents(String faq_num){
		ArrayList<faqBean> faqList = new ArrayList<faqBean>();
		String sql="";
		try{
			con = getConnection();
			sql = "select contents from faqboard where faq_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, faq_num);
			rs= pstmt.executeQuery();
			while(rs.next()){
				faqBean fbean = new faqBean();
				fbean.setContents(rs.getString("contents"));
				faqList.add(fbean);
				
			}
			
		}catch(Exception e){e.printStackTrace();}finally{freeResource();}
	return faqList;
	}
}
