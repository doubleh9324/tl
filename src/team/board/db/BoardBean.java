package team.board.db;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class BoardBean {
	
	private int q_num;//auto increment
	private int member_num;
	private String q_code;
	private String title;
	private String contents;
	private String q_date;
	
	private int re_state;
	
	
	//question_category index (q_code, q_category )
	private String q_category;
	public String getQ_category() {
		return q_category;
	}
	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}
	///////////////////
	
	
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
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public String getQ_code() {
		return q_code;
	}
	public void setQ_code(String q_code) {
		this.q_code = q_code;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getQ_date() {
		return q_date;
	}
	public void setQ_date(String q_date) {
		this.q_date = q_date;
	}
	public void setQ_date(Timestamp q_date) {
		this.q_date = setDateFormat(q_date);
	}
	public int getRe_state() {
		return re_state;
	}
	public void setRe_state(int re_state) {
		this.re_state = re_state;
	}

}
