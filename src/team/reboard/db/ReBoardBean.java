package team.reboard.db;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ReBoardBean {
	
	private int q_num;//auto increment

	private String contents;
	
	private String re_date;
	
	public String setDateFormat(Timestamp d){
	      SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	      return formatter.format(d);
	   }
	
	public int getQ_num() {
		return q_num;
	}
	public void setQ_num(int q_num) {
		this.q_num = q_num;
	}


	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
		
	public String getRe_date() {
		return re_date;
	}
	public void setRe_date(String re_date) {
		this.re_date =re_date;
	}
	public void setRe_date(Timestamp re_date) {
		this.re_date = setDateFormat(re_date);
	}
	public boolean isEmpty(){
	      if(this.contents==null)
	         return true;
	      else
	         return false;
	   }
	
}
