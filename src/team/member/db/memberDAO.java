
package team.member.db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.fabric.xmlrpc.base.Array;

import team.location.db.LocationListBean;
import team.reservation.db.ReservationBean;

public class memberDAO {
   
private static memberDAO instance;
    
 
   
   
   /* DB연결 메서드 */
   private Connection getConnection() throws Exception{
      Connection con=null;
      Context init=new InitialContext();
      DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Ticketlion");
      con=ds.getConnection();
      return con;
   }
   
   public int insertMember(memberBean dto){
       
       Connection con=null;
       String sql="";
       PreparedStatement pstmt=null;
       ResultSet rs = null;
       
       try {
          
          con = getConnection();
          sql="insert into member(id,pass,gender,birth,phone,name) "
             +"values(?,?,?,?,?,?)";
          
          pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
          pstmt.setString(1,dto.getId()); 
          pstmt.setString(2,dto.getPass()); 
          pstmt.setInt(3,dto.getGender()); 
          pstmt.setString(4, dto.getBirth());
          pstmt.setString(5, dto.getPhone());
          pstmt.setString(6, dto.getName());
          
          pstmt.executeUpdate();
          rs = pstmt.getGeneratedKeys();
          
          if(rs.next()){
             return rs.getInt(1);
          }else{
          	return 0;
          }
          
       } catch (Exception e) {
          e.printStackTrace();
       }finally{
       
          if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
          if(con!=null)try{con.close();}catch(SQLException ex){}
       }
       return 0;
    }

      /* 아이디 체크  */
      
