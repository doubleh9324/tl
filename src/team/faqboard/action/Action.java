package team.faqboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public interface Action {//Ŭ������ ����� ���� Ʋ
	
	//Ư�� Ŭ���̾�Ʈ�� ��û�� �����ϰ� �װ������ ActionForword Ŭ���� Ÿ������ ��ȯ
	
	public ActionForward execute(HttpServletRequest request , HttpServletResponse response) throws Exception;
	
	//�߻� �޼ҵ� 
	
	
	
}
