
package team.member.db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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
   


      public boolean insertMember(memberBean dto){
         
         Connection con=null;
         String sql="";
         PreparedStatement pstmt=null;
         
         int result = 0;
         
         try {
            
            con = getConnection();
            
            sql="insert into member(id,pass,gender,birth,phone,name) "
               +"values(?,?,?,?,?,?)";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1,dto.getId()); 
            pstmt.setString(2,dto.getPass()); 
            pstmt.setInt(3,dto.getGender()); 
            pstmt.setString(4, dto.getBirth());
            pstmt.setString(5, dto.getPhone());
            pstmt.setString(6, dto.getName());
            
            result = pstmt.executeUpdate();
            
            if(result !=0){
               return true;
            }
            
         } catch (Exception e) {
            e.printStackTrace();
         }finally{
         
            if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
            if(con!=null)try{con.close();}catch(SQLException ex){}
         }
         
         
         
         return false;
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
   
   
      
      
}
