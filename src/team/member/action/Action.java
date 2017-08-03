package team.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/* Action ���� Ŭ��������
 
 Action�������̽��� �߻�޼ҵ带 �������̵������ν� Ŭ���̾�Ʈ�� ��ûó�� ���¸� �԰�ȭ ��Ŵ
 
 */
public interface Action {	//Ŭ������ ����� ���� Ʋ
	
	//Ư�� Ŭ���̾�Ʈ�� ��û�� �����ϰ� �� ��� ���� ActionForwardŬ���� Ÿ������ ��ȯ
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception;

}
