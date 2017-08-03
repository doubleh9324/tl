

package team.member.db;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class memberBean {
   
   private int member_num; // num -> member_num   
   private String name;
   private String id;
   private String pass;
   private int gender;
   private String birth;
   private String phone;
   private int mPoint;
   private int del_flag;
   
   private String birthyy;       
    private String birthmm;        
    private String birthdd;       
    
   
   public String getBirthyy() {
      return birthyy;
   }
   public void setBirthyy(String birthyy) {
      this.birthyy = birthyy;
   }
   public String getBirthmm() {
      return birthmm;
   }
   public void setBirthmm(String birthmm) {
      this.birthmm = birthmm;
   }
   public String getBirthdd() {
      return birthdd;
   }
   public void setBirthdd(String birthdd) {
      this.birthdd = birthdd;
   }
   
   public int getMember_num() {
      return member_num;
   }
   public void setMember_num(int member_num) {
      this.member_num = member_num;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getPass() {
      return pass;
   }
   public void setPass(String pass) {
      this.pass = pass;
   }
   public int getGender() {
      return gender;
   }
   public void setGender(int gender) {
      this.gender = gender;
   }
   
   
   public String setDateFormat(Date d){
         SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
         return formatter.format(d);
      }
   
   
   public void setBirth(Date birth){
       this.birth = setDateFormat(birth);
    }
        
   

   public String getBirth(){
            return this.birth;
   }
   
   public void setBirth(String birth){
         this.birth = birth;
      }
   

   
   public String getPhone() {
      return phone;
   }
   public void setPhone(String phone) {
      this.phone = phone;
   }


   public int getmPoint() {
      return mPoint;
   }
   public void setmPoint(int mPoint) {
      this.mPoint = mPoint;
   }
   public int getDel_flag() {
      return del_flag;
   }
   public void setDel_flag(int del_flag) {
      this.del_flag = del_flag;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   
   
   
   
   
   

}