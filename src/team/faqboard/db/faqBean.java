package team.faqboard.db;

public class faqBean {
	private int faq_num;
	private String q_cate;
	private String title;
	private String contents;
	
	public int getFaq_num() {
		return faq_num;
	}
	public void setFaq_num(int faq_num) {
		this.faq_num = faq_num;
	}
	
	public String getQ_cate() {
		return q_cate;
	}
	public void setQ_cate(String q_cate) {
		this.q_cate = q_cate;
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
	
	
}