      public int idCheck(String id){ 
         Connection con = null; 
         PreparedStatement pstmt = null; 
         ResultSet rs = null; 
         String sql = "";
         int check = 0; 
         
         try{
         
            con = getConnection();
            
            sql = "select * from member where id=? and del_flag=1";
            
            pstmt=con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            
            
            
            if(rs.next()){
               check=1;
            }else{
               check=0;
            }
                  
         }catch(Exception err){
            System.out.println("idCheck메소드에서 오류 :"+err);
         }finally{
            if(rs!=null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
            if(pstmt!=null){try{pstmt.close();}catch(SQLException e){e.printStackTrace();}}
            if(con!=null){try{con.close();}catch (SQLException e) {e.printStackTrace();}}
            }

         return check;
      }
      
      /* 로그인 할 때*/
   public int userCheck(String id, String pass) {
      
      Connection con=null;
      String sql="";
      PreparedStatement pstmt=null;
      int check=-1;   //1-> 아이디 비번 맞음
                  //0->아이디 맞음 비번 틀림
                  //-1-> 아이디 틀림
      ResultSet rs=null;
      try {
         
         con=getConnection();
         //3단계
         // del_flag=1(현재 탈퇴한 회원이 아닌 사람의 패스워드를 불러옴)
         sql="select pass from member where id=? and del_flag=1";
         
         pstmt=con.prepareStatement(sql);
         pstmt.setString(1, id);
         //4단계
         rs=pstmt.executeQuery();
         
         //5단계
         if(rs.next()){
            
            if(pass.equals(rs.getString("pass"))){
               check=1;
            
            }else{
               check=0;
            }
      
         }else{
            check=-1; 
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally{
         
         if(rs!=null)try{rs.close();}catch(SQLException ex){}
         if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
         if(con!=null)try{con.close();}catch(SQLException ex){}
      }
      return check;
      
   }

   /* 회원탈퇴 메소드 ->DB삭제가 아니고 del_flag를 0으로 바꿈 */
   public int deleteMember(String id) {
      Connection con=null;
      String sql="";
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      int check =0;
      try {
         
         con = getConnection();
         
         sql = "select * from member where id=?";
         pstmt=con.prepareStatement(sql);
         pstmt.setString(1, id);
         
         rs = pstmt.executeQuery();
         
         if(rs.next()){
   
               sql = "update member set del_flag=0 where id=?";
               
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, id);
         
               check = pstmt.executeUpdate();
            }
      } catch (Exception e) {
         System.out.println("delete 메소드에서 오류 : "+e);
      }finally{
         if(rs!=null)try{rs.close();}catch(SQLException ex){}
         if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
         if(con!=null)try{con.close();}catch(SQLException ex){}
      }
      
      return check;
   }
   
   
   /* 회원정보 수정 */   
   
   //회원id로 회원 정보 가져오기
    public memberBean getmember(String id) {
         Connection con=null;
         PreparedStatement pstmt=null;
         String sql="";
         ResultSet rs=null;
         memberBean bean=null;
         
         try {
            con = getConnection();
            sql = "select * from member where id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs=pstmt.executeQuery();
            
            if(rs.next()){
               bean = new memberBean();
               bean.setBirth(rs.getString("birth"));
               bean.setDel_flag(rs.getInt("del_flag"));
               bean.setId(rs.getString("id"));
               bean.setGender(rs.getInt("gender"));
               bean.setmPoint(rs.getInt("mPoint"));
               bean.setName(rs.getString("name"));
               bean.setMember_num((rs.getInt("member_num")));
               bean.setPass(rs.getString("pass"));
               bean.setPhone(rs.getString("phone"));
               System.out.println("getmember 포인트"+rs.getInt("mPoint"));
            }

         } catch (Exception e) {
            System.out.println("getmember 메소드에서 오류 : "+e);
            
         }finally{
            if(rs!=null)try{rs.close();}catch(SQLException ex){}
            if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
            if(con!=null)try{con.close();}catch(SQLException ex){}
         }
         return bean;
      }
    
    //member_num으로 회원 정보 가져오기
    public memberBean getmember(int mnum) {
        Connection con=null;
        PreparedStatement pstmt=null;
        String sql="";
        ResultSet rs=null;
        memberBean bean=null;
        
        try {
           con = getConnection();
           sql = "select * from member where member_num=?";
           pstmt = con.prepareStatement(sql);
           pstmt.setInt(1, mnum);
           rs=pstmt.executeQuery();
           
           if(rs.next()){
              bean = new memberBean();
              bean.setBirth(rs.getString("birth"));
              bean.setDel_flag(rs.getInt("del_flag"));
              bean.setId(rs.getString("id"));
              bean.setGender(rs.getInt("gender"));
              bean.setmPoint(rs.getInt("mPoint"));
              bean.setName(rs.getString("name"));
              bean.setMember_num((rs.getInt("member_num")));
              bean.setPass(rs.getString("pass"));
              bean.setPhone(rs.getString("phone"));
              System.out.println("getmember 포인트"+rs.getInt("mPoint"));
           }

        } catch (Exception e) {
           System.out.println("getmember 메소드에서 오류 : "+e);
           
        }finally{
           if(rs!=null)try{rs.close();}catch(SQLException ex){}
           if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
           if(con!=null)try{con.close();}catch(SQLException ex){}
        }
        return bean;
     }

      public void updateMember(memberBean bean) {
         Connection con=null;
         PreparedStatement pstmt=null;
         String sql="";

         try {
            con = getConnection();

          sql = "update member set pass=?, birth=?, phone=? where id=?";
          pstmt=con.prepareStatement(sql);
          pstmt.setString(1, bean.getPass());
          pstmt.setString(2, bean.getBirth());
          pstmt.setString(3, bean.getPhone());
          pstmt.setString(4, bean.getId());
          pstmt.executeUpdate();

         } catch (Exception e) {
            e.printStackTrace();
         }finally{
            if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
            if(con!=null)try{con.close();}catch(SQLException ex){}
         }
 
      }

   public int modifyCheckMember(String id, String pass) {
        Connection con=null;
        PreparedStatement pstmt=null;
        ResultSet rs = null;
        String sql="";
        int check=0;
        
      try {
         //1,2 디비연결
         con=getConnection();
         //3 sql  pass   조건 num
         sql="select pass from member where id=?";
         
         pstmt=con.prepareStatement(sql);
         pstmt.setString(1, id);
         //4 rs 실행 저장
         rs=pstmt.executeQuery();
         //5 rs 첫행 이동 데이터 있으면 
         //  비밀번호비교  폼   디비 비밀번호  맞으면 check=1
         //  //3 update 수정 content name subject 조건 num  //4 실행
         //    틀리면  check=0
         if(rs.next()){
            if(pass.equals(rs.getString("pass"))){
               check=1;

            }else{
               check=0;
            }
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally{
         if(rs!=null)try{rs.close();}catch(SQLException ex){}
         if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
         if(con!=null)try{con.close();}catch(SQLException ex){}
      }
      return check;
   }
   
   public int updateMemberPoint(int mnum, int point) throws Exception{
	   Connection con=null;
       PreparedStatement pstmt=null;
       String sql="";
       int re = 0;
       try{
    	   con = getConnection();
    	   sql = "update member set mPoint = mPoint + ? where member_num = ?";
    	   pstmt = con.prepareStatement(sql);
    	   pstmt.setInt(1, point);
    	   pstmt.setInt(2, mnum);
    	   
    	   re = pstmt.executeUpdate();
    	   
    	   return re;
    	   
       }catch(Exception e){
    	   e.getMessage();
       }finally{
           if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
           if(con!=null)try{con.close();}catch(SQLException ex){}
       }
       return re;
   }
   
   public int getMemberPoint(int mnum) throws Exception{
	   Connection con=null;
       PreparedStatement pstmt=null;
       String sql="";
       ResultSet rs = null;
       try{
    	   con = getConnection();
    	   sql = "select mPoint from member where member_num = ?";
    	   pstmt = con.prepareStatement(sql);
    	   pstmt.setInt(1, mnum);
    	   
    	   rs = pstmt.executeQuery();
    	   System.out.println(pstmt.toString());
    	   rs.next();
    	   return rs.getInt(1);
    	   
       }catch(Exception e){
    	   System.out.println(e.getMessage());
       }finally{
           if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
           if(con!=null)try{con.close();}catch(SQLException ex){}
       }
       return 0;
   }
   
      
   public int getMnum(String id){
	    Connection con=null;
	    PreparedStatement pstmt=null;
	    String sql="";
	    ResultSet rs=null;
	    
	    try{
	        con = getConnection();
	        sql = "select member_num from member where id=?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs=pstmt.executeQuery();
	    	
	        rs.next();
	        return rs.getInt(1);
	        
	    }catch(Exception e){
	    	System.out.println("err");
	    }finally{
	        if(rs!=null)try{rs.close();}catch(SQLException ex){}
	        if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
	        if(con!=null)try{con.close();}catch(SQLException ex){}	
	    }
	    return 0;
  }
  
	public ArrayList<ReservationBean> getReservation(int mnum, String day, String option) {
	   Connection con=null;
	   PreparedStatement pstmt=null;
	   String sql="";
	   ResultSet rs=null;
	   ReservationBean bean=null;
	   ArrayList<ReservationBean> list = new ArrayList<>();
	   
	   
	   
	   try {
	      con = getConnection();
	      
	      if(option.equals("B")){
	      sql = "select * from reservation where member_num=? and reser_day like concat(?,'%') ";

	      pstmt = con.prepareStatement(sql);
	      pstmt.setInt(1, mnum);
	      pstmt.setString(2, day);
	      rs=pstmt.executeQuery();
	      System.out.println(pstmt.toString());
	      
	      }else if(option.equals("P")){
	          String sql1 = "select a.* from reservation a, playing b where a.member_num=? and a.view_date like concat(?,'%') "
	          		+ "and a.ping_num = b.ping_num and b.nc_code like concat('mo', '%')";
	          PreparedStatement pstmt1 = con.prepareStatement(sql1);
	          pstmt1.setInt(1, mnum);
	          pstmt1.setString(2, day);
	          rs=pstmt1.executeQuery();
	      }
	      
	      
	      if(rs.next()){
	   	   
	   	  do{
	             bean = new ReservationBean();
	             bean.setR_num(rs.getInt("r_num"));
	             bean.setMember_num(rs.getInt("member_num"));
	             bean.setPing_num(rs.getInt("ping_num"));
	             bean.setReseat_num(rs.getString("rseat_num")); 
	             bean.setSeat(rs.getString("seat"));
	             bean.setView_date(rs.getString("view_date"));
	             bean.setReser_day(rs.getString("reser_day"));
	             bean.setPay_day(rs.getString("pay_day"));
	             bean.setScreen_name(rs.getString("screen_name"));
	             bean.setMPoint(rs.getInt("mPoint"));
	             bean.setPrice(rs.getInt("price"));
	  
	   		  list.add(bean);
	   	  }while(rs.next());
	   	  	return list;
	
	      }
	
	   } catch (Exception e) {
	      System.out.println("getReservation 메소드에서 오류 : "+e);
	      
	   }finally{
	      if(rs!=null)try{rs.close();}catch(SQLException ex){}
	      if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
	      if(con!=null)try{con.close();}catch(SQLException ex){}
	   }
	   return list;
	}
	
	
	
	public void ReserveDelete(String id, String r_num) {
	   Connection con=null;
	   String sql="";
	   String sql1="";
	   PreparedStatement pstmt=null;
	   PreparedStatement pstmt1=null;
	
	   try {
	      con = getConnection();
	      
	      sql1 = "update member set mPoint = mPoint - (select mPoint from reservation where r_num=? ) where id = ?";
	      pstmt = con.prepareStatement(sql1);
	      pstmt.setString(1, r_num);
	      pstmt.setString(2, id);
	      
	      pstmt.executeUpdate();
	      
	      sql = "delete from reservation where r_num=?";
	     
	      pstmt1=con.prepareStatement(sql);
	      pstmt1.setString(1, r_num);
	      
	      pstmt1.executeUpdate();
	      
	   } catch (Exception e) {
	      System.out.println("Reservedelete 메소드에서 오류 : "+e);
	   }finally{
	
	      if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
	      if(con!=null)try{con.close();}catch(SQLException ex){}
	   }
	
	}
	
	public Map<String, Object> getReservationConfirm(String r_num) {
	   Connection con=null;
	   PreparedStatement pstmt=null;
	   String sql="";
	   ResultSet rs=null;
	   ReservationBean bean=null;
	   Map<String, Object> map = new HashMap<>();
	   
	   try {
	      con = getConnection();
	      sql = "select b.*, a.name, d.image, d.movie_num, e.name as pname, e.p_code from movie a, reservation b, playing c, movie_detail d, place e "
	      		+ "where b.ping_num = c.ping_num and substring(c.nc_code,3) = a.movie_num and c.p_code = e.p_code and a.movie_num = d.movie_num"
	      		+ " and r_num=?";
	      pstmt = con.prepareStatement(sql);
	      pstmt.setString(1, r_num);
	      rs=pstmt.executeQuery();
	
	      if(rs.next()){
	   	   
	             bean = new ReservationBean();
	             bean.setMember_num(rs.getInt("member_num"));
	             bean.setPing_num(rs.getInt("ping_num"));
	             bean.setReseat_num(rs.getString("rseat_num")); 
	             bean.setSeat(rs.getString("seat"));
	             bean.setView_date(rs.getString("view_date"));
	             bean.setReser_day(rs.getString("reser_day"));
	             bean.setPay_day(rs.getString("pay_day"));
	             bean.setScreen_name(rs.getString("screen_name"));
	             bean.setMPoint(rs.getInt("mPoint"));
	             bean.setPrice(rs.getInt("price"));
	             bean.setPayinfo(rs.getString("payinfo"));
	             
	             String pname = null;
	             String p_code = rs.getString("p_code");
	             String payinfo = rs.getString("payinfo");
	             String payway = null;
	         
	             System.out.println(p_code.substring(6));
	             if(p_code.substring(6).equals("lc")){
	           	  pname = rs.getString("pname") + " 롯데시네마";
	             }else if(p_code.substring(6).equals("mg")){
	           	  pname = rs.getString("pname") + " 메가박스";
	             }else if(p_code.substring(6).equals("cg")){
	           	  pname = rs.getString("pname") + " cgv";
	           	  System.out.println(pname);
	             }
	             String a[] = payinfo.split("_");
	             System.out.println(p_code.substring(6));
	             if(a[0].equals("card")){
	           	  payway = "신용카드";
	             }else if(a[0].equals("transfer")){
	           	  payway = "계좌이체";
	             }else if(a[0].equals("phone")){
	           	  payway = "휴대폰결제";
	           	  System.out.println(payway);
	             }  
	             
	             map.put("name", rs.getString("name"));
	             map.put("image", rs.getString("image"));
	             map.put("movie_num", rs.getInt("movie_num"));
	             map.put("pname", pname);
	             map.put("p_code", rs.getString("p_code"));
	             map.put("payway", payway);
	
	   		  map.put("rbean", bean);
	   	
	   	  	return map;
	
	      }
	
	   } catch (Exception e) {
	      System.out.println("getReservationConfirm 메소드에서 오류 : "+e);
	      
	   }finally{
	      if(rs!=null)try{rs.close();}catch(SQLException ex){}
	      if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
	      if(con!=null)try{con.close();}catch(SQLException ex){}
	   }
	   return map;
	
	}
	
	public LocationListBean getReserveMvLoc(String pname) {
		   Connection con=null;
		    PreparedStatement pstmt=null;
		    String sql="";
		    ResultSet rs=null;
		    LocationListBean bean = null;
		    
		    try{
		    	con = getConnection();
		    	sql = "select * from location_detail where l_name=?";
		    	pstmt = con.prepareStatement(sql);
		    	pstmt.setString(1, pname);
		    	rs = pstmt.executeQuery();
		    	
		    	if(rs.next()) {
		    	bean = new LocationListBean();
				bean.setL_num(rs.getInt(1));
				bean.setP_code(rs.getString(2));
				bean.setL_img(rs.getString(3));
				bean.setL_name(rs.getString(4));
				bean.setL_address(rs.getString(5));
		    }
		    	
		    }catch(Exception err){
		    	System.out.println("getReserveMvLoc 메소드에서 오류 : "+err);
		    }finally{
		        if(rs!=null)try{rs.close();}catch(SQLException ex){}
		        if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
		        if(con!=null)try{con.close();}catch(SQLException ex){}
		    }
		return bean;
	}
	     
	public int insertAddress(Map<String, Object> address){
		   Connection con=null;
	    PreparedStatement pstmt=null;
	    String sql="";
	    int result = 0;
	    try{
	 	   con = getConnection();
	 	   sql = "insert into member_address (member_num, post_code, address, add_detail, default_flag) values (?,?,?,?,?) ";
	 	   pstmt = con.prepareStatement(sql);
	 	   pstmt.setInt(1, (int) address.get("member_num"));
	 	   pstmt.setString(2,  (String) address.get("post_code")); 
	 	   pstmt.setString(3, (String) address.get("address")); 
	 	   pstmt.setString(4, (String) address.get("add_detail")); 
	 	   pstmt.setString(5, (String) address.get("default_flag")); 
	 	   
	 	   result = pstmt.executeUpdate();
	 	   System.out.println(pstmt.toString());
	 	   return result;
	 	   
	    }catch(Exception e){
	 	   System.out.println(e.getMessage());
	    }finally{
	        if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
	        if(con!=null)try{con.close();}catch(SQLException ex){}
	    }
	    return 0;
	}
	
	public List<Map<String, Object>> getAddressList(int mnum){
		 Connection con=null;
		 PreparedStatement pstmt=null;
		 String sql="";
		 ResultSet rs = null;
		 List<Map<String, Object>> addressList = new ArrayList<>();
		 try{
			   con = getConnection();
			   sql = "select * from member_address where member_num = ?";
			   pstmt = con.prepareStatement(sql);
			   pstmt.setInt(1,mnum);
			   rs = pstmt.executeQuery();
			   System.out.println(pstmt.toString());
			   
			   if(rs.next()){
				   do{
					   Map<String, Object> resultMap = new HashMap<>();
					   resultMap.put("post_code", rs.getString("post_code"));
					   resultMap.put("address", rs.getString("address"));
					   resultMap.put("add_detail", rs.getString("add_detail"));
					   addressList.add(resultMap);
				   }while(rs.next());
			   }
			   return addressList;
			   
		 }catch(Exception e){
			   System.out.println(e.getMessage());
		 }finally{
		     if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
		     if(con!=null)try{con.close();}catch(SQLException ex){}
		 }
		 return Collections.emptyList();
	}

    public Map<String, Object> getDefaultAddress(int mnum){
    	 Connection con=null;
		 PreparedStatement pstmt=null;
		 String sql="";
		 ResultSet rs = null;
		 Map<String, Object> resultMap = new HashMap<>();
		 
		 try{
			   con = getConnection();
			   sql = "select * from member_address where member_num = ? and default_flag='y'";
			   pstmt = con.prepareStatement(sql);
			   pstmt.setInt(1,mnum);
			   rs = pstmt.executeQuery();
			   System.out.println(pstmt.toString());
			   
			   if(rs.next()){
					   
					   resultMap.put("post_code", rs.getString("post_code"));
					   resultMap.put("address", rs.getString("address"));
					   resultMap.put("add_detail", rs.getString("add_detail"));
					   
					   return resultMap;
			   }else{
				   return null;
			   }
			   
			   
		 }catch(Exception e){
			   System.out.println(e.getMessage());
		 }finally{
		     if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
		     if(con!=null)try{con.close();}catch(SQLException ex){}
		 }
		 return null;
    }
}

